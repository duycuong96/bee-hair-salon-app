import 'package:beehairsalon/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:beehairsalon/providers/auth.dart';
import 'package:beehairsalon/utils/validate.dart';
import 'package:beehairsalon/styles/styles.dart';
import 'package:beehairsalon/widgets/styled_flat_button.dart';

class PasswordReset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quên mật khẩu'),
        backgroundColor: Palette.primaryColor,
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
            child: PasswordResetForm(),
          ),
        ),
      ),
    );
  }
}

class PasswordResetForm extends StatefulWidget {
  const PasswordResetForm({Key key}) : super(key: key);

  @override
  PasswordResetFormState createState() => PasswordResetFormState();
}

class PasswordResetFormState extends State<PasswordResetForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String email;
  String password;
  String message = '';

  Map response = new Map();

  Future<void> submit() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      bool success = await Provider.of<AuthProvider>(context).passwordReset(email);
      if (success) {
        Navigator.pushReplacementNamed( context, '/login' );
      } else {
        setState(() {
          message = 'Đã xảy ra lỗi trong khi đặt lại mật khẩu.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Quên mật khẩu',
            textAlign: TextAlign.center,
            style: Styles.h1,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Styles.error,
          ),
          SizedBox(height: 30.0),
          TextFormField(
            decoration: Styles.input.copyWith(
              hintText: 'Email',
            ),
            validator: (value) {
              email = value.trim();
              return Validate.validateEmail(value);
            }
          ),
          SizedBox(height: 15.0),
          StyledFlatButton(
            'Send Password Reset Email',
            onPressed: submit,
          ),
        ],
      ),
    );
  }
}
