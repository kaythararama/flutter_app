import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'generated/locale_keys.g.dart';
import 'home.dart';
import 'service/firebase_service.dart';

void main() {
  _initFirebase();
  //runApp(MyApp());
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en', ''), Locale('my', '')],
        path: 'assets/translations', // <-- change patch to your
        fallbackLocale: Locale('en', ''),
        child: MyApp()
    ),
  );

}

void _initFirebase() async{
  WidgetsFlutterBinding.ensureInitialized();
  try{
    FirebaseMessage _firebaseMessage = FirebaseMessage( );
    await _firebaseMessage.initMessaging( );
  }catch(e){}
}

class MyApp extends StatelessWidget {
  MaterialColor colorCustom = MaterialColor(0xFF0000fa, color);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.green,
      // ),
      home: MyHomePage(title: tr(LocaleKeys.lblGreeting)),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: colorCustom,
        accentColor: colorCustom,
        buttonColor: colorCustom[700],
        backgroundColor: Colors.white10,
        fontFamily: 'Roboto:300,400,500',
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline2: TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic, color: Colors.white),
          headline6: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic, color: colorCustom),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Roboto'),
        ),
      ),

    );
  }
}
Map<int, Color> color = {
  50:Color.fromRGBO(0,0,250, .1),
  100:Color.fromRGBO(0,0,250, .2),
  200:Color.fromRGBO(0,0,250, .3),
  300:Color.fromRGBO(0,0,250, .4),
  400:Color.fromRGBO(0,0,250, .5),
  500:Color.fromRGBO(0,0,250, .6),
  600:Color.fromRGBO(0,0,250, .7),
  700:Color.fromRGBO(0,0,250, .8),
  800:Color.fromRGBO(0,0,250, .9),
  900:Color.fromRGBO(0,0,250, 1),
};
