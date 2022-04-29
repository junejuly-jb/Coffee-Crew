import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Spinner extends StatelessWidget {
  const Spinner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.grey[500],
          size: 50.0,
        ),
      ),
    );
  }
}
