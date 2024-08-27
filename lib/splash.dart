import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat'),
        actions: [
          IconButton(
            onPressed: (){
              FirebaseAuth.instance.signOut();
            }, 
            icon: Icon(Icons.exit_to_app,color: Theme.of(context).colorScheme.primary,)
            )
        ],
      ),
      body: Center(
        child: Text(
          'Log In'
        ),
      ),
    );
  }
}