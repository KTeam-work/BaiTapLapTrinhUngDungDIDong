

import 'dart:io';
import 'dart:math';

bool CheckSNT(int n){
    if(n <= 1) return false;

    for(int i = 2; i <= sqrt(n);i++){
      if(n% i ==0){
        return false;
      }
    }

    return true;
}

void main(){
   stdout.write("Nhập số lượng số cần nhập: ");
   int n = int.parse(stdin.readLineSync()!);

   List<int> Marry = [];
   for(int i  =0; i < n;i++){
    stdout.write("Nhập số: ");
    int so = int.parse(stdin.readLineSync()!);
    Marry.add(so);
   }

   // a. Xuất danh sách vừa nhập ra màn hình
   print("Tất cả các giá trị: $Marry\n");

   // b. Tính tổng các phần tử có trong danh sách
   int tongso = Marry.fold(0,(a,b) =>a +b );
   print("Tổng các giá trị: $tongso\n");

   // c. Hãy xuất các phần tử là số nguyên tố có trong danh sách
   for(int i = 0; i < n; i++){
     if(CheckSNT(Marry[i])){
      int kq = Marry[i];
      print("Là số nguyên tố: $kq\n");
     }
   }

  // d. Nhập vào một giá trị bất kỳ, cho biết giá trị đó có trong danh sách hay không? Nếu không có, hãy thêm giá trị đó vào đầu danh sách. Nếu có hãy cho biết giá trị đó ở vị trí nào trong danh sách.
  stdout.write("Nhập một giá trị: ");
  int giatri = int.parse(stdin.readLineSync()!);
  
  if(Marry.contains(giatri)){
    int index = Marry.indexOf(giatri);
    print("Giá trị nằm ở: $index");
  }else{
    Marry.insert(0,giatri);
    print("Tất cả các giá trị: $Marry\n");
  }

}