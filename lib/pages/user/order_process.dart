import 'package:flutter/material.dart';

import '../../routes/home.dart';

class OrderProcess extends StatefulWidget {
  const OrderProcess({super.key});

  @override
  State<OrderProcess> createState() => _OrderProcessState();
}

class _OrderProcessState extends State<OrderProcess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/waiting_man.png'),
                  const Text(
                    'ออเดอร์ของคุณกำลังถูกจัดเตรียม โปรดรอสักครู่...',
                    style: TextStyle(
                      color: Color(0xFF505050),
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(
                  bottom: 20,
                  left: MediaQuery.of(context).size.width * 0.2,
                  right: MediaQuery.of(context).size.width * 0.2),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: const Color(0xFFFBE8C6),
                  shape: const StadiumBorder(),
                  minimumSize: const Size.fromHeight(10),
                ),
                child: const Text(
                  'กลับหน้าหลัก',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
