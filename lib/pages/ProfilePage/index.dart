import 'package:geogo/constants/text_style.dart';
import 'package:geogo/constants/theme.dart';
import 'package:geogo/pages/CreateWalletPage/index.dart';
import 'package:geogo/pages/MyCouponPage/index.dart';
import 'package:geogo/pages/OfferDetailPage/index.dart';
import 'package:geogo/pages/CouponUsagePage/index.dart';
import 'package:geogo/pages/DemoPage/index.dart';
import 'package:geogo/pages/LoginPage/index.dart';
import 'package:geogo/pages/ReferralPage/index.dart';
import 'package:geogo/pages/RegisterPage/index.dart';
import 'package:geogo/pages/Wallet2Page/index.dart';
import 'package:geogo/repositories/user_repo.dart';
import 'package:geogo/widgets/ActionTableListBody/index.dart';
import 'package:geogo/widgets/ActivityListBody/index.dart';
import 'package:geogo/widgets/Buttons/RoundButton/index.dart';
import 'package:geogo/widgets/CategoryListBody/index.dart';
import 'package:geogo/widgets/CombinedScrollView/index.dart';
import 'package:geogo/widgets/CouponListBody/index.dart';
import 'package:geogo/widgets/EventListBody/index.dart';
import 'package:geogo/widgets/Header/TitleHeader/index.dart';
import 'package:geogo/widgets/IconTextButton/index.dart';
import 'package:geogo/widgets/PurchasedCouponListBody/index.dart';
import 'package:geogo/widgets/RichText/index.dart';
import 'package:geogo/widgets/SilverAppBarScrollView/index.dart';
import 'package:geogo/widgets/TabBar/index.dart';
import 'package:geogo/widgets/TextFields/RoundTextField/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geogo/utils/secure_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geogo/bloc/AuthenticationBloc/authentication_bloc.dart';
import 'package:geogo/models/profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage();
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Profile _userData = Profile("", "", "", "", "", "");

  @override
  void initState() {
    UserRepository()
        .getProfile()
        .then((profile) => setState(() => _userData = profile));
    super.initState();
/*     print(_userData); */
  }

  _logoutHandler(context) {
    BlocProvider.of<AuthenticationBloc>(context).add(LogoutHandlerEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthenticationBloc(),
        child: MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: Scaffold(
                extendBodyBehindAppBar: true,
                backgroundColor: themeData.backgroundColor,
                body: BlocListener<AuthenticationBloc, AuthenticationState>(
                    listener: (context, state) {
                  if (state is AuthenticationSuccess) {
                    // print(state.isProfileAdded);
                    // state.isProfileAdded?
                    _navigateToLoginPage();
                    print("success");
                    // : _nvaigateToProfilePage(rootContext);
                  } else if (state is AuthenticationFailure) {
                    print("fail");
                    /*     hideLoadingDialog(context);
                  Scaffold.of(context).showSnackBar(
                      setErrorSnackBar(Colors.red, state.message)); */
                  } else if (state is AuthenticationLoading) {
                    print("loading");
                    /* showLoadingDialog(context); */
                  }
                }, child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                        builder: (context, state) {
                  return SafeArea(
                      child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          child: CombinedScrollView(
                            widgets: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 0),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  alignment: WrapAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "https://3rx7j43iphkgsbvmkyrgzb4yck2g2ecmku7b7o4gbvjko5wmx2ga.arweave.net/3G_082h51GkGrFYibIeYErRtEExVPh-7hg1Sp3bMvow?ext=png")),
                                    Wrap(
                                      children: [
                                        IconButton(
                                          padding: EdgeInsets.zero,
                                          icon: Icon(
                                            Icons.inbox_outlined,
                                            size: 30,
                                            color: Colors.black54,
                                          ),
                                          onPressed: () =>
                                              _logoutHandler(context),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 0),
                                  child: Card(
                                    elevation: 0,
                                    color: themeData.backgroundColor,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 12),
                                          Text(
                                            "Balance",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("${_userData.point} 〄",
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w900)),
                                              ActionChip(
                                                  elevation: 0,
                                                  labelPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 8,
                                                          vertical: -2),
                                                  label: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'View Detail',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      Icon(
                                                          size: 15,
                                                          Icons
                                                              .keyboard_arrow_right,
                                                          color: Colors.black),
                                                    ],
                                                  ),
                                                  backgroundColor:
                                                      themeData.primaryColor,
                                                  surfaceTintColor:
                                                      themeData.primaryColor,
                                                  onPressed: () => {
                                                        Navigator.push(
                                                            context,
                                                            CupertinoPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Wallet2Page()))
                                                      }),
                                            ],
                                          )
                                        ]),
                                  )),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconTextButton(
                                        title: "Deposit",
                                        imageUrl: "assets/images/deposit.png",
                                        action: () => {}),
                                    IconTextButton(
                                        title: "Transfer",
                                        imageUrl: "assets/images/transfer.png",
                                        action: () => {}),
                                    IconTextButton(
                                        title: "Stake",
                                        imageUrl: "assets/images/deposit.png",
                                        action: () => {}),
                                    IconTextButton(
                                        title: "Swap",
                                        imageUrl: "assets/images/transfer.png",
                                        action: () => {}),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: ListView(
                                      padding: EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          top: 12,
                                          bottom: 12),
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      children: <Widget>[
                                        ActionTableListBody(
                                            title: "My Coupons",
                                            action: () => {
                                                  Navigator.push(
                                                      context,
                                                      CupertinoPageRoute(
                                                          builder: (context) =>
                                                              MyCouponPage()))
                                                }),
                                        ActionTableListBody(
                                            title: "My Bookmarks",
                                            action: () => {}),
                                        ActionTableListBody(
                                            title: "My Events",
                                            action: () => {})
                                      ]),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 0),
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: ListView(
                                      padding: EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          top: 12,
                                          bottom: 12),
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      children: <Widget>[
                                        ActionTableListBody(
                                            title: "Referral",
                                            action: () => {
                                                  Navigator.push(
                                                      context,
                                                      CupertinoPageRoute(
                                                          builder: (context) =>
                                                              ReferralPage(
                                                                  referralCode:
                                                                      _userData
                                                                          .invitationCode)))
                                                }),
                                        ActionTableListBody(
                                            title: "Account & Security",
                                            action: () => {}),
                                        ActionTableListBody(
                                            title: "General Setting",
                                            action: () => {}),
                                        ActionTableListBody(
                                            title: "Referral Program",
                                            action: () => {
                                                  Navigator.push(
                                                      context,
                                                      CupertinoPageRoute(
                                                          builder: (context) =>
                                                              ReferralPage(
                                                                  referralCode:
                                                                      _userData
                                                                          .invitationCode)))
                                                }),
                                        ActionTableListBody(
                                            title: "Wallet Setting",
                                            action: () => {
                                                  Navigator.push(
                                                      context,
                                                      CupertinoPageRoute(
                                                          builder: (context) =>
                                                              CreateWalletPage()))
                                                }),
                                        ActionTableListBody(
                                            title: "Abount GeoGO",
                                            action: () => {}),
                                        ActionTableListBody(
                                            title: "Contact Us",
                                            action: () => {}),
                                        ActionTableListBody(
                                            title: "Logout",
                                            action: () =>
                                                _logoutHandler(context))
                                      ]),
                                ),
                              ),
                              SizedBox(height: 32),
                            ],
                          )));
                })))));
  }

  _navigateToLoginPage() {
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => LoginPage()));
  }
}
