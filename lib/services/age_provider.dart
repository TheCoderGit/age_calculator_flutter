import 'package:flutter/material.dart';

class AgeProvider with ChangeNotifier {
  DateTime _now = DateTime.now();

  int insertedYear, insertedMonth, insertedDay, insertedHour, insertedMinute;
  int currentYear, currentMonth, currentDay;
  var ageYears, ageMonths, ageDays;

  List bigMonths = [1, 3, 5, 7, 8, 10, 12];
  List smallMonths = [4, 6, 9, 11];

  void datePicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now())
        .then((value) {
      currentYear = _now.year;
      currentMonth = _now.month;
      currentDay = _now.day;

      insertedDay = value.day;
      insertedMonth = value.month;
      insertedYear = value.year;

      if (currentDay < insertedDay) {
        if (bigMonths.contains(currentMonth)) {
          currentMonth = currentMonth - 1;
          currentDay = currentDay + 31;
        } else if (smallMonths.contains(currentMonth)) {
          currentMonth = currentMonth - 1;
          currentDay = currentDay + 30;
        } else {
          currentMonth = currentMonth - 1;
          currentDay = currentDay + 28;
        }
        ageDays = currentDay - insertedDay;
      } else {
        ageDays = currentDay - insertedDay;
      }

      if (currentMonth < insertedMonth) {
        currentYear = currentYear - 1;
        currentMonth = currentMonth + 12;
        ageMonths = currentMonth - insertedMonth;
      } else {
        ageMonths = currentMonth - insertedMonth;
      }

      if (currentYear >= insertedYear) {
        ageYears = currentYear - insertedYear;
      } else {
        ageYears = 0;
      }

      if (value == null) {
        return;
      }
      notifyListeners();
    });
    
  }
}
