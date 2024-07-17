// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:storemaster/screens/main/main_screen.dart';
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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      child: const MainScreen(),
    );
  }
}
