
import 'dart:math';
import 'dart:io';


bool CheckDoiXung(List<int> ds){
    if(ds.isEmpty) return false;
    
    for(int i =0; i < ds.length/2;i++){
      if(ds[i] != ds[ds.length-i - 1]){
        return false;
      }
    }
    return true;
    
  
}


bool CheckTangDan(List<int> ds){
  if(ds.isEmpty) return false;
      
      for(int i =0; i <= ds.length - 1;i++){
        if(ds[i] != ds[i+1]){
          return false;
        }
      }
      return true;
}

void main(){
  Random random = Random();
  stdout.write('Nhập số lượng số cần tạo: ');
  int n = int.parse(stdin.readLineSync()!);

  List<int> ds = List.generate(
    n, 
    (_) => 5 + random.nextInt(96) );

  // a. Hãy xuất các phần tử trong danh sách ra màn hình. 
  print("Danh sách các phần tử: $ds");

  // b. Tính trung bình cộng các số lẻ có trong danh sách. Nếu danh sách không có số lẻ hãy thông báo: Danh sách không có số lẻ.
  List<int> DssoLe = ds.where((t) => t % 2 != 0).toList();

  if(DssoLe.isEmpty){
    print('Danh sách không có số lẻ.');
  }else{
    int SumsoLe = DssoLe.fold(0, (a,b)=> a+ b);
    double TBcong = SumsoLe / DssoLe.length;
    print('Các số lẻ có trong danh sách: $DssoLe\n');
    print('Trung bình cộng các số lẻ là: $TBcong\n');
  }

  if(CheckDoiXung((ds))){
    print('Danh sách là danh sách ĐỐI XỨNG.\n');
  }else{
    print('Danh sách KHÔNG PHẢI là danh sách đối xứng.\n');
  }

  // d. Hãy cho biết danh sách tạo ra có được sắp xếp tăng dần hay không?
  if(CheckTangDan(ds)){
    print('Danh sách là danh sách tăng dần.\n');;
  }else{
    print('Danh sách là danh sách không tăng dần.\n');
  }

  // e. Tìm phần tử lớn nhất có trong danh sách.
  int MaxSo = ds.reduce(max);
  print("Phần tử lớn nhất trong mảng: $MaxSo\n");

  //f. Tìm phần tử là số chẵn lớn nhất. Nếu danh sách không có số chẵn hãy thông báo danh sách h ông có số chẵn.
  List<int> DsSoChan = ds.where((t) => t % 2 == 0).toList();

  if(DsSoChan.isEmpty){
    print("Danh sách không có số chẵn");
  }else{
    int SoChanMAx = DsSoChan.reduce(max);
    print("Số chẵn lớn nhất: $SoChanMAx\n");
  }
   
//   g. Hãy nhập một giá trị, tìm xem giá trị vừa nhập có trong danh sách hay không?
// Nếu danh sách không có giá trị vừa nhập, hãy thông báo: Không tìm thấy. Nếu
// tìm thấy, hãy xóa các phần tử có cùng giá trị với giá trị vừa nhập.
  stdout.write('Hãy nhập giá trị: ');
  int giatri = int.parse(stdin.readLineSync()!);

  if(ds.contains(giatri)){
       ds.removeWhere((t)=> t == giatri);
       print("Danh sách còn lại: $ds");
  }else{
    print("Không tìm thấy giá trị trong danh sách");
  }



}