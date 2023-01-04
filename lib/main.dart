import 'package:egrocer_seller/firebase_options.dart';
import 'package:egrocer_seller/helper/generalWidgets/widgets.dart';
import 'package:egrocer_seller/helper/styles/colorsRes.dart';
import 'package:egrocer_seller/helper/utils/generalMethods.dart';
import 'package:egrocer_seller/helper/utils/routeGenerator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper/sessionManager.dart';
import 'helper/utils/appLocalization.dart';
import 'helper/utils/constant.dart';
import 'helper/utils/stringsRes.dart';
import 'screens/splashScreen.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) async {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      );
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    runApp(
      MyApp(
        prefs: prefs,
      ),
    );
  });
}

class MyApp extends StatefulWidget {
  final SharedPreferences? prefs;

  MyApp({Key? key, this.prefs}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SessionManager>(
      create: (_) => SessionManager(prefs: widget.prefs!),
      child: Consumer<SessionManager>(
          builder: (context, SessionManager sessionNotifier, child) {
        Constant.session = Provider.of<SessionManager>(context);

        FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
          Constant.session.setData(SessionManager.keyFCMToken, fcmToken, false);
        });
        Locale currLang = Constant.session.getCurrLang();

        final window = WidgetsBinding.instance.window;

        // This callback is called every time the brightness changes from the device.
        window.onPlatformBrightnessChanged = () {
          if (Constant.session.getData(SessionManager.appThemeName) ==
              Constant.themeList[0]) {
            Constant.session.setBoolData(SessionManager.isDarkTheme,
                window.platformBrightness == Brightness.dark, true);
          }
        };

        return MaterialApp(
          onGenerateRoute: RouteGenerator.generateRoute,
          initialRoute: "/",
          scrollBehavior: ScrollGlowBehavior(),
          debugShowCheckedModeBanner: false,
          locale: currLang,
          title: StringsRes.appName,
          theme: ColorsRes.setAppTheme(),
          home: SplashScreen(),
          localizationsDelegates: [
            AppLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: Constant.supportedLanguages.map((languageCode) {
            return GeneralMethods.getLocaleFromLangCode(languageCode);
          }).toList(),
        );
      }),
    );
  }
}
