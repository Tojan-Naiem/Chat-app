import 'package:chat_app/auth.dart';
import 'package:chat_app/chat.dart';
import 'package:chat_app/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
  await Firebase.initializeApp(options: FirebaseOptions(
   apiKey: "AIzaSyAZlYHPuwUu_EvxZgQ7gO4WWIvjhMNUIBU",
  authDomain: "chatapp-f3d5b.firebaseapp.com",
  projectId: "chatapp-f3d5b",
  storageBucket: "chatapp-f3d5b.appspot.com",
  messagingSenderId: "315588455711",
  appId: "1:315588455711:web:87a9a0c5c0526631bbd42a"
    
    
    )
    );
  }else{
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
       builder: (
        (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return SplashScreen();
          }
          if(snapshot.hasData)
          {
            return ChatScreen();
          }
          return AuthScreen();

        }
       )
       )
    );
  }
}

