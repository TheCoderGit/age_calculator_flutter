import 'package:age_calculator_flutter/services/ad_provider.dart';
import 'package:age_calculator_flutter/services/age_provider.dart';
import 'package:age_calculator_flutter/widgets/age_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=> AgeProvider()),
      ChangeNotifierProvider(create: (_)=> AdProvider())
    ],
    child:MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        theme: ThemeData(
          primaryColor: Colors.lightBlue,
          accentColor: Colors.blueGrey[300],
          primarySwatch: Colors.lightBlue,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,)
          ),
          )
      );
  }
}

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    context.read<AdProvider>().bannerAd.load();
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Age Calculator'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(//the banner ad
            bottom: 0,
            child: Container(
              height: context.read<AdProvider>().bannerAd.size.height.toDouble(),
              width: context.read<AdProvider>().bannerAd.size.width.toDouble(),
              child: AdWidget(
                ad: context.read<AdProvider>().bannerAd,
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<AgeProvider>()
                        .datePicker(context);
                  },
                  child: Text(
                    'Select your birthday',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green[900],
                    ),
                  ),
                ),
                Text( Provider.of<AgeProvider>(context).ageDays != null ?
                  'You Selected : ${context.read<AgeProvider>().insertedDay}'
                   ' ${DateFormat('MMMM').format(context.read<AgeProvider>().selectedDate)}' :
                   'nothing selected yet',
                   //Provider.of<AgeProvider>(context).insertedMonth
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.green[900],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    color: Theme.of(context).primaryColor,
                    elevation: 8,
                    shadowColor: Colors.black26,
                    margin: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AgeCard(
                          textNumber:
                              '${context.watch<AgeProvider>().ageYears ?? 0}',
                          textDescription: 'Years',
                        ),
                        AgeCard(
                          textNumber:
                              '${context.watch<AgeProvider>().ageMonths ?? 0}',
                          textDescription: 'Months',
                        ),
                        AgeCard(
                          textNumber:
                              '${context.watch<AgeProvider>().ageDays ?? 0}',
                          textDescription: 'Days',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
