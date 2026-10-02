import 'package:another_telephony/telephony.dart';
import 'package:flutter/material.dart';

class SmsAnalyzerScreen extends StatefulWidget {
  const SmsAnalyzerScreen({super.key});

  @override
  State<SmsAnalyzerScreen> createState() => _SmsAnalyzerScreenState();
}

class _SmsAnalyzerScreenState extends State<SmsAnalyzerScreen> {
  final Telephony telephony = Telephony.instance;

  List<SmsMessage> _messages = [];

  bool _isLoading = true;

  String _searchPhone = '';

  String _selectedFilter = 'Tất cả';

  @override
  void initState() {
    super.initState();
    _loadSms();
  }

  // đọc toàn bộ sms trong hộp thư đến
  Future<void> _loadSms() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final bool? permission =
      await telephony.requestSmsPermissions;

      if (permission != true) {
        if (!mounted) return;

        setState(() {
          _isLoading = false;
        });

        _showMessage(
          'Ứng dụng chưa được cấp quyền đọc SMS.',
        );

        return;
      }

      final List<SmsMessage> messages =
      await telephony.getInboxSms();

      if (!mounted) return;

      setState(() {
        _messages = messages;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      _showMessage(
        'Không thể đọc SMS: $e',
      );
    }
  }

  // kiểm tra sms quảng cáo
  bool _isAdvertisement(String body) {
    return body.trimLeft().startsWith('[QC]');
  }

  // kiểm tra sms otp
  bool _isOtp(String body) {
    return RegExp(
      r'\[OTP\][\s\S]*?\b\d{6}\b',
      caseSensitive: false,
    ).hasMatch(body);
  }

  // lấy chuỗi 6 số trong sms otp
  String? _getOtp(String body) {
    final match = RegExp(
      r'\[OTP\][\s\S]*?\b(\d{6})\b',
      caseSensitive: false,
    ).firstMatch(body);

    return match?.group(1);
  }

  // lọc sms theo số điện thoại và loại
  List<SmsMessage> get _filteredMessages {
    return _messages.where((sms) {
      final String phone =
          sms.address ?? '';

      final String body =
          sms.body ?? '';

      final bool matchPhone =
          _searchPhone.isEmpty ||
              phone.toLowerCase().contains(
                _searchPhone.toLowerCase(),
              );

      bool matchType = true;

      if (_selectedFilter == 'Quảng cáo') {
        matchType = _isAdvertisement(body);
      } else if (_selectedFilter == 'OTP') {
        matchType = _isOtp(body);
      }

      return matchPhone && matchType;
    }).toList();
  }

  int get _advertisementCount {
    return _messages.where((sms) {
      return _isAdvertisement(
        sms.body ?? '',
      );
    }).length;
  }

  int get _otpCount {
    return _messages.where((sms) {
      return _isOtp(
        sms.body ?? '',
      );
    }).length;
  }

  // nhóm sms theo ngày
  Map<String, int> _getStatisticsByDay() {
    final Map<String, int> statistics = {};

    for (final sms in _messages) {
      if (sms.date == null) continue;

      final DateTime date =
      DateTime.fromMillisecondsSinceEpoch(
        sms.date!,
      );

      final String key =
          '${date.day.toString().padLeft(2, '0')}/'
          '${date.month.toString().padLeft(2, '0')}/'
          '${date.year}';

      statistics[key] =
          (statistics[key] ?? 0) + 1;
    }

    return statistics;
  }

  // nhóm sms theo tháng
  Map<String, int> _getStatisticsByMonth() {
    final Map<String, int> statistics = {};

    for (final sms in _messages) {
      if (sms.date == null) continue;

      final DateTime date =
      DateTime.fromMillisecondsSinceEpoch(
        sms.date!,
      );

      final String key =
          '${date.month.toString().padLeft(2, '0')}/'
          '${date.year}';

      statistics[key] =
          (statistics[key] ?? 0) + 1;
    }

    return statistics;
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // hiển thị otp khi chọn sms
  void _showOtp(SmsMessage sms) {
    final String body =
        sms.body ?? '';

    final String? otp =
    _getOtp(body);

    if (otp == null) {
      _showMessage(
        'Không tìm thấy mã OTP 6 số.',
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Mã OTP',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Mã xác thực 6 số:',
              ),
              const SizedBox(height: 12),
              Text(
                otp,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 5,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSummary() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: _buildSummaryCard(
              title: 'Tổng SMS',
              value: _messages.length.toString(),
              icon: Icons.message,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildSummaryCard(
              title: 'Quảng cáo',
              value: _advertisementCount.toString(),
              icon: Icons.campaign,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildSummaryCard(
              title: 'OTP',
              value: _otpCount.toString(),
              icon: Icons.lock,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 8,
        ),
        child: Column(
          children: [
            Icon(icon),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Lọc theo số điện thoại',
              hintText: 'Nhập số điện thoại...',
              prefixIcon: const Icon(
                Icons.search,
              ),
              suffixIcon: _searchPhone.isNotEmpty
                  ? IconButton(
                onPressed: () {
                  setState(() {
                    _searchPhone = '';
                  });
                },
                icon: const Icon(
                  Icons.clear,
                ),
              )
                  : null,
              border: const OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _searchPhone = value;
              });
            },
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: DropdownButtonFormField<String>(
              value: _selectedFilter,
              decoration: const InputDecoration(
                labelText: 'Loại tin nhắn',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Tất cả',
                  child: Text('Tất cả'),
                ),
                DropdownMenuItem(
                  value: 'Quảng cáo',
                  child: Text('Quảng cáo [QC]'),
                ),
                DropdownMenuItem(
                  value: 'OTP',
                  child: Text('Mã OTP'),
                ),
              ],
              onChanged: (value) {
                if (value == null) return;

                setState(() {
                  _selectedFilter = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmsList() {
    final List<SmsMessage> messages =
        _filteredMessages;

    if (messages.isEmpty) {
      return const Center(
        child: Text(
          'Không có tin nhắn phù hợp.',
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final SmsMessage sms =
        messages[index];

        final String phone =
            sms.address ?? 'Không rõ số';

        final String body =
            sms.body ?? 'Không có nội dung';

        final bool isOtp =
        _isOtp(body);

        final bool isAdvertisement =
        _isAdvertisement(body);

        String type = 'SMS';
        IconData icon =
            Icons.message;

        if (isOtp) {
          type = 'OTP';
          icon = Icons.lock;
        } else if (isAdvertisement) {
          type = 'Quảng cáo';
          icon = Icons.campaign;
        }

        String dateText = '';

        if (sms.date != null) {
          final DateTime date =
          DateTime.fromMillisecondsSinceEpoch(
            sms.date!,
          );

          dateText =
          '${date.day.toString().padLeft(2, '0')}/'
              '${date.month.toString().padLeft(2, '0')}/'
              '${date.year} '
              '${date.hour.toString().padLeft(2, '0')}:'
              '${date.minute.toString().padLeft(2, '0')}';
        }

        return Card(
          margin: const EdgeInsets.only(
            bottom: 10,
          ),
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(icon),
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    phone,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (isOtp)
                  Chip(
                    label: const Text(
                      'OTP',
                      style: TextStyle(
                        fontSize: 11,
                      ),
                    ),
                  )
                else if (isAdvertisement)
                  Chip(
                    label: const Text(
                      'QC',
                      style: TextStyle(
                        fontSize: 11,
                      ),
                    ),
                  ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(
                top: 5,
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    body,
                    maxLines: 3,
                    overflow:
                    TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '$type • $dateText',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            onTap: isOtp
                ? () {
              _showOtp(sms);
            }
                : null,
          ),
        );
      },
    );
  }

  Widget _buildStatistics() {
    final Map<String, int> byDay =
    _getStatisticsByDay();

    final Map<String, int> byMonth =
    _getStatisticsByMonth();

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        const Text(
          'Thống kê theo ngày',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        if (byDay.isEmpty)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Chưa có dữ liệu.',
              ),
            ),
          )
        else
          ...byDay.entries.map(
                (entry) {
              return Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.calendar_today,
                  ),
                  title: Text(
                    entry.key,
                  ),
                  trailing: Text(
                    '${entry.value} SMS',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        const SizedBox(height: 20),
        const Text(
          'Thống kê theo tháng',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        if (byMonth.isEmpty)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Chưa có dữ liệu.',
              ),
            ),
          )
        else
          ...byMonth.entries.map(
                (entry) {
              return Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.calendar_month,
                  ),
                  title: Text(
                    entry.key,
                  ),
                  trailing: Text(
                    '${entry.value} SMS',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'SMS Analyzer',
          ),
          actions: [
            IconButton(
              onPressed: _loadSms,
              icon: const Icon(
                Icons.refresh,
              ),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.message),
                text: 'SMS',
              ),
              Tab(
                icon: Icon(Icons.bar_chart),
                text: 'Thống kê',
              ),
            ],
          ),
        ),
        body: _isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : TabBarView(
          children: [
            Column(
              children: [
                _buildSummary(),
                _buildSearchAndFilter(),
                const SizedBox(height: 10),
                Expanded(
                  child: _buildSmsList(),
                ),
              ],
            ),
            _buildStatistics(),
          ],
        ),
      ),
    );
  }
}