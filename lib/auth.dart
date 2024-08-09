import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin=true;
  final _formKey=GlobalKey<FormState>();
  String _enteredEmail='';
  String _enterdPassword='';
void _sumbit(){
  final valid= _formKey.currentState!.validate();
  if(valid){
    _formKey.currentState!.save();
  }

 

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