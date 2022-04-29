import 'package:coffee_maker/models/user.dart';
import 'package:coffee_maker/services/database.dart';
import 'package:coffee_maker/shared/spinner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  // final VoidCallback callback;
  const Setting({Key? key}) : super(key: key);
  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  String? currentName;
  String? _currentSugars;
  int? _currentStrength;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            UserData userData = snapshot.data!;

            return GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Container(
                color: Colors.grey[900],
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Row(
                            children: [
                              Text(
                                'Adjust your brew',
                                style: TextStyle(
                                    color: Colors.grey[100],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23.0,
                                    letterSpacing: 1.5),
                              ),
                              const Spacer(),
                              IconButton(
                                  color: Colors.grey[100],
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.close))
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          TextFormField(
                              initialValue: userData.name,
                              style: TextStyle(
                                color: Colors.grey[100],
                              ),
                              onChanged: (val) =>
                                  setState(() => currentName = val),
                              validator: (val) => (val == null || val.isEmpty)
                                  ? 'Please enter a name'
                                  : null,
                              decoration: InputDecoration(
                                  border: const UnderlineInputBorder(),
                                  labelText: 'NAME',
                                  labelStyle: TextStyle(
                                    color: Colors.grey[500],
                                    letterSpacing: 3.0,
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)))),
                          const SizedBox(height: 25.0),
                          DropdownButtonFormField(
                              dropdownColor: Colors.grey[900],
                              style: TextStyle(color: Colors.grey[100]),
                              value: _currentSugars ?? userData.sugars,
                              items: sugars.map((String e) {
                                return DropdownMenuItem<String>(
                                    value: e, child: Text('$e sugars'));
                              }).toList(),
                              onChanged: (String? val) {
                                setState(() => _currentSugars = val!);
                              },
                              decoration: InputDecoration(
                                  border: const UnderlineInputBorder(),
                                  labelText: 'SUGARS',
                                  labelStyle: TextStyle(
                                    color: Colors.grey[500],
                                    letterSpacing: 3.0,
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)))),
                          const SizedBox(height: 40.0),
                          const Text(
                            'STRENGTH',
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 2.0,
                            ),
                          ),
                          Slider(
                            min: 100,
                            max: 900,
                            divisions: 8,
                            activeColor: Colors.brown[_currentStrength ?? userData.strength!],
                            inactiveColor:
                                Colors.brown[_currentStrength ?? userData.strength!],
                            value: (_currentStrength ?? userData.strength!).toDouble(),
                            onChanged: (val) {
                              setState(() => _currentStrength = val.round());
                            },
                          ),
                          const Spacer(),
                          ElevatedButton.icon(
                            onPressed: isLoading ? null : () async {
                              setState(() {
                                isLoading = true;
                              });
                              if(_formKey.currentState!.validate()){
                                await DatabaseService(uid: user.uid).updateUserData(
                                  _currentSugars ?? userData.sugars!,
                                  currentName ?? userData.name!,
                                  _currentStrength ?? userData.strength!,
                                );
                                Navigator.pop(context);
                                setState(() {
                                  isLoading = false;
                                });
                              }
                              setState(() {
                                isLoading = false;
                              });
                            },
                            label: const Text('Update Coffee'),
                            icon: isLoading ? 
                            Container(
                              width: 24,
                              height: 24,
                              padding: const EdgeInsets.all(2.0),
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            ) :
                            const Icon(Icons.update),
                          )
                        ],
                      )),
                ),
              ),
            );
          } else {
            return const Spinner();
          }
        });
  }
}
