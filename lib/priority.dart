import 'dart:async';
import 'package:flutter/material.dart';
import 'package:time_keeper/utils/date_time_utils.dart';
import 'package:time_keeper/utils/constants.dart';
import 'database_helper.dart';

class PriorityPage extends StatefulWidget {
  const PriorityPage({Key? key}) : super(key: key);

  @override
  PriorityState createState() => PriorityState();
}

class PriorityState extends State<PriorityPage> {
  List<Map<String, dynamic>> queriedData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Priority'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(Constants.spacingAndHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _reportData,
                child: const Text('Generate Priority Report'),
              ),
              const SizedBox(height: Constants.spacingAndHeight),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Constants.blackColor),
                    borderRadius: BorderRadius.circular(Constants.edgeInset),
                  ),
                  padding: const EdgeInsets.all(Constants.spacingAndHeight),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Priority Report: '),
                      const SizedBox(height: Constants.edgeInset),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Task'),
                          Text('Occurrences'),
                        ],
                      ),
                      const Divider(),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: queriedData.map((data) {
                              return returnTaskAndOccurrence(data);
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget returnTaskAndOccurrence(Map<String, dynamic> data) {
    if (data.containsKey('error')) {
      return Text(data['error']);
    } else {
      String task = data['task'];
      task = task.length > 50 ? '${task.substring(0, 50)}...' : task;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(task),
          Text(data['count'].toString()),
        ],
      );
    }
  }

  Future<void> _reportData() async {
    final dbHelper = DatabaseHelper();
    try {
      final results = await dbHelper.queryAll('time_records');
      final taskCount = <String, int>{};

      for (final record in results) {
        final task = record['title'];
        taskCount[task] = (taskCount[task] ?? 0) + 1;
      }

      final sortedTasks = taskCount.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      setState(() {
        queriedData.clear();
        for (final entry in sortedTasks) {
          queriedData.add({'task': entry.key, 'count': entry.value});
        }
      });
    } catch (e) {
      print('Error generating report: $e');
      setState(() {
        queriedData.add({'error': 'Error generating report.'});
      });
    }
  }
}
