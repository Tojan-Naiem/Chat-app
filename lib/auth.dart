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
            ),
            Card( 
              margin: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    child: Column( 
                      children: [ 
                        TextFormField( 
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                        ),
                        TextFormField( 
                          decoration: InputDecoration(
                            labelText: 'Password',
                          ),
                          obscureText: true,
                        
                        ),
                        
                      ],
                    )),
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }
}