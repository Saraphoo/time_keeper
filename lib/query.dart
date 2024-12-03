import 'dart:async';
import 'package:flutter/material.dart';
import 'package:time_keeper/utils/date_time_utils.dart';
import 'package:time_keeper/utils/constants.dart';
import 'database_helper.dart';

class QueryPage extends StatefulWidget {
  const QueryPage({Key? key}) : super(key: key);

  @override
  QueryPageState createState() => QueryPageState();
}

class QueryPageState extends State<QueryPage> {
  final TextEditingController queryController = TextEditingController();
  String? dropdownValue;
  List<String> queriedData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Query Time'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Constants.spacingAndHeight),
        child: Column(
          children: [
            const Text('Query by: '),
            DropdownButton<String>(
              value: dropdownValue,
              items: const [
                DropdownMenuItem(value: 'today', child: Text('Today')),
                DropdownMenuItem(value: 'date', child: Text('Date')),
                DropdownMenuItem(value: 'task', child: Text('Task')),
                DropdownMenuItem(value: 'tag', child: Text('Tag')),
              ],
              onChanged: (value) {
                setState(() {
                  dropdownValue = value;
                  queryController.clear();
                });
              },
            ),
            if (dropdownValue != 'today')
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Constants.spacingAndHeight),
                child: TextFormField(
                  controller: queryController,
                  decoration: const InputDecoration(labelText: 'Input'),
                  enabled: dropdownValue != 'today',
                ),
              ),
            ElevatedButton(
              onPressed: _queryInformation,
              child: const Text('Query'),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: Constants.spacingAndHeight),
                decoration: BoxDecoration(
                  border: Border.all(color: Constants.blackColor),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.all(Constants.spacingAndHeight),
                child: ListView(
                  children: queriedData.map((data) => Text(data)).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _performQuery(String query) async {
    final dbHelper = DatabaseHelper();
    List<Map<String, dynamic>> results = [];
    try {
      if (dropdownValue == 'today') {
        final today = DateTime.now();
        final formattedToday =
            '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
        results = await dbHelper.database.then(
              (db) => db.query(
            'time_records',
            where: 'date = ?',
            whereArgs: [formattedToday],
          ),
        );
      } else if (dropdownValue == 'date') {
        results = await dbHelper.database.then(
              (db) => db.query(
            'time_records',
            where: 'date = ?',
            whereArgs: [query],
          ),
        );
      } else if (dropdownValue == 'task') {
        results = await dbHelper.database.then(
              (db) => db.query(
            'time_records',
            where: 'title LIKE ?',
            whereArgs: ['%$query%'],
          ),
        );
      } else if (dropdownValue == 'tag') {
        results = await dbHelper.database.then(
              (db) => db.query(
            'time_records',
            where: 'tag = ?',
            whereArgs: [query],
          ),
        );
      }

      setState(() {
        queriedData = results.map((row) {
          final formattedDate = DateTimeUtils.formatTimestamp(DateTime.parse(row['date']));
          final formattedFromTime = DateTimeUtils.formatTime(DateTime.parse(row['from_time']));
          final formattedToTime = DateTimeUtils.formatTime(DateTime.parse(row['to_time']));
          return 'Date: $formattedDate, From: $formattedFromTime, To: $formattedToTime, Task: ${row['title']}, Tag: ${row['tag']}';
        }).toList();
      });
    } catch (error) {
      setState(() {
        queriedData = ['Error querying records: $error'];
      });
    }
  }

  void _queryInformation() {
    if (dropdownValue == null) {
      setState(() {
        queriedData = ['Please select a query type.'];
      });
      return;
    }

    if (dropdownValue == 'today') {
      _performQuery('');
    } else if (dropdownValue == 'date' && DateTimeUtils.isValidDateFormat(queryController.text)) {
      _performQuery(queryController.text);
    } else if (dropdownValue == 'task' || dropdownValue == 'tag') {
      if (queryController.text.isNotEmpty) {
        _performQuery(queryController.text);
      } else {
        setState(() {
          queriedData = ['Please provide input for the query.'];
        });
      }
    } else {
      setState(() {
        queriedData = ['Invalid input.'];
      });
    }
  }
}
