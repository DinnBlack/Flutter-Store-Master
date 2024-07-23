// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storemaster/screens/login/login_screen.dart';
import 'package:storemaster/screens/login/start_screen.dart';
import 'package:storemaster/screens/main/main_screen.dart';
import 'package:storemaster/screens/splash/splash_screen.dart';
import 'package:storemaster/utils/const.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDARHDIaWGd9hA6m3XY-Eqt1HOdV6dLiX4',
      appId: '1:126628150865:android:6e594846fe882ca2ccc270',
      messagingSenderId: '126628150865',
      projectId: 'store-master-dinnblack',
      storageBucket: 'store-master-dinnblack.appspot.com',
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  ));

  final prefs = await SharedPreferences.getInstance();
  final bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

  if (isFirstLaunch) {
    await prefs.setBool('isFirstLaunch', false);
  }

  User? currentUser = FirebaseAuth.instance.currentUser;

  runApp(MyApp(isFirstLaunch: isFirstLaunch, currentUser: currentUser));
}

class MyApp extends StatelessWidget {
  final bool isFirstLaunch;
  final User? currentUser;
  const MyApp({super.key, required this.isFirstLaunch, this.currentUser});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 780),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            title: 'Store Master',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: "QuicksandRegular",
              colorScheme:
                  ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
            ),
            home: child,
          );
        },
        child: isFirstLaunch
            ? const SplashScreen(
                splash: 'assets/lottie/Animation - 1721314856511.json',
                nextScreen: StartScreen(),
              )
            : currentUser != null
                ? const SplashScreen(
                    splash: 'assets/lottie/Animation - 1721314856511.json',
                    nextScreen: MainScreen(),
                  )
                : const SplashScreen(
                    splash: 'assets/lottie/Animation - 1721314856511.json',
                    nextScreen: LoginScreen(),
                  ));
  }
}
