import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DateTime _now = DateTime.now();

  int insertedYear, insertedMonth, insertedDay, insertedHour, insertedMinute;
  int currentYear, currentMonth, currentDay;
  var ageYears, ageMonths, ageDays;

  List bigMonths = [1, 3, 5, 7, 8, 10, 12];
  List smallMonths = [4, 6, 9, 11];

  void _datePicker() {
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
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Age Calculator",
        ),
        backgroundColor: Colors.black45,
      ),
      body: Column(
        children: [
          Card(
            color: Colors.brown,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Pick your Birthday, to know exactly how old are you."
                    " and some info about events happened that day.",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.brown,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(color: Colors.white),
                      ),
                    ),
                    child: Text(
                      "Pick your Birthday",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: _datePicker),
              ],
            ),
          ),
          Card(
            color: Colors.brown,
            child: insertedYear != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "you are $ageYears year(s) and $ageMonths month(s) and $ageDays days",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "No Date selected yet",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}
