import 'package:app_tani_sejahtera/pages/berhasil/berhasil_page.dart';
import 'package:app_tani_sejahtera/pages/orders/components/detail_order.dart';
import 'package:app_tani_sejahtera/pages/orders/order_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth/register_page.dart';
import 'auth_check.dart';
import 'pages/address/address_page.dart';
import 'pages/address/components/address_edit.dart';
import 'pages/cart/cart_page.dart';
import 'pages/checkout/checkout_page.dart';
import 'pages/details/detail_page.dart';
import 'pages/favorite/favorite.dart';
import 'pages/init_page.dart';
import 'pages/profile/components/profile_edit.dart';
import 'pages/profile/profile_page.dart';
import 'view_models/daerah_view_model.dart';
import 'view_models/favorite_view_model.dart';
import 'view_models/kategori_view_model.dart';
import 'view_models/keranjang_view_model.dart';
import 'view_models/order_view_model.dart';
import 'view_models/produk_view_model.dart';
import 'auth/login_page.dart';
import 'view_models/user_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserViewModel()),
        ChangeNotifierProvider(create: (context) => DaerahViewModel()),
        ChangeNotifierProvider(create: (context) => ProdukViewModel()),
        ChangeNotifierProvider(create: (context) => KategoriViewModel()),
        ChangeNotifierProvider(create: (context) => FavoriteViewModel()),
        ChangeNotifierProvider(create: (context) => OrderViewModel()),
        ChangeNotifierProvider(create: (context) => KeranjangViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/": (context) => const AuthCheck(),
          "/SignUp": (context) => const RegisterPage(),
          "/login": (context) => const LoginPage(),
          "/main": (context) => const InitPage(),
          "/favorite": (context) => const FavoritePage(),
          "/DetailProduk": (context) => const DetailPage(),
          "/keranjang": (context) => const CartPage(),
          "/Profile": (context) => const ProfilePage(),
          "/EditProfile": (context) => const ProfileEdit(),
          "/checkout": (context) => const CheckoutPage(),
          "/AddressEdit": (context) => const AddressEdit(),
          "/berhasil": (context) => const BerhasilPage(),
          "/Orders": (context) => const OrderPage(),
          "/DetailOrder": (context) => DetailOrder(),
        },
      ),
    );
  }
}
