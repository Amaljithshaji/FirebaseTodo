import 'package:base/core/auth/auth_method.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final Authmethod _authmethod = Authmethod();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.7,
            color: Colors.red,
            child: Image.asset('assets/img/signinpage.jpeg',fit: BoxFit.fitHeight,)),
            Text(
            "Dive in without delay",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
        )),
        Container(
          width: MediaQuery.of(context).size.width* 0.9,
          child: Text(
              "Lorem ipsum dolor sit amet consectetur. Neque et nulla et.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  
              )
          ),
        ),
        Padding(
          padding:  EdgeInsets.only(bottom: MediaQuery.of(context).size.height* 0.04 ),
          child: Center(
            child:InkWell(
              onTap: ()async{

           bool res = await _authmethod.signInWithGoogle();
           if(res) {
           // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));
            print(res);
           }
              },
              child: Container(
                width: MediaQuery.of(context).size.width* 0.5,
                height: MediaQuery.of(context).size.height* 0.07,
               
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white,
                border: Border.all(color: Colors.black,width: 2)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      child: Image.asset('assets/img/google.png')),
                      Text(
                            "Sign in",
                            style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                            )
                        )
                  ],
                ),
              ),
            )
          ),
        )
      ]),
    );
  }
}