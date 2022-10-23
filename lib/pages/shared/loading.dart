import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget{
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: const Color(0xFF231942),
      child: const Center(
        child: SpinKitCubeGrid(
          color: Color(0xFF5E548E),
          size:  50.0,
        ),
      ),
    );
  }
}