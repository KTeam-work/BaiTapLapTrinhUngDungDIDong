import 'dart:convert';
import 'dart:io';

abstract class HoaDon {
  String _maKH = "";
  String _tenKH = "";
  int _soLuong = 0;
  double _giaBan = 0.0;

  
  String get maKH => _maKH;
  set maKH(String value) {
    // Kiểm tra mã: 6 ký tự, 2 ký tự đầu KH, 4 ký tự sau là số
    RegExp regex = RegExp(r'^KH\d{4}$');
    if (regex.hasMatch(value)) {
      _maKH = value;
    } else {
      throw FormatException('Lỗi: Mã KH phải có 6 ký tự dạng KHxxxx (VD: KH0002)!');
    }
  }

  String get tenKH => _tenKH;
  set tenKH(String value) {
    if (value.trim().isNotEmpty) {
      _tenKH = value;
    } else {
      throw FormatException('Lỗi: Tên khách hàng không được để trống!');
    }
  }

  int get soLuong => _soLuong;
  set soLuong(int value) {
    if (value > 0) {
      _soLuong = value;
    } else {
      throw FormatException('Lỗi: Số lượng phải > 0!');
    }
  }

  double get giaBan => _giaBan;
  set giaBan(double value) {
    if (value > 0) {
      _giaBan = value;
    } else {
      throw FormatException('Lỗi: Giá bán phải > 0!');
    }
  }

  // 1. Constructor mặc định
  HoaDon();

  // 2. Constructor có tên đầy đủ tham số
  HoaDon.fullPara(String maKH, String tenKH, int soLuong, double giaBan) {
    this.maKH = maKH;
    this.tenKH = tenKH;
    this.soLuong = soLuong;
    this.giaBan = giaBan;
  }

  // Các phương thức tính toán (Đa hình)
  double tinhVAT() => soLuong * giaBan * 0.10;

  double tinhChietKhau();

  double tinhTroGia() => 0.0; // Mặc định Đại lý không có trợ giá

  double tinhThanhTien() {
    return (soLuong * giaBan) - tinhChietKhau() + tinhVAT();
  }

  // Phương thức nhập thông tin
  void nhap() {
    while (true) {
      try {
        stdout.write('  - Nhập mã KH (KHxxxx): ');
        maKH = stdin.readLineSync()?.trim() ?? '';
        break;
      } catch (e) {
        print('    ${e.toString().replaceAll("FormatException: ", "")}');
      }
    }

    while (true) {
      try {
        stdout.write('  - Nhập tên KH: ');
        tenKH = stdin.readLineSync()?.trim() ?? '';
        break;
      } catch (e) {
        print('    ${e.toString().replaceAll("FormatException: ", "")}');
      }
    }

    while (true) {
      try {
        stdout.write('  - Nhập số lượng: ');
        soLuong = int.parse(stdin.readLineSync()!);
        break;
      } catch (e) {
        print('    Lỗi: Số lượng phải là số nguyên > 0!');
      }
    }

    while (true) {
      try {
        stdout.write('  - Nhập giá bán: ');
        giaBan = double.parse(stdin.readLineSync()!);
        break;
      } catch (e) {
        print('    Lỗi: Giá bán phải là số thực > 0!');
      }
    }
  }

  // Phương thức xuất thông tin
  void xuat() {
    print('[Mã: $_maKH] Tên: $_tenKH | SL: $_soLuong | Đơn giá: ${_giaBan.toStringAsFixed(0)} | Chiết khấu: ${tinhChietKhau().toStringAsFixed(0)} | Trợ giá: ${tinhTroGia().toStringAsFixed(0)} | VAT: ${tinhVAT().toStringAsFixed(0)} | Thành tiền: ${tinhThanhTien().toStringAsFixed(0)}');
  }
}


class HoaDonCaNhan extends HoaDon {
  double khoangCach = 0.0; // km

  // Constructor mặc định
  HoaDonCaNhan() : super();

  // Constructor đầy đủ tham số
  HoaDonCaNhan.fullPara(
    String maKH,
    String tenKH,
    int soLuong,
    double giaBan,
    this.khoangCach,
  ) : super.fullPara(maKH, tenKH, soLuong, giaBan);

  @override
  double tinhChietKhau() {
    double chietKhau = 0.0;
    if (soLuong >= 3) {
      chietKhau += soLuong * (giaBan * 0.05);
    }
    if (khoangCach < 10) {
      chietKhau += soLuong * 50000;
    }
    return chietKhau;
  }

  @override
  double tinhTroGia() {
    double troGia = soLuong * (giaBan * 0.02);
    if (soLuong > 2) {
      troGia += 100000;
    }
    return troGia;
  }

  @override
  void nhap() {
    super.nhap();
    stdout.write('  - Nhập khoảng cách giao hàng (km): ');
    khoangCach = double.parse(stdin.readLineSync()!);
  }

  @override
  void xuat() {
    super.xuat();
    print('    -> Khoảng cách giao hàng: ${khoangCach}km');
  }
}



class HoaDonDaiLy extends HoaDon {
  int namHopTac = 0;

  // Constructor mặc định
  HoaDonDaiLy() : super();

  // Constructor đầy đủ tham số
  HoaDonDaiLy.fullPara(
    String maKH,
    String tenKH,
    int soLuong,
    double giaBan,
    this.namHopTac,
  ) : super.fullPara(maKH, tenKH, soLuong, giaBan);

  @override
  double tinhChietKhau() {
    double phanTram = 0.30; // Mặc định 30%
    if (namHopTac > 5) {
      int namThem = namHopTac - 5;
      phanTram += namThem * 0.01;
      if (phanTram > 0.35) phanTram = 0.35; // Tối đa 35%
    }
    return soLuong * giaBan * phanTram;
  }

  @override
  double tinhTroGia() => 0.0; // Không được trợ giá

  @override
  void nhap() {
    super.nhap();
    stdout.write('  - Nhập số năm hợp tác: ');
    namHopTac = int.parse(stdin.readLineSync()!);
  }

  @override
  void xuat() {
    super.xuat();
    print('    -> Số năm hợp tác: $namHopTac năm');
  }
}


class HoaDonCongTy extends HoaDon {
  int soNhanVien = 0;

  // Constructor mặc định
  HoaDonCongTy() : super();

  // Constructor đầy đủ tham số
  HoaDonCongTy.fullPara(
    String maKH,
    String tenKH,
    int soLuong,
    double giaBan,
    this.soNhanVien,
  ) : super.fullPara(maKH, tenKH, soLuong, giaBan);

  @override
  double tinhChietKhau() {
    double phanTram = 0.0;
    if (soNhanVien > 5000) {
      phanTram = 0.07;
    } else if (soNhanVien > 1000) {
      phanTram = 0.05;
    }
    return soLuong * giaBan * phanTram;
  }

  @override
  double tinhTroGia() {
    return soLuong * 120000.0;
  }

  @override
  void nhap() {
    super.nhap();
    stdout.write('  - Nhập số lượng nhân viên: ');
    soNhanVien = int.parse(stdin.readLineSync()!);
  }

  @override
  void xuat() {
    super.xuat();
    print('    -> Số lượng nhân viên: $soNhanVien');
  }
}


