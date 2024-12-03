class DateTimeUtils {
  /// Formats a [DateTime] object into a readable string with both date and time.
  static String formatTimestamp(DateTime dateTime) {
    return _formatDateTime(dateTime);
  }

  /// Formats a time represented as [DateTime] into a readable string.
  static String formatTime(DateTime time) {
    return _formatDateTime(time);
  }

  /// Helper method to format a [DateTime] into a `YYYY-MM-DD HH:mm` string.
  static String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} '
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  /// Validates a string against the `YYYY-MM-DD` date format.
  static bool isValidDateFormat(String date) {
    RegExp dateRegExp = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    return dateRegExp.hasMatch(date);
  }
}
