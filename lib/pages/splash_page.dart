import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supershoes/models/user_model.dart';
import 'package:supershoes/providers/auth_provider.dart';
import 'package:supershoes/providers/product_provider.dart';
import 'package:supershoes/utils/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    getInit();
  }

  getInit() async {
    final AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    await authProvider.getPreviouslyLoggedInUser();
    await Provider.of<ProductProvider>(context, listen: false).getProducts();

    Navigator.pushReplacementNamed(
        context, authProvider.user.isAuthorized ? '/home' : '/sign-in');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: Center(
        child: Container(
          width: 130,
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image_splash.png'),
            ),
          ),
        ),
      ),
    );
  }
}
