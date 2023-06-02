import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/theme.dart';

class InputField extends StatelessWidget {
   InputField(
      {Key? key,
       this.hint,
      required this.title,
      this.controller,
      this.widget,  this.onChange, })
      : super(key: key);
  final String? hint;
   double ?height;
  final String title;
   TextEditingController? controller;
  final Widget? widget;
final  Function(String value)? onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          Container(
            height: height,
            margin: EdgeInsets.only(top: 14),
            padding: EdgeInsets.only(right: 8),
            width: SizeConfig.screenHeight,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey[200]!,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onChanged:onChange ,
                    style: titleStyle,
                    maxLines: null,

                    cursorWidth: 2,
                    cursorHeight: 2,
                   cursorRadius: Radius.circular(1),
                    controller: controller,
                    readOnly: widget!=null?true:false,
                    cursorColor:Colors.black,
                    autofocus: false,
                    decoration: InputDecoration(
                      hintStyle: titleStyle,
                      hintText: hint,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[300]!,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: context.theme.backgroundColor,
                        ),
                      ),
                    ),
                  ),
                ),
                widget??Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
