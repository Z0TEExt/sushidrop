import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'menu_store_page.dart';

class UserWidget extends StatelessWidget {
  final String userName;

  const UserWidget({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            decoration: const BoxDecoration(
              color: Color(0xFFFBE8C6),
            ),
          ),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                const SizedBox(height: 50),
                const Text(
                  "สวัสดีวันจันทร์ เช้าที่สดใส",
                  style: TextStyle(
                    color: Color(0xFF505050),
                    fontSize: 30,
                  ),
                ),
                Text(
                  "คุณ $userName",
                  style: const TextStyle(
                    color: Color(0xFF505050),
                    fontSize: 26,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'วันนี้กินอะไรดี?',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'ร้านอาหารที่คุณเคยกิน',
                    style: TextStyle(
                      color: Color(0xFF505050),
                      fontSize: 26,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 25,
                      mainAxisSpacing: 25,
                      children: const <Widget>[
                        StoreMenu(
                          title: 'กะเพราประจำใจ',
                          imgSrc: 'assets/images/food1.png',
                          pushScreen: StorePage(
                            storeName: 'กะเพราประจำใจ',
                            storeImg: 'assets/images/food1.png',
                          ),
                        ),
                        StoreMenu(
                          title: 'เบอร์เกอร์อะไรเอ่ย',
                          imgSrc: 'assets/images/food2.png',
                          pushScreen: StorePage(
                            storeName: 'เบอร์เกอร์อะไรเอ่ย',
                            storeImg: 'assets/images/food2.png',
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}

class StoreMenu extends StatelessWidget {
  final String title;
  final String imgSrc;
  final Widget pushScreen;

  const StoreMenu(
      {super.key,
      required this.title,
      required this.imgSrc,
      required this.pushScreen});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 15,
            offset: const Offset(0, 0.75),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: pushScreen,
                withNavBar: false,
              );
            },
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Image.asset(
                    imgSrc,
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF505050),
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
