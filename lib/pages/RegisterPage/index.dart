import 'package:geogo/constants/text_style.dart';
import 'package:geogo/constants/theme.dart';
import 'package:geogo/pages/EmailVerificationPage/index.dart';
import 'package:geogo/pages/LoginPage/index.dart';
import 'package:geogo/utils/loading_helper.dart';
import 'package:geogo/widgets/Buttons/RoundButton/index.dart';
import 'package:geogo/widgets/RichText/index.dart';
import 'package:geogo/widgets/TextFields/RoundTextField/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geogo/bloc/RegisterBloc/register_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage();
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final __referralCodeController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode __referralCodeFocus = FocusNode();
/*   late TextEditingController _confirmPasswordController; */
  bool _validate1 = false;
  bool _validate2 = false;
  bool _validate3 = false;
  bool _validate4 = false;
  bool _validate5 = false;
  bool isAgree = false;
  @override
  void initState() {
    super.initState();
  }

  _registerHandler(context) {
    if (isAgree) {
      setState(() {
        _emailController.text.isEmpty ? _validate1 = true : _validate1 = false;

        _firstNameController.text.isEmpty
            ? _validate2 = true
            : _validate2 = false;
        _lastNameController.text.isEmpty
            ? _validate3 = true
            : _validate3 = false;
        _passwordController.text.isEmpty
            ? _validate4 = true
            : _validate4 = false;
        /*      __referralCodeController.text.isEmpty
            ? _validate5 = true
            : _validate5 = false; */
      });
      if (!_validate1 && !_validate2 && !_validate3 && !_validate4) {
        BlocProvider.of<RegisterBloc>(context).add(RegisterHandlerEvent(
            email: _emailController.text,
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            password: _passwordController.text,
            code: __referralCodeController.text));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RegisterBloc(),
        child: MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: Scaffold(
              backgroundColor: themeData.backgroundColor,
              appBar: AppBar(
                  title: Text(''),
                  iconTheme: IconThemeData(
                    color: Color.fromRGBO(
                        128, 128, 128, 1), //change your color here
                  )),
              body: BlocListener<RegisterBloc, RegisterState>(
                  listener: (context, state) {
                if (state is RegisterSuccess) {
                  hideLoadingDialog(context);
                  _navigateToEmailVerificationPage();
                } else if (state is RegisterFailure) {
                  hideLoadingDialog(context);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                } else if (state is RegisterLoading) {
                  showLoadingDialog(context);
                }
              }, child: BlocBuilder<RegisterBloc, RegisterState>(
                      builder: (context, state) {
                return SafeArea(
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
                                  text: "Setting Up ",
                                  style: headerHighlightTitleStyle,
                                  children: const [
                                TextSpan(
                                    text: "your Account",
                                    style: headerHighlightTitleStyleBlack)
                              ])),
                          SizedBox(height: 2),
                          Text(
                              "Get started in earning reward by filling in the following data",
                              style: subHeaderTitleStyle),
                          SizedBox(height: 32),
                          Text("Email", style: textFieldTitleStyle),
                          SizedBox(height: 12),
                          RoundTextField(false, _emailController, _validate1,
                              currentFocus: _emailFocus,
                              nextFocus: _firstNameFocus),
                          SizedBox(height: 24),
                          Text("First Name", style: textFieldTitleStyle),
                          SizedBox(height: 12),
                          RoundTextField(
                              false, _firstNameController, _validate2,
                              currentFocus: _firstNameFocus,
                              nextFocus: _lastNameFocus),
                          SizedBox(height: 24),
                          Text("Last Name", style: textFieldTitleStyle),
                          SizedBox(height: 12),
                          RoundTextField(false, _lastNameController, _validate3,
                              currentFocus: _lastNameFocus,
                              nextFocus: _passwordFocus),
                          SizedBox(height: 24),
                          Text("Password", style: textFieldTitleStyle),
                          SizedBox(height: 12),
                          RoundTextField(true, _passwordController, _validate4,
                              currentFocus: _passwordFocus,
                              nextFocus: __referralCodeFocus),
                          SizedBox(height: 24),
                          Text("Referral Code (Optional)",
                              style: textFieldTitleStyle),
                          SizedBox(height: 12),
                          RoundTextField(
                              false, __referralCodeController, _validate5,
                              currentFocus: __referralCodeFocus),
                          SizedBox(height: 24),
                          Row(children: <Widget>[
                            Checkbox(
                                checkColor: Colors.white,
                                activeColor: themeData.primaryColor,
                                value: isAgree,
                                onChanged: (value) {
                                  setState(() {
                                    isAgree = !isAgree;
                                  });
                                }),
                            Expanded(child: _buildTermText()),
                          ]),
                          SizedBox(height: 24),
                          RoundButton("Create Account", themeData.primaryColor,
                              () => _registerHandler(context)),
                          SizedBox(height: 48),
                        ],
                      )),
                ));
              })),
            )));
  }

  _navigateToEmailVerificationPage() {
    Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
            builder: (context) =>
                EmailVerificationPage(email: _emailController.text)));
  }

  Widget _buildTermText() {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black38),
        text: "By creating an account, you agree to our ",
        children: <TextSpan>[
          TextSpan(
              text: "Terms of Use",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: themeData.primaryColor,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
              // ..onTap = () => _navigateToWebView(context, "terms_of_use",
              // AppLocalizations.of(context).translate("Terms of Use"))
              ),
          TextSpan(text: " and "),
          TextSpan(
            text: 'Privacy Policy',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: themeData.primaryColor,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer(),
          ),
        ],
      ),
    );
  }
}
