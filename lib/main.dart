import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vision_app/core/go_router/go_router.dart';
import 'package:vision_app/core/di_storage_listner/di.dart';

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
//extrac the button and make it the same for the hole buttons

//handle no newtork will opining it //can't handle this case >>>>
//! know more about this : This uses the HTML renderer instead of CanvasKit — no internet needed to load it.
//
//1-save the access and refresh token , using 'FlutterSecureStorage'
//2- depend on it , to make rather than the sign buttons a user container
//
//make the api keys in seperated class
//! fix the DI
// make the attachement non required
//!fix this :  Another exception was thrown: Error: Could not find the correct Provider<ProjectDomainsBloc> above this DialogScreen Widget

//? handle if projct id in the project details page null

//! must fix the user login state

//** remember:
// >Supabase Uses a Direct Client SDK,that allows to connect and interact directly:
//add:
  //  await Supabase.instance.client.from('rooms').insert([
  //                           {
  //                             'table_num': _tableNumController.text,
  //                             'table_category': _tableCategoryController.text,
  //                             'char_num': _charNumController.text,
  //                             'emty': true
  //                           }
  //                         ]);
//-------------------------------------------------------------------------------

//update :
  // await Supabase.instance.client
  //       .from('rooms')
  //       .update({'emty': emty}).eq('table_num', id);
//-------------------------------------------------------------------------------
//delete :
  // Supabase.instance.client
  //                                   .from('rooms')
  //                                   .delete()
  //                                   .eq('${table['table_num']}', table)
  //                                   .select();




//? done :
//adding the showcasewidget
//fix the border of TextWithExpansionTileSelector
//fix the problem in the image
//add the domain and the owner name to the ui
//fix the image svg problem
//fix the login refresh page needed (but have to recheck it )
//join the attachements with the get projectID and make show it in the ui