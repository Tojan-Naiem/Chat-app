import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: SingleChildScrollView( 
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
            Container( 
              margin: EdgeInsets.only( 
                top: 30,
                bottom: 30,
                left: 20,
                right: 20,

              ),
              child: Image.asset('images/chat.png'),
            )
          ],
        ),
      ),
    );
  }
}