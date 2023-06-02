import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo/db/db_helper.dart';
import 'package:todo/db/db_helper_note.dart';
import 'package:todo/ui/Home_Nav_Bar.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/ON-Boarding.dart';
import 'AppLocalizations/AppLocalizations.dart';
import 'cashHelper/sheardprefrences.dart';
import 'services/theme_services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  await DBHelper.initDb();
  await DBHelperNotes.initDb();
  await CashHelper.init();
  Widget startWidget;

  bool? onBoarding = CashHelper.getDataOnBoarding(key: 'skipBoarding');
  // nameController!.text = CashHelper.getDataName(key: 'userName')!;
  if (onBoarding != null) {
    startWidget = HomeNavBar();
  } else {
    startWidget = OnPording();
  }

  runApp(
    MyApp(
      startWidgets: startWidget,
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidgets;

   MyApp({required this.startWidgets});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // locale: HomeCubit.get(context).locale,
      locale: const Locale('ar'),
      textDirection: TextDirection.rtl,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        for (var locale in supportedLocales) {
          if (deviceLocale != null &&
              deviceLocale.languageCode == locale.languageCode) {
            return deviceLocale;
          }
        }
        return supportedLocales.first;
      },
      supportedLocales: const [Locale('ar'), Locale('en')],
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeServices().theme,
      debugShowCheckedModeBanner: false,
      home: startWidgets,
      // home: OnPording(),
    );
  }
}
