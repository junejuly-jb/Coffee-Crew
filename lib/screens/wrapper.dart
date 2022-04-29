import 'package:coffee_maker/models/user.dart';
import 'package:coffee_maker/screens/authenticate/authenticate.dart';
import 'package:coffee_maker/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
    const Wrapper({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        final user = Provider.of<MyUser?>(context);
        return user == null ? const Authenticate() : const Home();
    }
}
