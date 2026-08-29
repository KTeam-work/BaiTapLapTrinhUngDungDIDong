import 'dart:io';

// Lớp cha
class PhongThue {
  String maPhong;
  int soNguoi;
  int soDien;
  int soNuoc;

  PhongThue(this.maPhong, this.soNguoi, this.soDien, this.soNuoc);

  double tinhTienPhong() {
    return 0;
  }

  void hienThi() {
    print(
      'Mã phòng: $maPhong | ' 'Số người: $soNguoi | ' 'Số điện: $soDien | ' 'Số nước: $soNuoc | ' 'Tiền phòng: ${tinhTienPhong()}',
    );
  }
}

// Phòng loại A
class PhongA extends PhongThue {
  int soNguoiThan;

  PhongA(
    String maPhong,
    int soNguoi,
    int soDien,
    int soNuoc,
    this.soNguoiThan,
  ) : super(maPhong, soNguoi, soDien, soNuoc);

  @override
  double tinhTienPhong() {  // Tính tiền phòng
    return 1400.0 +
        2 * soDien +
        8 * soNuoc +
        50 * soNguoiThan;
  }

  @override
  void hienThi() {
    print(
      'Loại A | '
      'Mã phòng: $maPhong | '
      'Số người: $soNguoi | '
      'Số điện: $soDien | '
      'Số nước: $soNuoc | '
      'Số người thân: $soNguoiThan | '
      'Tiền phòng: ${tinhTienPhong()}',
    );
  }
}

// Phòng loại B
class PhongB extends PhongThue {
  int giatui;
  int soMay;

  PhongB(
    String maPhong,
    int soNguoi,
    int soDien,
    int soNuoc,
    this.giatui,
    this.soMay,
  ) : super(maPhong, soNguoi, soDien, soNuoc);

  @override
  double tinhTienPhong() {
    return 2000 +
        2 * soDien +
        8 * soNuoc +
        giatui * 5 +
        soMay * 100;
  }

  @override
  void hienThi() {
    print(
      'Loại B | ' 'Mã phòng: $maPhong | ''Số người: $soNguoi | ''Số điện: $soDien | ''Số nước: $soNuoc | ''Giặt ủi: $giatui | ''Số máy: $soMay | ''Tiền phòng: ${tinhTienPhong()}',
    );
  }
}

// Đọc file và tạo danh sách phòng
List<PhongThue> docDanhSachPhong(String tenFile) {
  List<PhongThue> danhSach = [];

  File file = File(tenFile);

  if (!file.existsSync()) {
    print('Không tìm thấy file $tenFile');
    return danhSach;
  }

  List<String> lines = file.readAsLinesSync();

  for (String line in lines) {
    if (line.trim().isEmpty) {
      continue;
    }

    List<String> data = line.split('#');

    String maPhong = data[0];
    int soNguoi = int.parse(data[1]);
    int soDien = int.parse(data[2]);
    int soNuoc = int.parse(data[3]);

    // Phòng A có 5 thông tin
    if (maPhong.startsWith('A')) {
      int soNguoiThan = int.parse(data[4]);

      danhSach.add(
        PhongA(
          maPhong,
          soNguoi,
          soDien,
          soNuoc,
          soNguoiThan,
        ),
      );
    }

    // Phòng B có 6 thông tin
    else if (maPhong.startsWith('B')) {
      int giatui = int.parse(data[4]);
      int soMay = int.parse(data[5]);

      danhSach.add(
        PhongB(
          maPhong,
          soNguoi,
          soDien,
          soNuoc,
          giatui,
          soMay,
        ),
      );
    }
  }

  return danhSach;
}
