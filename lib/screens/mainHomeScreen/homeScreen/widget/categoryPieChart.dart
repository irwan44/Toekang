import 'dart:math';

import 'package:egrocer_seller/helper/styles/colorsRes.dart';
import 'package:egrocer_seller/helper/utils/stringsRes.dart';
import 'package:egrocer_seller/models/sellerDashBoard.dart';
import 'package:egrocer_seller/screens/mainHomeScreen/homeScreen/widget/pieChartIndicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CategoryPieChart extends StatefulWidget {
  final List<CategoryProductCount> categoryProductCounts;

  CategoryPieChart({Key? key, required this.categoryProductCounts})
      : super(key: key);

  @override
  State<CategoryPieChart> createState() => _CategoryPieChartState();
}

class _CategoryPieChartState extends State<CategoryPieChart> {
  int touchedIndex = -1;

  List<Color> colors = [];

  @override
  void initState() {
    Future.delayed(
        Duration.zero,
        () => colors = List.generate(
              widget.categoryProductCounts.length,
              (index) => Color.fromRGBO(
                Random().nextInt(255),
                Random().nextInt(255),
                Random().nextInt(255),
                1,
              ),
            )).then((value) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (colors.length > 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringsRes.lblTitleProductWiseCategoryCount,
            style: TextStyle(
              color: ColorsRes.appColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 10,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      startDegreeOffset: 180,
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: List.generate(
                          widget.categoryProductCounts.length, (index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Indicator(
                            color: colors[index],
                            text:
                                widget.categoryProductCounts[index].name ?? "",
                            textColor: touchedIndex == index
                                ? ColorsRes.mainTextColor
                                : ColorsRes.grey,
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return SizedBox.shrink();
    }
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(widget.categoryProductCounts.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;

      return PieChartSectionData(
        color: colors[i],
        value: widget.categoryProductCounts[i].productCount ?? 0.0,
        title: "",
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: isTouched ? ColorsRes.mainTextColor : ColorsRes.grey,
        ),
      );
    });
  }
}
