import 'package:dart_application_1/BaiTapTuan_02/BaiTapVeNha_1.dart';
import 'dart:io';

class QuanLyHoaDon {
  List<HoaDon> ds = [];

  // 1. Nhập danh sách hóa đơn
  void nhapDanhSach() {
    stdout.write('Nhập số lượng hóa đơn: ');
    int n = int.parse(stdin.readLineSync()!);

    for (int i = 0; i < n; i++) {
      print('\n--- Nhập hóa đơn thứ ${i + 1} ---');

      print(
        'Chọn loại khách hàng (1: Cá nhân, 2: Đại lý, 3: Công ty): ',
      );

      int loai = int.parse(stdin.readLineSync()!);

      late HoaDon hd;

      if (loai == 1) {
        hd = HoaDonCaNhan();
      } else if (loai == 2) {
        hd = HoaDonDaiLy();
      } else {
        hd = HoaDonCongTy();
      }

      hd.nhap();
      ds.add(hd);
    }
  }

  // 2. Xuất danh sách
  void xuatDanhSach() {
    if (ds.isEmpty) {
      print('Danh sách hóa đơn trống!');
      return;
    }

    for (var hd in ds) {
      hd.xuat();
    }
  }

  // 3. Tổng thành tiền
  double tinhTongThanhTien() {
    return ds.fold(
      0.0,
      (sum, hd) => sum + hd.tinhThanhTien(),
    );
  }

  // 4. Tổng tiền trợ giá
  double tinhTongTienTroGia() {
    return ds.fold(
      0.0,
      (sum, hd) => sum + hd.tinhTroGia(),
    );
  }

  // 5. Khách hàng mua nhiều nhất
  void timKHMuaNhieuNhat() {
    if (ds.isEmpty) {
      print('\nDanh sách trống!');
      return;
    }

    int maxSL = ds.fold(
      0,
      (max, hd) => hd.soLuong > max ? hd.soLuong : max,
    );

    print(
      '\n=== KHÁCH HÀNG CÓ SỐ LƯỢNG MUA NHIỀU NHẤT ($maxSL sản phẩm) ===',
    );

    for (var hd in ds.where((h) => h.soLuong == maxSL)) {
      hd.xuat();
    }
  }

  // 6. Tổng chiết khấu khách hàng công ty
  double tinhTongChietKhauKhachHangCongTy() {
    double tongChietKhau = 0.0;

    for (var hd in ds) {
      if (hd is HoaDonCongTy) {
        tongChietKhau += hd.tinhChietKhau();
      }
    }

    return tongChietKhau;
  }

  // 7. Sắp xếp
  void sapXepDanhSach() {
    ds.sort((a, b) {
      int compareSL = a.soLuong.compareTo(b.soLuong);

      if (compareSL != 0) {
        return compareSL;
      }

      return b.tinhThanhTien().compareTo(
        a.tinhThanhTien(),
      );
    });

    print('\n=== DANH SÁCH SAU KHI SẮP XẾP ===');
    xuatDanhSach();
  }

  // 8. Tìm hóa đơn theo mã khách hàng
  void timHoaDonTheoMa(String maX) {
    var dsTimDuoc = ds
        .where(
          (hd) =>
              hd.maKH.toLowerCase() ==
              maX.trim().toLowerCase(),
        )
        .toList();

    if (dsTimDuoc.isEmpty) {
      print('\nKhách hàng lạ');
    } else {
      print(
        '\n=== CÁC HÓA ĐƠN CỦA MÃ KHÁCH HÀNG: $maX ===',
      );

      for (var hd in dsTimDuoc) {
        hd.xuat();
      }
    }
  }
}

// ================= MAIN =================

void main() {
  QuanLyHoaDon ql = QuanLyHoaDon();

  // 1. Nhập
  ql.nhapDanhSach();

  // 2. Xuất
  print('\n===== DANH SÁCH HÓA ĐƠN =====');
  ql.xuatDanhSach();

  // 3. Tổng thành tiền
  print(
    '\nTổng thành tiền: ${ql.tinhTongThanhTien()}',
  );

  // 4. Tổng trợ giá
  print(
    'Tổng tiền trợ giá: ${ql.tinhTongTienTroGia()}',
  );

  // 5. Khách mua nhiều nhất
  ql.timKHMuaNhieuNhat();

  // 6. Tổng chiết khấu khách hàng công ty
  print(
    '\nTổng chiết khấu khách hàng công ty: '
    '${ql.tinhTongChietKhauKhachHangCongTy()}',
  );

  // 7. Sắp xếp
  ql.sapXepDanhSach();

  // 8. Tìm theo mã khách hàng
  stdout.write('\nNhập mã khách hàng cần tìm: ');
  String maX = stdin.readLineSync()!;

  ql.timHoaDonTheoMa(maX);
}