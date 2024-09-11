import 'package:geogo/constants/text_style.dart';
import 'package:geogo/constants/theme.dart';
import 'package:geogo/pages/EmailVerificationPage/index.dart';
import 'package:geogo/pages/RegisterPage/index.dart';
import 'package:geogo/pages/ResetPasswordPage/index.dart';
import 'package:geogo/utils/loading_helper.dart';
import 'package:geogo/widgets/Buttons/RoundButton/index.dart';
import 'package:geogo/widgets/RichText/index.dart';
import 'package:geogo/widgets/TabBar/index.dart';
import 'package:geogo/widgets/TextFields/RoundTextField/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geogo/bloc/AuthenticationBloc/authentication_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage();
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  bool _validate1 = false;
  bool _validate2 = false;
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  _loginHandler(context) {
    setState(() {
      _emailController.text = 'peter.so@golabs.xyz';
      _passwordController.text = 'abc12345678';
      _emailController.text.isEmpty ? _validate1 = true : _validate1 = false;
      _passwordController.text.isEmpty ? _validate2 = true : _validate2 = false;
      if (!_validate1 && !_validate2) {
        BlocProvider.of<AuthenticationBloc>(context).add(LoginHandlerEvent(
            email: _emailController.text, password: _passwordController.text));
      }
    });
  }

  @override
  Widget build(BuildContext rootContext) {
    return BlocProvider(
        create: (context) => AuthenticationBloc(),
        child: MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: Scaffold(
              backgroundColor: themeData.backgroundColor,
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                  title: Text(''),
                  iconTheme: IconThemeData(
                    color: Color.fromRGBO(
                        128, 128, 128, 1), //change your color here
                  )),
              body: BlocListener<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                if (state is AuthenticationSuccess) {
                  hideLoadingDialog(context);
                  _navigateToHomePage(rootContext);
                } else if (state is AuthenticationFailure) {
                  hideLoadingDialog(context);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                } else if (state is AuthenticationLoading) {
                  showLoadingDialog(context);
                }
              }, child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                      builder: (context, state) {
                return SafeArea(
                    child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Center(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Image.asset(
                              'assets/images/logo_yellow.png',
                              height: 55,
                              alignment: Alignment.centerLeft,
                            ),
                            // SvgPicture.asset(
                            //   "assets/images/logo.svg",
                            //   width: MediaQuery.of(context).size.width * 0.5,
                            //   alignment: Alignment.centerLeft,
                            // ),
                            SizedBox(height: 36),
                            Text("Email", style: textFieldTitleStyle),
                            SizedBox(height: 12),
                            RoundTextField(false, _emailController, _validate1,
                                currentFocus: _emailFocus,
                                nextFocus: _passwordFocus),
                            SizedBox(height: 24),
                            Text("Password", style: textFieldTitleStyle),
                            SizedBox(height: 12),
                            RoundTextField(
                                true, _passwordController, _validate2,
                                currentFocus: _passwordFocus),
                            SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              height: 44,
                              child: InkWell(
                                splashFactory: NoSplash.splashFactory,
                                onTap: () => {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              const ResetPasswordPage()))
                                },
                                child: Text(
                                  "Forgot Password?",
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                            RoundButton("Login", themeData.primaryColor,
                                () => {_loginHandler(context)}),
                            SizedBox(height: 48),
                            InkWell(
                              onTap: () => {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            const RegisterPage()))
                              },
                              splashFactory: NoSplash.splashFactory,
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    style: contentTextStyle,
                                    text: "Don't have an account?",
                                    children: [
                                      TextSpan(
                                          text: " Sign up",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: themeData.primaryColor,
                                              fontSize: 14))
                                    ]),
                              ),
                            ),
                            SizedBox(height: 64),
                          ],
                        ),
                      )),
                ));
              })),
            )));
  }

  _navigateToHomePage(context) {
    // print(firebase_observer.runtimeType);
    // print("##################");
    Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(builder: (context) => TabBarApp()),
        (Route<dynamic> route) => false);
  }
}
