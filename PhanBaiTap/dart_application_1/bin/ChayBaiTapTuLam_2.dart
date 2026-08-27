import 'dart:io';
import 'package:dart_application_1/BaiTapTuan_02/BaiTapTuLam_2.dart';

void main() async {
  List<MonHoc> ds = [];

  //1.nhập danh sách từ bàn phím
  print("========== 1. NHẬP DANH SÁCH ==========");
  ds = nhapDanhSachTuBanPhim();

  //2. xuất danh sách
  print("\n========== 2. DANH SÁCH MÔN HỌC ==========");
  xuatDanhSach(ds);

 //3. danh sách có tăng dần theo tnee không
  print("\n========== 3. KIỂM TRA TĂNG DẦN THEO TÊN ==========");

  if (CheckTangDan(ds)) {
    print("Danh sách ĐÃ được sắp xếp tăng dần theo tên.");
  } else {
    print("Danh sách CHƯA được sắp xếp tăng dần theo tên.");
  }

  // 4. tang dần theo số tiến chỉ
  print("\n========== 4. SẮP XẾP TĂNG DẦN THEO TÍN CHỈ ==========");

  Ds_TangDan(ds);

  print("Danh sách sau khi sắp xếp:");
  xuatDanhSach(ds);

  // 5.các môn học có số tín chỉ cao nhất
  print("\n========== 5. MÔN CÓ SỐ TÍN CHỈ CAO NHẤT ==========");

  List<MonHoc> dsMaxTC = ds_MonHocTC(ds);

  if (dsMaxTC.isEmpty) {
    print("Danh sách rỗng.");
  } else {
    print("Các môn có số tín chỉ cao nhất:");
    xuatDanhSach(dsMaxTC);
  }

  // 6. tìm môn học theo tên, không có đưa vào cuối danh sách
  print("\n========== 6. TÌM HOẶC THÊM MÔN HỌC ==========");

  timHoacThemMonHoc(ds);

  print("\nDanh sách sau khi tìm/thêm:");
  xuatDanhSach(ds);

  // 7. đọc file
  print("\n========== 7. ĐỌC FILE monhoc.txt ==========");

  List<MonHoc> dsFile = await readfile("../lib/BaiTapTuan_02/monhoc.txt");

  if (dsFile.isEmpty) {
    print("Không đọc được môn học nào từ file.");
  } else {
    print("Danh sách môn học đọc từ file:");
    xuatDanhSach(dsFile);

    // Thêm các môn trong file vào danh sách hiện tại
    ds.addAll(dsFile);

    print("\nĐã thêm dữ liệu từ file vào danh sách.");
  }

   

 // 8. tính số tín chỉ trung bình
  print("\n========== 8. TÍNH SỐ TÍN CHỈ TRUNG BÌNH ==========");

  if (ds.isEmpty) {
    print("Danh sách rỗng.");
  } else {
    int tongTinChi = 0;

    for (var m in ds) {
      tongTinChi += m.stc;
    }

    double trungBinh = tongTinChi / ds.length;

    print("Tổng số tín chỉ: $tongTinChi");
    print("Số môn học: ${ds.length}");
    print("Số tín chỉ trung bình: ${trungBinh.toStringAsFixed(2)}");
  }
}