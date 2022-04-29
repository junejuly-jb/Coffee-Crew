import 'package:coffee_maker/screens/authenticate/widgets/signin_header.dart';
import 'package:coffee_maker/services/auth.dart';
import 'package:coffee_maker/shared/spinner.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  String email = '';
  String password = '';
  bool isVisible = false;
  String message = '';
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final emailField = TextEditingController();

  void onSignIn() async {
   if(_formKey.currentState!.validate()){
     setState(() {
       isLoading = true;
     });
     dynamic result = await AuthService().signInWithEmailAndPassword(email, password);
     if(result == null){
       setState(() {
         isLoading = false;
         message = 'Could not sign in with those credentials';
       });
       _showToast(context);
     }
   }
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message)
      ),
    );
  }

  void clearEmail(){
    emailField.clear();
    setState(() {
      email = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? const Spinner() : GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey[850],
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children:  <Widget>[
                  const SignInHeader(title1: 'Hello.', title2: 'Welcome Back'),
                  const SizedBox(height: 60.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                            controller: emailField,
                            validator: (val) => (val != null && val.isEmpty) ? 'Email is required' : null,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                height: 2.2
                            ),
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                            decoration: InputDecoration(
                                suffixIcon: email.isNotEmpty ? IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: clearEmail,
                                  color: Colors.grey[500],
                                ) : null,
                                border: const UnderlineInputBorder(),
                                labelText: 'USERNAME',
                                labelStyle: TextStyle(
                                    color: Colors.grey[500],
                                    letterSpacing: 3.0,
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide( color: Colors.white),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)
                                )
                            )
                        ),
                        const SizedBox(height: 25.0),
                        TextFormField(
                            validator: (val) => val!.length < 6 ? 'Password is too short' : null,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                height: 2.2
                            ),
                            onChanged: (val) {
                              setState(() {
                                password = val;
                              });
                            },
                            obscureText: !isVisible,
                            decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                labelText: 'PASSWORD',
                                suffixIcon: password.isNotEmpty ? TextButton(
                                  child: Text(
                                      isVisible ? 'HIDE' : 'SHOW',
                                      style: TextStyle(
                                        letterSpacing: 2.0,
                                        color: Colors.grey[500]
                                    ),
                                  ),
                                  onPressed: (){
                                    setState(() {
                                      isVisible = !isVisible;
                                    });
                                  },
                                ) : null,
                                labelStyle: TextStyle(
                                  color: Colors.grey[500],
                                  letterSpacing: 3.0,
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide( color: Colors.white),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)
                                )
                            )
                        ),
                        const SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, '/register');
                                },
                                child: const Text('Dont have an account?')
                            )
                          ],
                        ),
                        const SizedBox(height: 85.0),
                        ElevatedButton(
                            onPressed: onSignIn,
                            child: const Text('Login'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50)
                            ),
                        ),
                        const SizedBox(height: 5.0)
                      ],
                    )
                  )
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}
