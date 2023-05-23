import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class itemShowBottom extends StatefulWidget {
  int count;
  itemShowBottom({super.key, required this.count});

  @override
  State<itemShowBottom> createState() => _itemShowBottomState();
}

class _itemShowBottomState extends State<itemShowBottom> {
  int countRoom = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RawMaterialButton(
          constraints: const BoxConstraints(
            minWidth: 0,
            minHeight: 0,
            maxWidth: 60,
            maxHeight: 60,
          ),
          padding: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(color: Colors.blue),
          ),
          onPressed: () {
            setState(() {
              countRoom++;
            });
          },
          child: const Icon(Icons.add, color: Colors.blue),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Text('$countRoom'),
        ),
        RawMaterialButton(
          constraints: const BoxConstraints(
            minWidth: 0,
            minHeight: 0,
            maxWidth: 60,
            maxHeight: 60,
          ),
          padding: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: countRoom == 1 ? Colors.grey : Colors.blue),
          ),
          onPressed: () {
            setState(() {
              if (countRoom == 1) return;
              countRoom--;
              print(countRoom);
            });
          },
          child: const Icon(
            Icons.remove,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
