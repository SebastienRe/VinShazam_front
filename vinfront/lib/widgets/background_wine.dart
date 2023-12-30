// background_wine.dart
import 'dart:async';

import 'package:flutter/material.dart';

class BackgroundWine extends StatefulWidget {
  @override
  _BackgroundWineState createState() => _BackgroundWineState();
}

class _BackgroundWineState extends State<BackgroundWine> {
  late PageController _pageController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startTimer() {
    // Commencez à changer l'image après 3 secondes (au lancement)
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_pageController.page == 2) {
        _pageController.animateToPage(0,
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      } else {
        _pageController.nextPage(
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> imageUrls = [
      'https://www.bordeaux-shop.fr/wp-content/uploads/2019/06/caisse-bois_2_bouteilles_bordeaux_shop_margaux_prieure_lichine_graviers.jpg',
      'https://www.amikado.com/photo/bouteille-de-vin-personnalisee-annee-de-naissance-une-piece.jpg',
      'https://cdn.bioalaune.com/img/article/thumb/900x500/37182-rouge-blanc-contient-reellement-bouteille-vin.png',
    ];

    return PageView.builder(
      controller: _pageController,
      itemBuilder: (context, index) {
        return Image.network(
          imageUrls[index],
          fit: BoxFit.cover,
          width: double.infinity,
        );
      },
      itemCount: imageUrls.length,
    );
  }
}
