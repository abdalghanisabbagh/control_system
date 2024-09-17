import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';

class PageNotFoundScreen extends StatelessWidget {
  const PageNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Page Not Found" " 404",
            style: nunitoBold.copyWith(fontSize: 30)),
      ),
    );
  }
}
