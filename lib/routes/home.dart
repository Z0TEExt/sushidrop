import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../pages/user/order.dart';
import 'menu_project.dart';
import '../pages/user/user_ui.dart';
import '../pages/main/chat.dart';
import '../pages/main/map.dart';
import '../settings/shared/data-shared.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: PersistentTabView(
          context,
          navBarStyle: NavBarStyle.style7,
          screens: appRoute(),
          items: bottomNavbar(),
        ),
      ),
    );
  }

  Widget homePage() {
    switch (UserData.userRole) {
      case 'user':
        return UserWidget(userName: UserData.userName.toString());
      case 'store':
        return Container();
      case 'rider':
        return Container();
      default:
        return errorRole();
    }
  }

  List<PersistentBottomNavBarItem> bottomNavbar() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: 'Home',
        activeColorPrimary: Theme.of(context).colorScheme.primary,
        activeColorSecondary: const Color(0xFF505050),
        inactiveColorPrimary: const Color(0xFF505050),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.sticky_note_2),
        title: 'Order',
        activeColorPrimary: Theme.of(context).colorScheme.primary,
        activeColorSecondary: const Color(0xFF505050),
        inactiveColorPrimary: const Color(0xFF505050),
      ),
      // PersistentBottomNavBarItem(
      //   icon: const Icon(CupertinoIcons.chat_bubble),
      //   title: 'Chat',
      //   activeColorPrimary: Theme.of(context).colorScheme.primary,
      //   activeColorSecondary: const Color(0xFF505050),
      //   inactiveColorPrimary: const Color(0xFF505050),
      // ),
      // PersistentBottomNavBarItem(
      //   icon: const Icon(CupertinoIcons.map),
      //   title: 'Map',
      //   activeColorPrimary: Theme.of(context).colorScheme.primary,
      //   activeColorSecondary: const Color(0xFF505050),
      //   inactiveColorPrimary: const Color(0xFF505050),
      // ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.menu_rounded),
        title: 'Menu',
        activeColorPrimary: Theme.of(context).colorScheme.primary,
        activeColorSecondary: const Color(0xFF505050),
        inactiveColorPrimary: const Color(0xFF505050),
      ),
    ];
  }

  List<Widget> appRoute() {
    return [
      homePage(),
      const OrderPage(),
      // const ChatPage(),
      // const MapPage(),
      const MenuProject()
    ];
  }

  Widget errorRole() {
    return Center(
        child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '????????????????????????????????????\n????????? ${UserData.userName} (${UserData.userRole})',
            style: const TextStyle(fontSize: 30),
          ),
          const Text('????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????',
              style: TextStyle(fontSize: 30))
        ],
      ),
    ));
  }
}
