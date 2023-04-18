import 'package:flutter/material.dart';
import 'package:places/config/theme/app_theme.dart';
import 'package:places/service/login_service.dart';
import 'package:places/view/login/screens/otp_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginService loginService;

  @override
  void initState() {
    // TODO: implement initState
    loginService = Provider.of<LoginService>(context, listen: false);
    super.initState();
  }

  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Center(
                          child: Container(
                            height: 240,
                            constraints: const BoxConstraints(maxWidth: 500),
                            margin: const EdgeInsets.only(top: 100),
                            decoration: const BoxDecoration(
                              color: Color(0xFFE1E0F5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://github.com/huextrat/TheGorgeousOtp/blob/master/assets/img/login.png?raw=true",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: const Text('The Phone Otp',
                              style: TextStyle(
                                  color: MyColors.primaryColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800)))
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      Container(
                          constraints: const BoxConstraints(maxWidth: 500),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: 'We will send you an ',
                                  style:
                                      TextStyle(color: MyColors.primaryColor)),
                              TextSpan(
                                  text: 'One Time Password ',
                                  style: TextStyle(
                                      color: MyColors.primaryColor,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: 'on this mobile number',
                                  style:
                                      TextStyle(color: MyColors.primaryColor)),
                            ]),
                          )),
                      Container(
                        height: 40,
                        constraints: const BoxConstraints(maxWidth: 500),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: TextField(
                          autofocus: false,
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter the Phone Number',
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        constraints: const BoxConstraints(maxWidth: 500),
                        child: Material(
                          color: Colors.deepOrangeAccent,
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            onTap: () {
                              String phoneNumber = "+91${phoneController.text}";

                              loginService
                                  .loginWithOtpSent(phoneNumber: phoneNumber)
                                  .then(
                                (value) {
                                  if (loginService.isCompleted!) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const OtpScreen()));
                                  }
                                },
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 35),
                              child: const Text(
                                "Login",
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
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
