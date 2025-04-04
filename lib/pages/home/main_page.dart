import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supershoes/pages/home/chat_page.dart';
import 'package:supershoes/pages/home/home_page.dart';
import 'package:supershoes/pages/home/profile_page.dart';
import 'package:supershoes/pages/home/wishlist_page.dart';
import 'package:supershoes/providers/page_provider.dart';
import 'package:supershoes/utils/theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final PageProvider pageProvider = Provider.of<PageProvider>(context);
    Widget cartButton() {
      return FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/cart');
        },
        shape: CircleBorder(),
        backgroundColor: secondaryColor,
        child: Image.asset(
          'assets/icon_cart.png',
          width: 20,
        ),
      );
    }

    Widget customButtonNav() {
      return Container(
        color: pageProvider.currentIndex == 0 ? backgroundColor1 : backgroundColor3,
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
          child: BottomAppBar(
            color: backgroundColor4,
            shape: CircularNotchedRectangle(),
            notchMargin: 10,
            clipBehavior: Clip.antiAlias,
            child: Wrap(
              children: [
                BottomNavigationBar(
                  currentIndex: pageProvider.currentIndex,
                  onTap: (value) {
                    pageProvider.currentIndex = value;
                  },
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: backgroundColor4,
                  elevation: 0.0,
                  items: [
                    BottomNavigationBarItem(
                        label: '',
                        icon: Image.asset(
                          'assets/icon_home.png',
                          width: 21,
                          color: pageProvider.currentIndex == 0
                              ? primaryColor
                              : unselectedColor,
                        )),
                    BottomNavigationBarItem(
                        label: '',
                        icon: Image.asset(
                          'assets/icon_chat.png',
                          width: 20,
                          color: pageProvider.currentIndex == 1
                              ? primaryColor
                              : unselectedColor,
                        )),
                    BottomNavigationBarItem(
                        label: '',
                        icon: Image.asset(
                          'assets/icon_wishlist.png',
                          width: 21,
                          color: pageProvider.currentIndex == 2
                              ? primaryColor
                              : unselectedColor,
                        )),
                    BottomNavigationBarItem(
                        label: '',
                        icon: Image.asset(
                          'assets/icon_profile.png',
                          width: 20,
                          color: pageProvider.currentIndex == 3
                              ? primaryColor
                              : unselectedColor,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget body() {
      switch (pageProvider.currentIndex) {
        case 0:
          return HomePage();
        case 1:
          return ChatPage();
        case 2:
          return WishlistPage();
        case 3:
          return ProfilePage();

        default:
          return HomePage();
      }
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      floatingActionButton: cartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: customButtonNav(),
      body: body(),
    );
  }
}
