import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'welcome.dart';
import '../project/calculator.dart';

class MenuProject extends StatefulWidget {
  const MenuProject({super.key});

  @override
  State<MenuProject> createState() => _MenuProjectState();
}

class _MenuProjectState extends State<MenuProject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CalculatorPage()));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              icon: const Icon(Icons.calculate),
              label: const Text('Calculator'),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('userID');
                await prefs.remove('userName').then(
                  (_) {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: const WelcomePage(),
                      withNavBar: false,
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              icon: const Icon(Icons.exit_to_app_rounded),
              label: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
