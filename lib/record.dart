import 'package:flutter/material.dart';
import 'package:time_keeper/utils/constants.dart';
import 'database_helper.dart';

class RecordTimePage extends StatefulWidget {
  const RecordTimePage({Key? key}) : super(key: key);

  @override
  RecordTimePageState createState() => RecordTimePageState();
}

class RecordTimePageState extends State<RecordTimePage> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController fromTimeController = TextEditingController();
  final TextEditingController toTimeController = TextEditingController();
  final TextEditingController taskController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  int? selectedPriority;

  final List<int> priorities = [1,2,3,4,5];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Record Time'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Constants.spacingAndHeight),
        child: Column(
          children: [
            TextFormField(
              controller: dateController,
              decoration: const InputDecoration(
                labelText: 'Date (YYYY-MM-DD)',
              ),
            ),
            const SizedBox(height: Constants.spacingAndHeight),
            TextFormField(
              controller: fromTimeController,
              decoration: const InputDecoration(
                labelText: 'From-Time (HH:MM AM/PM)',
              ),
            ),
            const SizedBox(height: Constants.spacingAndHeight),
            TextFormField(
              controller: toTimeController,
              decoration: const InputDecoration(
                labelText: 'To-Time (HH:MM AM/PM)',
              ),
            ),
            const SizedBox(height: Constants.spacingAndHeight),
            TextFormField(
              controller: taskController,
              decoration: const InputDecoration(
                labelText: 'Task',
              ),
            ),
            const SizedBox(height: Constants.spacingAndHeight),
            TextFormField(
              controller: tagController,
              decoration: const InputDecoration(
                labelText: 'Tag',
              ),
            ),
            const SizedBox(height: Constants.spacingAndHeight),
            DropdownButtonFormField<int>(
              value: selectedPriority,
              items: priorities
                  .map((priority) => DropdownMenuItem(
                value: priority,
                child: Text(priority.toString()), // Convert int to String for display
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedPriority = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Priority',
              ),
            ),
            const SizedBox(height: Constants.spacingAndHeight),
            ElevatedButton(
              onPressed: _handleSaveRecord,
              child: const Text('Record Time'),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSaveRecord() {
    final date = dateController.text.trim();
    final fromTime = fromTimeController.text.trim();
    final toTime = toTimeController.text.trim();
    final task = taskController.text.trim();
    final tag = tagController.text.trim();

    if (date.isEmpty || fromTime.isEmpty || toTime.isEmpty || task.isEmpty || selectedPriority == null) {
      _showSnackBar('Please fill all fields and select a priority.', isError: true);
      return;
    }

    _saveTimeRecord(date, fromTime, toTime, task, tag, selectedPriority!);
  }

  Future<void> _saveTimeRecord(
      String date,
      String fromTime,
      String toTime,
      String task,
      String tag,
      int priority,
      ) async {
    try {
      final parsedDate = _parseDate(date);
      final parsedFromTime = _parseTime(fromTime);
      final parsedToTime = _parseTime(toTime);

      final fromDateTime = DateTime(
        parsedDate.year,
        parsedDate.month,
        parsedDate.day,
        parsedFromTime.hour,
        parsedFromTime.minute,
      );

      final toDateTime = DateTime(
        parsedDate.year,
        parsedDate.month,
        parsedDate.day,
        parsedToTime.hour,
        parsedToTime.minute,
      );

      final db = await DatabaseHelper().database;

      await db.insert(
        'time_records',
        {
          'date': parsedDate.toIso8601String(),
          'from_time': fromDateTime.toIso8601String(),
          'to_time': toDateTime.toIso8601String(),
          'title': task,
          'tag': tag,
          'priority': priority,
        },
      );

      setState(() {
        dateController.clear();
        fromTimeController.clear();
        toTimeController.clear();
        taskController.clear();
        tagController.clear();
        selectedPriority = null;
      });

      _showSnackBar('Record submitted successfully.');
    } catch (error) {
      _showSnackBar('Failed to submit record.', isError: true);
    }
  }

  DateTime _parseDate(String date) {
    if (date.toLowerCase() == 'today') {
      return DateTime.now();
    } else {
      return DateTime.parse(date);
    }
  }

  TimeOfDay _parseTime(String time) {
    final parts = time.split(' ');
    final timeParts = parts[0].split(':');
    int hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);

    if (parts[1].toLowerCase() == 'pm' && hour < 12) {
      hour += 12;
    }

    return TimeOfDay(hour: hour, minute: minute);
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
