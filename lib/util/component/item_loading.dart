import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class itemLoading extends StatelessWidget {
  final String message;
  const itemLoading({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Center(
        child: Container(
            height: 150,
            width: 150,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 12),
                DefaultTextStyle(
                  style: const TextStyle(color: Colors.black),
                  child: Text(
                    message,
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
