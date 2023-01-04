import 'package:egrocer_seller/helper/styles/colorsRes.dart';
import 'package:egrocer_seller/helper/utils/generalMethods.dart';
import 'package:egrocer_seller/helper/utils/stringsRes.dart';
import 'package:egrocer_seller/models/sellerDashBoard.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklySalesBarChart extends StatefulWidget {
  final List<WeeklySales> weeklySales;
  final double maxSaleLimit;

  WeeklySalesBarChart(
      {Key? key, required this.weeklySales, required this.maxSaleLimit})
      : super(key: key);

  @override
  State<WeeklySalesBarChart> createState() => _WeeklySalesBarChartState();
}

class _WeeklySalesBarChartState extends State<WeeklySalesBarChart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          StringsRes.lblTitleWeeklySales,
          style: TextStyle(
            color: ColorsRes.appColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          StringsRes.lblDescriptionWeeklySales,
          style: TextStyle(
            color: ColorsRes.mainTextColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Expanded(
          child: BarChart(
            mainBarData(),
          ),
        ),
        SizedBox(
          height: 12,
        ),
      ],
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    double width = 22,
    List<int>? showTooltips,
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
            toY: y,
            color: ColorsRes.appColor,
            width: width,
            borderRadius: BorderRadius.circular(0)),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() =>
      List.generate(widget.weeklySales.length, (index) {
        return makeGroupData(
          index,
          (widget.weeklySales[index].totalSale!),
        );
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipRoundedRadius: 10,
          fitInsideVertically: true,
          fitInsideHorizontally: true,
          tooltipBgColor: ColorsRes.appColor,
          tooltipMargin: 10,
          tooltipPadding: EdgeInsets.all(10),
          tooltipBorder: BorderSide(color: ColorsRes.appColorBlack,width: 2),
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String selectedDate = widget.weeklySales[group.x].orderDate ?? "";
            return BarTooltipItem(
              "$selectedDate\n${GeneralMethods.getCurrencyFormat(rod.toY - 1)}",
              TextStyle(
                color: ColorsRes.mainTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            );
          },
        ),
      ),
      alignment: BarChartAlignment.spaceBetween,
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: true),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Container(
        decoration: BoxDecoration(
          color: ColorsRes.appColor,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsetsDirectional.all(5),
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Text(
            "${widget.weeklySales[value.toInt()].orderDate?.split("-")[2]}-${widget.weeklySales[value.toInt()].orderDate?.split("-")[1]}",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: ColorsRes.appColorWhite),
            softWrap: true),
      ),
    );
  }
}
