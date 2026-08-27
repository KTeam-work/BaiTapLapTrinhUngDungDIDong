import 'package:dart_application_1/BaiTapTuan_02/BaiTapTuLam_1.dart';

void main() {

  // Đọc file phongthue.txt
  List<PhongThue> ds = docDanhSachPhong(
    '../lib/BaiTapTuan_02/phongthue.txt',
  );

  print('========== DANH SÁCH PHÒNG THUÊ ==========');

  // 1. In danh sách các phòng
  for (var p in ds) {
    p.hienThi();
  }

  // 2. In danh sách phòng có số người thuê > 2
  print('\n========== PHÒNG CÓ SỐ NGƯỜI > 2 ==========');

  for (var p in ds) {
    if (p.soNguoi > 2) {
      p.hienThi();
    }
  }

  // 3. Tính tổng tiền phòng của tất cả các phòng
  print('\n========== TỔNG TIỀN PHÒNG ==========');

  double tongTien = 0;

  for (var p in ds) {
    tongTien += p.tinhTienPhong();
  }

  print('Tổng tiền phòng: $tongTien');

  // 4. Sắp xếp giảm dần theo số điện
  print('\n========== SẮP XẾP GIẢM DẦN THEO SỐ ĐIỆN ==========');

  ds.sort((a, b) {
    return b.soDien.compareTo(a.soDien);
  });

  for (var p in ds) {
    p.hienThi();
  }

  // 5. In danh sách phòng loại A
  print('\n========== DANH SÁCH PHÒNG LOẠI A ==========');

  for (var p in ds) {
    if (p is PhongA) {
      p.hienThi();
    }
  }
}