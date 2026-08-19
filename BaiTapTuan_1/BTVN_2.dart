// Bài tập 2. Hãy viết chương trình thực hiện các yêu cầu sau:
// a. Nhập vào 1 chuỗi và xuất chuỗi đó ra màn hình
// b. Cho biết chuỗi có bao nhiêu kí tự là nguyên âm?
// c. Cho biết chuỗi có bao nhiêu từ?
// d. Cho biết chuỗi có đối xứng hay không?
// e. Đảo ngược từ trong chuỗi. Ví dụ: Bò ăn cỏ ➔ cỏ ăn Bò

import 'dart:io';

void main(){
  stdout.write("Nhập một chuỗi: ");
  String chuoi = stdin.readLineSync()!;
  
  // a. Nhập vào 1 chuỗi và xuất chuỗi đó ra màn hình
  print("Chuỗi là: $chuoi");
  
  // b. Cho biết chuỗi có bao nhiêu kí tự là nguyên âm?
  List<String> nguyenAm = ['a', 'e', 'i', 'o', 'u'];
  List<String> dschuoi = chuoi.toLowerCase().split('');
  int soNguyenAm = dschuoi.where((t) => nguyenAm.contains(t)).toList().length;
  
  if(soNguyenAm == 0){
    print("Không có ký tự nguyên âm");
  }else{
    print("Có $soNguyenAm ký tự nguyên âm");
  }

  // c. Cho biết chuỗi có bao nhiêu từ?
  List<String> dsTu =  chuoi.trim().split(' ');
  int Tu = dsTu.length;
  print("Có $Tu từ!\n");

  // d. Cho biết chuỗi có đối xứng hay không?
  bool DoiXung= true;
  for(int i =0; i < dschuoi.length/2;i++){
    if(dschuoi[i] != dschuoi[dschuoi.length- 1 - i]){
      DoiXung = false;
      break;
    }
  }

  if(DoiXung){
    print("Là danh sách đối xứng");
  }else{
    print("không phải danh sách đối xứng");
  }

  // e. Đảo ngược từ trong chuỗi. Ví dụ: Bò ăn cỏ ➔ cỏ ăn Bò
  String chuoiDaoNguoi = dsTu.reversed.join(' ');

  print('Chuỗi sau khi đảo ngược từ: $chuoiDaoNguoi');
}






