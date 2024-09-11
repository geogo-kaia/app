// import 'package:geogo/constants/text_style.dart';
// import 'package:geogo/constants/theme.dart';
// import 'package:geogo/pages/CouponDetailPage/index.dart';
// import 'package:geogo/pages/LoginPage/index.dart';
// import 'package:geogo/pages/RegisterPage/index.dart';
// import 'package:geogo/widgets/ActivityListBody/index.dart';
// import 'package:geogo/widgets/Buttons/RoundButton/index.dart';
// import 'package:geogo/widgets/CategoryListBody/index.dart';
// import 'package:geogo/widgets/CombinedScrollView/index.dart';
// import 'package:geogo/widgets/CouponListBody/index.dart';
// import 'package:geogo/widgets/EventListBody/index.dart';
// import 'package:geogo/widgets/Header/TitleHeader/index.dart';
// import 'package:geogo/widgets/IconTextButton/index.dart';
// import 'package:geogo/widgets/RichText/index.dart';
// import 'package:geogo/widgets/SilverAppBarScrollView/index.dart';
// import 'package:geogo/widgets/TabBar/index.dart';
// import 'package:geogo/widgets/TextFields/RoundTextField/index.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage();
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       backgroundColor: Colors.white,
//       body: SafeArea(
//           child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//               child: CombinedScrollView(
//                 widgets: [
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
//                     child: Wrap(
//                       alignment: WrapAlignment.spaceBetween,
//                       children: [
//                         CircleAvatar(
//                             backgroundImage: NetworkImage(
//                                 "https://3rx7j43iphkgsbvmkyrgzb4yck2g2ecmku7b7o4gbvjko5wmx2ga.arweave.net/3G_082h51GkGrFYibIeYErRtEExVPh-7hg1Sp3bMvow?ext=png")),
//                         Chip(
//                           label: Wrap(
//                             crossAxisAlignment: WrapCrossAlignment.center,
//                             runAlignment: WrapAlignment.spaceBetween,
//                             children: [
//                               Icon(
//                                   size: 20,
//                                   Icons.settings,
//                                   color: Colors.black54),
//                               SizedBox(width: 4),
//                               Text("Setting")
//                             ],
//                           ),
//                           backgroundColor: Colors.grey[200],
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 24, vertical: 0),
//                       color: Colors.white,
//                       child: Card(
//                         elevation: 0,
//                         color: Colors.white,
//                         child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               SizedBox(height: 48),
//                               Text(
//                                 "Balance",
//                                 style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),
//                               ),
//                               SizedBox(height: 8),
//                               Text("〄 171.22",
//                                   style: TextStyle(
//                                       fontSize: 44,
//                                       fontWeight: FontWeight.w900)),
//                               SizedBox(height: 8),
//                               Align(
//                                 alignment: Alignment.center,
//                                 child: ActionChip(
//                                     elevation: 1,
//                                     labelPadding: EdgeInsets.symmetric(
//                                         horizontal: 8, vertical: -2),
//                                     label: Text('Detailed Balance',
//                                         style: buttonTextStyle.copyWith(
//                                             fontSize: 12)),
//                                     backgroundColor: themeData.primaryColor,
//                                     surfaceTintColor: themeData.primaryColor,
//                                     shape: StadiumBorder(
//                                         side: BorderSide(
//                                             color: themeData.primaryColor)),
//                                     onPressed: () => {}),
//                               ),
//                               SizedBox(height: 8),
//                             ]),
//                       )),
//                   Container(
//                     margin: EdgeInsets.symmetric(horizontal: 24),
//                     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(16),
//                       // color: Colors.white,
//                       // boxShadow: [
//                       //   BoxShadow(
//                       //     color: Colors.grey.withOpacity(0.1),
//                       //     spreadRadius: 5,
//                       //     blurRadius: 7,
//                       //     offset: Offset(0, 2), // changes position of shadow
//                       //   ),
//                       // ],
//                     ),
//                     child: Wrap(
//                       alignment: WrapAlignment.center,
//                       children: [
//                         IconTextButton(
//                             title: "Deposit",
//                             imageUrl: "assets/images/deposit.png",
//                             action: () => {}),
//                         IconTextButton(
//                             title: "Transfer",
//                             imageUrl: "assets/images/transfer.png",
//                             action: () => {}),
//                         IconTextButton(
//                             title: "Stake",
//                             imageUrl: "assets/images/deposit.png",
//                             action: () => {}),
//                         IconTextButton(
//                             title: "Swap",
//                             imageUrl: "assets/images/transfer.png",
//                             action: () => {}),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
//                     child: Text("Purchased Coupons", style: titleStyle),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                     child: ListView.builder(
//                         scrollDirection: Axis.vertical,
//                         shrinkWrap: true,
//                         physics: ScrollPhysics(),
//                         itemCount: 4,
//                         itemBuilder: (BuildContext context, int index) {
//                           return GestureDetector(
//                               onTap: () => Navigator.push(
//                                   context,
//                                   CupertinoPageRoute(
//                                       builder: (context) =>
//                                           CouponDetailPage())),
//                               child: CouponListBody(index));
//                         }),
//                   )
//                 ],
//               ))),
//     );
//   }
// }
