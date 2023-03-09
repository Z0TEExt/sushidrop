import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/data_store.dart';
import 'providers/cal_store.dart';
import 'providers/img_store.dart';

import 'routes/welcome.dart';
import 'settings/theme/theme.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DataStore(),
        ),
        ChangeNotifierProvider(
          create: (context) => CalStore(),
        ),
        ChangeNotifierProvider(
          create: (context) => ImgStore(),
        )
      ],
      child: MaterialApp(
        theme: lightModeTheme(context),
        darkTheme: darkModeTheme(context),
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: const WelcomePage(),
      ),
    );
  }
}
