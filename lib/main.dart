import 'package:database_benchmark/benchmark/benchmark_runner.dart';
import 'package:database_benchmark/benchmark/benchmark_type.dart';
import 'package:database_benchmark/database/database.dart';
import 'package:database_benchmark/ui/result_container.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xff99cbff),
          onPrimary: Color(0xff003256),
          secondary: Color(0xffbac8db),
          onSecondary: Color(0xff243140),
          error: Color(0xffffb4a9),
          onError: Color(0xff680003),
          background: Color(0xff1b1b1d),
          onBackground: Color(0xffe3e2e6),
          surface: Color(0xff1b1b1d),
          onSurface: Color(0xffe3e2e6),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Database Benchmark'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final runner = BenchmarkRunner();
  final amountController = TextEditingController(text: '1000');

  BenchmarkType _selectedBenchmark = BenchmarkType.values[1];
  bool _isRunning = false;
  final benchmarkResult = <Database, RunnerResult>{};

  @override
  Widget build(BuildContext context) {
    final result = benchmarkResult[Database.hive] == null
        ? 'no result'
        : benchmarkResult[Database.hive]!.value;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField(
                    value: _selectedBenchmark,
                    decoration: const InputDecoration(
                      label: Text('Benchmark Type'),
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      for (var benchmark in BenchmarkType.values)
                        DropdownMenuItem(
                          value: benchmark,
                          child: Text(benchmark.name),
                        )
                    ],
                    onChanged: (BenchmarkType? value) {
                      setState(() {
                        if (value != null) {
                          _selectedBenchmark = value;
                        }
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text('Amount of Entries'),
                      border: OutlineInputBorder(),
                    ),
                    controller: amountController,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: _isRunning ? null : _runBenchmark,
              child: const Text('LET\'S GO!'),
            ),
            const SizedBox(
              height: 15,
            ),
            Flexible(
              child: AspectRatio(
                aspectRatio: 1,
                child: benchmarkResult.isNotEmpty
                    ? ResultContainer(
                        results: benchmarkResult.values.toList(),
                        objectCount: int.parse(
                          amountController.value.text,
                        ),
                      )
                    : const Center(
                        child: Text('No results yet.'),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _runBenchmark() {
    setState(() {
      _isRunning = true;
    });
    int amountOfObjects = 0;
    try {
      amountOfObjects = int.parse(amountController.text);
    } catch (e) {
      const snackBar = SnackBar(
        content: Text('Please enter a number in the "Amount of Entries" field'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    final stream = runner.runBenchmark(_selectedBenchmark, amountOfObjects);
    stream.listen((event) {
      setState(() {
        benchmarkResult[event.database] = event;
      });
    }).onDone(() {
      setState(() {
        _isRunning = false;
      });
    });
  }
}
