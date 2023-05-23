import 'package:booking_hotel/bloc/bloc/profile_bloc.dart';
import 'package:booking_hotel/bloc/bloc_login/login_bloc.dart';
import 'package:booking_hotel/bloc/bloc_search_all/search_bloc.dart';
import 'package:booking_hotel/screen/menu_page.dart';
import 'package:booking_hotel/screen/login_page.dart';
import 'package:booking_hotel/service/auth_service.dart';
import 'package:booking_hotel/service/detail_hotel.dart';
import 'package:booking_hotel/service/profile.dart';
import 'package:booking_hotel/service/search_all.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }
import 'package:device_preview/device_preview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc_auth/authen_bloc.dart';
import 'bloc/detailItem_hotel_bloc/detail_item_hotel_bloc.dart';

void main() => runApp(
      /* DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => MyApp(), // Wrap your app
      ), */
      const MyApp(),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>
                SearchAllDataBloc(SearchAllData())),
        BlocProvider(
            create: (BuildContext context) =>
                DetailItemHotelBloc(DetailHotelService())),
        BlocProvider(
            create: (BuildContext context) => LoginBloc(AuthService())),
        BlocProvider(
            create: (BuildContext context) => AuthenBloc(AuthService())),
        BlocProvider(
            create: (BuildContext context) => ProfileBloc(ProfileUser()))
      ],
      child: MaterialApp(
        /* useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder, */
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(
          create: (context) => AuthenBloc(AuthService())..add(authFetchEvent()),
          child: BlocBuilder<AuthenBloc, AuthenState>(
            builder: (context, state) {
              if (state is authenLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is authSuccsess) {
                return MenuPage();
              } else {
                return LoginPage();
              }
            },
          ),
        ),
      ),
    );
  }
}
