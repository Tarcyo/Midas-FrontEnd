import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:midas/constants.dart';

class Graphic extends StatelessWidget {
  final List<Color> gradientColors = [mainColor, mainColor];

  @override
  Widget build(BuildContext context) {
    // Obtém a largura e a altura da tela
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth * 0.4, // Reduzido para 40% da largura da tela
      height: screenHeight * 0.4, // Mantido em 40% da altura da tela
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: 10,
          minY: 0,
          maxY: 6,
          titlesData: FlTitlesData(
            bottomTitles: SideTitles(
              showTitles: true,
              reservedSize: 22,
              getTitles: (value) {
                switch (value.toInt()) {
                  case 0:
                    return 'Dezembro';
                  case 2:
                    return 'Janeiro';
                  case 4:
                    return 'Fevereiro';
                  case 6:
                    return 'Março';
                  case 8:
                    return 'Abril';
                  case 10:
                    return 'Maio';
                }
                return '';
              },
              margin: 10,
            ),
            leftTitles: SideTitles(
              showTitles: true,
              getTitles: (value) {
                switch (value.toInt()) {
                  case 1:
                    return 'R\$100';
                  case 2:
                    return 'R\$200';
                  case 3:
                    return 'R\$300';
                  case 4:
                    return 'R\$400';
                  case 5:
                    return 'R\$500';
                  case 6:
                    return 'R\$600';
                }
                return '';
              },
              reservedSize: 60,
              margin: 12,
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: const Color(0xff37434d),
                strokeWidth: 1,
              );
            },
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: const Color(0xff37434d),
                strokeWidth: 1,
              );
            },
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: const Color(0xff37434d), width: 1),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 0),
                FlSpot(2, 2),
                FlSpot(4, 3),
                FlSpot(6, 4),
                FlSpot(8, 3),
                FlSpot(10, 5),
              ],
              isCurved: true,
              colors: gradientColors,
              barWidth: 5,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: false,
              ),
              belowBarData: BarAreaData(
                show: true,
                colors: gradientColors
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
