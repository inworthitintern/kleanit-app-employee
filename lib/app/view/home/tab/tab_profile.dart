import 'package:flutter/material.dart';
import 'package:provider_man_app/app/routes/app_routes.dart';
import 'package:provider_man_app/base/constant.dart';
import 'package:provider_man_app/base/resizer/fetch_pixels.dart';
import 'package:provider_man_app/base/widget_utils.dart';

import '../../../../base/color_data.dart';

class TabProfile extends StatefulWidget {
  const TabProfile({Key? key}) : super(key: key);

  @override
  State<TabProfile> createState() => _TabProfileState();
}

class _TabProfileState extends State<TabProfile> {
  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return SafeArea(
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
        child: Column(
          children: [
            getVerSpace(FetchPixels.getPixelHeight(20)),
            Align(
                alignment: Alignment.topCenter,
                child: getCustomFont("Profile", 24, Colors.black, 1,
                    fontWeight: FontWeight.w800)),
            getVerSpace(FetchPixels.getPixelHeight(40)),
            Container(
              height: FetchPixels.getPixelHeight(100),
              width: FetchPixels.getPixelHeight(100),
              decoration: BoxDecoration(
                  image: getDecorationAssetImage(context, "profile.png")),
            ),
            getVerSpace(FetchPixels.getPixelHeight(44)),
            Expanded(
              flex: 1,
              child: ListView(
                primary: true,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  getButtonWithIcon(
                      context, Colors.white, "My Profile", Colors.black, () {
                    Constant.sendToNext(context, Routes.myProfileScreenRoute);
                  }, 16,
                      weight: FontWeight.w400,
                      buttonHeight: FetchPixels.getPixelHeight(60),
                      borderRadius:
                          BorderRadius.circular(FetchPixels.getPixelHeight(12)),
                      boxShadow: [
                        const BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0.0, 4.0)),
                      ],
                      prefixIcon: true,
                      prefixImage: "user.svg",
                      sufixIcon: true,
                      suffixImage: "arrow_right.svg"),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  getButtonWithIcon(
                      context, Colors.white, "Privacy Policy", Colors.black,
                      () {
                    Constant.sendToNext(context, Routes.privacyRoute);
                  }, 16,
                      weight: FontWeight.w400,
                      buttonHeight: FetchPixels.getPixelHeight(60),
                      borderRadius:
                          BorderRadius.circular(FetchPixels.getPixelHeight(12)),
                      boxShadow: [
                        const BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0.0, 4.0)),
                      ],
                      prefixIcon: true,
                      prefixImage: "privacy.svg",
                      sufixIcon: true,
                      suffixImage: "arrow_right.svg"),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  getButtonWithIcon(
                      context, Colors.white, "Terms of Use", Colors.black, () {
                    Constant.sendToNext(context, Routes.termOfUseRoute);
                  }, 16,
                      weight: FontWeight.w400,
                      buttonHeight: FetchPixels.getPixelHeight(60),
                      borderRadius:
                          BorderRadius.circular(FetchPixels.getPixelHeight(12)),
                      boxShadow: [
                        const BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0.0, 4.0)),
                      ],
                      prefixIcon: true,
                      prefixImage: "termuse.svg",
                      sufixIcon: true,
                      suffixImage: "arrow_right.svg"),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  getButtonWithIcon(
                      context, Colors.white, "Support", Colors.black, () {
                    Constant.sendToNext(context, Routes.supportRoute);
                  }, 16,
                      weight: FontWeight.w400,
                      buttonHeight: FetchPixels.getPixelHeight(60),
                      borderRadius:
                          BorderRadius.circular(FetchPixels.getPixelHeight(12)),
                      boxShadow: [
                        const BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0.0, 4.0)),
                      ],
                      prefixIcon: true,
                      prefixImage: "headphone.svg",
                      sufixIcon: true,
                      suffixImage: "arrow_right.svg"),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  getButtonWithIcon(
                      context, Colors.white, "Report", Colors.black, () {
                    Constant.sendToNext(context, Routes.reportRoute);
                  }, 16,
                      weight: FontWeight.w400,
                      buttonHeight: FetchPixels.getPixelHeight(60),
                      borderRadius:
                          BorderRadius.circular(FetchPixels.getPixelHeight(12)),
                      boxShadow: [
                        const BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0.0, 4.0)),
                      ],
                      prefixIcon: true,
                      prefixImage: "documnet.svg",
                      sufixIcon: true,
                      suffixImage: "arrow_right.svg"),
                  getVerSpace(FetchPixels.getPixelHeight(40)),
                  getButton(context, greenColor, "Logout", Colors.white, () {
                    Constant.closeApp();
                  }, 18,
                      weight: FontWeight.w600,
                      buttonHeight: FetchPixels.getPixelHeight(60),
                      borderRadius: BorderRadius.circular(
                          FetchPixels.getPixelHeight(14))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
