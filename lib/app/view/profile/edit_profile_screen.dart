import 'package:flutter/material.dart';
import 'package:provider_man_app/base/resizer/fetch_pixels.dart';

import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/widget_utils.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = "Albert Flores";
    emailController.text = "albertflores@gmail.com";
    phoneController.text = "(907) 563-0101";
    FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: backGroundColor,
          bottomNavigationBar: saveButton(context),
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
                      title: "Edit Profile",
                      weight: FontWeight.w800,
                      fontsize: 24,
                      textColor: Colors.black),
                  getVerSpace(FetchPixels.getPixelHeight(40)),
                  profilePictureEdit(context),
                  getVerSpace(FetchPixels.getPixelHeight(40)),
                  getDefaultTextFiledWithLabel(
                      context, "Customer Name", nameController, Colors.grey,
                      function: () {},
                      height: FetchPixels.getPixelHeight(60),
                      isEnable: false,
                      withprefix: true,
                      image: "user.svg",
                      imageWidth: FetchPixels.getPixelHeight(24),
                      imageHeight: FetchPixels.getPixelHeight(24)),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  getDefaultTextFiledWithLabel(
                      context, "Email", emailController, Colors.grey,
                      function: () {},
                      height: FetchPixels.getPixelHeight(60),
                      isEnable: false,
                      withprefix: true,
                      image: "message.svg",
                      imageWidth: FetchPixels.getPixelHeight(24),
                      imageHeight: FetchPixels.getPixelHeight(24)),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  getDefaultTextFiledWithLabel(
                      context, "Phone", phoneController, Colors.grey,
                      function: () {},
                      height: FetchPixels.getPixelHeight(60),
                      isEnable: false,
                      withprefix: true,
                      image: "call.svg",
                      imageWidth: FetchPixels.getPixelHeight(24),
                      imageHeight: FetchPixels.getPixelHeight(24)),
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

  Container saveButton(BuildContext context) {
    return Container(
      color: backGroundColor,
      padding: EdgeInsets.only(
          left: FetchPixels.getPixelWidth(20),
          right: FetchPixels.getPixelWidth(20),
          bottom: FetchPixels.getPixelHeight(30)),
      child: getButton(context, greenColor, "Save", Colors.white, () {
        Constant.backToPrev(context);
        Constant.backToPrev(context);
      }, 18,
          weight: FontWeight.w600,
          buttonHeight: FetchPixels.getPixelHeight(60),
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14))),
    );
  }

  Align profilePictureEdit(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: FetchPixels.getPixelHeight(100),
            width: FetchPixels.getPixelHeight(100),
            decoration: BoxDecoration(
              image: getDecorationAssetImage(context, "profile.png"),
            ),
          ),
          Positioned(
              top: FetchPixels.getPixelHeight(68),
              left: FetchPixels.getPixelHeight(70),
              child: Container(
                height: FetchPixels.getPixelHeight(46),
                width: FetchPixels.getPixelHeight(46),
                padding: EdgeInsets.symmetric(
                    vertical: FetchPixels.getPixelHeight(10),
                    horizontal: FetchPixels.getPixelHeight(10)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0.0, 4.0)),
                    ],
                    borderRadius:
                        BorderRadius.circular(FetchPixels.getPixelHeight(35))),
                child: getSvgImage("camera.svg",
                    height: FetchPixels.getPixelHeight(24),
                    width: FetchPixels.getPixelHeight(24)),
              ))
        ],
      ),
    );
  }
}
