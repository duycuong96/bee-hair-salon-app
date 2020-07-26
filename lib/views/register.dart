import 'package:beehairsalon/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:beehairsalon/providers/auth.dart';
import 'package:beehairsalon/utils/validate.dart';
import 'package:beehairsalon/styles/styles.dart';
import 'package:beehairsalon/widgets/styled_flat_button.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng ký tài khoản'),
        backgroundColor: Palette.primaryColor,
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
            child: RegisterForm(),
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key key}) : super(key: key);

  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String full_name;
  String email;
  String password;
  String passwordConfirm;
  String message = '';

  Map response = new Map();


  Future<void> submit() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      response = await Provider.of<AuthProvider>(context)
          .register(full_name, email, password, passwordConfirm);
      if (response['success']) {
        Navigator.pop(context);
      } else {
        setState(() {
          message = response['message'];
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
            'Đăng ký tài khoản',
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
              hintText: 'Tên',
            ),
            validator: (value) {
              full_name = value.trim();
              return Validate.requiredField(value, 'Nhập đầy đủ tên.');
            }
          ),
          SizedBox(height: 15.0),
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
          TextFormField(
            obscureText: true,
            decoration: Styles.input.copyWith(
              hintText: 'Mật khẩu',
            ),
            validator: (value) {
              password = value.trim();
              return Validate.requiredField(value, 'Yêu cầu nhập mật khẩu.');
            }
          ),
          SizedBox(height: 15.0),
          TextFormField(
            obscureText: true,
            decoration: Styles.input.copyWith(
              hintText: 'Nhập lại mật khẩu',
            ),
            validator: (value) {
              passwordConfirm = value.trim();
              return Validate.requiredField(value, 'Nhập lại mật khẩu chưa khớp.');
            }
          ),
          SizedBox(height: 15.0),
          StyledFlatButton(
            'Register',
            onPressed: submit,
          ),
        ],
      ),
    );
  }
}
