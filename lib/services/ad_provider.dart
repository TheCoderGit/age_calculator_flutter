import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdProvider with ChangeNotifier {
  final BannerAd bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: 'ca-app-pub-2556925527469330/9886505794',
      listener: AdListener(),
      request: AdRequest());
}