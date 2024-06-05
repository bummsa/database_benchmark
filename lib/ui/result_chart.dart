import 'package:database_benchmark/benchmark/benchmark_runner.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ResultChart extends StatelessWidget {
  final List<RunnerResult> results;

  const ResultChart({
    super.key,
    required this.results,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var maxResult = 0;
    for (var result in results) {
      if (result.value > maxResult) {
        maxResult = result.value;
      }
    }
    return BarChart(
      swapAnimationDuration: Duration.zero,
      BarChartData(
        barTouchData: getBarTouchData(theme),
        titlesData: getTitlesData(theme),
        alignment: BarChartAlignment.center,
        maxY: maxResult * 1.2,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        groupsSpace: 70,
        barGroups: [
          for (var i = 0; i < results.length; i++)
            BarChartGroupData(
              x: i,
              showingTooltipIndicators: [0],
              barRods: [
                BarChartRodData(
                  color: theme.colorScheme.primary,
                  toY: results[i].value.toDouble(),
                  width: 18,
                ),
              ],
            ),
        ],
      ),
    );
  }

  BarTouchData getBarTouchData(ThemeData theme) {
    return BarTouchData(
      enabled: false,
      touchTooltipData: BarTouchTooltipData(
        tooltipPadding: const EdgeInsets.all(0),
        tooltipMargin: 5,
        getTooltipItem: (_, int i, __, ___) {
          return BarTooltipItem(
            '${results[i].value}${results[i].benchmark.unit}',
            TextStyle(
              color: theme.colorScheme.secondary,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
    );
  }

  FlTitlesData getTitlesData(ThemeData theme) {
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTitlesWidget: (i, _) {
            return Center(
              child: Text(
                results[i.toInt()].database.name,
                style: TextStyle(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            );
          },
        ),
      ),
      leftTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    );
  }
}
