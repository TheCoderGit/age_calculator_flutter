import 'package:flutter/material.dart';

class AgeCard extends StatelessWidget {
  final String textNumber;
  final String textDescription;

  AgeCard({
    @required this.textNumber,
    @required this.textDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 2),
      child: Expanded(
        child: Card(
          color: Colors.white54,
          shadowColor: Colors.green,
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  '$textNumber',
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 25,
                    fontWeight: FontWeight.bold,)
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  '$textDescription',
                  style: TextStyle(
                    color: Colors.indigo[900],
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
