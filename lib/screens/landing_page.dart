import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:simple_ecommerce_app/constants.dart';
import 'package:simple_ecommerce_app/screens/home_page.dart';
import 'package:simple_ecommerce_app/screens/login_page.dart';

class Landingpage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error:${snapshot.error}"),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
         return StreamBuilder(
           stream: FirebaseAuth.instance.authStateChanges(),
           builder: (context,streamSnapshot)
           {
             if (streamSnapshot.hasError) {
               return Scaffold(
                 body: Center(
                   child: Text("Error:${streamSnapshot.error}"),
                 ),
               );
             }

             if(streamSnapshot.connectionState == ConnectionState.active)
             {
               User _user=streamSnapshot.data;

               if(_user== null)
               {
                 return LoginPage();
               }
               else
                 {
                   return HomePage();
                 }
             }

//check uthentication---------------------------------------
             return Scaffold(
               body: Center(
                 child: Text(
                   "Checking authenticaion",
                   style: Constants.regularHeading,
                 ),
               ),
             );

           },
         );
        }

        return Scaffold(
          body: Center(
            child: Text(
              "Initializing app...",
              style: Constants.regularHeading,
            ),
          ),
        );
      },
    );
  }
}
