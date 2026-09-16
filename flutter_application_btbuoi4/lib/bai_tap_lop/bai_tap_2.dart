import 'package:flutter/material.dart';

class gioithieu extends StatelessWidget {
  const gioithieu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bai_2',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cơ sở vật chất HUIT'),
          centerTitle: true,
        ),

        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.school,
                size: 100,
              ),
              SizedBox(height: 20),
              Text(
                'Cơ sở vật chất HUIT',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Giới thiệu cơ sở vật chất\n'
                    'Trường Đại học Công thương TP.HCM',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Trường',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              label: 'Thư viện',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sports_soccer),
              label: 'Thể thao',
            ),
          ],
        ),
      ),
    );
  }
}