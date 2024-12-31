import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:cutlink/core/admob/admob_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

class AdBanner extends StatefulWidget {
  const AdBanner({
    required this.adId,
    this.height,
    this.margin,
    super.key,
  });

  final EdgeInsetsGeometry? margin;
  final int? height;
  final String adId;

  @override
  State<AdBanner> createState() => _AdBanner300x60State();
}

class _AdBanner300x60State extends State<AdBanner> {
  bool _bannerAdFailedToLoad = false;
  late BannerAd _bannerAd;

  @override
  void initState() {
    final size = AnchoredAdaptiveBannerAdSize(
      height: widget.height ?? 56,
      width: Get.width.toInt(),
      Orientation.landscape,
    );

    if (Platform.isAndroid || Platform.isIOS) {
      _bannerAd = BannerAd(
        listener: AdMobUtils.bannerAdListener(onAdLoaded: (ad) {
          if (kDebugMode) debugPrint('TiuTiuApp: Banner Ad ${ad.adUnitId} Load.');
          _bannerAdFailedToLoad = false;
        }, onAdFailedToLoad: (ad, error) {
          if (kDebugMode) debugPrint('TiuTiuApp: Banner Ad ${ad.adUnitId} Failed to load: $error');
          _bannerAdFailedToLoad = true;
        }),
        request: const AdRequest(),
        adUnitId: widget.adId,
        size: size,
      );

      _bannerAd.load();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid || Platform.isIOS) {
      return Visibility(
        visible: !_bannerAdFailedToLoad,
        child: Container(
          margin: widget.margin ?? EdgeInsets.zero,
          height: _bannerAd.size.height.toDouble(),
          width: _bannerAd.size.width.toDouble(),
          child: ClipRRect(
            borderRadius: BorderRadius.zero,
            child: AdWidget(ad: _bannerAd),
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  void dispose() {
    if (Platform.isAndroid || Platform.isIOS) {
      _bannerAd.dispose();
    }
    super.dispose();
  }
}
