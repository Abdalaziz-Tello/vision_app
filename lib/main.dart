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
//add the navigate in the homepage into the project details , with somefixes


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


/*
//flutter pub add webview_flutter
------------------------------------------------------------------
<!--Start of Tawk.to Script-->
<script type="text/javascript">
var Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();
(function(){
var s1=document.createElement("script"),s0=document.getElementsByTagName("script")[0];
s1.async=true;
s1.src='https://embed.tawk.to/686c02ebe27303190bc1358c/1iviumqrk';
s1.charset='UTF-8';
s1.setAttribute('crossorigin','*');
s0.parentNode.insertBefore(s1,s0);
})();
</script>
<!--End of Tawk.to Script-->
----------------------------------------------------------------



*/
//? done :
/*
-fix the onTap properities
-add customSnackBar func to use it in the widgets
-fix the footer image in the homepage
-fix the dialog size
-fix the password validation
-add the confirm password snackbar
-change the navigation of the resources into the homepage if success
-make the button shake animation
-add get top projects depends on percentage_completed
-make the passwrod toggle between hidden and visible
-fix the arabic file name problem
-fix the ui of the top project card
*/


