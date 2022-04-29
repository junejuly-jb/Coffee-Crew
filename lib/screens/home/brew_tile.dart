import 'package:coffee_maker/models/coffee.dart';
import 'package:flutter/material.dart';

class BrewTile extends StatelessWidget {

  final Coffee? coffee;
  const BrewTile({Key? key, this.coffee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[850],
      margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25.0,
          backgroundColor: Colors.brown[coffee!.strength],
        ),
        title: Text(
            coffee!.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
        subtitle: Text(
            'Takes ${coffee!.sugars} sugar(s)',
            style: TextStyle(
              color: Colors.grey[100]
            ),
        ),
      ),
    );
  }
}
