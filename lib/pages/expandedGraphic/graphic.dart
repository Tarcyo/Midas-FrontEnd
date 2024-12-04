import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:midas/constants.dart'; // Certifique-se de importar corretamente as constantes

class Graphic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9, // Tornando o tamanho do gráfico responsivo
      height: 500,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: 11,
          minY: 0,
          maxY: 6,
          titlesData: FlTitlesData(
            bottomTitles: SideTitles(
              showTitles: true,
              reservedSize: 5,
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
              margin: 8,
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
              reservedSize: 40,
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
                FlSpot(11, 6),
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

  static const List<Color> gradientColors = [mainColor, mainColor]; // Declarando gradientColors como uma constante
}