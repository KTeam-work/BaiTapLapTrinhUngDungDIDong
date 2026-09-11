import 'package:flutter/material.dart';

class nganh extends StatelessWidget {
  const nganh({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HuitHomeScreen(),
    );
  }
}

class HuitHomeScreen extends StatelessWidget {
  const HuitHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0265B9),
        title: const Row(
          children: [
            Icon(Icons.school, color: Colors.white, size: 28),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ĐẠI HỌC CÔNG THƯƠNG TP.HCM', style: TextStyle(fontSize: 10, color: Colors.white)),
                Text('KHOA CÔNG NGHỆ THÔNG TIN', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
          ],
        ),
        actions: const [
          Icon(Icons.menu, color: Colors.white),
          SizedBox(width: 10),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              //kết nối tri thức
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Kiến tạo tri thức\nKết nối tương lai', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text('Khoa Công nghệ Thông tin\n– Trường ĐH Công thương TP.HCM', style: TextStyle(fontSize: 11, color: Colors.grey)),
                        ],
                      ),
                    ),
                    Icon(Icons.location_city, size: 60, color: Color(0xFF0265B9)),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              //ngành công nghệ thông tin
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F9FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.code, color: Color(0xFF0284C7), size: 30),
                        SizedBox(width: 10),
                        Text('NGÀNH CÔNG NGHỆ THÔNG TIN (CNTT)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0284C7))),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text('Đào tạo nguồn nhân lực chất lượng cao trong lĩnh vực công nghệ thông tin, đáp ứng nhu cầu chuyển đổi số và phát triển công nghệ hiện đại.', style: TextStyle(fontSize: 12)),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        Icon(Icons.check_circle, color: Color(0xFF0284C7), size: 16),
                        SizedBox(width: 5),
                        Text('Lập trình và phát triển phần mềm', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Row(
                      children: [
                        Icon(Icons.check_circle, color: Color(0xFF0284C7), size: 16),
                        SizedBox(width: 5),
                        Text('Quản trị hệ thống và mạng', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Row(
                      children: [
                        Icon(Icons.check_circle, color: Color(0xFF0284C7), size: 16),
                        SizedBox(width: 5),
                        Text('Trí tuệ nhân tạo, dữ liệu lớn, đám mây', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0284C7)),
                      onPressed: () {},
                      child: const Text('Tìm hiểu thêm', style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              //ngàng an toàn thông tin
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.shield, color: Color(0xFF059669), size: 30),
                        SizedBox(width: 10),
                        Text('NGÀNH AN TOÀN THÔNG TIN (ATTT)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF059669))),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text('Trang bị kiến thức và kỹ năng bảo vệ hệ thống, dữ liệu và thông tin trong môi trường số, góp phần xây dựng một không gian mạng an toàn.', style: TextStyle(fontSize: 12)),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        Icon(Icons.check_circle, color: Color(0xFF059669), size: 16),
                        SizedBox(width: 5),
                        Text('Bảo mật mạng và hệ thống', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Row(
                      children: [
                        Icon(Icons.check_circle, color: Color(0xFF059669), size: 16),
                        SizedBox(width: 5),
                        Text('Phân tích và phòng chống tấn công mạng', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Row(
                      children: [
                        Icon(Icons.check_circle, color: Color(0xFF059669), size: 16),
                        SizedBox(width: 5),
                        Text('An toàn dữ liệu và quản trị rủi ro', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF059669)),
                      onPressed: () {},
                      child: const Text('Tìm hiểu thêm', style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}