import 'dart:io';

class MonHoc {
  String _maMon = "";
  String _tenMon = "";
  int _soTinChi = 0;

  MonHoc.fullPara(String mamon, String tenmon, int sotinchi) {
    _maMon = mamon;
    _tenMon = tenmon;
    _soTinChi = sotinchi;
  }

  String get ten => _tenMon;
  int get stc => _soTinChi;
  String get maMon => _maMon;

  @override
  String toString() {
    return "$_maMon\t$_tenMon\t$_soTinChi";
  }

  double DTB() => 0;

  String XepLoai(double diem) {
    if (diem >= 8.5) return "A";
    if (diem >= 8.0) return "B+";
    if (diem >= 7.0) return "B";
    if (diem >= 6.5) return "C+";
    if (diem >= 5.5) return "C";
    if (diem >= 5.0) return "D+";
    if (diem >= 4.0) return "D";
    return "F";
  }
}

class LyThuyet extends MonHoc {
  double _diemTL = 0.0;
  double _diemCK = 0.0;

  LyThuyet.fullPara(String mamon, String tenmon, int sotinchi, double diemTL, double diemCK)
      : super.fullPara(mamon, tenmon, sotinchi) {
    _diemTL = diemTL;
    _diemCK = diemCK;
  }

  @override
  double DTB() => _diemTL * 0.3 + _diemCK * 0.7;

  @override
  String toString() {
    return "${super.toString()}\t$_diemTL\t$_diemCK\t${DTB().toStringAsFixed(2)}\t${XepLoai(DTB())}";
  }
}

class ThucHanh extends MonHoc {
  double _ktr1 = 0.0;
  double _ktr2 = 0.0;
  double _ktr3 = 0.0;

  ThucHanh.fullPara(String mamon, String tenmon, int sotinchi, double Ktr1, double Ktr2, double Ktr3)
      : super.fullPara(mamon, tenmon, sotinchi) {
    _ktr1 = Ktr1;
    _ktr2 = Ktr2;
    _ktr3 = Ktr3;
  }

  @override
  double DTB() => (_ktr1 + _ktr2 + _ktr3) / 3;

  @override
  String toString() {
    return "${super.toString()}\t$_ktr1\t$_ktr2\t$_ktr3\t${DTB().toStringAsFixed(2)}\t${XepLoai(DTB())}";
  }
}

class DoAn extends MonHoc {
  double _diemGVHD = 0.0;
  double _diemGVPB = 0.0;

  DoAn.fullPara(String mamon, String tenmon, int sotinchi, double diemgvhd, double diemgvpb)
      : super.fullPara(mamon, tenmon, sotinchi) {
    _diemGVHD = diemgvhd;
    _diemGVPB = diemgvpb;
  }

  @override
  double DTB() => (_diemGVHD + _diemGVPB) / 2;

  @override
  String toString() {
    return "${super.toString()}\t$_diemGVHD\t$_diemGVPB\t${DTB().toStringAsFixed(2)}\t${XepLoai(DTB())}";
  }
}


// kiếm tra mã môn đã tồn tài chưa
bool Checkmamon(String maMon, List<MonHoc> ds){
  return ds.any((t) => t.maMon.toLowerCase() == maMon.toLowerCase());
  
}


// 1. Nhập danh sách môn học từ bàn phím
List<MonHoc> nhapDanhSachTuBanPhim() {
  List<MonHoc> ds = [];
  stdout.write('Nhập số lượng môn học muốn thêm từ bàn phím: ');
  int n = int.parse(stdin.readLineSync() ?? '0');

  for (int i = 0; i < n; i++) {
    print('\n--- Nhập môn học thứ ${i + 1} ---');
    stdout.write('Chọn loại môn (1: Lý thuyết, 2: Thực hành, 3: Đồ án): ');
    int loai = int.parse(stdin.readLineSync()!);
    String ma = "";
    do{
      stdout.write('Mã môn: ');
      ma = stdin.readLineSync()!; 
    }while(Checkmamon(ma, ds) && ds.length > 0);

    
    stdout.write('Tên môn: ');
    String ten = stdin.readLineSync()!;
    stdout.write('Số tín chỉ: ');
    int stc = int.parse(stdin.readLineSync()!);

    if (loai == 1) {
      stdout.write('Điểm tiểu luận: ');
      double tl = double.parse(stdin.readLineSync()!);
      stdout.write('Điểm cuối kỳ: ');
      double ck = double.parse(stdin.readLineSync()!);
      ds.add(LyThuyet.fullPara(ma, ten, stc, tl, ck));
    } else if (loai == 2) {
      stdout.write('Điểm KT 1: ');
      double kt1 = double.parse(stdin.readLineSync()!);
      stdout.write('Điểm KT 2: ');
      double kt2 = double.parse(stdin.readLineSync()!);
      stdout.write('Điểm KT 3: ');
      double kt3 = double.parse(stdin.readLineSync()!);
      ds.add(ThucHanh.fullPara(ma, ten, stc, kt1, kt2, kt3));
    } else {
      stdout.write('Điểm GVHD: ');
      double gvhd = double.parse(stdin.readLineSync()!);
      stdout.write('Điểm GVPB: ');
      double gvpb = double.parse(stdin.readLineSync()!);
      ds.add(DoAn.fullPara(ma, ten, stc, gvhd, gvpb));
    }
  }
  return ds;
}

// Xuất danh sách
void xuatDanhSach(List<MonHoc> ds) {
  for (var m in ds) {
    print(m.toString());
  }
}

// Kiểm tra tăng dần theo tên
bool CheckTangDan(List<MonHoc> ds) {
  if (ds.isEmpty) return true;
  for (int i = 0; i < ds.length - 1; i++) {
    if (ds[i].ten.compareTo(ds[i + 1].ten) > 0) {
      return false;
    }
  }
  return true;
}

// Sắp xếp tăng dần theo tín chỉ
List<MonHoc> Ds_TangDan(List<MonHoc> ds) {
  ds.sort((a, b) => a.stc.compareTo(b.stc));
  return ds;
}

// Các môn học có số tín chỉ cao nhất
List<MonHoc> ds_MonHocTC(List<MonHoc> ds) {
  if (ds.isEmpty) return [];
  int max = ds[0].stc;
  for (var m in ds) {
    if (m.stc > max) max = m.stc;
  }
  return ds.where((m) => m.stc == max).toList();
}

// Tìm hoặc thêm môn học
void timHoacThemMonHoc(List<MonHoc> dsMonHoc) {
  stdout.write('\n-> Nhập tên môn học cần tìm: ');
  String tenTim = stdin.readLineSync()?.trim() ?? '';

  MonHoc? timDuoc;
  try {
    timDuoc = dsMonHoc.firstWhere(
      (m) => m.ten.toLowerCase() == tenTim.toLowerCase(),
    );
  } catch (e) {
    timDuoc = null;
  }

  if (timDuoc != null) {
    print('=> Tìm thấy môn học trong danh sách. Thông tin chi tiết:');
    print(timDuoc.toString());
  } else {
    print('=> Môn "$tenTim" không có trong danh sách. Tiến hành nhập để thêm mới:');
    stdout.write('Chọn loại môn (1: Lý thuyết, 2: Thực hành, 3: Đồ án): ');
    int loai = int.parse(stdin.readLineSync()!);

    stdout.write(' - Nhập mã môn: ');
    String ma = stdin.readLineSync()!;
    stdout.write(' - Nhập số tín chỉ: ');
    int stc = int.parse(stdin.readLineSync()!);

    late MonHoc mhMoi;
    if (loai == 1) {
      stdout.write(' - Điểm tiểu luận: ');
      double tl = double.parse(stdin.readLineSync()!);
      stdout.write(' - Điểm cuối kỳ: ');
      double ck = double.parse(stdin.readLineSync()!);
      mhMoi = LyThuyet.fullPara(ma, tenTim, stc, tl, ck);
    } else if (loai == 2) {
      stdout.write(' - Điểm KT 1: ');
      double kt1 = double.parse(stdin.readLineSync()!);
      stdout.write(' - Điểm KT 2: ');
      double kt2 = double.parse(stdin.readLineSync()!);
      stdout.write(' - Điểm KT 3: ');
      double kt3 = double.parse(stdin.readLineSync()!);
      mhMoi = ThucHanh.fullPara(ma, tenTim, stc, kt1, kt2, kt3);
    } else {
      stdout.write(' - Điểm GVHD: ');
      double gvhd = double.parse(stdin.readLineSync()!);
      stdout.write(' - Điểm GVPB: ');
      double gvpb = double.parse(stdin.readLineSync()!);
      mhMoi = DoAn.fullPara(ma, tenTim, stc, gvhd, gvpb);
    }

    dsMonHoc.add(mhMoi);
    print('=> Đã thêm môn học mới vào cuối danh sách thành công!');
  }
}

// Đọc file
Future<List<MonHoc>> readfile(String fileName) async {
  List<MonHoc> ds = [];
  try {
    List<String> dsLine = await File(fileName).readAsLines();
    for (String line in dsLine) {
      if (line.trim().isEmpty) continue;
      List<String> lines = line.split('|');
      String loai = lines[0].trim();
      String ma = lines[1].trim();
      String ten = lines[2].trim();
      int stc = int.parse(lines[3].trim());

      if (loai == 'LT') {
        double tl = double.parse(lines[4].trim());
        double ck = double.parse(lines[5].trim());
        ds.add(LyThuyet.fullPara(ma, ten, stc, tl, ck));
      } else if (loai == 'TH') {
        double kt1 = double.parse(lines[4].trim());
        double kt2 = double.parse(lines[5].trim());
        double kt3 = double.parse(lines[6].trim());
        ds.add(ThucHanh.fullPara(ma, ten, stc, kt1, kt2, kt3));
      } else if (loai == 'DA') {
        double gvhd = double.parse(lines[4].trim());
        double gvpb = double.parse(lines[5].trim());
        ds.add(DoAn.fullPara(ma, ten, stc, gvhd, gvpb));
      }
    }
  } catch (e) {
    print("Lỗi đọc file: $e");
  }
  return ds;
}