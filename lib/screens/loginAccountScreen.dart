import 'package:egrocer_seller/helper/generalWidgets/widgets.dart';
import 'package:egrocer_seller/helper/provider/userProfileProvider.dart';
import 'package:egrocer_seller/helper/sessionManager.dart';
import 'package:egrocer_seller/helper/styles/colorsRes.dart';
import 'package:egrocer_seller/helper/styles/designConfig.dart';
import 'package:egrocer_seller/helper/utils/apiAndParams.dart';
import 'package:egrocer_seller/helper/utils/constant.dart';
import 'package:egrocer_seller/helper/utils/generalMethods.dart';
import 'package:egrocer_seller/helper/utils/routeGenerator.dart';
import 'package:egrocer_seller/helper/utils/stringsRes.dart';
import 'package:egrocer_seller/models/deliveryBoyLogin.dart';
import 'package:egrocer_seller/models/sellerLogin.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginAccountScreen extends StatefulWidget {
  LoginAccountScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginAccountScreen> createState() => _LoginAccountState();
}

class _LoginAccountState extends State<LoginAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController edtEmail = TextEditingController(
      text: Constant.session.getData(SessionManager.keyUserType) == "seller"
          ? "seller@gmail.com"
          : "delivery@gmail.com");
  late TextEditingController edtPassword =
      TextEditingController(text: "123456");
  bool isLoading = false, isAcceptedTerms = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: Text(
          StringsRes.lblLogin,
          style: TextStyle(color: ColorsRes.mainTextColor),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Constant.paddingOrMargin10,
                vertical: Constant.paddingOrMargin20),
            child:Image(
              image: AssetImage('assets/images/logo.png'),
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Card(
              shape: DesignConfig.setRoundedBorder(10),
              margin: EdgeInsets.symmetric(
                  horizontal: Constant.paddingOrMargin15,
                  vertical: Constant.paddingOrMargin15),
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Constant.paddingOrMargin15,
                    vertical: Constant.paddingOrMargin15),
                child: Form(
                  key: _formKey,
                  child: ListView(children: [
                    Container(
                      padding: EdgeInsetsDirectional.all(10),
                      decoration: DesignConfig.boxDecoration(
                          Theme.of(context).scaffoldBackgroundColor, 10),
                      child: Row(
                        children: [
                          Widgets.defaultImg(
                              image: "mail_icon",
                              iconColor: ColorsRes.grey,
                              width: 25,
                              height: 24),
                          SizedBox(
                            width: 10.0,
                          ),
                          Flexible(
                            child: TextField(
                              controller: edtEmail,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                color: ColorsRes.mainTextColor,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                                hintStyle: TextStyle(color: Colors.grey[300]),
                                hintText: StringsRes.lblEmail,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Consumer<UserProfileProvider>(
                        builder: (context, userProfileProvider, _) {
                      return Container(
                        padding: EdgeInsetsDirectional.all(10),
                        decoration: DesignConfig.boxDecoration(
                            Theme.of(context).scaffoldBackgroundColor, 10),
                        child: Row(
                          children: [
                            Widgets.defaultImg(
                                image: "password_icon",
                                iconColor: ColorsRes.grey,
                                width: 25,
                                height: 24),
                            SizedBox(
                              width: 10.0,
                            ),
                            Flexible(
                              child: TextField(
                                controller: edtPassword,
                                obscureText: userProfileProvider.hidePassword,
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                  color: ColorsRes.mainTextColor,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                  hintStyle: TextStyle(color: Colors.grey[300]),
                                  hintText: StringsRes.lblPassword,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                userProfileProvider.showHidePassword();
                              },
                              child: Widgets.defaultImg(
                                  image:
                                      userProfileProvider.hidePassword == true
                                          ? "hide_password"
                                          : "show_password",
                                  iconColor: ColorsRes.grey,
                                  width: 25,
                                  height: 24),
                            ),
                          ],
                        ),
                      );
                    }),
                    SizedBox(height: 40),
                    Row(
                      children: [
                        Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: isAcceptedTerms,
                          onChanged: (bool? val) {
                            setState(() {
                              isAcceptedTerms = val!;
                            });
                          },
                        ),
                        //padding: const EdgeInsets.only(top: 15.0),
                        Expanded(
                          child: RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              style:
                                  Theme.of(context).textTheme.subtitle2!.merge(
                                        const TextStyle(
                                            fontWeight: FontWeight.w400),
                                      ),
                              text: "${StringsRes.lblAgreementMsg1}\t",
                              children: <TextSpan>[
                                TextSpan(
                                    text: StringsRes.lblTermsOfService,
                                    style: TextStyle(
                                      color: ColorsRes.appColor,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushNamed(
                                            context, webViewScreen,
                                            arguments: "terms");
                                      }),
                                TextSpan(text: "\t${StringsRes.lblAnd}\t"),
                                TextSpan(
                                    text: StringsRes.lblPrivacyPolicy,
                                    style: TextStyle(
                                      color: ColorsRes.appColor,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushNamed(
                                            context, webViewScreen,
                                            arguments: "privacy");
                                      }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Widgets.getSizedBox(height: 40),
                    Consumer<UserProfileProvider>(
                      builder: (context, userProfileProvider, _) {
                        return Widgets.gradientBtnWidget(context, 10,
                            otherWidgets: userProfileProvider.loginState ==
                                    LoginState.loading
                                ? Center(
                                    child: CircularProgressIndicator(
                                        color: ColorsRes.appColorWhite),
                                  )
                                : Text(
                                    StringsRes.lblLogin,
                                    softWrap: true,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .merge(
                                          TextStyle(
                                              color: Colors.white,
                                              letterSpacing: 0.5,
                                              fontWeight: FontWeight.w500),
                                        ),
                                  ), callback: () {
                          if (!isAcceptedTerms) {
                            GeneralMethods.showSnackBarMsg(context,
                                StringsRes.lblAcceptTermsConditionMessage);
                          } else if (edtPassword.text.toString().isEmpty) {
                            GeneralMethods.showSnackBarMsg(
                                context, StringsRes.lblEnterValidPassword);
                          } else if (edtEmail.text.toString().isEmpty ||
                              GeneralMethods.validateEmail(
                                    edtEmail.text.toString(),
                                  ) !=
                                  null) {
                            GeneralMethods.showSnackBarMsg(
                                context, StringsRes.lblEnterValidEmail);
                          } else {
                            Map<String, String> params = {};
                            params[ApiAndParams.email] =
                                edtEmail.text.toString();
                            params[ApiAndParams.password] =
                                edtPassword.text.toString();
                            params[ApiAndParams.type] = Constant.session
                                        .getData(SessionManager.keyUserType) ==
                                    "seller"
                                ? "3"
                                : "4";
                            params[ApiAndParams.fcmToken] = Constant.session
                                .getData(SessionManager.keyFCMToken);

                            userProfileProvider
                                .loginApiProvider(params, context)
                                .then((value) async {
                              if (value != null) {
                                if (Constant.session
                                        .getData(SessionManager.keyUserType) ==
                                    "seller") {
                                  SellerLogin sellerLogin =
                                      value as SellerLogin;
                                  Constant.session.setUserData(
                                    name: sellerLogin.data!.user!.seller!.name
                                        .toString(),
                                    email: sellerLogin.data!.user!.seller!.email
                                        .toString(),
                                    profile: sellerLogin
                                        .data!.user!.seller!.logoUrl
                                        .toString(),
                                    mobile: sellerLogin
                                        .data!.user!.seller!.mobile
                                        .toString(),
                                    status: int.parse(
                                      sellerLogin.data!.user!.seller!.status
                                          .toString(),
                                    ),
                                    token: sellerLogin.data!.accessToken
                                        .toString(),
                                    balance: sellerLogin
                                        .data!.user!.seller!.balance
                                        .toString(),
                                  );
                                } else {
                                  DeliveryBoyLogin deliveryBoyLogin =
                                      value as DeliveryBoyLogin;
                                  DeliveryBoy? deliveryBoy =
                                      deliveryBoyLogin.data?.user?.deliveryBoy;
                                  Constant.session.setUserData(
                                    name: deliveryBoy?.name ?? "",
                                    email: deliveryBoyLogin.data?.user?.email ??
                                        "",
                                    profile: "",
                                    mobile: deliveryBoy?.mobile ?? "",
                                    status: int.parse(
                                        "${deliveryBoy?.status ?? "0"}"),
                                    token: deliveryBoyLogin.data!.accessToken
                                        .toString(),
                                    balance: "${deliveryBoy?.balance ?? "0"}",
                                  );
                                }

                                Constant.session.setData(
                                    SessionManager.appThemeName,
                                    Constant.themeList[0],
                                    true);

                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    mainHomeScreen,
                                    (Route<dynamic> route) => false);
                              }
                            });
                          }
                        });
                      },
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
