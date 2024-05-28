import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../view_models/user_view_model.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, userViewModel, child) {
        final user = userViewModel.currentUser;

        final username = user?.username ?? "Nama Pengguna";
        final email = user?.email ?? "email@example.com";

        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
            ),
            SizedBox(
              height: 105,
              width: 105,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/profile.jpg"),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20), // Add spacing between profile picture and text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5), // Add spacing between name and email
                Text(
                  email,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
