import 'package:booking_hotel/screen/login_page.dart';
import 'package:booking_hotel/screen/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../service/auth_service.dart';
import '../service/profile.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 10),
              child: Row(
                children: [
                  SizedBox(
                    height: 115,
                    width: 115,
                    child: Stack(
                      fit: StackFit.expand,
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.account_circle_rounded,
                            size: 75,
                            color: Colors.white,
                          ),
                        ),
                        Positioned(
                          right: -16,
                          bottom: 0,
                          child: SizedBox(
                            height: 46,
                            width: 46,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: BorderSide(color: Colors.white),
                                ),
                                primary: Colors.white,
                                backgroundColor: Color(0xFFF5F6F9),
                              ),
                              onPressed: () {},
                              child: Icon(
                                Icons.camera_alt,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  FutureBuilder(
                    future: ProfileUser().fetchProfileUser(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Text(
                              'Xin chào ' + snapshot.data!['user']['username'],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              snapshot.data!['user']['email'],
                            ),
                          ],
                        );
                      } else if (!snapshot.hasData) {
                        Text('chưa có dữ liệu');
                      } else {
                        return CircularProgressIndicator(); // or any other loading widget
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 70, right: 10),
              child: Divider(
                indent: 5,
              ),
            ),
            MaterialButton(
              onPressed: () async {
                await AuthService().logout();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => SplashScreen()),
                    (Route<dynamic> route) => false);
              },
              child: Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.logout),
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Đăng xuất',
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 70, right: 10),
              child: Divider(
                indent: 5,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Field Sales - Version: 1.0.0'),
                ],
              ),
            ),
          ])),
    );
  }
}
