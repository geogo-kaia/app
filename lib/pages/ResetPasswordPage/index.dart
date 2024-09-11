import 'package:geogo/constants/text_style.dart';
import 'package:geogo/constants/theme.dart';
import 'package:geogo/widgets/Buttons/RoundButton/index.dart';
import 'package:geogo/widgets/RichText/index.dart';
import 'package:geogo/widgets/TextFields/RoundTextField/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage();
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  bool _validate1 = false;
  bool _validate2 = false;
  bool _validate3 = false;
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeData.backgroundColor,
      appBar: AppBar(
          title: Text(''),
          iconTheme: IconThemeData(
            color: Color.fromRGBO(128, 128, 128, 1), //change your color here
          )),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
              padding: EdgeInsets.all(24),
              child: ListView(
                shrinkWrap: true,
                children: [
                  RichText(
                      text: TextSpan(
                          text: "Reset",
                          style: headerHighlightTitleStyle,
                          children: const [
                        TextSpan(
                            text: " Login Password",
                            style: headerHighlightTitleStyleBlack)
                      ])),
                  SizedBox(height: 2),
                  Text("You will receive a reset-password email",
                      style: subHeaderTitleStyle),
                  SizedBox(height: 32),
                  Text("Email Verification", style: textFieldTitleStyle),
                  SizedBox(height: 12),
                  RoundTextField(false, _emailController, _validate1),
                  SizedBox(height: 24),
                  RoundButton("Next", themeData.primaryColor, () => {}),
                  SizedBox(height: 16),
                ],
              )),
        ),
      ),
    );
  }
}
