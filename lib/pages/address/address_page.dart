import 'package:flutter/material.dart';
import 'package:app_tani_sejahtera/models/address.dart';
import 'package:provider/provider.dart';

import '../../view_models/user_view_model.dart';
import '../../view_models/daerah_view_model.dart';

class AddressWidget extends StatefulWidget {
  const AddressWidget({Key? key}) : super(key: key);

  @override
  _AddressWidgetState createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  UserViewModel? _userViewModel;
  String? kecamatanName;

  @override
  void initState() {
    super.initState();
    _userViewModel = context.read<UserViewModel>();
    fetchKecamatanName();
  }

  Future<void> fetchKecamatanName() async {
    final user = _userViewModel!.currentUser;
    if (user != null && user.idKecamatan != null) {
      try {
        final kecamatan = await context
            .read<DaerahViewModel>()
            .getKecamatanById(user.idKecamatan!);
        setState(() {
          kecamatanName = kecamatan.nama;
        });
      } catch (e) {
        print("Error fetching kecamatan: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = _userViewModel!.currentUser;

    if (user == null) {
      return Center(child: Text('No user logged in'));
    }

    return Container(
      height: 200,
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
                          "${user.alamat} - ${kecamatanName ?? user.idKecamatan}",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/AddresEdit');
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
  }
}
