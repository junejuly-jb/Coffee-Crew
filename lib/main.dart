import 'package:coffee_maker/models/user.dart';
import 'package:coffee_maker/screens/authenticate/register.dart';
import 'package:coffee_maker/screens/wrapper.dart';
import 'package:coffee_maker/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // transparent status bar
    ));
    await Firebase.initializeApp();
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({Key? key}) : super(key: key);

    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
        return StreamProvider<MyUser?>.value(
            initialData: null,
            value: AuthService().user,
            child: MaterialApp(
                initialRoute: '/',
                routes: {
                    '/': (context) => const Wrapper(),
                    '/register': (context) => const Register()
                },
            ),
        );
    }
}
