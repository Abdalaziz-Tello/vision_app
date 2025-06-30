import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vision_app/core/go_router/go_router.dart';
import 'package:vision_app/features/auth/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await init();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/lang',
      fallbackLocale: Locale('en'),
      startLocale: Locale('ar'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Routes().router,
      debugShowCheckedModeBanner: false,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      // home: HomePage(),
    );
  }
}



//TODO:
//fix the exeption when choosing file !!
//slove this error : 10_Another exception was thrown: Incorrect use of ParentDataWidget// already why its 10 times ?!
//to save the role after get it

//? done:
//complete the API's files
//change the strings in homepage
//make the dropdown widget , and fix the validation for it
//fix problem of (Incorrect use of ParentDataWidget) in the createProjectPage

//** remember:
// >Supabase Uses a Direct Client SDK,that allows to connect and interact directly: