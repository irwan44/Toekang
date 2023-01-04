import 'package:egrocer_seller/helper/generalWidgets/widgets.dart';
import 'package:egrocer_seller/helper/provider/categoryProvider.dart';
import 'package:egrocer_seller/helper/styles/colorsRes.dart';
import 'package:egrocer_seller/helper/utils/apiAndParams.dart';
import 'package:egrocer_seller/helper/utils/constant.dart';
import 'package:egrocer_seller/helper/utils/generalMethods.dart';
import 'package:egrocer_seller/helper/utils/stringsRes.dart';
import 'package:egrocer_seller/models/category.dart';
import 'package:egrocer_seller/screens/mainHomeScreen/categoryListScreen/widget/categoryItemContainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryListScreen extends StatefulWidget {
  CategoryListScreen({Key? key}) : super(key: key);

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  @override
  void initState() {
    super.initState();
    //fetch categoryList from api
    Future.delayed(Duration.zero).then((value) {
      Map<String, String> params = {};
      params[ApiAndParams.categoryId] = context
              .read<CategoryListProvider>()
              .selectedCategoryIdsList[
          context.read<CategoryListProvider>().selectedCategoryIdsList.length -
              1];

      context
          .read<CategoryListProvider>()
          .getCategoryApiProvider(context: context, params: params);
    });
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: Text(
          StringsRes.lblTitleCategories,
          style: TextStyle(color: ColorsRes.mainTextColor),
        ),
      ),
      body: setRefreshIndicator(
        refreshCallback: () {
          Map<String, String> params = {};
          params[ApiAndParams.categoryId] = context
              .read<CategoryListProvider>()
              .selectedCategoryIdsList[context
                  .read<CategoryListProvider>()
                  .selectedCategoryIdsList
                  .length -
              1];

          return context
              .read<CategoryListProvider>()
              .getCategoryApiProvider(context: context, params: params);
        },
        child: SingleChildScrollView(
          child: Column(
            children: [subCategorySequenceWidget(), categoryWidget()],
          ),
        ),
      ),
    );
  }

  //categoryList ui
  categoryWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Consumer<CategoryListProvider>(
            builder: (context, categoryListProvider, _) {
          return categoryListProvider.categoryState == CategoryState.loaded
              ? Card(
                  color: Theme.of(context).cardColor,
                  elevation: 0,
                  margin: EdgeInsets.symmetric(
                      horizontal: Constant.paddingOrMargin10,
                      vertical: Constant.paddingOrMargin10),
                  child: GridView.builder(
                    itemCount: categoryListProvider.categories.length,
                    padding: EdgeInsets.symmetric(
                        horizontal: Constant.paddingOrMargin10,
                        vertical: Constant.paddingOrMargin10),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      CategoryData category =
                          categoryListProvider.categories[index];

                      categoryListProvider.subCategoriesList[
                          categoryListProvider.selectedCategoryIdsList[
                              categoryListProvider
                                      .selectedCategoryIdsList.length -
                                  1]] = categoryListProvider.categories;

                      return CategoryItemContainer(
                          category: category,
                          voidCallBack: () {
                            if (category.hasChild == true) {
                              context
                                  .read<CategoryListProvider>()
                                  .selectedCategoryIdsList
                                  .add(
                                    category.id.toString(),
                                  );
                              context
                                  .read<CategoryListProvider>()
                                  .selectedCategoryNamesList
                                  .add(category.name ?? "");

                              Map<String, String> params = {};
                              params[ApiAndParams.categoryId] = context
                                  .read<CategoryListProvider>()
                                  .selectedCategoryIdsList[context
                                      .read<CategoryListProvider>()
                                      .selectedCategoryIdsList
                                      .length -
                                  1];

                              context
                                  .read<CategoryListProvider>()
                                  .getCategoryApiProvider(
                                      context: context, params: params);

                              setState(() {});
                            } else {
                              // Navigator.pushNamed(context, productListScreen,
                              //     arguments: [
                              //       "category",
                              //       category.id.toString(),
                              //       category.name
                              //     ]);
                            }
                          });
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.8,
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                  ),
                )
              : categoryListProvider.categoryState == CategoryState.loading
                  ? getCategoryShimmer(
                      context: context, count: 9)
                  : SizedBox.shrink();
        }),
      ],
    );
  }

  //category index widget
  subCategorySequenceWidget() {
    return Consumer<CategoryListProvider>(
        builder: (context, categoryListProvider, _) {
      return categoryListProvider.selectedCategoryIdsList.length > 1
          ? Container(
              margin: EdgeInsets.all(Constant.paddingOrMargin10),
              padding: EdgeInsets.all(Constant.paddingOrMargin10),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                runSpacing: 5,
                spacing: 5,
                children: List.generate(
                    categoryListProvider.selectedCategoryIdsList.length,
                    (index) {
                  return GestureDetector(
                    onTap: () {
                      if (categoryListProvider.selectedCategoryIdsList.length !=
                          index) {
                        categoryListProvider.setCategoryData(index);
                      }
                    },
                    child: Text(
                        "${categoryListProvider.selectedCategoryNamesList[index]}${categoryListProvider.selectedCategoryNamesList.length == (index + 1) ? "" : " > "}"),
                  );
                }),
              ),
            )
          : SizedBox.shrink();
    });
  }
}
