import 'dart:io';

class SanPham{
  String _maSP = '';
  String _tenSP = '';
  double _donGia = 0;
  double _giamGia = 0;

  SanPham(){
    _maSP = "SP000";
    _tenSP = "Unknow";
    _donGia = 0;
    _giamGia = 0;
  }

  SanPham.fullPara(String masp, String tensp, double gia, double giam){
    _maSP  = masp;
    _tenSP = tensp;
    _donGia =gia;
    _giamGia = giam;
  }

  // Phuong thuc get/set
  // tên Sản phẩm
  String get maSP => _maSP;
  set maSP(String value){
    if(value.isNotEmpty){
      _maSP = value;
    }
  }

  // cho giảm giá
  double get donGia => _donGia;
  set donGia(double value){
    if(value > 0){
      _donGia = value;
    }
  }

  //phương thức tính thuế nhập khẩu
  double tinhThueNhapKhau(){
    return 0.01 * _donGia;
  }
   
  void ShowInfo(){
    print("Ma San Pham:$_maSP, Ten:$_tenSP, gia ban:$_donGia, giam gia: $_giamGia,thue:${tinhThueNhapKhau()}");
  }



}

Future<List<SanPham>> readFile(String filename) async{
  List<SanPham> arrs = [];
  try{
    // Doc file va lay danh sach dong
    List<String> Lines = await File(filename).readAsLines();
    for(String line in Lines){
      List<String> parts = line.split('#');
      if(parts.length == 4){
        String masp = parts[0].trim();
        String tensp = parts[1].trim();
        double giaban = double.parse(parts[2].trim());
        double gimagia = double.parse(parts[3].trim());

        if(masp != null && tensp != null){
          arrs.add(SanPham.fullPara(masp, tensp, giaban, gimagia));
        }
      }
    }
  }catch(e){
    print('Loi khi doc file: $e');
  }
  return arrs;
}