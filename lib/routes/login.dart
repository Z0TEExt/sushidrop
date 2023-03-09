import 'dart:math';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'welcome.dart';
import 'register.dart';
import '../settings/shared/data-shared.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _typeinput = GlobalKey<FormState>();
  final TextEditingController _inputUser = TextEditingController();
  final TextEditingController _inputPass = TextEditingController();

  String userRole(String name) {
    switch (name) {
      case 'a':
        return 'user';
      case 'b':
        return 'store';
      case 'c':
        return 'rider';
      default:
        return 'null role';
    }
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFFBE8C6),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.navigate_before_rounded,
              size: 30,
              color: Color(0xFF505050),
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WelcomePage(),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ),
                  );
                },
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF505050),
                    ),
                  ),
                ),
              ),
            ),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            key: _typeinput,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sign In',
                            style: TextStyle(
                              color: Color(0xFF505050),
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: Text(
                              'สวัสดีวัน ${DateFormat('EEEE').format(DateTime.now())} ที่ ${DateFormat('d').format(DateTime.now())}\nโปรดเข้าสู่ระบบด้วยชื่อผู้ใช้และรหัสผ่านหรือเข้าสู่ระบบด้วยบัญชีออนไลน์ของคุณ',
                              softWrap: true,
                              style: const TextStyle(
                                color: Color(0xFF505050),
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          vertical: 50, horizontal: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              controller: _inputUser,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter you username';
                                }
                                return null;
                              },
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(25)
                              ],
                              decoration: InputDecoration(
                                hintText: "Username",
                                hintStyle: const TextStyle(color: Colors.grey),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18, horizontal: 30),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: brightness == Brightness.light
                                          ? Colors.white
                                          : Colors.black),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                fillColor: brightness == Brightness.light
                                    ? Colors.white
                                    : const Color(0xFF303030),
                                filled: true,
                              ),
                              style: TextStyle(
                                color: brightness == Brightness.light
                                    ? const Color(0xFF505050)
                                    : Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              controller: _inputPass,
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter you username';
                                }
                                return null;
                              },
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(25)
                              ],
                              decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: const TextStyle(color: Colors.grey),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18, horizontal: 30),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: brightness == Brightness.light
                                          ? Colors.white
                                          : Colors.black),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                fillColor: brightness == Brightness.light
                                    ? Colors.white
                                    : const Color(0xFF303030),
                                filled: true,
                              ),
                              style: TextStyle(
                                color: brightness == Brightness.light
                                    ? const Color(0xFF505050)
                                    : Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),
                          ElevatedButton(
                            onPressed: () async {
                              if (_typeinput.currentState!.validate()) {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setInt(
                                  'userID',
                                  Random().nextInt(10000),
                                );
                                await prefs.setString(
                                  'userName',
                                  _inputUser.text,
                                );
                                // userName 'a'=user 'b'=store 'c'=rider
                                await prefs.setString(
                                    'userRole', userRole(_inputUser.text));
                                UserData().loadData().then(
                                  (_) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HomePage(),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: brightness == Brightness.light
                                  ? const Color(0xFF303030)
                                  : Colors.white,
                              shape: const StadiumBorder(),
                              minimumSize: const Size.fromHeight(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  color: brightness == Brightness.light
                                      ? Colors.white
                                      : const Color(0xFF303030),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'or',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: const StadiumBorder(),
                                  minimumSize: const Size.fromHeight(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        'assets/images/facebook_icon.png',
                                        height: 30,
                                      ),
                                      const Text(
                                        'Continue with Facebook',
                                        style: TextStyle(
                                          color: Color(0xFF505050),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const Icon(Icons.navigate_next_rounded),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: const StadiumBorder(),
                                  minimumSize: const Size.fromHeight(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 20,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        'assets/images/google_icon.png',
                                        height: 30,
                                      ),
                                      const Text(
                                        'Continue with Google',
                                        style: TextStyle(
                                          color: Color(0xFF505050),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const Icon(Icons.navigate_next_rounded),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
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
