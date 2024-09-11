import 'package:geogo/bloc/VerifyEmailBloc/verify_email_bloc.dart';
import 'package:geogo/constants/text_style.dart';
import 'package:geogo/constants/theme.dart';
import 'package:geogo/pages/CreateWalletPage/index.dart';
import 'package:geogo/utils/loading_helper.dart';
import 'package:geogo/widgets/Buttons/RoundButton/index.dart';
import 'package:geogo/widgets/TextFields/RoundTextField/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailVerificationPage extends StatefulWidget {
  final String email;
  const EmailVerificationPage({required this.email});
  @override
  _EmailVerificationPageState createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  late TextEditingController _verificationCodeController;
  bool _codeValidator = false;
  final FocusNode _codeFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _verificationCodeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyEmailBloc(),
      child: Scaffold(
        backgroundColor: themeData.backgroundColor,
        appBar: AppBar(
          title: Text(''),
          iconTheme: IconThemeData(
            color: Color.fromRGBO(128, 128, 128, 1), //change your color here
          ),
        ),
        body: BlocListener<VerifyEmailBloc, VerifyEmailState>(
          listener: (context, state) {
            if (state is VerifyEmailLoading) {
              showLoadingDialog(context);
            } else if (state is VerifyEmailSuccess) {
              hideLoadingDialog(context);
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => const CreateWalletPage()));
            } else if (state is VerifyEmailFailure) {
              hideLoadingDialog(context);
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: BlocBuilder<VerifyEmailBloc, VerifyEmailState>(
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
                                  text: "Email",
                                  style: headerHighlightTitleStyle,
                                  children: const [
                                TextSpan(
                                    text: " Verification",
                                    style: headerHighlightTitleStyleBlack)
                              ])),
                          SizedBox(height: 2),
                          Text(
                              "A verification email has been sent to your mail.",
                              style: subHeaderTitleStyle),
                          SizedBox(height: 32),
                          Text("Email Verification Code",
                              style: textFieldTitleStyle),
                          SizedBox(height: 12),
                          RoundTextField(false, _verificationCodeController,
                              _codeValidator,
                              currentFocus: _codeFocus,
                              inputType: TextInputType.text),
                          SizedBox(height: 16),
                          InkWell(
                            onTap: () {
                              showLoadingDialog(context);
                              BlocProvider.of<VerifyEmailBloc>(context).add(
                                  VerifyEmailResendEvent(email: widget.email));
                            },
                            splashFactory: NoSplash.splashFactory,
                            child: Text("Resend Code",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                          SizedBox(height: 24),
                          RoundButton("Verify", themeData.primaryColor, () {
                            showLoadingDialog(context);
                            BlocProvider.of<VerifyEmailBloc>(context).add(
                                VerifyEmailInitialEvent(
                                    code: _verificationCodeController.text));
                          }),
                          SizedBox(height: 16),
                        ],
                      )),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
