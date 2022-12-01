// ignore_for_file: use_build_context_synchronously, camel_case_types, non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:async_button_builder/async_button_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';


FirebaseAuth? auth;
void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  auth = FirebaseAuth.instance;
  runApp(const MyApp());

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Mobile_number_and_otp(),
    );
  }
}

class Mobile_number_and_otp extends StatefulWidget {
  const Mobile_number_and_otp({super.key});

  @override
  State<Mobile_number_and_otp> createState() => _Mobile_number_and_otpState();
}

class _Mobile_number_and_otpState extends State<Mobile_number_and_otp> {

  TextEditingController mobileno = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text("Login using Mobile number and OTP",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Enter Mobile Number',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Use for login',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    autocorrect: true,
                    enableSuggestions: true,
                    controller: mobileno,
                    obscureText: false,
                    cursorColor: Colors.black,
                    style: const TextStyle(height: 1),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter(RegExp(r'^[0-9]{0,10}'), allow: true)
                    ],
                    decoration: InputDecoration(
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 15,right: 15,),
                        child: Icon(Icons.call_rounded,color: Colors.green,),
                      ),
                      labelText: 'Enter Mobile Number',
                      labelStyle: TextStyle(fontSize: 13,color: Colors.grey.withOpacity(.8)),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(),)
                    ),
                    onChanged: (value){
    
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AsyncButtonBuilder(
                      loadingWidget: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 57),
                        child: SizedBox(
                          height: 16.0,
                          width: 16.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      ),
                      errorWidget: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 57),
                        child: SizedBox(
                          height: 16.0,
                          width: 16.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      ),
                      successWidget: 
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.2, horizontal: 53),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if(!currentFocus.hasPrimaryFocus) {
                          currentFocus.focusedChild!.unfocus();
                        }
                        if(mobileno.text ==''){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text('Enter Mobile Number', style: TextStyle(color: Colors.white),),
                              ),
                              backgroundColor: Colors.red.withOpacity(0.8),
                              action: SnackBarAction(label: "",textColor: Colors.white, onPressed: (){}),
                              padding: const EdgeInsets.only(top: 5,left: 8),
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        }
                        else {
                          FocusManager.instance.primaryFocus?.unfocus();
                          await Future.delayed(const Duration(seconds: 2));
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  Otp(number: mobileno.text),));
                        }
                      },
                      loadingSwitchInCurve: Curves.bounceInOut,
                      loadingTransitionBuilder: (child, animation) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 1.0),
                            end: const Offset(0, 0),
                          ).animate(animation),
                          child: child,
                        );
                      },
                      builder: (context, child, callback, state) {
                        return Material(
                          borderRadius: BorderRadius.circular(10),
                          color: state.maybeWhen(
                            success: () => Colors.green,
                            orElse: () => Colors.green,
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: InkWell(
                            onTap: callback,
                            child: child,
                          ),
                        );
                      },
                      child: Container(
                        height: 40,
                        width: 130,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.green,
                              Colors.green,
                            ],
                          )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 5,),
                            Icon(Icons.arrow_right_alt_rounded, color: Colors.white,)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class Otp extends StatefulWidget {
  String number;
  Otp({super.key,required this.number});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {

  TextEditingController otp = TextEditingController();

  int btn=0;
  String? vid;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
     }
    );
    OTPsend();
    super.initState();
  }

  Future OTPsend() async
  {
    await auth!.verifyPhoneNumber(
        phoneNumber: '+91 ${widget.number}',
        verificationCompleted: (PhoneAuthCredential credential) async {
        // Sign the user in (or link) with the auto-generated credential
          await auth!.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
        }
        // Handle other errors
        },
        codeSent: (String verificationId, int? resendToken) async {
          setState(() {
            vid = verificationId;
            btn = 1;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
        },
        timeout: const Duration(seconds: 60),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text("Login using Mobile number and OTP",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Enter OTP',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Use for login',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    autocorrect: true,
                    enableSuggestions: true,
                    autofocus: true,
                    controller: otp,
                    obscureText: false,
                    cursorColor: Colors.black,
                    style: const TextStyle(height: 1),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter(RegExp(r'^[0-9]{0,6}'), allow: true)
                    ],
                    decoration: InputDecoration(
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 15,right: 15,),
                        child: Icon(Icons.call_rounded,color: Colors.green,),
                      ),
                      labelText: 'Enter OTP Number',
                      labelStyle: TextStyle(fontSize: 13,color: Colors.grey.withOpacity(.8)),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(),)
                    ),
                    onChanged: (value){
    
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    btn==0 ? const SizedBox() : AsyncButtonBuilder(
                      loadingWidget: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 57),
                        child: SizedBox(
                          height: 16.0,
                          width: 16.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      ),
                      errorWidget: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 57),
                        child: SizedBox(
                          height: 16.0,
                          width: 16.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      ),
                      successWidget: 
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.2, horizontal: 53),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if(otp.text ==''){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text('Enter OTP', style: TextStyle(color: Colors.white),),
                              ),
                              backgroundColor: Colors.red.withOpacity(0.8),
                              action: SnackBarAction(label: "",textColor: Colors.white, onPressed: (){}),
                              padding: const EdgeInsets.only(top: 5,left: 8),
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        }
                        else
                        {
                          String smsCode = otp.text;
                          PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: vid!, smsCode: smsCode);
                          await auth!.signInWithCredential(credential);
                          FocusManager.instance.primaryFocus?.unfocus();
                          await Future.delayed(const Duration(seconds: 2));
                          otp.clear();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Homepage(),));
                        }
                        
                      },
                      loadingSwitchInCurve: Curves.bounceInOut,
                      loadingTransitionBuilder: (child, animation) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 1.0),
                            end: const Offset(0, 0),
                          ).animate(animation),
                          child: child,
                        );
                      },
                      builder: (context, child, callback, state) {
                        return Material(
                          borderRadius: BorderRadius.circular(10),
                          color: state.maybeWhen(
                            success: () => Colors.green,
                            orElse: () => Colors.green,
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: InkWell(
                            onTap: callback,
                            child: child,
                          ),
                        );
                      },
                      child: Container(
                        height: 40,
                        width: 130,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.green,
                              Colors.green,
                            ],
                          )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 5,),
                            Icon(Icons.arrow_right_alt_rounded, color: Colors.white,)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text("Welcome",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SizedBox(),
            Center(child: Text("Successoft Infotech",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))
          ],
        ),
      ),
    );
  }
}