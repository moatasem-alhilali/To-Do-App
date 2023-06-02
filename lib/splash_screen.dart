
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/ui/Home_Nav_Bar.dart';

import 'ui/Tasks/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  bool animated = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 4000)).then((value) {
     // Get.to(const HomePage());
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> HomeNavBar()), (route) => false);
      animated = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            height: 600,
            width: double.infinity,
            'images/splash.json',
            animate: animated,
          ),
        ],
      ),
    );
  }
}
// import 'package:splash_screen_view/SplashScreenView.dart';
// import 'package:flutter/material.dart';
// import 'package:todo/ui/pages/home_page.dart';
// import 'package:todo/ui/theme.dart';
//
// class SplashScreen extends StatelessWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SplashScreenView(
//         navigateRoute: const HomePage(),
//         duration: 2000,
//         imageSize: 500,
//         pageRouteTransition: PageRouteTransition.CupertinoPageRoute,
//         imageSrc: 'images/splashes.png',
//         text: 'To Do',
//         textType: TextType.ColorizeAnimationText,
//         textStyle: titleStyle.copyWith(fontSize: 50),
//         colors: const [
//           Colors.purple,
//           Colors.blue,
//           Colors.yellow,
//           Colors.red,
//         ],
//         backgroundColor: Colors.white,
//       ),
//     );
//   }
// }
