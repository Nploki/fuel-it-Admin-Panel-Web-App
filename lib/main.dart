import 'package:fuel_it_admin_panel/screens/admin_users.dart';
import 'package:fuel_it_admin_panel/screens/category_screen.dart';
import 'package:fuel_it_admin_panel/screens/home_screen.dart';
import 'package:fuel_it_admin_panel/screens/login_screen.dart';
import 'package:fuel_it_admin_panel/screens/manage_banner.dart';
import 'package:fuel_it_admin_panel/screens/order_screen.dart';
import 'package:fuel_it_admin_panel/screens/price_update.dart';
import 'package:fuel_it_admin_panel/screens/rider_screen.dart';
import 'package:fuel_it_admin_panel/screens/splash_screen.dart';
import 'package:fuel_it_admin_panel/screens/vendor_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBA5ahUbw2eYGQJPWAlqr8W5h2mAK5zDd4",
          projectId: "map-np",
          messagingSenderId: "217803086791",
          appId: "1:217803086791:web:af0c8fbe1f255b3410d7e2"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Fuel-It Admin Panel',
        theme: ThemeData(
          primaryColor: Colors.yellow,
          useMaterial3: true,
        ),
        home: splash_screen(),
        debugShowCheckedModeBanner: false,
        initialRoute: home_screen.id,
        routes: {
          home_screen.id: (context) => home_screen(),
          splash_screen.id: (context) => splash_screen(),
          login_screen.id: (context) => login_screen(),
          category_Screen.id: (context) => category_Screen(),
          BannerScreen.id: (context) => BannerScreen(),
          PriceUpdate.id: (context) => PriceUpdate(),
          VendorScreen.id: (context) => VendorScreen(),
          RiderScreen.id: (context) => RiderScreen(),
          admin_users.id: (context) => admin_users(),
          Order_Screen.id: (context) => Order_Screen(),
        });
  }
}
