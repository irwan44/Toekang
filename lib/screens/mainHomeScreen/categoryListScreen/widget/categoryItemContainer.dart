import 'package:egrocer_seller/helper/generalWidgets/widgets.dart';
import 'package:egrocer_seller/helper/styles/designConfig.dart';
import 'package:egrocer_seller/models/category.dart';
import 'package:flutter/material.dart';

class CategoryItemContainer extends StatelessWidget {
  final CategoryData category;
  final VoidCallback voidCallBack;

  CategoryItemContainer(
      {Key? key, required this.category, required this.voidCallBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: voidCallBack,
      child: Container(
        decoration: DesignConfig.boxDecoration(
            Theme.of(context).scaffoldBackgroundColor, 8),
        child: Column(children: [
          Expanded(
            flex: 8,
            child: Container(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.height,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Widgets.setNetworkImg(
                  boxFit: BoxFit.cover,
                  image: category.imageUrl ?? "",
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                "${category.name}",
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
