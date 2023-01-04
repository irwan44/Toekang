import 'package:egrocer_seller/helper/generalWidgets/widgets.dart';
import 'package:egrocer_seller/helper/styles/colorsRes.dart';
import 'package:egrocer_seller/helper/utils/constant.dart';
import 'package:egrocer_seller/helper/utils/stringsRes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class WebViewScreen extends StatefulWidget {
  final String dataFor;

  WebViewScreen({Key? key, required this.dataFor}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
          title: Text(
            widget.dataFor,
            style: TextStyle(color: ColorsRes.mainTextColor),
          ),
          context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.all(Constant.paddingOrMargin10),
          child: HtmlWidget(
            widget.dataFor == StringsRes.lblPrivacyPolicy
                ? Constant.privacyPolicy
                : Constant.termsConditions,
            isSelectable: false,
            enableCaching: true,
          ),
        ),
      ),
    );
  }
}
