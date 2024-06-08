import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/kecamatan_model.dart';
import '../../../models/provinsi_model.dart';
import '../../../view_models/daerah_view_model.dart';
import '../../../view_models/user_view_model.dart';
import '../../../widgets/dropdown_widget.dart';
import '../../../widgets/form_input.dart';

class AddressEdit extends StatefulWidget {
  const AddressEdit({Key? key}) : super(key: key);

  @override
  State<AddressEdit> createState() => _AddressEditState();
}

class _AddressEditState extends State<AddressEdit> {
  final _noHpController = TextEditingController();
  final _alamatController = TextEditingController();

  String? _idProvinsi;
  String? _idKecamatan;

  List<ProvinsiModel> _listProvinsi = [];
  List<KecamatanModel> _listKecamatan = [];

  @override
  void initState() {
    super.initState();
    getProvinsi();
  }

  Future<void> getProvinsi() async {
    _listProvinsi = await context.read<DaerahViewModel>().getProvinsi();
    if (_listProvinsi.isNotEmpty) {
      setState(() {
        _idProvinsi = _listProvinsi.first.id;
      });
      await getKecamatan();
    }
  }

  Future<void> getKecamatan() async {
    if (_idProvinsi != null) {
      _listKecamatan =
          await context.read<DaerahViewModel>().getKecamatan(_idProvinsi!);
      if (_listKecamatan.isNotEmpty) {
        setState(() {
          _idKecamatan = _listKecamatan.first.id;
        });
      }
    }
  }

  Future<void> submitUpdate() async {
    final userViewModel = context.read<UserViewModel>();
    final daerahViewModel = context.read<DaerahViewModel>();
    final noHp = _noHpController.text;
    final alamat = _alamatController.text;
    final idKecamatan = _idKecamatan;

    final error = await userViewModel.updateAddress(noHp, alamat, idKecamatan!);
    if (error.isEmpty) {
      // Fetch updated profile after address update
      await userViewModel.getProfile();
      // Trigger fetchKecamatanName after updating the profile
      await userViewModel.fetchKecamatanName(context);
      // Call getOngkir to update the shipping cost
      await daerahViewModel.getOngkir();
      Navigator.pop(context);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(error),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserViewModel>().currentUser;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: ListView(
          children: [
            const SizedBox(height: kToolbarHeight),
            const Text(
              "Perbarui Alamat",
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 16),
            FormInput(
              hintText: user?.noHp,
              controller: _noHpController,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            FormInput(
              hintText: user?.alamat,
              controller: _alamatController,
              multiline: true,
            ),
            DropdownWidget(
              value: _idProvinsi,
              onChange: (value) async {
                setState(() {
                  _idProvinsi = value;
                });
                await getKecamatan();
              },
              label: "Provinsi",
              items: _listProvinsi.map((e) {
                return DropdownMenuItem(
                  value: e.id,
                  child: Text(e.nama),
                );
              }).toList(),
            ),
            DropdownWidget(
              value: _idKecamatan,
              onChange: (value) {
                setState(() {
                  _idKecamatan = value;
                });
              },
              label: "Kecamatan",
              items: _listKecamatan.map((e) {
                return DropdownMenuItem(
                  value: e.id,
                  child: Text(e.nama),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitUpdate,
              child: const Text('Simpan'),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
