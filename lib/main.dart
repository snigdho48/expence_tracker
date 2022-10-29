
import 'package:expence_tracker/pages/destinatio_page.dart';
import 'package:expence_tracker/pages/expense_add_page.dart';
import 'package:expence_tracker/pages/home_page.dart';
import 'package:expence_tracker/pages/launcher_page.dart';
import 'package:expence_tracker/pages/loan_add.dart';
import 'package:expence_tracker/pages/loan_page.dart';
import 'package:expence_tracker/pages/login_page.dart';
import 'package:expence_tracker/pages/multi_screen_pages.dart';
import 'package:expence_tracker/pages/multipages/food_expence.dart';
import 'package:expence_tracker/providers/expence_provider.dart';
import 'package:expence_tracker/providers/lone_provider.dart';
import 'package:expence_tracker/providers/multi_screen_provider.dart';
import 'package:expence_tracker/providers/user_provider.dart';
import 'package:expence_tracker/utils/notifications_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
NotificationService notificationService = NotificationService();


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService notificationService = NotificationService();
  await notificationService.init();
  await notificationService.requestIOSPermissions();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=>ExpenceProvider()),
      ChangeNotifierProvider(create: (context)=>UserProvider()),
      ChangeNotifierProvider(create: (context)=>MultiScreenProvider()),
      ChangeNotifierProvider(create: (context)=>LoneProvider()),
    ],
      child: const MyApp()),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      //home: HomeScreen(),


      initialRoute: LauncherPage.routeName,
      routes: {
        LoginPage.routeName:(context)=>const LoginPage(),
        HomePage.routeName:(context)=>const HomePage(),
        ExpenseAddPage.routeName:(context)=>const ExpenseAddPage(),
        LoanPage.routeName:(context)=>LoanPage(),
        LoanAdd.routeName:(context)=>const LoanAdd(),
        LauncherPage.routeName:(context)=>const LauncherPage(),
        MultiScreenPages.routeName:(context)=>const MultiScreenPages(),
        DetailsPage.routeName:(context)=>DetailsPage(payload: 'payload')
      },

    );
  }
}
