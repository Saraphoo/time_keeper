import 'dart:async';
import 'package:flutter/material.dart';
import 'package:time_keeper/utils/date_time_utils.dart';
import 'package:time_keeper/utils/constants.dart';
import 'database_helper.dart';

abstract class ReportCommand {
  void execute();
}

class ReportDataCommand implements ReportCommand {
  final ReportState state;

  ReportDataCommand(this.state);

  @override
  void execute() {
    state._reportData(state.startDateController.text, state.endDateController.text);
  }
}

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  ReportState createState() => ReportState();
}

class ReportState extends State<ReportPage> {
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  List<String> queriedData = [];
  ReportCommand? _command;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Report Time'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Constants.spacingAndHeight),
        child: Column(
          children: [
            TextFormField(
              controller: startDateController,
              decoration: const InputDecoration(
                labelText: 'Start Date (YYYY-MM-DD)',
              ),
            ),
            const SizedBox(height: Constants.spacingAndHeight),
            TextFormField(
              controller: endDateController,
              decoration: const InputDecoration(
                labelText: 'End Date (YYYY-MM-DD)',
              ),
            ),
            const SizedBox(height: Constants.spacingAndHeight),
            ElevatedButton(
              onPressed: handleButtonPress,
              child: const Text('Query Data'),
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
                    const Text('Queried Data: '),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: queriedData.map((data) => Text(data)).toList(),
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
    );
  }

  void handleButtonPress() {
    setState(() {
      _command = ReportDataCommand(this);
      _executeCommand();
    });
  }

  Future<void> _reportData(String startDate, String endDate) async {
    final dbHelper = DatabaseHelper();
    try {
      if (!_isValidDateFormat(startDate) || !_isValidDateFormat(endDate)) {
        setState(() {
          queriedData.clear();
          queriedData.add('Invalid date format');
        });
        return;
      }

      final results = await dbHelper.queryAll('time_records');
      final filteredResults = results.where((record) {
        final recordDate = DateTime.parse(record['date']);
        return recordDate.isAfter(DateTime.parse(startDate)) && recordDate.isBefore(DateTime.parse(endDate));
      }).toList();

      setState(() {
        queriedData.clear();
        for (final record in filteredResults) {
          queriedData.add(
            'Task: ${record['title']}, Date: ${record['date']}, From: ${record['from_time']}, To: ${record['to_time']}',
          );
        }
      });
    } catch (e) {
      print('Error generating report: $e');
      setState(() {
        queriedData.add('Error generating report.');
      });
    }
  }

  bool _isValidDateFormat(String date) {
    return DateTimeUtils.isValidDateFormat(date);
  }

  void _executeCommand() {
    if (_command != null) {
      _command!.execute();
    }
  }
}
