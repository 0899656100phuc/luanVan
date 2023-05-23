import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class InfoUser extends StatefulWidget {
  const InfoUser({super.key});

  @override
  State<InfoUser> createState() => _InfoUserState();
}

class _InfoUserState extends State<InfoUser> {
  TextEditingController controllerName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            textInput('Họ và tên', controllerName),
            SizedBox(
              height: 10,
            ),
            textInput('Địa chỉ email', controllerName),
            SizedBox(
              height: 10,
            ),
            textInput('Số DTDĐ', controllerName),
          ]),
        ),
      ],
    );
  }

  textInput(String text, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        SizedBox(
          height: 3,
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
              border: OutlineInputBorder(), contentPadding: EdgeInsets.zero),
        )
      ],
    );
  }
}
