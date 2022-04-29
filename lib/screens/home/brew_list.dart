import 'package:coffee_maker/models/coffee.dart';
import 'package:coffee_maker/screens/home/brew_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {

  @override
  Widget build(BuildContext context) {

    final brews = Provider.of<List<Coffee>?>(context) ?? [];

    return ListView.builder(
      itemCount: brews.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index){
        return BrewTile(coffee: brews[index]);
      }
    );
  }
}
