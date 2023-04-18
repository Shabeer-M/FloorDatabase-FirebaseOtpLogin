import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:places/main.dart';
class LoginService extends ChangeNotifier{
  bool _isCompleted= false;
  bool? get isCompleted => _isCompleted;
  bool _isOtpCompleted= false;
  bool? get isOtpCompleted => _isOtpCompleted;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? _verificationId;


  Future<void> loginWithOtpSent({required String phoneNumber})async{
    await sharedPreferences.setBool("isLogged", false);

    await _firebaseAuth.verifyPhoneNumber(
        verificationCompleted: (phoneAuthCredential) {
          signInWithPhone(phoneAuthCredential);
        },
        verificationFailed: (error) {

        },
        codeSent: (verificationId, forceResendingToken) {
          _verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {
          _verificationId = verificationId;
        },
        phoneNumber: phoneNumber);
    _isCompleted =true;
  }
  Future<void> signInWithPhone(PhoneAuthCredential credential) async {
    try {
      _firebaseAuth.signInWithCredential(credential);

    } on FirebaseAuthException catch (ex) {
    }
  }
  Future<void> verifyOTP({required String otp}) async {
    _isOtpCompleted =false;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: _verificationId!, smsCode: otp);
    signInWithPhone(credential);
   var value = placeDaoMain?.getAllPlace();
   print(value);
    await sharedPreferences.setBool("isLogged", true);

    _isOtpCompleted=true;
  }
}