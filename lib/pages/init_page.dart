import 'package:app_tani_sejahtera/pages/cart/cart_page.dart';
import 'package:app_tani_sejahtera/pages/favorite/favorite.dart';
import 'package:app_tani_sejahtera/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app_tani_sejahtera/pages/home/home_page.dart';
import 'package:app_tani_sejahtera/constants.dart';

// import 'package:app_tani_sejahtera/pages/home/';
const Color inActiveIconColor = Color(0xFFB6B6B6);

class InitPage extends StatefulWidget {
  const InitPage({Key? key}) : super(key: key);

  // static String routeName = "/";

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  int currentSelectedIndex = 0;

  void updateCurrentIndex(int index) {
    setState(() {
      currentSelectedIndex = index;
    });
  }

  final pages = [
    const HomePage(),
    const FavoritePage(),
    const CartPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: updateCurrentIndex,
        currentIndex: currentSelectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/home.svg",
              color:
                  currentSelectedIndex == 0 ? kPrimaryColor : inActiveIconColor,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/Heart Icon.svg",
              color:
                  currentSelectedIndex == 1 ? kPrimaryColor : inActiveIconColor,
            ),
            label: "Fav",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/order.svg",
              color:
                  currentSelectedIndex == 2 ? kPrimaryColor : inActiveIconColor,
            ),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/User Icon.svg",
              color:
                  currentSelectedIndex == 3 ? kPrimaryColor : inActiveIconColor,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
