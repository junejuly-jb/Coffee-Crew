import 'package:coffee_maker/models/coffee.dart';
import 'package:coffee_maker/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email = '';
  String password = '';
  bool isVisible = false;
  String message = '';
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  void onSignIn() async {
    if (_formKey.currentState!.validate()) {
      dynamic result =
          await _auth.registerWithEmailAndPassword(email, password);
      if (result['status'] == 409) {
        setState(() {
          message = result['message'];
        });
        _showToast(context);
      } else {
        Navigator.pop(context);
      }
    }
  }

  
  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey[850],
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close),
                        color: Colors.grey[100],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Text(
                        'Register',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0),
                      ),
                      const SizedBox(height: 50.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                  validator: (val) =>
                                      (val != null && val.isEmpty)
                                          ? 'Enter an email'
                                          : null,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      height: 2.2),
                                  onChanged: (val) {
                                    setState(() {
                                      email = val;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      border: const UnderlineInputBorder(),
                                      labelText: 'EMAIL',
                                      labelStyle: TextStyle(
                                        color: Colors.grey[500],
                                        letterSpacing: 3.0,
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white)))),
                              TextFormField(
                                  validator: (val) => val!.length < 6
                                      ? 'password is too short'
                                      : null,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      height: 2.2),
                                  onChanged: (val) {
                                    setState(() {
                                      password = val;
                                    });
                                  },
                                  obscureText: !isVisible,
                                  decoration: InputDecoration(
                                      border: const UnderlineInputBorder(),
                                      labelText: 'PASSWORD',
                                      suffixIcon: password.isNotEmpty
                                          ? TextButton(
                                              child: Text(
                                                isVisible ? 'HIDE' : 'SHOW',
                                                style: const TextStyle(
                                                    letterSpacing: 2.0),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  isVisible = !isVisible;
                                                });
                                              },
                                            )
                                          : null,
                                      labelStyle: TextStyle(
                                        color: Colors.grey[500],
                                        letterSpacing: 3.0,
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white)))),
                              const SizedBox(height: 85.0),
                              ElevatedButton(
                                onPressed: onSignIn,
                                child: const Text('REGISTER'),
                                style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(50)),
                              ),
                            ],
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
