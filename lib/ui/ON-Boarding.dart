import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todo/cashHelper/sheardprefrences.dart';
import 'package:todo/constant.dart';
import 'package:todo/ui/Home_Nav_Bar.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/button.dart';

import 'widgets/input_field.dart';

class OnPording extends StatefulWidget {
  @override
  State<OnPording> createState() => _OnPordingState();
}

class _OnPordingState extends State<OnPording> {
  PageController pc = PageController();

  //
  // void onSubmit() {
  //   CashHelper.setData(key: 'skipBoarding', value: true).then(
  //     (value) {
  //       print(value);
  //       if (value) {
  //         Navigator.pushReplacement(
  //             context, MaterialPageRoute(builder: (context) => HomeNavBar()));
  //       }
  //     },
  //   );
  // }

  void setName() async {
    await CashHelper.setData(key: 'userName', value: nameController.text);
    await CashHelper.setData(key: 'skipBoarding', value: true);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeNavBar()));
  }

  bool selected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                height: 600,
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'اختر صورتك الشخصية',
                      style: titleStyle.copyWith(
                        color: Colors.blueAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            child: Container(
                              child: Image.asset(
                                'assets/profile/profileMan.png',
                                fit: BoxFit.cover,
                              ),
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: selected
                                      ? Colors.blueAccent
                                      : Colors.grey,
                                ),
                              ),
                            ),
                            onTap: () {
                              female = false;
                              super.setState(() {
                                selected = true;
                              });
                              // onSubmit();
                            },
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              child: Image.asset(
                                  'assets/profile/profileWomen.png'),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: selected
                                      ? Colors.grey
                                      : Colors.blueAccent,
                                ),
                              ),
                            ),
                            onTap: () {
                              female = true;
                              super.setState(() {
                                selected = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      textDirection: TextDirection.rtl,
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: 'ادخل اسمك الشخصي',
                        labelText: ' اسمك الشخصي',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        hintStyle: titleStyle.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w400),
                        labelStyle: titleStyle.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child: MyButton(
                        onTap: () {
                          if (nameController.text.isEmpty) {
                            showToast(
                                states: ToastShowColor.ERROR,
                                message: 'يجب عليك كتابة اسمك الشخصي');
                          } else {
                            setName();
                          }
                        },
                        lable: 'Get Started',
                        sizeFont: 25,
                      ),
                      height: 60,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PordingModel {
  final String title;
  final String descriotion;
  final IconData icon;
  final String image;

  PordingModel(this.title, this.descriotion, this.icon, this.image);
}
