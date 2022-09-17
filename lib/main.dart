import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/models/todo.dart';
import 'package:to_do_app/providers/ThemeProvider.dart';
import 'package:to_do_app/providers/listProvider.dart';
import 'package:to_do_app/providers/localProvider.dart';
import 'package:to_do_app/screens/editTask.dart';
import 'package:to_do_app/screens/home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_app/style/appStyle.dart';
import 'package:to_do_app/ui/bottomSheetStyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings =
      Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  await FirebaseFirestore.instance.disableNetwork();
  runApp(
      ChangeNotifierProvider(
        create: (_) => LocaleProvider(),
        child: ChangeNotifierProvider(
          create: (_) => ListProvider(),
          child: ChangeNotifierProvider(
              create: (_) => ThemeProvider(),
              child: MyApp()
          ),
        ),
      )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  late LocaleProvider localeProvider;
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of(context);
    LocaleProvider localeProvider = Provider.of(context);
    getShared();
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('ar', ''), // Spanish, no country code
      ],
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppStyle.lightTheme,
      darkTheme: AppStyle.darkTheme,
      themeMode: themeProvider.currentTheme,
      locale: Locale(localeProvider.currentLocale),
      routes: {
        Home.routeName: (context) => Home(),

      },
      initialRoute: Home.routeName,
    );
  }
  void getShared ()async{
    final prefs = await SharedPreferences.getInstance();
    localeProvider.changeCurrentLocale(prefs.getString('lang')?? 'ar');
  }
}
