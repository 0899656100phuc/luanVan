import 'package:booking_hotel/screen/home_page.dart';
import 'package:booking_hotel/screen/login_page.dart';
import 'package:booking_hotel/screen/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'menu_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final sizeDevice = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/splash.jpeg"),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Booking Hotel',
                        style: TextStyle(
                            fontFamily: 'Sen',
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
              Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text(
                          'Đi du lịch một cách dễ dàng',
                          style: TextStyle(
                              fontFamily: 'Sen',
                              color: Colors.white,
                              fontSize: 30),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Khám phá điểm yêu thích & tận hưởng kì nghĩ của bạn',
                          style: TextStyle(
                              fontFamily: 'Sen',
                              color: Colors.white,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: sizeDevice.width / 2 - 26,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 6,
                                ),
                                child: MaterialButton(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  color: Colors.white,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginPage(),
                                        ));
                                  },
                                  child: const Text('Đăng nhập',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Container(
                              width: sizeDevice.width / 2 - 26,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RegisterPage(),
                                      ));
                                },
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  side: BorderSide(color: Colors.white),
                                ),
                                child: Text(
                                  "Đăng ký",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Vào xem phòng',
                        style: TextStyle(
                          fontFamily: 'Sen',
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: Ink(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MenuPage(),
                                  ));
                            },
                            child: Padding(
                              padding: EdgeInsets.all(13.0),
                              child: Icon(
                                Icons.navigate_next_outlined,
                                size: 20.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
