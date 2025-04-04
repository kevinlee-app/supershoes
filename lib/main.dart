import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supershoes/pages/cart_page.dart';
import 'package:supershoes/pages/checkout_page.dart';
import 'package:supershoes/pages/checkout_success_page.dart';
import 'package:supershoes/pages/detail_chat_page.dart';
import 'package:supershoes/pages/edit_profile_page.dart';
import 'package:supershoes/pages/home/main_page.dart';
import 'package:supershoes/pages/product_page.dart';
import 'package:supershoes/pages/sign_in_page.dart';
import 'package:supershoes/pages/sign_up_page.dart';
import 'package:supershoes/pages/splash_page.dart';
import 'package:supershoes/pages/cart_page.dart';
import 'package:supershoes/pages/checkout_success_page.dart';
import 'package:supershoes/providers/auth_provider.dart';
import 'package:supershoes/providers/cart_provider.dart';
import 'package:supershoes/providers/page_provider.dart';
import 'package:supershoes/providers/product_provider.dart';
import 'package:supershoes/providers/transaction_provider.dart';
import 'package:supershoes/providers/wishlist_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => WishlistProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => TransactionProvider()),
        ChangeNotifierProvider(create: (context) => PageProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashPage(),
          '/sign-in': (context) => SignInPage(),
          '/sign-up': (context) => SignUpPage(),
          '/home': (context) => MainPage(),
          '/detail-chat': (context) => DetailChatPage(),
          '/edit-profile': (context) => EditProfilePage(),
          '/product': (context) => ProductPage(),
          '/cart': (context) => CartPage(),
          '/checkout': (context) => CheckoutPage(),
          '/checkout-success': (context) => CheckoutSuccessPage(),
        },
      ),
    );
  }
}
