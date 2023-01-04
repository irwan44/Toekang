import 'dart:io';

import 'package:egrocer_seller/helper/generalWidgets/widgets.dart';
import 'package:egrocer_seller/helper/sessionManager.dart';
import 'package:egrocer_seller/helper/styles/colorsRes.dart';
import 'package:egrocer_seller/helper/utils/constant.dart';
import 'package:egrocer_seller/helper/utils/generalMethods.dart';
import 'package:egrocer_seller/helper/utils/stringsRes.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  final String? from;

  EditProfile({Key? key, this.from}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController edtUsername = TextEditingController();
  late TextEditingController edtEmail = TextEditingController();
  late TextEditingController edtMobile = TextEditingController();
  bool isLoading = false;
  String selectedImagePath = "";

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero).then((value) {
      edtUsername = TextEditingController(
        text: Constant.session.getData(SessionManager.keyUserName),
      );
      edtEmail = TextEditingController(
        text: Constant.session.getData(SessionManager.keyEmail),
      );
      edtMobile = TextEditingController(
        text: Constant.session.getData(SessionManager.keyPhone),
      );
      selectedImagePath = "";
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: Text(
          StringsRes.lblTitleProfile,
          style: TextStyle(color: ColorsRes.mainTextColor),
        ),
      ),
      body: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: Constant.paddingOrMargin10,
              vertical: Constant.paddingOrMargin15),
          children: [
            // imgWidget(),
            Card(
              margin: EdgeInsets.only(top: 20),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Constant.paddingOrMargin10,
                    vertical: Constant.paddingOrMargin15),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  userInfoWidget(),
                ]),
              ),
            ),
          ]),
    );
  }

  userInfoWidget() {
    return Form(
      key: _formKey,
      child: Column(children: [
        Widgets.textFieldWidget(
            edtUsername,
            GeneralMethods.emptyValidation,
            StringsRes.lblUserName,
            TextInputType.text,
            StringsRes.lblEnterUserName,
            context,
            hint: StringsRes.lblUserName,
            floatingLbl: false,
            iseditable: false,
            borderRadius: 8,
            sicon: Padding(
              padding: EdgeInsetsDirectional.only(end: 8, start: 8),
              child: Widgets.defaultImg(
                  image: "user_icon", iconColor: ColorsRes.grey),
            ),
            prefixIconConstaint: BoxConstraints(maxHeight: 40, maxWidth: 40),
            bgcolor: Theme.of(context).scaffoldBackgroundColor),
        SizedBox(height: 15),
        Widgets.textFieldWidget(
            edtEmail,
            GeneralMethods.emailValidation,
            StringsRes.lblEmail,
            TextInputType.emailAddress,
            StringsRes.lblEnterValidEmail,
            context,
            hint: StringsRes.lblEmail,
            floatingLbl: false,
            iseditable: false,
            borderRadius: 8,
            sicon: Padding(
              padding: EdgeInsetsDirectional.only(end: 8, start: 8),
              child: Widgets.defaultImg(
                  image: "mail_icon", iconColor: ColorsRes.grey),
            ),
            prefixIconConstaint: BoxConstraints(maxHeight: 40, maxWidth: 40),
            bgcolor: Theme.of(context).scaffoldBackgroundColor),
        SizedBox(height: 15),
        Widgets.textFieldWidget(
            edtMobile,
            GeneralMethods.phoneValidation,
            edtMobile.text.trim().isEmpty ? StringsRes.lblMobileNumber : "",
            TextInputType.phone,
            StringsRes.lblEnterValidMobile,
            context,
            hint: StringsRes.lblMobileNumber,
            borderRadius: 8,
            floatingLbl: false,
            iseditable: false,
            sicon: Padding(
              padding: EdgeInsetsDirectional.only(end: 8, start: 8),
              child: Widgets.defaultImg(
                  image: "phone_icon", iconColor: ColorsRes.grey),
            ),
            prefixIconConstaint: BoxConstraints(maxHeight: 40, maxWidth: 40),
            bgcolor: Theme.of(context).scaffoldBackgroundColor),
      ]),
    );
  }

  imgWidget() {
    return Center(
        child: Padding(
      padding: EdgeInsetsDirectional.only(bottom: 15, end: 15),
      child: ClipRRect(
        borderRadius: Constant.borderRadius10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: selectedImagePath.isEmpty
            ? Widgets.setNetworkImg(
                height: 100,
                width: 100,
                boxFit: BoxFit.fill,
                image: Constant.session.getData(SessionManager.keyUserImage),
              )
            : Image(
                image: FileImage(
                  File(selectedImagePath),
                ),
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              ),
      ),
    ));
  }
}
