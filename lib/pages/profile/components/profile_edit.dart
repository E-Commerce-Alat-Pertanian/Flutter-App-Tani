import 'package:app_tani_sejahtera/widgets/form_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/user_model.dart';
import '../../../view_models/user_view_model.dart';
import '../../address/address_page.dart'; // Import AddressWidget

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  String foto = "";

  @override
  void initState() {
    super.initState();
    final user = context.read<UserViewModel>().currentUser;
    if (user != null) {
      _usernameController.text = user.username;
      _emailController.text = user.email;
    }
  }

  void submitUpdate() async {
    final userViewModel = context.read<UserViewModel>();
    final username = _usernameController.text;
    final email = _emailController.text;

    String error = await userViewModel.updateUsername(username, email);

    if (error.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );
      Navigator.pushNamed(context, "/main");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    }
  }

  void gantiFoto() async {
    // Your implementation for changing the photo
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserViewModel>().currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 110,
                width: 110,
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage("assets/images/profile.jpg"),
                    ),
                    Positioned(
                      right: -16,
                      bottom: 0,
                      child: SizedBox(
                        height: 46,
                        width: 46,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: const BorderSide(color: Colors.white),
                            ),
                            backgroundColor: const Color(0xFFF5F6F9),
                          ),
                          onPressed: gantiFoto,
                          child: Icon(Icons.camera_alt),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              FormInput(
                hintText: user?.username ?? 'Enter your username',
                controller: _usernameController,
              ),
              SizedBox(height: 20),
              FormInput(
                hintText: user?.email ?? 'Enter your email',
                controller: _emailController,
              ),
              SizedBox(height: 20),
              AddressWidget(), // Include the AddressWidget
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitUpdate, // Call the function correctly
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
