import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_models/user_view_model.dart';

class AddressWidget extends StatefulWidget {
  const AddressWidget({Key? key}) : super(key: key);

  @override
  _AddressWidgetState createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  @override
  void initState() {
    super.initState();
    fetchKecamatanName();
  }

  Future<void> fetchKecamatanName() async {
    final userViewModel = context.read<UserViewModel>();
    await userViewModel.fetchKecamatanName(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, userViewModel, child) {
        final user = userViewModel.currentUser;

        if (user == null) {
          return Center(child: Text('No user logged in'));
        }

        return Container(
          height: 120,
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${user.username} - ${user.noHp}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "${user.alamat} - ${userViewModel.kecamatanName ?? user.idKecamatan}",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/AddressEdit');
                        },
                        child: Text(
                          'Edit',
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
