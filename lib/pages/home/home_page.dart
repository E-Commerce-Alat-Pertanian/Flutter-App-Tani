import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_tani_sejahtera/pages/home/components/categories.dart';
import 'package:app_tani_sejahtera/pages/home/components/all_product.dart';
import 'package:app_tani_sejahtera/pages/home/components/home_header.dart';
import 'package:app_tani_sejahtera/pages/home/components/promo.dart';
import '../../view_models/kategori_view_model.dart';
import '../../view_models/produk_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();
  int? _activeKategori;
  String _searchText = "";

  // Fungsi untuk memperbarui kata kunci pencarian dan membangun ulang tampilan
  void _onSearch(String value) {
    setState(() {
      _searchText = value;
    });
  }

  void getData() async {
    await context.read<KategoriViewModel>().getKategori();
    await context.read<ProdukViewModel>().getProduk();
  }

  void updateKategori(int kategori) {
    if (_activeKategori != kategori) {
      setState(() => _activeKategori = kategori);
    } else {
      setState(() => _activeKategori = null);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              HomeHeader(
                controller: _searchController,
                onSearch: _onSearch, // Ubah pemanggilan fungsi onSearch
              ),
              const SizedBox(height: 10),
              const Promo(),
              const SizedBox(height: 10),
              Categories(
                activeKategori: _activeKategori,
                onTap: updateKategori,
              ),
              AllProduct(
                searchText: _searchText,
                activeKategori: _activeKategori,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
