

import 'dart:isolate';

class NhanVien{
  String _maNV = '';
  String _tenNV = '';
  double _heSoLuong = 0.0;
  String _phongBan = '';
  double _soNgayLV = 0.0;
  static double LCB = 2340;

  // Phuong thuc khoi tao
  NhanVien(){
    _maNV = 'NV0001';
    _tenNV = "Nguyen Van A";
    _heSoLuong = 2.34;
    _phongBan = "To Chuc";
    _soNgayLV = 22;
  }

  NhanVien.fullPara(String maNV , String tennv, double hsl, String pb, double soNgayLV){
    _maNV = maNV;
    _tenNV = tennv;
    _heSoLuong = hsl;
    _phongBan = pb;
    _soNgayLV = soNgayLV;
  }

  String XepLoai(){
    if(_soNgayLV > 25){
      return 'A';
    }
    else if(_soNgayLV > 22){
      return 'B';
    }else{
      return 'C';
    }
  }

  // phuong thuc tinh luong
  double tinhLuong(){
    String xLoai = XepLoai();
    double hsThiDua = 0.5;
    if(xLoai =='A'){
      hsThiDua = 1;
    }else if(xLoai == 'B'){
      hsThiDua = 0.75;
    }

    return LCB * _heSoLuong * hsThiDua;
  }

  @override
  String toString(){
    return "$_maNV\t $_tenNV \t $_heSoLuong \t $_soNgayLV\t ${XepLoai()} \t${tinhLuong()}";
  }


}

class CanBo extends NhanVien{
   String _ChucVu = '';
   double _heSoChuVu = 0;

   CanBo():super(){  // super khoi tao ham cha
     _ChucVu = "Unknow";
     _heSoChuVu = 0;
   }

   CanBo.fullPara(String manv,String tennv,double hsl, String pb, double soNgayLV,
   String chucvu,double hscv):super.fullPara(manv, tennv, hsl, pb, soNgayLV){
     _ChucVu = chucvu;
     _heSoChuVu = hscv;
   }
   
   @override
   String toString(){
      return super.toString() + "\t$_ChucVu\t$_heSoChuVu";
   }
   
   @override
   double tinhLuong(){
       return super.tinhLuong() + _heSoChuVu * 1100;
   }

}