import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SingleModeScreen extends StatelessWidget {
  const SingleModeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.go('/');
        return false;
      },
      child: const Scaffold(),
    );
  }
}