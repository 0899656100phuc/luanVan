import 'package:booking_hotel/bloc/bloc_login/login_bloc.dart';
import 'package:booking_hotel/screen/home_page.dart';
import 'package:booking_hotel/screen/register_page.dart';
import 'package:booking_hotel/screen/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/auth_service.dart';
import '../style/const/colors.dart';
import '../util/component/item_loading.dart';
import 'profile_page.dart';
import 'menu_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginpageState();
}

class _LoginpageState extends State<LoginPage> {
  @override
  void initState() {
    _loadUserEmailPassword();
    // TODO: implement initState
    super.initState();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isChecked = false;
  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*  appBar: AppBar(
        title: Text(
          'Đăng nhập',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        centerTitle: true,
      ), */
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 150,
                width: 150,
              ),
              const SizedBox(
                height: 50,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email_outlined)),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: passwordController,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  hintText: 'Mật khẩu',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Color(0xFF545380),
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
              ),
              Container(
                child: CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: const Text(
                    'Giữ cho tôi đăng nhập',
                    style: TextStyle(color: Color(0xff737F8B), fontSize: 13),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  checkColor: Colors.white,
                  value: _isChecked,
                  activeColor: AppColors.button,
                  onChanged: (value) {
                    _handleRemeberme(value!);
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginFaild) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        padding: EdgeInsets.all(18),
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          'Tài khoản hoặc mật khẩu không chính xác',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    );
                  }
                  if (state is LoginLoading) {
                    Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is LoginSuccess) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return const itemLoading(
                          message: 'Đang xử lý...',
                        );
                      },
                    );
                    Future.delayed(Duration(seconds: 1), () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MenuPage()),
                      );
                    });
                  }
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: MaterialButton(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      color: AppColors.button,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () {
                        context.read<LoginBloc>().add(LoginButtonPressed(
                            emailController.text, passwordController.text));
                      },
                      child: const Text('Đăng nhập',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('bạn chưa có tài khoản ?'),
                  TextButton(
                      onPressed: () {},
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterPage(),
                                ));
                          },
                          child: Text('Đăng ký ngay')))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handleRemeberme(bool value) {
    _isChecked = value;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('email', emailController.text);
        prefs.setString('password', passwordController.text);
      },
    );
    setState(() {
      _isChecked = value;
    });
  }

  void _loadUserEmailPassword() async {
    print("Load Email");
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _email = _prefs.getString("email") ?? "";
      print(_email);
      var _password = _prefs.getString("password") ?? "";
      var _remeberMe = _prefs.getBool("remember_me") ?? false;
      if (_remeberMe) {
        setState(() {
          _isChecked = true;
        });
        emailController.text = _email;
        passwordController.text = _password;
      }
    } catch (e) {
      print(e);
    }
  }
}
