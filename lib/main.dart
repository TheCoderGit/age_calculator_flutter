import 'package:age_calculator_flutter/services/age_provider.dart';
import 'package:age_calculator_flutter/widgets/age_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AgeProvider>(
      create: (_) => AgeProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final BannerAd _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: 'ca-app-pub-2556925527469330/9886505794',
      listener: AdListener(),
      request: AdRequest());

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    super.dispose();
    widget._bannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget._bannerAd.load();
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: Text('Age Calculator'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              height: widget._bannerAd.size.height.toDouble(),
              width: widget._bannerAd.size.width.toDouble(),
              child: AdWidget(
                ad: widget._bannerAd,
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    color: Colors.amber,
                    elevation: 8,
                    shadowColor: Colors.black26,
                    margin: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AgeCard(
                          textNumber:
                              '${Provider.of<AgeProvider>(context).ageYears ?? 0}',
                          textDescription: 'Years',
                        ),
                        AgeCard(
                          textNumber:
                              '${Provider.of<AgeProvider>(context).ageMonths ?? 0}',
                          textDescription: 'Months',
                        ),
                        AgeCard(
                          textNumber:
                              '${Provider.of<AgeProvider>(context).ageDays ?? 0}',
                          textDescription: 'Days',
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<AgeProvider>(context, listen: false)
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
                Text(
                  '${Provider.of<AgeProvider>(context).ageDays ?? 0}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.amber,
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
