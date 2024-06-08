import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/profile_pic.dart';
import 'components/profile_menu.dart';
import '../../view_models/user_view_model.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 10),
              child: Text(
                "My Profile",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ProfilePic(),
            ),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "My orders",
              icon: "assets/icons/Cart Icon.svg",
              press: () {
                Navigator.pushNamed(context, "/Orders");
              },
            ),
            ProfileMenu(
              text: "Settings",
              icon: "assets/icons/Settings.svg",
              press: () {
                Navigator.pushNamed(context, "/EditProfile");
              },
            ),
            // ProfileMenu(
            //   text: "Help Center",
            //   icon: "assets/icons/Question mark.svg",
            //   press: () {},
            // ),
            ProfileMenu(
              text: "Log Out",
              icon: "assets/icons/Log out.svg",
              press: () {
                context.read<UserViewModel>().logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
