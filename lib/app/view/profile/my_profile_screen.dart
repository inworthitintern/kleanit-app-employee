import 'package:flutter/material.dart';
import 'package:provider_man_app/base/resizer/fetch_pixels.dart';

import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/widget_utils.dart';
import '../../routes/app_routes.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: backGroundColor,
          bottomNavigationBar: editProfileButton(context),
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: FetchPixels.getPixelWidth(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  gettoolbarMenu(context, "back.svg", () {
                    Constant.backToPrev(context);
                  },
                      istext: true,
                      title: "My Profile",
                      weight: FontWeight.w800,
                      fontsize: 24,
                      textColor: Colors.black),
                  getVerSpace(FetchPixels.getPixelHeight(40)),
                  profilePicture(context),
                  getVerSpace(FetchPixels.getPixelHeight(40)),
                  getCustomFont("Customer Name", 16, textColor, 1,
                      fontWeight: FontWeight.w400),
                  getVerSpace(FetchPixels.getPixelHeight(6)),
                  getCustomFont("Albert Flores", 16, Colors.black, 1,
                      fontWeight: FontWeight.w400),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  getDivider(dividerColor, 0, 1),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  getCustomFont("Email", 16, textColor, 1,
                      fontWeight: FontWeight.w400),
                  getVerSpace(FetchPixels.getPixelHeight(6)),
                  getCustomFont("albertflores@gmail.com", 16, Colors.black, 1,
                      fontWeight: FontWeight.w400),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  getDivider(dividerColor, 0, 1),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  getCustomFont("Phone No", 16, textColor, 1,
                      fontWeight: FontWeight.w400),
                  getVerSpace(FetchPixels.getPixelHeight(6)),
                  getCustomFont("(907) 563-0101", 16, Colors.black, 1,
                      fontWeight: FontWeight.w400),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          Constant.backToPrev(context);
          return false;
        });
  }

  Align profilePicture(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: FetchPixels.getPixelHeight(100),
        width: FetchPixels.getPixelHeight(100),
        decoration: BoxDecoration(
          image: getDecorationAssetImage(context, "profile.png"),
        ),
      ),
    );
  }

  Container editProfileButton(BuildContext context) {
    return Container(
      color: backGroundColor,
      padding: EdgeInsets.only(
          left: FetchPixels.getPixelWidth(20),
          right: FetchPixels.getPixelWidth(20),
          bottom: FetchPixels.getPixelHeight(30)),
      child: getButton(context, greenColor, "Edit Profile", Colors.white, () {
        Constant.sendToNext(context, Routes.editProfileScreenRoute);
      }, 18,
          weight: FontWeight.w600,
          buttonHeight: FetchPixels.getPixelHeight(60),
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14))),
    );
  }
}
