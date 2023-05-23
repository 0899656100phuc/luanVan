import 'package:booking_hotel/screen/login_page.dart';
import 'package:booking_hotel/style/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../service/register.dart';
import '../util/component/snackbar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _passwordVisible = false;
  bool _rePasswordVisible = false;
  TextEditingController nameCotroller = TextEditingController();
  TextEditingController emailCotroller = TextEditingController();
  TextEditingController phoneCotroller = TextEditingController();
  TextEditingController passwordCotroller = TextEditingController();
  TextEditingController rePasswordCotroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        title: Text(
          'Đăng ký',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 150,
                  width: 150,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: nameCotroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng nhập họ tên';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Họ tên',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person_outline_outlined)),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: emailCotroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng nhập email';
                    }
                    if (!value.contains('@')) {
                      return 'Email không hợp lệ';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email_outlined)),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: phoneCotroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng nhập số điện thoại';
                    }
                    if (value.length < 8) {
                      return 'Số điện thoại không hợp lệ';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Số điện thoại',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email_outlined)),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: passwordCotroller,
                  obscureText: !_passwordVisible,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng nhập mật khẩu';
                    }
                    if (value.length < 6) {
                      return 'Mật khẩu phải từ 6 ký tự trở lên';
                    }
                    return null;
                  },
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
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: rePasswordCotroller,
                  obscureText: !_rePasswordVisible,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng nhập mật khẩu';
                    }
                    if (value.length < 6) {
                      return 'Mật khẩu phải từ 6 ký tự trở lên';
                    }
                    if (value != passwordCotroller.text) {
                      return 'Mật khẩu không khớp';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Nhập lại mật khẩu',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _rePasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Color(0xFF545380),
                      ),
                      onPressed: () {
                        setState(() {
                          _rePasswordVisible = !_rePasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
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
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          Register register = Register();
                          try {
                            await register.register(
                                nameCotroller.text,
                                emailCotroller.text,
                                phoneCotroller.text,
                                passwordCotroller.text);
                            showSnackBar(
                                context, 'Đăng ký thành công', Colors.green);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ));
                          } catch (e) {
                            print(e.toString());

                            showSnackBar(
                                context, 'Email này đã tồn tại', Colors.black);
                          }
                        }
                      },
                      child: const Text('Đăng ký',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
