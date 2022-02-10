import 'package:flutter/material.dart';
import 'package:prepare/view/home/widgets/home_body.dart';
import 'package:prepare/view/shared_widgets/header_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const HeaderWidget(arrow: false),
              HomeBodyWidget()
            ],
          ),
        ),
      ),
    );
  }
}
