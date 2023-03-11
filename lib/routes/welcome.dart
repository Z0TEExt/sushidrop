import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'login.dart';
import 'register.dart';
import '../settings/shared/data-shared.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool animate = false;

  Future internetDialog(
    bool isWifi,
    bool isMobile,
    bool isVPN,
    bool isEthernet,
  ) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          title: const Text('Connection Lost'),
          content: const Text('โปรดตรวดสอบการเชื่อมต่อของคุณ'),
          actions: [
            TextButton(
              onPressed: () {
                if (isWifi || isMobile) {
                  return getDataFromLocal();
                } else if (isVPN || isEthernet) {
                  return getDataFromLocal();
                } else {
                  Navigator.of(context, rootNavigator: true).pop(false);
                  return checkIsOnline();
                }
              },
              child: const Text('Okay!'),
            )
          ],
        );
      },
    );
  }

  void checkIsOnline() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    bool isVPN = connectivityResult == ConnectivityResult.vpn;
    bool isWifi = connectivityResult == ConnectivityResult.wifi;
    bool isMobile = connectivityResult == ConnectivityResult.mobile;
    bool isEthernet = connectivityResult == ConnectivityResult.ethernet;

    await Future.delayed(const Duration(milliseconds: 1000));

    if (isWifi || isMobile) {
      getDataFromLocal();
    } else if (isVPN || isEthernet) {
      getDataFromLocal();
    } else {
      internetDialog(isWifi, isMobile, isVPN, isEthernet);
    }
  }

  void getDataFromLocal() {
    UserData().loadData().then(
      (value) {
        if (UserData.userName == null && UserData.userID == null) {
          Future.delayed(const Duration(milliseconds: 500), () {
            setState(() => animate = true);
          });
        } else {
          Future.delayed(const Duration(milliseconds: 500), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          });
        }
      },
    );
  }

  @override
  void initState() {
    checkIsOnline();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var brightness =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    var query = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(
                      'assets/images/icon/sushidrop_icon.png',
                    ),
                  ),
                  Text(
                    'SushiDrop',
                    style: TextStyle(
                      color:
                          brightness ? const Color(0xFF505050) : Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Delivery',
                    style: TextStyle(
                      color:
                          brightness ? const Color(0xFF505050) : Colors.white,
                      fontSize: 16,
                      letterSpacing: 4,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 0,
              child: AnimatedContainer(
                height: animate ? query.height * 0.35 : 0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOutSine,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  color: Color(0xFFFBE8C6),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 50,
                ),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ยินดีต้อนรับ',
                        style: TextStyle(
                          color: Color(0xFF505050),
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      const Text(
                        'เราจะส่งของให้ถึงคุณภายในไม่ถึงเสี้ยววิแต่ก่อนขั้นตอนแรก โปรดเข้าสู่ระบบเพื่อใช้บริการของเราก่อนนะ',
                        style: TextStyle(
                          color: Color(0xFF505050),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF303030),
                                shape: const StadiumBorder(),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 25,
                                ),
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RegisterPage(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: const StadiumBorder(),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 25),
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Color(0xff303030),
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
