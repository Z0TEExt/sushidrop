import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'order_process.dart';

class StorePage extends StatefulWidget {
  final String storeName;
  final String storeImg;
  const StorePage({super.key, required this.storeImg, required this.storeName});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color(0xFFFBE8C6),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: backgroundLogo(),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                        icon: const Icon(
                          Icons.navigate_before_rounded,
                          size: 30,
                          color: Color(0xFF505050),
                        ),
                        onPressed: () => Navigator.pop(context)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 75,
                            backgroundColor: Colors.white,
                            child: Image.asset(widget.storeImg),
                          ),
                          const SizedBox(width: 20),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              'ร้าน\n${widget.storeName}',
                              style: const TextStyle(
                                color: Color(0xFF505050),
                                fontSize: 26,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: ListView.builder(
                          itemCount: 5,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return menuFood();
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrderProcess()));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: MediaQuery.of(context).size.width * 0.2),
                backgroundColor: Colors.white,
                shape: const StadiumBorder(),
              ),
              child: const Text(
                'สั่งเลย หิวข้าวแล้วว',
                style: TextStyle(
                  color: Color(0xFF505050),
                  fontSize: 16,
                  fontFamily: 'Kanit',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget menuFood() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
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
            child: Image.asset(
              widget.storeImg,
              height: 100,
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'กะเพราหมู',
            style: TextStyle(
              color: Color(0xFF505050),
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }

  Widget randomImage(double x, bool state) {
    return Transform.rotate(
      angle: x,
      child: Image.asset(widget.storeImg,
          height: 200, color: state ? const Color(0xFF505050) : null),
    );
  }

  Widget backgroundLogo() {
    return Stack(
      children: [
        Positioned(
          left: -50,
          child: randomImage(-math.pi / 3, false),
        ),
        Positioned(
          bottom: -50,
          left: 50,
          child: randomImage(math.pi / 5, true),
        ),
        Positioned(
          top: 75,
          left: 200,
          child: randomImage(-math.pi / 8, false),
        ),
        Positioned(
          top: -60,
          right: -50,
          child: randomImage(math.pi / 15, true),
        ),
      ],
    );
  }
}
