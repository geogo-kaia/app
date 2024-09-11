import 'package:geogo/constants/text_style.dart';
import 'package:geogo/constants/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ShareCard extends StatelessWidget {
  const ShareCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: EdgeInsets.all(16),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          children: [
            ListTile(
                leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://3rx7j43iphkgsbvmkyrgzb4yck2g2ecmku7b7o4gbvjko5wmx2ga.arweave.net/3G_082h51GkGrFYibIeYErRtEExVPh-7hg1Sp3bMvow?ext=png")),
                title: Text("Peter#8888"),
                subtitle: Text("21 Feb 2023")),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "I got coins on reaching checkpoint",
                style: TextStyle(color: Colors.black87, fontSize: 12),
              ),
            ),
            SizedBox(height: 12),
            Image.asset("assets/images/gift.png"),
            SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: Colors.black),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                "+4 \$BGT",
                style: TextStyle(
                    color: themeData.primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
