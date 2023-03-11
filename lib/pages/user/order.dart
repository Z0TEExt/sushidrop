import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../widgets/toast.dart';
import 'order_process.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  FToast? fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast!.init(context);
  }

  @override
  Widget build(BuildContext context) {
    var brightness =
        MediaQuery.of(context).platformBrightness == Brightness.light;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.05,
          horizontal: MediaQuery.of(context).size.height * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'ออเดอร์ของคุณ',
              style: TextStyle(
                color: brightness ? const Color(0xFF505050) : Colors.white,
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
    int error = 0;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.02,
        horizontal: MediaQuery.of(context).size.height * 0.025,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFBE8C6),
        borderRadius: BorderRadius.circular(50),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              if (state >= 0 && state <= 3) {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: const OrderProcess(),
                  withNavBar: false,
                );
              } else {
                if (error < 3) {
                  fToast!.showToast(
                    child: const ToastMessage(
                      msg: 'เกิดข้อผิดพลาด',
                    ),
                    gravity: ToastGravity.BOTTOM,
                    toastDuration: const Duration(seconds: 2),
                  );
                  error += 1;
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
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
                      ],
                    ),
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
            ),
          ),
        ),
      ),
    );
  }
}
