import 'package:beehairsalon/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';

import 'package:beehairsalon/providers/auth.dart';
import 'package:beehairsalon/utils/validate.dart';
import 'package:beehairsalon/styles/styles.dart';
import 'package:beehairsalon/widgets/notification_text.dart';
import 'package:beehairsalon/widgets/styled_flat_button.dart';

class LogIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
            child: LogInForm(),
          ),
        ),
      ),
    );
  }
}

class LogInForm extends StatefulWidget {
  const LogInForm({Key key}) : super(key: key);

  @override
  LogInFormState createState() => LogInFormState();
}

class LogInFormState extends State<LogInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String email;
  String password;
  String message = '';

  Future<void> submit() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      await Provider.of<AuthProvider>(context).login(email, password);
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
            'Đăng nhập',
            textAlign: TextAlign.center,
            style: Styles.h1,
          ),
          Consumer<AuthProvider>(
            builder: (context, provider, child) => provider.notification ?? NotificationText(''),
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
          StyledFlatButton(
            'Đăng nhập',
            onPressed: submit,
          ),
          SizedBox(height: 20.0),
          Center(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Chưa có tài khoản? ",
                    style: Styles.p,
                  ),
                  TextSpan(
                    text: 'Đăng ký.',
                    style: Styles.p.copyWith(color: Palette.primaryColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => {
                        Navigator.pushNamed(context, '/register'),
                      },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Center(
            child: RichText(
              text: TextSpan(
                text: 'Quên mật khẩu?',
                style: Styles.p.copyWith(color: Palette.primaryColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => {
                     Navigator.pushNamed(context, '/password-reset'),
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
