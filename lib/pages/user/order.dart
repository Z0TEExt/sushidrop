import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.05,
          horizontal: MediaQuery.of(context).size.height * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'ออเดอร์ของคุณ',
              style: TextStyle(
                color: Color(0xFF505050),
                fontSize: 30,
              ),
            ),
            ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return orderState(index);
              },
            ),
          ],
        ),
      ),
    );
  }

  String checkOrderText(int state) {
    switch (state) {
      case 0:
        return 'ร้านค้ารับออเด้อของคุณแล้ว';
      case 1:
        return 'ไรเดอร์กำลังจัดส่งให้คุณ';
      case 2:
        return 'กำลังค้นหาไรเดอร์';
      case 3:
        return 'ร้านค้าปฏิเสธออเด้อของคุณ :(';
      default:
        return 'เกิดข้อผิดพพลาดโปรดสั่งใหม่';
    }
  }

  Color checkOrderState(int state) {
    switch (state) {
      case 0:
        return Colors.yellow;
      case 1:
        return Colors.green;
      case 2:
        return Colors.green;
      case 3:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget orderState(int state) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.02,
        horizontal: MediaQuery.of(context).size.height * 0.025,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 30,
        horizontal: 30,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFBE8C6),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(
            TextSpan(children: [
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.circle,
                    color: checkOrderState(state),
                  ),
                ),
              ),
              TextSpan(
                text: checkOrderText(state),
                style: const TextStyle(
                  color: Color(0xFF505050),
                  fontSize: 20,
                ),
              ),
            ]),
          ),
          Text(
            'Order #00$state',
            style: const TextStyle(
              color: Color(0xFF505050),
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
