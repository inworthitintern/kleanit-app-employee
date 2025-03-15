import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../routes/app_routes.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  void finishView() {
    Constant.backToPrev(context);
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  SharedPreferences? selection;
  bool agree = false;

  TextEditingController passwordController = TextEditingController();
  bool ispass = true;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      selection = sp;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      SharedPreferences.getInstance().then((SharedPreferences sp) {
        selection = sp;
        setState(() {});
      });
    });

    FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: backGroundColor,
          body: SafeArea(
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
              child: Column(
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(26)),
                  gettoolbarMenu(
                    context,
                    "back.svg",
                    () {
                      finishView();
                    },
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(22)),
                  getCustomFont("Sign Up", 24, Colors.black, 1,
                      fontWeight: FontWeight.w800),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  getCustomFont(
                      "Enter your detail for sign up!", 16, Colors.black, 1,
                 fontWeight: FontWeight.w400),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  getDefaultTextFiledWithLabel(
                    context,
                    "Name",
                    nameController,
                    Colors.grey,
                    function: () {},
                    height: FetchPixels.getPixelHeight(60),
                    isEnable: false,
                    withprefix: true,
                    image: "user.svg",
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  getDefaultTextFiledWithLabel(
                    context,
                    "Email",
                    emailController,
                    Colors.grey,
                    function: () {},
                    height: FetchPixels.getPixelHeight(60),
                    isEnable: false,
                    withprefix: true,
                    image: "message.svg",
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  GestureDetector(
                      onTap: () {
                        Constant.sendToNext(context, Routes.selectCountryRoute);
                      },
                      child: getCountryTextField(
                          context,
                          "Phone Number",
                          phoneNumberController,
                          textColor,
                          selection!.getString("code") ?? "+1",
                          function: () {},
                          isEnable: false,
                          minLines: true,
                          height: FetchPixels.getPixelHeight(60),
                          image: selection!.getString("country") ??
                              "image_albania.jpg")),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  getDefaultTextFiledWithLabel(
                      context, "Password", passwordController, Colors.grey,
                      function: () {},
                      height: FetchPixels.getPixelHeight(60),
                      isEnable: false,
                      withprefix: true,
                      image: "lock.svg",
                      isPass: ispass,
                      imageWidth: FetchPixels.getPixelWidth(19),
                      imageHeight: FetchPixels.getPixelHeight(17.66),
                      withSufix: true,
                      suffiximage: "eye.svg", imagefunction: () {
                    setState(() {
                      ispass = !ispass;
                    });
                  }),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            agree = !agree;
                          });
                        },
                        child: Container(
                          height: FetchPixels.getPixelHeight(24),
                          width: FetchPixels.getPixelHeight(24),
                          decoration: BoxDecoration(
                              color: (agree) ? greenColor : backGroundColor,
                              border: (agree)
                                  ? null
                                  : Border.all(color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(
                                  FetchPixels.getPixelHeight(6))),
                          padding: EdgeInsets.symmetric(
                              vertical: FetchPixels.getPixelHeight(6),
                              horizontal: FetchPixels.getPixelWidth(4)),
                          child: (agree) ? getSvgImage("done.svg") : null,
                        ),
                      ),
                      getHorSpace(FetchPixels.getPixelWidth(10)),
                      getCustomFont(
                          "I agree with Terms & Privacy", 16, Colors.black, 1,
                          fontWeight: FontWeight.w400)
                    ],
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(50)),
                  getButton(context, greenColor, "Sign Up", Colors.white, () {
                    Constant.sendToNext(context, Routes.verifyRoute);
                  }, 18,
                      weight: FontWeight.w600,
                      buttonHeight: FetchPixels.getPixelHeight(60),
                      borderRadius:
                          BorderRadius.circular(FetchPixels.getPixelHeight(15))),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getCustomFont(
                          "Already have an account?", 14, Colors.black, 1,
                          fontWeight: FontWeight.w400),
                      GestureDetector(
                        onTap: () {
                          finishView();
                        },
                        child: getCustomFont(" Login", 16, greenColor, 1,
                           fontWeight: FontWeight.w800
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          finishView();
          return false;
        });
  }
}
