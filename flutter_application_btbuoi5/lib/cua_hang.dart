import 'package:flutter/material.dart';
import 'package:flutter_application_btbuoi5/gio_hang.dart';

class cuahang extends StatefulWidget{
  const cuahang({super.key});

  @override
  State<cuahang> createState() => hienthi();


}

class hienthi extends State<cuahang>{
  List<Map<String, String>> hang = [];
  //dữ liệu mẫu
  final List<Map<String, String>> dsSanPham = [
    {
      "ten": "iPhone 15 Pro",
      "mota": "Điện thoại Apple với chip A17 Pro siêu mạnh",
      "gia": "25000.0",
      "anh": "Images/anh1.png",
    },
    {
      "ten": "Samsung S24 Ultra",
      "mota": "Điện thoại Samsung tích hợp công nghệ AI đỉnh cao",
      "gia": "23000.0",
      "anh": "Images/anh2.png",
    },
    {
      "ten": "Xiaomi 14 Pro",
      "mota": "Điện thoại Xiaomi với camera Leica chuyên nghiệp",
      "gia": "18000.0",
      "anh": "Images/anh3.png",
    },
    {
      "ten": "OPPO Find X7",
      "mota": "Thiết kế sang trọng với khả năng chụp ảnh vượt trội",
      "gia": "16000.0",
      "anh": "Images/anh4.png",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellowAccent,

          title: Text("Cửa hàng điện thoại",style: TextStyle(fontSize: 16,color: Colors.grey),),
          centerTitle: true,
          actions: [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (builder)=>gioHang(gio_hang: hang)));
            }, icon: Icon(Icons.shopping_cart,size: 16,))
          ],

        ),
        drawer: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.only(topRight:Radius.circular(16) )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Padding(padding: EdgeInsets.only(left: 10,top: 40),
                      child: CircleAvatar(
                        backgroundImage: AssetImage("Images/logo.png",),
                        radius: 40,
                      ),
                    ),

                    const SizedBox(height: 10,),
                    Padding(padding: EdgeInsets.only(left: 10),child:
                    Text("Vũ Văn Vinh",style: TextStyle(fontSize: 16),),),

                    const SizedBox(height: 10,),
                    Padding(padding: EdgeInsets.only(left: 10),child:
                    Text("vinhvv@huit.edu.vn",style: TextStyle(fontSize: 16),),),

                  ],
                ),
              ),

              Expanded(child:Container(
                height: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.blue
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.storefront, color: Colors.black),
                      title: const Text('Cửa hàng', style: TextStyle(color: Colors.black)),
                      onTap: (){},
                    ),

                    ListTile(
                      leading: const Icon(Icons.shopping_cart, color: Colors.black),
                      title: const Text('Giỏ hàng', style: TextStyle(color: Colors.black)),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=>gioHang(gio_hang: hang)));
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.black),
                      title: const Text('Thoát', style: TextStyle(color: Colors.black)),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              )
              )
            ],
          ),
        ),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.all(4),
              child: Text("Chọn sản phẩm bạn muốn sử dụng ",style: TextStyle(color: Colors.black,fontSize: 18),),),
            const SizedBox(height: 10,),

            SizedBox(
              height: 420,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dsSanPham.length,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (context, index) {
                  final sp = dsSanPham[index];
                  return Container(
                    width: 200,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // ảnh
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            sp["anh"]!,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // tên sản phẩm
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            sp["ten"]!,
                            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 5),


                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            sp["mota"]!,
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        const Spacer(),

                        //giá và nút thêm
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                sp["gia"]!,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),

                            Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(8),
                                ),
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  //hiển thị dialog xác nhận
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext dialogContext) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        backgroundColor: Colors.grey.shade200,
                                        title: const Text(
                                          "Xác nhận",
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        content: const Text("Bạn vừa thêm sản phẩm vào Giỏ hàng"),
                                        actions: [
                                          // Nút Không
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(dialogContext);// đóng gialogContent
                                            },
                                            child: const Text(
                                              "Không",
                                              style: TextStyle(color: Colors.black),
                                            ),
                                          ),

                                          //nút Đồng ý
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                hang.add(sp);
                                              });
                                              Navigator.pop(dialogContext);// đóng gialogContent
                                            },
                                            child: const Text(
                                              "Đồng ý",
                                              style: TextStyle(color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(Icons.add, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10,),
            Padding(padding: EdgeInsets.all(4),
              child: Text("Sản phẩm được chọn nhều nhất ",style: TextStyle(color: Colors.black,fontSize: 18),),)
          ],
        ),
      ),
    );
  }
}