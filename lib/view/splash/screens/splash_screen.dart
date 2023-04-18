import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:places/main.dart';
import 'package:places/view/home/screens/home_screen.dart';
import 'package:places/view/login/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  isLoggedCheck()async{
    final bool? value = sharedPreferences.getBool("isLogged");
    if(value==true){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const HomeScreen()));
    }
    else{
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.only(top: 100, bottom: 40),
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              image: NetworkImage(
                "https://images.unsplash.com/photo-1603638725730-233a04d9dca4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aGlnaHdheSUyMG5pZ2h0fGVufDB8fDB8fA%3D%3D&w=1000&q=80",
              ),
              fit: BoxFit.cover,
              opacity: 0.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Destination",
              style: GoogleFonts.pacifico(fontSize: 50, color: Colors.white),
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Feeling Low? Plan for a Trip!",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                Material(
                  color: Colors.deepOrangeAccent,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    // splashColor: Colors.black,
                    onTap: () {
                      isLoggedCheck();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 35),
                      child: const Text(
                        "Get started",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
