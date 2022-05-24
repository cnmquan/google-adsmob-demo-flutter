// ignore_for_file: deprecated_member_use, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:google_adsmod_demo/sample_ads_unit.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerScreen extends StatefulWidget {
  const BannerScreen({super.key});

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  late BannerAd _bannerAd1;
  late BannerAd _bannerAd2;
  bool _isAd1Loaded = false;
  bool _isAd2Loaded = false;

  initBannerAds() {
    _bannerAd1 = BannerAd(
      adUnitId: BANNER_TEST,
      size: AdSize(width: 300, height: 250),
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isAd1Loaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(error.message),
            action: SnackBarAction(
              label: 'CLOSE',
              onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar,
            ),
          ));
          ad.dispose();
        },
      ),
    );

    _bannerAd2 = BannerAd(
      adUnitId: BANNER_TEST,
      size: AdSize(width: 320, height: 100),
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isAd2Loaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(error.message),
            action: SnackBarAction(
              label: 'CLOSE',
              onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar,
            ),
          ));
          ad.dispose();
        },
      ),
    );

    _bannerAd1.load();
    _bannerAd2.load();
  }

  @override
  void initState() {
    super.initState();
    initBannerAds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Banner Screen")),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 120),
            _isAd2Loaded
                ? Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      width: _bannerAd2.size.width.toDouble() + 20,
                      height: _bannerAd2.size.height.toDouble() + 10,
                      child: AdWidget(ad: _bannerAd2),
                    ),
                  )
                : SizedBox(),
            SizedBox(height: 50),
            _isAd1Loaded
                ? Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      width: _bannerAd1.size.width.toDouble() + 20,
                      height: _bannerAd1.size.height.toDouble() + 10,
                      child: AdWidget(ad: _bannerAd1),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
