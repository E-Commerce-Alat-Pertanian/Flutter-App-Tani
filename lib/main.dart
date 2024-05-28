import 'package:app_tani_sejahtera/auth/register_page.dart';
import 'package:app_tani_sejahtera/auth_check.dart';
import 'package:app_tani_sejahtera/pages/address/address_page.dart';
import 'package:app_tani_sejahtera/pages/address/components/address_edit.dart';
import 'package:app_tani_sejahtera/pages/cart/cart_card.dart';
import 'package:app_tani_sejahtera/pages/cart/cart_page.dart';
import 'package:app_tani_sejahtera/pages/checkout/checkout_page.dart';
import 'package:app_tani_sejahtera/pages/details/detail_page.dart';
import 'package:app_tani_sejahtera/pages/favorite/favorite.dart';
import 'package:app_tani_sejahtera/pages/init_page.dart';
import 'package:app_tani_sejahtera/pages/profile/components/profile_edit.dart';
import 'package:app_tani_sejahtera/pages/profile/profile_page.dart';
import 'package:app_tani_sejahtera/view_models/daerah_view_model.dart';
import 'package:app_tani_sejahtera/view_models/favorite_view_modell.dart';
import 'package:app_tani_sejahtera/view_models/kategori_view_model.dart';
import 'package:app_tani_sejahtera/view_models/produk_view_model.dart';
import 'package:flutter/material.dart';
import 'package:app_tani_sejahtera/auth/login_page.dart';
import 'package:provider/provider.dart';

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
        ChangeNotifierProvider(create: (context) => FavoriteViewModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/": (context) => const AuthCheck(),
          "/SignUp": (context) => const RegisterPage(),
          "/login": (context) => const LoginPage(),
          "/main": (context) => const InitPage(),
          // "/favorite": (context) => const FavoritePage(),
          "/DetailProduk": (context) => const DetailPage(),
          // "/keranjang": (context) => const CartPage(),
          "/Profile": (context) => const ProfilePage(),
          "/EditProfile": (context) => const ProfileEdit(),
          "/AddresEdit": (context) => const AddressEdit(),
        },
      ),
    );
  }
}

// class LoginPageWrapper extends StatelessWidget {
//   const LoginPageWrapper({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LoginPage(
//         showRegisterPage: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => RegisterPageWrapper(),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
