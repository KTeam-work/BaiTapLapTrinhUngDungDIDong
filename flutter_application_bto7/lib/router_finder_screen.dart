import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import 'favorite_route.dart';

enum TravelMode { driving, bike, foot }

class RouteFinderScreen extends StatefulWidget {
  const RouteFinderScreen({super.key});

  @override
  State<RouteFinderScreen> createState() => _RouteFinderScreenState();
}

class _RouteFinderScreenState extends State<RouteFinderScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  LatLng? _startLatLng;
  LatLng? _endLatLng;

  // Phương tiện di chuyển mặc định
  TravelMode _selectedMode = TravelMode.driving;

  String _distanceInfo = '';
  String _durationInfo = '';
  bool _isLoadingRoute = false;

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(10.7769, 106.7009),
    zoom: 12,
  );

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // 1. Lấy vị trí hiện tại
  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Chưa cấp quyền truy cập vị trí!')),
        );
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
      );

      if (!mounted) return;

      setState(() {
        _startLatLng = LatLng(position.latitude, position.longitude);
        _startController.text = "Vị trí của tôi";
        _addMarker(_startLatLng!, 'Xuất phát', BitmapDescriptor.hueBlue);
      });

      _moveCamera(_startLatLng!);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi lấy vị trí: $e')),
        );
      }
    }
  }

  // 2. Chuyển đổi Địa chỉ văn bản sang LatLng (Có Timeout chống đơ)
  Future<LatLng?> _geocodeAddress(String input) async {
    if (input.trim().isEmpty) return null;

    // Nếu nhập chuỗi tọa độ "lat, lng" trực tiếp
    if (input.contains(',')) {
      try {
        List<String> parts = input.split(',');
        if (parts.length == 2) {
          return LatLng(
            double.parse(parts[0].trim()),
            double.parse(parts[1].trim()),
          );
        }
      } catch (_) {}
    }

    // Biến đổi địa chỉ chữ bằng Geocoding (Native)
    try {
      List<Location> locations = await locationFromAddress(input)
          .timeout(const Duration(seconds: 5)); // Đặt timeout 5 giây chống đơ

      if (locations.isNotEmpty) {
        return LatLng(locations.first.latitude, locations.first.longitude);
      }
    } catch (_) {
      // Nếu Geocoding Native bị lỗi/timeout -> Fallback qua OpenStreetMap Nominatim
      try {
        final url = Uri.parse(
          'https://nominatim.openstreetmap.org/search?q=${Uri.encodeComponent(input)}&format=json&limit=1',
        );
        final response = await http
            .get(url, headers: {'User-Agent': 'FlutterApp'})
            .timeout(const Duration(seconds: 5));

        if (response.statusCode == 200) {
          List data = jsonDecode(response.body);
          if (data.isNotEmpty) {
            return LatLng(
              double.parse(data[0]['lat']),
              double.parse(data[0]['lon']),
            );
          }
        }
      } catch (_) {}
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Không tìm thấy tọa độ địa chỉ: "$input"')),
      );
    }
    return null;
  }

  // 3. Tìm đường đi tối ưu theo Phương tiện chọn
  Future<void> _findRoute() async {
    FocusScope.of(context).unfocus();

    if (_startController.text.trim().isEmpty || _endController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin điểm đi và điểm đến!')),
      );
      return;
    }

    setState(() => _isLoadingRoute = true);

    try {
      // Nếu không phải "Vị trí của tôi" thì mới Geocode điểm đi
      if (_startController.text != "Vị trí của tôi" || _startLatLng == null) {
        _startLatLng = await _geocodeAddress(_startController.text);
      }
      _endLatLng = await _geocodeAddress(_endController.text);

      // Nếu 1 trong 2 điểm không tìm thấy -> Thoát
      if (_startLatLng == null || _endLatLng == null) {
        return;
      }

      // Xác định Profile OSRM API phù hợp
      String profile = 'driving';
      if (_selectedMode == TravelMode.bike) profile = 'bike';
      if (_selectedMode == TravelMode.foot) profile = 'foot';

      String url = 'https://router.project-osrm.org/route/v1/$profile/'
          '${_startLatLng!.longitude},${_startLatLng!.latitude};'
          '${_endLatLng!.longitude},${_endLatLng!.latitude}'
          '?overview=full&geometries=polyline';

      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        if (data['code'] == 'Ok' &&
            data['routes'] != null &&
            data['routes'].isNotEmpty) {
          var route = data['routes'][0];

          double distanceInMeters = (route['distance'] as num).toDouble();
          double durationInSeconds = (route['duration'] as num).toDouble();

          String distanceStr = (distanceInMeters >= 1000)
              ? '${(distanceInMeters / 1000).toStringAsFixed(2)} km'
              : '${distanceInMeters.round()} m';

          int totalMinutes = (durationInSeconds / 60).round();
          String durationStr = (totalMinutes >= 60)
              ? '${totalMinutes ~/ 60} giờ ${totalMinutes % 60} phút'
              : '$totalMinutes phút';

          List<LatLng> points = _decodePolyline(route['geometry']);

          setState(() {
            _distanceInfo = distanceStr;
            _durationInfo = durationStr;

            _markers.clear();
            _addMarker(_startLatLng!, 'Xuất phát', BitmapDescriptor.hueBlue);
            _addMarker(_endLatLng!, 'Đích đến', BitmapDescriptor.hueRed);

            _polylines.clear();
            _polylines.add(
              Polyline(
                polylineId: const PolylineId('route'),
                points: points,
                color: _getRouteColor(_selectedMode),
                width: 6,
              ),
            );
          });

          _zoomToFitRoute(points);
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Không tìm thấy tuyến đường phù hợp!')),
            );
          }
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Máy chủ đường đi báo lỗi: ${response.statusCode}')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi kết nối / Tìm đường: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      // Đảm bảo LUÔN LUÔN tắt loading dù thành công hay thất bại
      if (mounted) {
        setState(() => _isLoadingRoute = false);
      }
    }
  }

  // Căn chỉnh camera bao quát toàn bộ đường đi
  Future<void> _zoomToFitRoute(List<LatLng> points) async {
    if (points.isEmpty) return;

    double minLat = points.first.latitude;
    double maxLat = points.first.latitude;
    double minLng = points.first.longitude;
    double maxLng = points.first.longitude;

    for (LatLng point in points) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLng) minLng = point.longitude;
      if (point.longitude > maxLng) maxLng = point.longitude;
    }

    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }

  // 4. Lưu tuyến đường vào danh sách Yêu thích (SQLite)
  Future<void> _saveFavoriteRoute() async {
    if (_startLatLng == null || _endLatLng == null || _distanceInfo.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Chưa có thông tin tuyến đường để lưu!')),
      );
      return;
    }

    TextEditingController titleController = TextEditingController(
      text: '${_startController.text} ➔ ${_endController.text}',
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Lưu tuyến đường yêu thích'),
        content: TextField(
          controller: titleController,
          decoration: const InputDecoration(
            labelText: 'Tên ghi nhớ',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () async {
              String title = titleController.text.trim();
              if (title.isEmpty) return;

              FavoriteRoute route = FavoriteRoute(
                title: title,
                startAddress: _startController.text,
                endAddress: _endController.text,
                startLat: _startLatLng!.latitude,
                startLng: _startLatLng!.longitude,
                endLat: _endLatLng!.latitude,
                endLng: _endLatLng!.longitude,
                profile: _selectedMode.name,
                distance: _distanceInfo,
                duration: _durationInfo,
              );

              await DatabaseHelper.instance.insertRoute(route);

              if (!mounted) return;
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã lưu tuyến đường vào danh sách yêu thích!')),
              );
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  // 5. Hiển thị danh sách Yêu thích
  void _showFavoriteRoutes() async {
    List<FavoriteRoute> favorites = await DatabaseHelper.instance.getAllRoutes();

    if (!mounted) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.6,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tuyến đường yêu thích (SQLite)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: favorites.isEmpty
                        ? const Center(child: Text('Chưa có tuyến đường nào lưu.'))
                        : ListView.builder(
                      itemCount: favorites.length,
                      itemBuilder: (context, index) {
                        final item = favorites[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Icon(_getModeIcon(item.profile)),
                            ),
                            title: Text(item.title,
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(
                                '${item.distance} • ${item.duration}\n${item.startAddress} ➔ ${item.endAddress}'),
                            isThreeLine: true,
                            onTap: () {
                              Navigator.pop(context);
                              _loadSavedRoute(item);
                            },
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                await DatabaseHelper.instance.deleteRoute(item.id!);
                                setModalState(() {
                                  favorites.removeAt(index);
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _loadSavedRoute(FavoriteRoute route) {
    setState(() {
      _startController.text = route.startAddress;
      _endController.text = route.endAddress;
      _startLatLng = LatLng(route.startLat, route.startLng);
      _endLatLng = LatLng(route.endLat, route.endLng);
      _selectedMode = TravelMode.values.firstWhere(
            (e) => e.name == route.profile,
        orElse: () => TravelMode.driving,
      );
    });

    _findRoute();
  }

  // Helper hàm phụ trợ
  Color _getRouteColor(TravelMode mode) {
    switch (mode) {
      case TravelMode.driving:
        return Colors.blue;
      case TravelMode.bike:
        return Colors.orange;
      case TravelMode.foot:
        return Colors.green;
    }
  }

  IconData _getModeIcon(String mode) {
    if (mode == 'bike') return Icons.two_wheeler;
    if (mode == 'foot') return Icons.directions_walk;
    return Icons.directions_car;
  }

  void _addMarker(LatLng position, String markerId, double hueColor) {
    setState(() {
      _markers.removeWhere((m) => m.markerId.value == markerId);
      _markers.add(
        Marker(
          markerId: MarkerId(markerId),
          position: position,
          icon: BitmapDescriptor.defaultMarkerWithHue(hueColor),
          infoWindow: InfoWindow(title: markerId),
        ),
      );
    });
  }

  Future<void> _moveCamera(LatLng position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(position, 14));
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0) ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0) ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }

  @override
  void dispose() {
    _startController.dispose();
    _endController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bản đồ & Tìm đường đi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            tooltip: 'Tuyến đường đã lưu',
            onPressed: _showFavoriteRoutes,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Ô Nhập Địa chỉ xuất phát
                TextField(
                  controller: _startController,
                  decoration: InputDecoration(
                    labelText: 'Điểm xuất phát (Nhập địa chỉ hoặc tọa độ)',
                    prefixIcon: const Icon(Icons.my_location, color: Colors.blue),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.gps_fixed),
                      tooltip: 'Lấy vị trí hiện tại',
                      onPressed: _getCurrentLocation,
                    ),
                    border: const OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 6),

                // Ô Nhập Địa chỉ điểm đến
                TextField(
                  controller: _endController,
                  decoration: const InputDecoration(
                    labelText: 'Điểm đến (VD: 227 Nguyễn Văn Cừ, TP.HCM)',
                    prefixIcon: Icon(Icons.location_on, color: Colors.red),
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 8),

                // Chọn loại Phương tiện di chuyển
                SegmentedButton<TravelMode>(
                  segments: const [
                    ButtonSegment(
                      value: TravelMode.driving,
                      label: Text('Ô tô'),
                      icon: Icon(Icons.directions_car),
                    ),
                    ButtonSegment(
                      value: TravelMode.bike,
                      label: Text('Xe máy'),
                      icon: Icon(Icons.two_wheeler),
                    ),
                    ButtonSegment(
                      value: TravelMode.foot,
                      label: Text('Đi bộ'),
                      icon: Icon(Icons.directions_walk),
                    ),
                  ],
                  selected: {_selectedMode},
                  onSelectionChanged: (Set<TravelMode> newSelection) {
                    setState(() {
                      _selectedMode = newSelection.first;
                    });
                    if (_startController.text.isNotEmpty &&
                        _endController.text.isNotEmpty) {
                      _findRoute();
                    }
                  },
                ),
                const SizedBox(height: 8),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    onPressed: _isLoadingRoute ? null : _findRoute,
                    icon: _isLoadingRoute
                        ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                        : const Icon(Icons.directions, color: Colors.white),
                    label: const Text('Tìm tuyến đường tối ưu',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),

          // Google Maps Widget & Card Khoảng cách
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: _initialPosition,
                  markers: _markers,
                  polylines: _polylines,
                  onMapCreated: (controller) => _controller.complete(controller),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  onTap: (LatLng tappedPoint) {
                    setState(() {
                      _endLatLng = tappedPoint;
                      _endController.text = '${tappedPoint.latitude}, ${tappedPoint.longitude}';
                      _addMarker(tappedPoint, 'Đích đến', BitmapDescriptor.hueRed);
                    });
                  },
                ),

                if (_distanceInfo.isNotEmpty && _durationInfo.isNotEmpty)
                  Positioned(
                    bottom: 15,
                    left: 10,
                    right: 10,
                    child: Card(
                      color: Colors.white.withOpacity(0.95),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Thời gian: $_durationInfo',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                      fontSize: 15),
                                ),
                                Text('Khoảng cách: $_distanceInfo'),
                              ],
                            ),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber.shade800,
                              ),
                              onPressed: _saveFavoriteRoute,
                              icon: const Icon(Icons.star, color: Colors.white, size: 18),
                              label: const Text('Lưu Yêu thích',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}