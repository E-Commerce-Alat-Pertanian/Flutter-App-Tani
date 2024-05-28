// address.dart
class Address {
  final String name;
  final String phone;
  final String address;
  bool isSelected;

  Address({
    required this.name,
    required this.phone,
    required this.address,
    this.isSelected = false,
  });
}

List<Address> addresses = [
  Address(
    name: 'Jane Doe',
    phone: '085112345678',
    address:
        'Jl. Pendidikan , Kec. Babalan, Kab. Langkat, Sumatera Utara, 20852',
    isSelected: true,
  ),
  Address(
    name: 'Jimmy',
    phone: '085112345678',
    address:
        'Jl. Kalimantan , Kec. Babalan, Kab. Langkat, Sumatera Utara, 20852',
  ),
  Address(
    name: 'John Doe',
    phone: '085112345678',
    address: 'Jl. Wahidin , Kec. Babalan, Kab. Langkat, Sumatera Utara, 20852',
  ),
];
