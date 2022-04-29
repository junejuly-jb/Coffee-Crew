import 'package:coffee_maker/models/coffee.dart';
import 'package:coffee_maker/screens/home/brew_list.dart';
import 'package:coffee_maker/screens/home/settings.dart';
import 'package:coffee_maker/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee_maker/services/database.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

    final AuthService _auth = AuthService();
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void logout() async {
    await _auth.signOut();
  }

  void showSettingsPanel(){
    _scaffoldKey.currentState!.openEndDrawer();
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(30.0)
            )
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (context){
            return const Setting();
        }
    );
  }

  openDrawer(){
    _scaffoldKey.currentState!.openDrawer();
  }


  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<Coffee>?>.value(
      value: DatabaseService().coffee,
      initialData: null,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          backgroundColor: Colors.grey[900],
          child: SafeArea(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  textColor: Colors.white,
                  title: const Text('Settings'),
                  onTap: showSettingsPanel,
                ),
                ListTile(
                  textColor: Colors.white,
                  title: const Text('Logout'),
                  onTap: logout,
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.grey[900],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Builder(builder: (context) {
                      return IconButton(
                        color: Colors.grey[100],
                        icon: const Icon(Icons.menu),
                        onPressed: openDrawer,
                      );
                    }),
                    const Text(
                        'Coffee Maker',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0
                        ),
                    ),
                  ],
                ),
                const BrewList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
