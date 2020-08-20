DateTime convertFromISOString(String dateString) {
  if (dateString.isEmpty) return DateTime.now();
  return DateTime.parse(dateString).toLocal();
}

bool isToday(DateTime date) {
  final today = DateTime.now();
  return today.year == date.year &&
      today.month == date.month &&
      today.day == date.day;
}

bool inCurrentYear(DateTime date) {
  final today = DateTime.now();
  return today.year == date.year;
}

String getSubfix(DateTime date) {
  return date.hour < 12 ? "AM" : "PM";
}

String shortDateString(DateTime date) {
  if (isToday(date)) {
    return '${date.hour}:${date.minute.toString().padLeft(2, '0')} ${getSubfix(date)}';
  }
  if (inCurrentYear(date)) {
    return '${date.day}/${date.month} ${date.hour}:${date.minute.toString().padLeft(2, '0')}  ${getSubfix(date)}';
  }
  return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}  ${getSubfix(date)}';
}

String fullDateString(DateTime date) {
  return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}  ${getSubfix(date)}';
}

String isoToDisplayShortDate(String iso) {
  final isoDate = convertFromISOString(iso) ?? DateTime.now();
  return shortDateString(isoDate);
}

String isoToDisplayFullDate(String iso) {
  final isoDate = convertFromISOString(iso) ?? DateTime.now();
  return fullDateString(isoDate);
}
