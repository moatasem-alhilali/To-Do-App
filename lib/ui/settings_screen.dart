import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:get/get.dart';
import 'package:todo/constant.dart';
import 'package:todo/services/theme_services.dart';
import 'package:todo/ui/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<MaterialColor> colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'الاعدادات',
          style: titleStyle,
        ),
        centerTitle: true,
        backgroundColor: context.theme.backgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SimpleUserCard(
              userName: nameController.text,
              textStyle: titleStyle,
              imageRadius: 15,
              onTap: (){
                print(female);
              },
              icon: const Icon(Icons.favorite,color: Colors.red,),
              userProfilePic: female? const AssetImage('assets/profile/profileWomen.png'): const AssetImage('assets/profile/profileMan.png'),
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => SizedBox(
                        height: 200,
                        child: AlertDialog(
                          actions: [
                            Text(
                              'تغير الثيم',
                              style: subTitleStyle,
                            ),
                            IconButton(
                              onPressed: () {
                                ThemeServices().switchTheme();
                              },
                              icon: const Icon(Icons.brightness_2),
                            ),
                            const SizedBox(
                              width: 60,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  icons: CupertinoIcons.pencil_outline,
                  iconStyle: IconStyle(),
                  title: 'المظهر',
                  subtitle: 'قم بتحسين واللغة',
                  titleStyle: titleStyle.copyWith(
                      color: Get.isDarkMode ? Colors.black : primaryClr),
                  subtitleStyle: titleStyle.copyWith(
                      fontSize: 14,
                      color: Get.isDarkMode ? Colors.black : primaryClr),
                ),
              ],
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                        margin: const EdgeInsets.all(10),
                        height: 220,
                        child: Column(
                          children: [
                            Container(
                              width: 100,
                              height: 12,
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            DefaultTextStyle(
                              textAlign: TextAlign.center,
                              style: titleStyle,
                              child: AnimatedTextKit(
                                repeatForever: false,
                                totalRepeatCount: 1,
                                animatedTexts: [
                                  TypewriterAnimatedText(
                                    'تطبيق المهام والملاحضات الذي يمكنك من خلاله كتابة يومياتك وتتذكيرك بمواعيدك',
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'حساباتي في مواقع التواصل الاجتماعي',
                                    style: titleStyle,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              await _launchUrl(Uri.parse(
                                                  ' https://www.facebook.com/max5hd'));
                                            },
                                            icon: const Icon(
                                              Icons.facebook,
                                              color: Colors.blueAccent,
                                            ),
                                          ),
                                          const Text('facebook'),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              await _launchUrl(Uri.parse(
                                                  'https://www.youtube.com/channel/UCAIBsVhcGffOWrC3bPcuZWQ'));
                                            },
                                            icon: const Icon(
                                              FontAwesomeIcons.youtube,
                                              color: Colors.red,
                                            ),
                                          ),
                                          const Text('YouTube'),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          IconButton(
                                            onPressed: () async{
                                              await _launchUrl(
                                              Uri.parse(
                                                  'https://instagram.com/am.vi3'),
                                            );},
                                            icon: const Icon(
                                              FontAwesomeIcons.instagram,
                                              color: Colors.redAccent,
                                            ),
                                          ),
                                          const Text('Instagram'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: AnimatedTextKit(
                                totalRepeatCount: 5,
                                isRepeatingAnimation: true,
                                repeatForever: true,
                                animatedTexts: [
                                  ColorizeAnimatedText('المطور معتصم الهلالي',
                                      textStyle: titleStyle,
                                      colors: colorizeColors,
                                      textAlign: TextAlign.start),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  titleStyle: titleStyle.copyWith(
                      color: Get.isDarkMode ? Colors.black : primaryClr),
                  subtitleStyle: titleStyle.copyWith(
                      fontSize: 14,
                      color: Get.isDarkMode ? Colors.black : Colors.black),
                  icons: Icons.info_rounded,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.purple,
                  ),
                  title: 'حول',
                  subtitle: "تعلم اكثر حول كيفيه استخدامه",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(_url) async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}
