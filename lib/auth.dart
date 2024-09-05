import 'dart:developer';
import 'dart:io';

import 'package:chat_app/widgets/userImage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final _firebase= FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin=true;
  bool _isLoading=true;
  File? _selectedImage;
  bool _isUploading=false;

  final _formKey=GlobalKey<FormState>();
  String _enteredEmail='';
  String _enterdPassword='';
  String _enterdName='';
void _sumbit() async{
  final valid= _formKey.currentState!.validate();
  if(!valid||!_isLogin&&_selectedImage==null){
    return ;
    
  }

  // عرض مؤشر التحميل
  setState(() {
    _isLoading = true;
  });

  try {
    setState(() {
      _isUploading=true;
    });
    if (_isLogin) {
     try{ log('Attempting to log in');
       UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _enteredEmail.trim(), 
      password: _enterdPassword.trim()
    );
        log("User logged in successfully: ${userCredential.user?.uid}");
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    log('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    log('Wrong password provided for that user.');
  } else {
    log('Error: ${e.message}');
  }
}


    } else {
      log('Attempting to create a new user');

      final UserCredential userCredential = await _firebase.createUserWithEmailAndPassword(
        email: _enteredEmail.trim(), 
        password: _enterdPassword.trim(),
      );
      final storageRef=FirebaseStorage.instance
      .ref().
      child('user-image').
      child('${userCredential.user!.uid}.jpg');
      storageRef.putFile(_selectedImage!);
      final uploadTask = await storageRef.putFile(_selectedImage!);

// التحقق من نجاح الرفع
if (uploadTask.state == TaskState.success) {
  // الحصول على رابط التنزيل بعد نجاح الرفع
  final imageURL = await storageRef.getDownloadURL();
  
      await FirebaseFirestore.instance
    .collection('users')
    .doc(userCredential.user!.uid)
    .set({
  'name': _enterdName,
  'email': _enteredEmail,
  'image': imageURL,
});


  log('Download URL: $imageURL');
} else {
  log('File upload failed');
}


    }
  } on FirebaseAuthException catch (e) {
    log('FirebaseAuthException: ${e.message}');
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.message ?? 'Authentication Failed'),
      ),
    );
  } 

if (_formKey.currentState!.validate()) {
  _formKey.currentState!.save();
}
setState(() {
      _isUploading=false;
    });

 


}

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView( 
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
                width: 200,
                child: Image.asset('images/chat.png'),
              ),
              Card( 
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column( 
                        children: [ 
                         if(!_isLogin) UserImagePicker(
                          onPickedImage: (File pickedImage){
                            _selectedImage=pickedImage;
                          }
                          ),
                          TextFormField( 
                            decoration: InputDecoration(
                              labelText: 'Email Address',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            onSaved: (newValue) => _enteredEmail=newValue!,
                            validator: (value) {
                              if(value==null||value.trim().isEmpty||!value.contains('@')){
                                return '';
                              }
                              return null;
                            },
                          ),
                          if(!_isLogin)
                           TextFormField( 
                            decoration: InputDecoration(
                              labelText: 'UserName',
                            ),
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            onSaved: (newValue) => _enterdName=newValue!,
                            validator: (value) {
                              if(value==null||value.trim().length<3){
                                return '';
                              }
                              return null;
                            },
                          ),
                          TextFormField( 
                            decoration: InputDecoration(
                              labelText: 'Password',
                            ),
                            obscureText: true,
                            onSaved: (newValue) => _enterdPassword=newValue!,
                         validator: (value) {
                              if(value==null||value.trim().length<6){
                                return 'Password must be at least 6 charactors long';
                              }
                              return null;
                            },
                          
                          ),
                          const SizedBox(height: 15,),
                          if(_isUploading)CircularProgressIndicator(),
                          if(!_isUploading)
                          ElevatedButton(
                            style: ElevatedButton.styleFrom( 
                              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                            ),
                            onPressed:_sumbit,
                            child: Text(
                             _isLogin? 'Login':'Sign Up',
                              // style: TextStyle
                              // (
                              //   color:Theme.of(context).colorScheme.primaryContainer,
                              //   ),
                                )
                            ),
                            if(!_isUploading)
                            TextButton(
                              onPressed: (){
                               setState(() {
                                 _isLogin=!_isLogin;
                               });
                            }, 
                            child: Text(
                              _isLogin? 'Creat an account':'I have already an account',
                              // style: TextStyle( 
                              //   color: Theme.of(context).colorScheme.primaryContainer
                              // ),
                            ))
                          
                        ],
                      )),
                    ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}