import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stake_casino_app2/pages/home_page.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  ValueNotifier<int> page = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.only(top: 65),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Stake Casino',
                  style: TextStyle(
                      color: Color(0xFF9B51E0),
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          if (page.value == 0)
            Container(
              height: 280,
              width: 390,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/onBoarding1.png'))),
            ),
          if (page.value == 1)
            Container(
              height: 280,
              width: 390,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/onBoarding2.png'))),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 20, 11, 8),
            child: Column(children: [
              if (page.value == 0)
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Stake App\nwelcomes you!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 32,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              if (page.value == 0)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    'Learn how to buy/sell stocks safely! No money is needed, only your intuition.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              if (page.value == 1)
                const Padding(
                  padding: EdgeInsets.only(
                    bottom: 8,
                  ),
                  child: Text(
                    'How to play',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 32,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              if (page.value == 1)
                Padding(
                  padding: const EdgeInsets.only(bottom: 56),
                  child: Text(
                    'Buy first stocks. Generate event. Read the description. Repeat!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(bottom: 96),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: page,
                      builder: (context, index, child) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: DotsIndicator(
                          dotsCount: 2,
                          position: page.value,
                          decorator: DotsDecorator(
                            size: const Size(141.0, 8.0),
                            activeSize: const Size(141.0, 8.0),
                            spacing: const EdgeInsets.all(3),
                            color: Colors.black.withOpacity(0.1),
                            activeColor: const Color(0xFF9B51E0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 20, 18),
                child: InkWell(
                  onTap: () {
                    if (page.value == 0) {
                      page.value = 1;
                      setState(() {});
                    } else if (page.value == 1) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const HomePage()),
                      );
                    }
                  },
                  child: Container(
                      width: double.infinity,
                      height: 48,
                      padding: const EdgeInsets.only(top: 13),
                      decoration: BoxDecoration(
                          color: const Color(0xFF9B51E0),
                          borderRadius: BorderRadius.circular(12)),
                      child: const Text(
                        'Next',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      )),
                ),
              ),
            ]),
          )
        ]),
      ),
    );
  }
}
