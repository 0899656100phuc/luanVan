import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FavouvitePage extends StatefulWidget {
  const FavouvitePage({super.key});

  @override
  State<FavouvitePage> createState() => _FavouvitePageState();
}

class _FavouvitePageState extends State<FavouvitePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffC4DFCB),
      child: Center(
        child: Text(
          "Yêu thích",
          style: TextStyle(
            color: Colors.green[900],
            fontSize: 45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
