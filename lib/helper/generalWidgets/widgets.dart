import 'package:egrocer_seller/helper/sessionManager.dart';
import 'package:egrocer_seller/helper/styles/colorsRes.dart';
import 'package:egrocer_seller/helper/styles/designConfig.dart';
import 'package:egrocer_seller/helper/utils/constant.dart';
import 'package:egrocer_seller/helper/utils/generalMethods.dart';
import 'package:egrocer_seller/helper/utils/stringsRes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

class Widgets {
  static Widget gradientBtnWidget(BuildContext context, double borderRadius,
      {required Function callback,
      String title = "",
      Widget? otherWidgets,
      double? height,
      bool? isSetShadow}) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Container(
        height: height ?? 55,
        alignment: Alignment.center,
        decoration: DesignConfig.boxGradient(borderRadius,
            isSetShadow: isSetShadow ?? true),
        child: otherWidgets ??= Text(
          title,
          softWrap: true,
          style: Theme.of(context).textTheme.subtitle1!.merge(
                TextStyle(
                    color: Colors.white,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w500),
              ),
        ),
      ),
    );
  }

  static Widget defaultImg(
      {double? height,
      double? width,
      required String image,
      Color? iconColor,
      BoxFit? boxFit,
      EdgeInsetsDirectional? padding}) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: SvgPicture.asset(
        Constant.getAssetsPath(1, image),
        width: width,
        height: height,
        color: iconColor,
        fit: boxFit ?? BoxFit.contain,
      ),
    );
  }

  static Widget getDarkLightIcon({
    double? height,
    double? width,
    required String image,
    Color? iconColor,
    BoxFit? boxFit,
    EdgeInsetsDirectional? padding,
    bool? isActive,
  }) {
    String dark = (Constant.session.getBoolData(SessionManager.isDarkTheme))
        ? "_dark"
        : "";
    String active = (isActive ??= false) == true ? "_active" : "";
    return defaultImg(
        height: height,
        width: width,
        image: "$image$active${dark}_icon",
        iconColor: iconColor,
        boxFit: boxFit,
        padding: padding);
  }

  static Widget setNetworkImg({
    double? height,
    double? width,
    String image = "placeholder",
    Color? iconColor,
    BoxFit? boxFit,
    String? defaultimage,
  }) {
    return image.trim().isEmpty
        ? defaultImg(
            image: defaultimage ??= "placeholder",
            height: height,
            width: width,
            boxFit: boxFit)
        : Container(
            child: FadeInImage.assetNetwork(
              image: image,
              width: width,
              height: height,
              fit: boxFit,
              placeholder:
                  Constant.getAssetsPath(0, defaultimage ??= "placeholder.png"),
              imageErrorBuilder: (
                BuildContext context,
                Object error,
                StackTrace? stackTrace,
              ) {
                return defaultImg(image: defaultimage ??= "placeholder");
              },
            ),
          );
  }

  static openBottomSheetDialog(
      BuildContext context, String title, var sheetWidget) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: DesignConfig.setRoundedBorderSpecific(20, istop: true),
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setStater) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.all(20),
                child: Center(
                  child: Text(
                    title,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1!.merge(
                          TextStyle(letterSpacing: 0.5),
                        ),
                  ),
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  padding:
                      EdgeInsetsDirectional.only(start: 20, end: 8, bottom: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: sheetWidget(context),
                  ),
                ),
              ),
            ],
          );
        });
      },
    );
  }

  static langDialog(BuildContext context) {
    return openBottomSheetDialog(
        context, StringsRes.lblChangeLanguage, langListView);
  }

  static langListView(BuildContext context) {
    List<Locale> langList = GeneralMethods.langList();
    String currentLanguageCode =
        Constant.session.getData(SessionManager.keyLangCode);
    if (currentLanguageCode.trim().isEmpty) {
      currentLanguageCode = Constant.defaultLangCode;
    }
    return List.generate(langList.length, (index) {
      Locale localeLang = langList[index];
      return ListTile(
        contentPadding: EdgeInsets.zero,
        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        onTap: () {
          Navigator.pop(context);
          if (currentLanguageCode != localeLang.languageCode) {
            Constant.session.setCurrLang(localeLang.languageCode, context);
          }
        },
        leading: Icon(
          currentLanguageCode == localeLang.languageCode
              ? Icons.radio_button_checked
              : Icons.radio_button_off,
          color: ColorsRes.appColor,
        ),
        title: Text(
          Constant.languageNames[localeLang.languageCode],
          softWrap: true,
        ),
      );
    });
  }

  static themeDialog(BuildContext context) async {
    return openBottomSheetDialog(
        context, StringsRes.lblChangeTheme, Widgets.themeListView);
  }

  static Widget textFieldWidget(
      TextEditingController edtcontrl,
      Function? validatorfunc,
      String lbl,
      TextInputType txttype,
      String errmsg,
      BuildContext context,
      {bool ishidetext = false,
      Function? tapCallback,
      Widget? ticon,
      Widget? sicon,
      bool iseditable = true,
      int? minlines,
      int? maxlines,
      FocusNode? currfocus,
      FocusNode? nextfocus,
      BoxConstraints? prefixIconConstaint,
      Color? bgcolor,
      String? hint,
      double borderRadius = 0,
      bool floatingLbl = true,
      EdgeInsetsGeometry? contentPadding}) {
    return TextFormField(
      enabled: iseditable,
      obscureText: ishidetext,
      style: Theme.of(context).textTheme.subtitle1!.merge(
            TextStyle(
                color: iseditable == true
                    ? ColorsRes.mainTextColor
                    : ColorsRes.grey),
          ),
      textAlign: TextAlign.start,
      minLines: minlines ?? 1,
      maxLines: maxlines,
      focusNode: currfocus,
      onFieldSubmitted: (term) {
        if (currfocus != null) {
          currfocus.unfocus();
        }
        if (nextfocus != null) {
          FocusScope.of(context).requestFocus(nextfocus);
        }
      },
      controller: edtcontrl,
      keyboardType: txttype,
      validator: (val) => validatorfunc!(val, errmsg),
      decoration: InputDecoration(
        errorStyle: TextStyle(color: ColorsRes.appColorRed),
        hintText: hint,
        suffixIcon: ticon,
        prefixIcon: sicon,
        prefixIconConstraints: prefixIconConstaint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        contentPadding: contentPadding,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        fillColor: bgcolor,
        filled: bgcolor == null ? false : true,
      ),
      onTap: tapCallback == null ? null : tapCallback(),
    );
  }

  static themeListView(BuildContext context) {
    return List.generate(Constant.themeList.length, (index) {
      String themeDisplayName = StringsRes.lblThemeDisplayNames[index] ?? "";
      String themeName = Constant.themeList[index];

      return ListTile(
        contentPadding: EdgeInsets.zero,
        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        onTap: () {
          if (Constant.session.getData(SessionManager.appThemeName) !=
              themeName) {
            Constant.session.setData(
                SessionManager.appThemeName, Constant.themeList[index], true);
          }
        },
        leading: Icon(
          Constant.session.getData(SessionManager.appThemeName) == themeName
              ? Icons.radio_button_checked
              : Icons.radio_button_off,
          color: ColorsRes.appColor,
        ),
        title: Text(
          themeDisplayName,
          softWrap: true,
        ),
      );
    });
  }

  static homeBottomNavigation(int selectedIndex, Function selectBottomMenu,
      int totalPage, BuildContext context) {
    return BottomNavigationBar(
        items: List.generate(
          totalPage,
          (index) => BottomNavigationBarItem(
            backgroundColor: Theme.of(context).cardColor,
            icon: Widgets.getHomeBottomNavigationBarIcons(
                isActive: selectedIndex == index)[index],
            label: StringsRes.lblHomeBottomMenu[index],
          ),
        ),
        type: BottomNavigationBarType.shifting,
        currentIndex: selectedIndex,
        selectedItemColor: ColorsRes.mainTextColor,
        unselectedItemColor: Colors.transparent,
        onTap: (int ind) {
          selectBottomMenu(ind);
        },
        elevation: 5);
  }

  static List getHomeBottomNavigationBarIcons({required bool isActive}) {
    if (Constant.session.getData(SessionManager.keyUserType) == "seller") {
      return [
        Widgets.getDarkLightIcon(
            image: "home", isActive: isActive, height: 24, width: 24),
        Widgets.getDarkLightIcon(
            image: "orders", isActive: isActive, height: 30, width: 30),
        Widgets.getDarkLightIcon(
            image: "category", isActive: isActive, height: 24, width: 24),
        Widgets.getDarkLightIcon(
            image: "profile", isActive: isActive, height: 24, width: 24)
      ];
    } else {
      return [
        Widgets.getDarkLightIcon(
            image: "home", isActive: isActive, height: 24, width: 24),
        Widgets.getDarkLightIcon(
            image: "profile", isActive: isActive, height: 24, width: 24)
      ];
    }
  }

  static getSizedBox({double? height, double? width}) {
    return SizedBox(height: height ?? 0, width: width ?? 0);
  }

  static getProductVariantDropdownBorderBoxDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
        border: Border(
          bottom: BorderSide(color: ColorsRes.subTitleTextColor, width: 0.5),
          top: BorderSide(color: ColorsRes.subTitleTextColor, width: 0.5),
          right: BorderSide(color: ColorsRes.subTitleTextColor, width: 0.5),
          left: BorderSide(color: ColorsRes.subTitleTextColor, width: 0.5),
        ));
  }

  static Widget getLoadingIndicator() {
    return CircularProgressIndicator(
      backgroundColor: Colors.transparent,
      color: ColorsRes.appColor,
      strokeWidth: 2,
    );
  }
}

class CustomShimmer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;
  final EdgeInsetsGeometry? margin;

  CustomShimmer(
      {Key? key, this.height, this.width, this.borderRadius, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      enabled: true,
      baseColor: ColorsRes.shimmerBaseColor,
      highlightColor: ColorsRes.shimmerHighlightColor,
      child: Container(
        width: width,
        margin: margin ?? EdgeInsets.zero,
        height: height ?? 10,
        decoration: BoxDecoration(
          // color: ColorsRes.shimmerContainerColor,
          color: ColorsRes.shimmerContainerColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
        ),
      ),
    );
  }
}

AppBar getAppBar(
    {required BuildContext context,
    Widget? appBarLeading,
    bool? centerTitle,
    required Widget title,
    List<Widget>? actions,
    Color? backgroundColor}) {
  return AppBar(
    elevation: 0,
    title: title,
    centerTitle: centerTitle ?? true,
    backgroundColor: backgroundColor ?? Theme.of(context).cardColor,
    actions: actions ?? [],
  );
}

class ScrollGlowBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return AlwaysScrollableScrollPhysics(
      parent: BouncingScrollPhysics(),
    );
  }
}

Widget getProductListShimmer(
    {required BuildContext context, required bool isGrid}) {
  return isGrid
      ? GridView.builder(
          itemCount: 6,
          padding: EdgeInsets.symmetric(
              horizontal: Constant.paddingOrMargin10,
              vertical: Constant.paddingOrMargin10),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return CustomShimmer(
              width: double.maxFinite,
              height: double.maxFinite,
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.7,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
        )
      : Column(
          children: List.generate(20, (index) {
            return Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
              child: CustomShimmer(
                width: double.maxFinite,
                height: 125,
              ),
            );
          }),
        );
}

Widget getProductItemShimmer(
    {required BuildContext context, required bool isGrid}) {
  return isGrid
      ? GridView.builder(
          itemCount: 2,
          padding: EdgeInsets.symmetric(
              horizontal: Constant.paddingOrMargin10,
              vertical: Constant.paddingOrMargin10),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return CustomShimmer(
              width: double.maxFinite,
              height: double.maxFinite,
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.7,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
        )
      : Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
          child: CustomShimmer(
            width: double.maxFinite,
            height: 125,
          ),
        );
}

Widget setRefreshIndicator(
    {required RefreshCallback refreshCallback, required Widget child}) {
  return RefreshIndicator(onRefresh: refreshCallback, child: child);
}

// CategorySimmer
Widget getCategoryShimmer(
    {required BuildContext context, int? count, EdgeInsets? padding}) {
  return GridView.builder(
    itemCount: count,
    padding: padding ??
        EdgeInsets.symmetric(
            horizontal: Constant.paddingOrMargin10,
            vertical: Constant.paddingOrMargin10),
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemBuilder: (BuildContext context, int index) {
      return CustomShimmer(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        borderRadius: 8,
      );
    },
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.8,
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10),
  );
}

Widget getOutOfStockWidget({
  required double height,
  required double width,
  double? textSize,
}) {
  return Container(
    alignment: AlignmentDirectional.center,
    decoration: BoxDecoration(
      borderRadius: Constant.borderRadius10,
      color: ColorsRes.appColorBlack.withOpacity(0.3),
    ),
    child: FittedBox(
      fit: BoxFit.none,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: Constant.borderRadius5,
          color: ColorsRes.appColorWhite,
        ),
        child: Text(
          StringsRes.lblOutOfStock,
          softWrap: true,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: textSize ?? 18,
              fontWeight: FontWeight.w400,
              color: ColorsRes.appColorRed),
        ),
      ),
    ),
  );
}
