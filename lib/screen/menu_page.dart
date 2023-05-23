import 'package:booking_hotel/screen/order_page.dart';
import 'package:flutter/material.dart';

import 'profile_page.dart';
import 'favourite_page.dart';
import 'home_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int pageIndex = 0;
  final pages = [
    const HomePage(),
    const OrderPage(),
    const FavouvitePage(),
    const AccountPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        backgroundColor: Color(0xff003580),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Travel',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: IconButton(
              // icon: Image.asset('assets/images/messenger.png'),
              icon: Icon(
                Icons.notifications_none_rounded,
                size: 30,
              ),
              tooltip: 'Closes application',
              onPressed: () => () {},
            ),
          ),
        ],
        /*  leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset(
            'assets/images/logo.png',
          ),
        ), */
      ), */
      body: pages[pageIndex],
      extendBody: true,
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  Widget buildMyNavBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //Here goes the same radius, u can put into a var or function
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: 'Trang chủ'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_sharp), label: 'Đặt chỗ'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outlined), label: 'Yêu thích'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.person_sharp), label: 'Tài khoản'),
          ],
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xff277AB9),
          unselectedItemColor: Colors.grey,
          currentIndex: pageIndex,
          onTap: (value) {
            setState(() {
              pageIndex = value;
            });
          },
        ),
      ),
    );
  }
}
