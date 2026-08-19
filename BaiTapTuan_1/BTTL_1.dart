import 'dart:io';
void main(){
    stdout.write('Nhập số lượng que kem cần mua(>0): ');
    int n = int.parse(stdin.readLineSync()!);

    if(n <= 0){ // Kiểm tra đk
       print('Số lượng que kem phải lớn hơn 0!');
       return;
    }

    stdout.write('Nhập giá tiền của 1 que kem: ');
    double money = double.parse(stdin.readLineSync()!);

    if(money <= 0){
       print('Tiền phải lớn > 0!');
       return;
    }
    double tongtien = 0;
    if(n > 10){
        tongtien = (n * money) - ((n * money) * 0.10);
    }else if(n >= 5){
        tongtien = (n * money) - ((n * money) * 0.05);
    }else{
        tongtien  = n * money;
    }

   print('Số lượng mua: $n que');
   print('Tổng tiền ban đầu: ${tongtien.toStringAsFixed(0)} VNĐ');




}