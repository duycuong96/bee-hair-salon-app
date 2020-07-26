import 'package:beehairsalon/views/bottom_nav.dart';
import 'package:beehairsalon/views/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:beehairsalon/providers/auth.dart';
import 'package:beehairsalon/providers/todo.dart';

import 'package:beehairsalon/views/loading.dart';
import 'package:beehairsalon/views/login.dart';
import 'package:beehairsalon/views/register.dart';
import 'package:beehairsalon/views/password_reset.dart';
import 'package:beehairsalon/views/todos.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      builder: (context) => AuthProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => Router(),
          '/login': (context) => LogIn(),
          '/register': (context) => Register(),
          '/password-reset': (context) => PasswordReset(),
        },
      ),
    ),
  );
}

class Router extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);

    return Consumer<AuthProvider>(
      builder: (context, user, child) {
        switch (user.status) {
          case Status.Uninitialized:
            return Loading();
          case Status.Unauthenticated:
            return LogIn();
          case Status.Authenticated:
            return ChangeNotifierProvider(
              builder: (context) => TodoProvider(authProvider),
              child: BottomNavScreen(),
            );
          default:
            return LogIn();
        }
      },
    );
  }
}