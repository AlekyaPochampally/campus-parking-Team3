import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ApplicationBar extends StatelessWidget implements PreferredSizeWidget {

  AppBar appBarWidget = AppBar(
    title: Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Container(
            height: 35.0,
            width: 35.0,
            child: Image.asset('assets/images/nwm_logo.png')
          ),
        ),
        Text("Campus Parking"),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return appBarWidget;
  }

  @override
  Size get preferredSize {
    return appBarWidget.preferredSize;
  }
}
