import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/theme.dart';

class NotificationScreen extends StatefulWidget {
  final String payload;

  const NotificationScreen({Key? key, required this.payload}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String payload = '';

  @override
  void initState() {
    payload = widget.payload;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  'لقد حان الوقت',
                  style: titleStyle.copyWith(color: Colors.black, fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(
                      SizeConfig.orientation == Orientation.landscape ? 8 : 20),
                ),
                width: SizeConfig.orientation == Orientation.landscape
                    ? SizeConfig.screenWidth / 2
                    : SizeConfig.screenWidth,
                margin: EdgeInsets.only(
                  bottom: getProportionateScreenHeight(8),
                ),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: primaryClr,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                payload.toString().split('|')[0],
                                style: titleStyle.copyWith(color: Colors.white),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'تنبيه جديد',
                                style: GoogleFonts.tajawal(
                                  textStyle: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                " ${payload.toString().split('|')[1]}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    fontFamily: 'Tajawal',
                                    color: Colors.white,

                                ),
                              ),
                            ],
                          ),
                          physics: const BouncingScrollPhysics(),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        color: Colors.grey[200]!.withOpacity(0.7),
                      ),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          'تنبيه',
                          style: titleStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    'الخروج',
                    style: titleStyle.copyWith(color: Colors.blueAccent),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
