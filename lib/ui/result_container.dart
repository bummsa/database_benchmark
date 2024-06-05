import 'package:database_benchmark/benchmark/benchmark_runner.dart';
import 'package:flutter/material.dart';

import 'result_chart.dart';

class ResultContainer extends StatelessWidget {
  static final GlobalKey globalKey = GlobalKey();

  final List<RunnerResult> results;
  final int objectCount;

  const ResultContainer({
    super.key,
    required this.results,
    required this.objectCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RepaintBoundary(
      key: globalKey,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.onSecondary,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              results.first.benchmark.name,
              style: theme.textTheme.headlineMedium,
            ),
            Text(
              '$objectCount Objects',
              style: theme.textTheme.headlineSmall!
                  .copyWith(color: theme.hintColor),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ResultChart(results: results),
            ),
          ],
        ),
      ),
    );
  }
}
