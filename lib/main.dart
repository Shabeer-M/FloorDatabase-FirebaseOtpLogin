import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:places/database/dao/place_dao.dart';
import 'package:places/database/place_database/place_database.dart';
import 'package:places/service/login_service.dart';
import 'package:places/view/splash/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
PlaceDao? placeDaoMain;
late SharedPreferences sharedPreferences;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences =await SharedPreferences.getInstance();
  final database = await $FloorAppDatabase.databaseBuilder("place_database.db").build();
  placeDaoMain= database.placeDao;
   await Firebase.initializeApp();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginService()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
