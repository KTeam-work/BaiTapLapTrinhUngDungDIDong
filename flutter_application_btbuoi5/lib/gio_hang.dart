import 'package:flutter/material.dart';

class gioHang extends StatefulWidget {
  final List<Map<String, String>> gio_hang;
  const gioHang({super.key, required this.gio_hang});

  @override
  State<gioHang> createState() => hienthiGioHang();
}

class hienthiGioHang extends State<gioHang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,
        //bắt sự kiện bấm nút mũi tên quay lại trang Cửa hàng
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 20),
          onPressed: () {
           Navigator.pop(context);
          },
        ),
        title: const Text(
          "Giỏ hàng của bạn",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        centerTitle: true,
      ),
      body: widget.gio_hang.isEmpty
          ? const Center(
        child: Text(
          "Giỏ hàng của bạn đang trống",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              "Giỏ hàng của bạn",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          //danh sách giỏ hàng
          Expanded(
            child: ListView.builder(
              itemCount: widget.gio_hang.length,
              itemBuilder: (context, index) {
                final item = widget.gio_hang[index];
                return ListTile(
                  title: Text(
                    item["ten"] ?? "",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(item["gia"] ?? ""),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.black),
                    onPressed: () {
                      setState(() {
                        widget.gio_hang.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: ElevatedButton(
          onPressed: () {
            //kiểm tra giỏ hàng
            if (widget.gio_hang.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Giỏ hàng của bạn đang trống!")),
              );
              return;
            }

            //xóa dữ liệu giỏ hàng
            setState(() {
              widget.gio_hang.clear();
            });

            //hiển thị thanh toán
            showDialog(
              context: context,
              builder: (BuildContext dialogContext) {
                //tự đóng sau 1.5 giấy
                Future.delayed(const Duration(milliseconds: 1500), () {
                  if (dialogContext.mounted) {
                    Navigator.pop(dialogContext);
                  }
                });

                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.grey.shade200,
                  title: const Text(
                    "Thanh toán",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  content: const Text("Bạn đã thanh toán xong giỏ hàng"),
                );
              },
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.greenAccent,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            "Thanh toán",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}