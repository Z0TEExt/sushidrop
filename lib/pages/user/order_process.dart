import 'package:flutter/material.dart';

import '../main/chat.dart';
import '../main/map.dart';

class OrderProcess extends StatefulWidget {
  const OrderProcess({super.key});

  @override
  State<OrderProcess> createState() => _OrderProcessState();
}

class _OrderProcessState extends State<OrderProcess> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Text(
                  'สถานะออเดอร์ของคุณ',
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 50),
                orderStatus(
                  Icons.store_rounded,
                  const Color(0xFFFFD281),
                  1,
                  'ร้านค้ารับออเด้อของคุณแล้ว',
                ),
                spaceBox(),
                orderStatus(
                  Icons.search_rounded,
                  const Color(0xFFFFD281),
                  0,
                  'กำลังค้นหาไรเดอร์',
                ),
                spaceBox(),
                orderStatus(
                  Icons.delivery_dining_rounded,
                  const Color(0xFF505050),
                  404,
                  'ไรเดอร์กำลังจัดส่งให้คุณ',
                ),
                spaceBox(),
                orderStatus(
                  Icons.playlist_add_circle_rounded,
                  const Color(0xFF505050),
                  404,
                  'จัดส่งสำเร็จ',
                ),
                const SizedBox(height: 100),
                menubottom()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget spaceBox() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: 100,
        width: 10,
        margin: const EdgeInsets.only(left: 40),
        color: Colors.white,
      ),
    );
  }

  Widget orderStatus(IconData logo, Color isPass, int state, String status) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                logo,
                color: isPass,
                size: 50,
              ),
            ),
            if (state == 0)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Colors.yellow,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.timelapse_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            if (state == 1)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Colors.greenAccent,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            if (state == 2)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.do_not_disturb_alt_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 20),
        Text(
          status,
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }

  Widget menubottom() {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChatPage(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            backgroundColor: const Color(0xFFFFD281),
            shape: const StadiumBorder(),
          ),
          child: const Icon(
            Icons.chat_bubble_rounded,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MapPage(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            backgroundColor: const Color(0xFFFFD281),
            shape: const StadiumBorder(),
          ),
          child: const Icon(
            Icons.map_rounded,
            color: Colors.white,
          ),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            backgroundColor: const Color(0xFFFFD281),
            shape: const StadiumBorder(),
          ),
          child: const Text(
            'กลับหน้าหลัก',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ],
    );
  }
}
