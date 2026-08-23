import 'dart:io';

void main(){
  stdout.write("Nhập một số nguyên > 10:");
  int n = int.parse(stdin.readLineSync()!);

  if(n <=10){  // Kiểm tra số nguyên nhập vào
    print("Phải nhập số nguyên > 10");
    return;
  }

  // a. Cho biết số nguyên nhập vào là số có bao nhiêu chữ số?
  List<String> Count = n.toString().split("");  // Chuyển thành chuỗi , rùi tách ra từng số
  int soChuSo = Count.length;
  
  // b. Tính tổng các chữ số có trong số nguyên nhập vào.
  int tongso = 0;
  // c. Cho biết số nhập vào có chứa chữ số nào là số lẻ hay không?
  bool sole = false;
  // Tính tổng số và các số lẻ
  for(int i = 0; i < Count.length;i++){
      int giatri = int.parse(Count[i]);
      tongso += giatri;
      if(int.parse(Count[i]) % 2 != 0){  // kiểm tra có chia hết cho 2 kh
        sole = true;
      }
      
  }
  
  // Kết quả
  print("a. Số $n có $soChuSo chữ số.");
  print("b. Tổng các chữ số là: $tongso");
  
  // Nếu có số lẻ thì in ra có và ngược lại
  if (sole) {
    print("c. Số nhập vào CÓ chứa chữ số lẻ.");
  } else {
    print("c. Số nhập vào KHÔNG chứa chữ số lẻ.");
  }


  
}

