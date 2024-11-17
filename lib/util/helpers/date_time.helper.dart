class DateHelper {
  static String formatDate(DateTime date) {
    return '${date.day < 10 ? '0' : ''}${date.day}/${date.month < 10 ? '0' : ''}${date.month}/${date.year}';
  }

  static String formatDateTime(DateTime dateTime) {
    return '${dateTime.day < 10 ? '0' : ''}${dateTime.day}/${dateTime.month < 10 ? '0' : ''}${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute < 10 ? '0' : ''}${dateTime.minute}';
  }

  static String formatTime(DateTime time) {
    return '${time.hour}:${time.minute < 10 ? '0' : ''}${time.minute}';
  }

  //Me devuelve la fecha actual menos 18 años
  static DateTime todayDateMinus18Years() {
    return DateTime(
        DateTime.now().year - 18, DateTime.now().month, DateTime.now().day);
  }
}
