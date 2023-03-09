import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'login.dart';
import 'welcome.dart';
import '../settings/shared/data-shared.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _typeinput = GlobalKey<FormState>();
  final TextEditingController _inputUser = TextEditingController();
  final TextEditingController _inputPass = TextEditingController();
  final TextEditingController _inputconPass = TextEditingController();

  String dropdownValue = 'ลูกค้าทั่วไป';

  var items = ['ลูกค้าทั่วไป', 'แม่ค้าขายผัก', 'ไรเดอร์'];

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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WelcomePage(),
                ),
              );
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF505050),
                    ),
                  ),
                ),
              ),
            )
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
                        vertical: 20,
                        horizontal: 50,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Color(0xFF505050),
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'โปรดกรอกชื่อผู้ใช้และรหัสผ่านไว้ แล้วเลือกตำแหน่งการใช้งานของคุณ เราจะติดต่อคุณกลับให้ไวทีสุด',
                            style: TextStyle(
                              color: Color(0xFF505050),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                            textAlign: TextAlign.start,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
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
                        vertical: 50,
                        horizontal: 30,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              controller: _inputUser,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your username';
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
                                  vertical: 18,
                                  horizontal: 30,
                                ),
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
                                  return 'Please enter your password';
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
                                  vertical: 18,
                                  horizontal: 30,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: brightness == Brightness.light
                                        ? Colors.white
                                        : Colors.black,
                                  ),
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
                              controller: _inputconPass,
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                } else if (value != _inputPass.text) {
                                  return 'Password not match';
                                }
                                return null;
                              },
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(25)
                              ],
                              decoration: InputDecoration(
                                hintText: "Confirm Password",
                                hintStyle: const TextStyle(color: Colors.grey),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 18,
                                  horizontal: 30,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: brightness == Brightness.light
                                        ? Colors.white
                                        : Colors.black,
                                  ),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'ตำแหน่ง',
                                style: TextStyle(color: Color(0xFF505050)),
                              ),
                              const SizedBox(width: 20),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFBE8C6),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: DropdownButton(
                                  value: dropdownValue,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  items: items.map(
                                    (String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(
                                          items,
                                          style: const TextStyle(
                                            color: Color(0xFF505050),
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      dropdownValue = value!;
                                    });
                                  },
                                  underline: const SizedBox(),
                                ),
                              ),
                            ],
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
                                minimumSize: const Size.fromHeight(15)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 20,
                              ),
                              child: Text(
                                'Sign Up',
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
                                    vertical: 15,
                                    horizontal: 20,
                                  ),
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
                                            fontWeight: FontWeight.w700),
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
