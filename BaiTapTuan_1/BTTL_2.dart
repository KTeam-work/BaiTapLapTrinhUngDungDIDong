import 'dart:io';

void main(){
  stdout.write("Nhập một số nguyên > 10:");
  int n = int.parse(stdin.readLineSync()!);

  if(n <=10){
    print("Phải nhập số nguyên > 10");
    return;
  }

  // a. Cho biết số nguyên nhập vào là số có bao nhiêu chữ số?
  List<String> Count = n.toString().split("");
  int soChuSo = Count.length;
  
  // b. Tính tổng các chữ số có trong số nguyên nhập vào.
  int tongso = 0;
  // c. Cho biết số nhập vào có chứa chữ số nào là số lẻ hay không?
  bool sole = false;
  for(int i = 0; i < Count.length;i++){
      int giatri = int.parse(Count[i]);
      tongso += giatri;
      if(int.parse(Count[i]) % 2 != 0){
        sole = true;
      }
      
  }
  
  // Kết quả
  print("a. Số $n có $soChuSo chữ số.");
  print("b. Tổng các chữ số là: $tongso");
  
  if (sole) {
    print("c. Số nhập vào CÓ chứa chữ số lẻ.");
  } else {
    print("c. Số nhập vào KHÔNG chứa chữ số lẻ.");
  }


  
}

