import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vision_app/res/app_string.dart';
import 'package:vision_app/res/color/app_colors.dart';
import 'package:vision_app/view/create_project_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
    
    supportedLocales: [
      Locale('en'),
      Locale('ar'),
    ],
    path: 'assets/lang',
    fallbackLocale: Locale('en'),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // context.setLocale(Locale('ar'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Wrap(
            children: [
              Image.asset('assets/logo.png'),
              // Spacer(),
              FractionallySizedBox(
                widthFactor: 0.4,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    // margin: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColors.lightBlue),
                
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 185,
                    height: 55,
                    child: Text(
                      AppString.login,
                      style: TextStyle(
                        color: AppColors.lightBlue,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),Padding(
                padding: const EdgeInsets.all(8),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    // margin: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.lightBlue,
                      border: Border.all(color: AppColors.lightBlue),
                
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 185,
                    height: 55,
                    child: Text(
                      AppString.signup,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Image.asset('assets/header.png'),
          Container(
            height: 300,
            width: double.infinity,
            color: AppColors.lightGrey,
            child: Card(
              margin: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
             child:  ListView.builder(
              padding: EdgeInsets.all(20),
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  height: 200,
                  width: 200,
                  color: Colors.white,
                );
              },
             )

            )
          ),
          Image.asset('assets/footer.png'),
        ],
      ),

    );
  }
}
