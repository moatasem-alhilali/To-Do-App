import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/theme.dart';

class MyButton extends StatelessWidget {
  const MyButton({Key? key, required this.onTap, required this.lable,  this.sizeFont})
      : super(key: key);
  final Function() onTap;
  final String lable;
  final double ?sizeFont;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        // width: 100,
        height: 30,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6), color: primaryClr),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              lable,
              style: titleStyle.copyWith(fontSize:sizeFont?? 14,color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
