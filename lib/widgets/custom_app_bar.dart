import 'package:beehairsalon/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:beehairsalon/config/palette.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.primaryColor,
      elevation: 0.0,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.info_outline),
          iconSize: 28.0,
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}