import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stake_casino_app2/model/stock_item.dart';
import 'package:stake_casino_app2/model/user.dart';
import 'package:stake_casino_app2/pages/description_stock_page.dart';
import 'package:stake_casino_app2/pages/settings_page.dart';

List<Stock> mystocks = [];
UserItem user = UserItem(balance: 10000);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selected = 0;

  List<Stock> stocks = [
    Stock(
        cost: 180.00,
        increasePercent: -0.60,
        name: 'Technology',
        positiveArticle: 'Technological innovations and breakthroughs:',
        positiveText:
            'Announcement of new technologies, technological breakthroughs, or patents can push the company\'s stocks higher.',
        negativeArticle: 'Technological obsolescence:',
        negativeText:
            'Rapid technological advancements or shifts in consumer preferences can render existing products or services obsolete, leading to a decline in demand and stock prices.',
        image: 'assets/Technology.png'),
    Stock(
        cost: 40.00,
        increasePercent: 0.5,
        name: 'Pharmaceutical',
        positiveArticle: 'Strategic mergers and acquisitions',
        positiveText:
            'Participation in strategic mergers and acquisitions that strengthen the company\'s market positions or expand its portfolio of products and services can attract investor Robotoest.',
        negativeArticle: 'Leadership scandals or controversies:',
        negativeText:
            'Scandals or controversies involving company executives or key personnel can erode investor trust and have a detrimental impact on stock prices.',
        image: 'assets/Pharmaceutical.png'),
    Stock(
        cost: 400.00,
        increasePercent: 2.00,
        name: 'Financial',
        positiveArticle: 'Positive financial results:',
        positiveText:
            'Publishing positive financial reports, including revenue growth, profits, and growth indicators, can strengthen investor confidence and support stock prices.',
        negativeArticle: 'Macroeconomic factors:',
        negativeText:
            'Economic downturns, recessions, or geopolitical tensions can weaken consumer spending and corporate investment, negatively impacting technology companies\' earnings and stock prices.',
        image: 'assets/Financial.png'),
    Stock(
        cost: 230,
        increasePercent: 1.5,
        name: 'Retail',
        positiveArticle: 'Growth in user base or activity:',
        positiveText:
            'Significant growth in the number of users or activity on the platform (such as an increase in active users, time spent on the site, or app downloads) can positively impact stocks.',
        negativeArticle: 'Product recalls or failures:',
        negativeText:
            'Instances of product recalls due to defects or failures can lead to a loss of investor confidence and a decline in stock prices.',
        image: 'assets/Retail.png'),
    Stock(
        cost: 170,
        increasePercent: -3.0,
        name: 'Energy',
        positiveArticle: 'Stable leadership and development strategy:',
        positiveText:
            'Confirmation of stable company leadership and announcement of a clear development strategy for the future can strengthen investor confidence and support stock prices.',
        negativeArticle: 'Supply chain disruptions:',
        negativeText:
            'Disruptions in the supply chain due to natural disasters, trade disputes, or geopolitical conflicts can disrupt production and distribution, affecting technology companies\' ability to meet market demand and impacting stock prices.',
        image: 'assets/Energy.png'),
  ];
  Timer? timer;
  Timer? timer2;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) {
        for (var stock in stocks) {
          Stock sameMyStock = mystocks
              .firstWhere((element) => element.name == stock.name, orElse: () {
            return Stock();
          });
          stock.increasePercent = doubleInRange(-3.0, 3.0);
          if (sameMyStock.increasePercent != null) {
            sameMyStock.increasePercent = stock.increasePercent;
          }
          stock.cost =
              stock.cost! + (stock.cost! * stock.increasePercent! / 100);
          if (sameMyStock.cost != null) {
            sameMyStock.cost = stock.cost;
          }
          setState(() {});
        }
      },
    );
    getSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    Future(() {
      if (user.balance == 0 || user.balance! < 0) {
        timer!.cancel();
        showModalBottomSheet(
            isDismissible: false,
            showDragHandle: true,
            backgroundColor: Colors.white,
            context: context,
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height - 500),
            builder: (context) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Well...',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Text(
                        'Your balance is empty! Try one more time, but think all time!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: InkWell(
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.clear();
                          if (context.mounted) {
                            Phoenix.rebirth(context);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(52, 11, 52, 11),
                          decoration: BoxDecoration(
                              color: const Color(0xFF9B51E0),
                              borderRadius: BorderRadius.circular(60)),
                          child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Restart',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ]);
            });
      }
    });
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 65, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(16)),
                  child: Row(children: [
                    Image.asset('assets/money.png'),
                    const SizedBox(width: 12),
                    Text(
                      user.balance!.toStringAsFixed(0),
                      style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    )
                  ]),
                ),
                InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const SettingsPage()));
                    },
                    child: Image.asset('assets/settings.png'))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, top: 8),
                  child: Image.asset(
                    'assets/fire.png',
                    scale: 3.0,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20, right: 16, top: 8),
                        child: Text(
                          'Events of the day',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 24,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 11, right: 16),
                        child: InkWell(
                          onTap: () {
                            Stock newSctock = Stock();
                            Stock randomSctock =
                                stocks.elementAt(Random().nextInt(5));
                            newSctock.name = randomSctock.name;
                            newSctock.cost = randomSctock.cost;
                            newSctock.image = randomSctock.image;
                            newSctock.positiveArticle =
                                randomSctock.positiveArticle;
                            newSctock.positiveText = randomSctock.positiveText;
                            newSctock.negativeArticle =
                                randomSctock.negativeArticle;
                            newSctock.negativeText = randomSctock.negativeText;
                            newSctock.increasePercent =
                                doubleInRange(-3.0, 3.0);
                            newSctock.cost = newSctock.cost! +
                                (newSctock.cost! *
                                    newSctock.increasePercent! /
                                    100);
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      DescriptionStockPage(
                                        stock: newSctock,
                                        callBackBuy: () {
                                          if (mystocks.firstWhere(
                                                  (element) =>
                                                      element.name ==
                                                      newSctock.name,
                                                  orElse: () {
                                                return Stock();
                                              }).cost ==
                                              null) {
                                            newSctock.amount = 1;
                                            user.balance =
                                                user.balance! - newSctock.cost!;
                                            mystocks.add(newSctock);
                                          } else {
                                            mystocks.firstWhere(
                                                (element) =>
                                                    element.name ==
                                                    newSctock.name, orElse: () {
                                              return Stock();
                                            }).amount = mystocks.firstWhere(
                                                    (element) =>
                                                        element.name ==
                                                        newSctock.name,
                                                    orElse: () {
                                                  return Stock();
                                                }).amount! +
                                                1;
                                            user.balance =
                                                user.balance! - newSctock.cost!;
                                          }
                                          addToSharedPref(mystocks);
                                        },
                                        callBackSell: () {
                                          mystocks.firstWhere(
                                              (element) =>
                                                  element.name ==
                                                  newSctock.name, orElse: () {
                                            return Stock();
                                          }).amount = mystocks.firstWhere(
                                                  (element) =>
                                                      element.name ==
                                                      newSctock.name,
                                                  orElse: () {
                                                return Stock();
                                              }).amount! -
                                              1;
                                          user.balance =
                                              user.balance! + newSctock.cost!;
                                          if (mystocks.firstWhere(
                                                  (element) =>
                                                      element.name ==
                                                      newSctock.name,
                                                  orElse: () {
                                                return Stock();
                                              }).amount ==
                                              0) {
                                            user.balance =
                                                user.balance! + newSctock.cost!;
                                            mystocks.remove(newSctock);
                                          }

                                          addToSharedPref(mystocks);

                                          setState(() {});
                                        },
                                      )),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(0, 11, 0, 11),
                            decoration: BoxDecoration(
                                color: const Color(0xFF9B51E0),
                                borderRadius: BorderRadius.circular(16)),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/generate.png'),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  const Text(
                                    'Generate',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ]),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Container(
                height: 44,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      16,
                    ),
                    color: Colors.black.withOpacity(0.06),
                  ),
                  child: TabBar(
                    onTap: (tabNum) {
                      selected = tabNum;
                      setState(() {});
                    },
                    dividerHeight: 0,
                    padding: const EdgeInsets.all(2),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                      color: Colors.white,
                    ),
                    tabs: [
                      Tab(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (selected == 1)
                                Image.asset(
                                  'assets/allstocks.png',
                                ),
                              if (selected == 0)
                                Image.asset(
                                  'assets/allstocks2.png',
                                ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                'All Stocks',
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: selected == 0
                                        ? const Color(0xFF9B51E0)
                                        : Colors.black.withOpacity(0.4),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ]),
                      ),
                      Tab(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (selected == 0)
                                Image.asset(
                                  'assets/mystocks.png',
                                ),
                              if (selected == 1)
                                Image.asset(
                                  'assets/mystocks2.png',
                                ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                'Your Stocks',
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: selected == 1
                                        ? const Color(0xFF9B51E0)
                                        : Colors.black.withOpacity(0.4),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ]),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: getStocks(),
                )),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                    child: mystocks.isEmpty
                        ? Text(
                            'Buy your first Stock in All stocks',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: getMyStocks(),
                          ),
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }

  Widget getStocks() {
    List<Widget> list = [];
    for (var stock in stocks) {
      list.add(InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
                builder: (BuildContext context) => DescriptionStockPage(
                      stock: stock,
                      callBackBuy: () {
                        if (mystocks.firstWhere(
                                (element) => element.name == stock.name,
                                orElse: () {
                              return Stock();
                            }).cost ==
                            null) {
                          stock.amount = 1;
                          user.balance = user.balance! - stock.cost!;
                          mystocks.add(stock);
                        } else {
                          mystocks.firstWhere(
                              (element) => element.name == stock.name,
                              orElse: () {
                            return Stock();
                          }).amount = mystocks.firstWhere(
                                  (element) => element.name == stock.name,
                                  orElse: () {
                                return Stock();
                              }).amount! +
                              1;
                          user.balance = user.balance! - stock.cost!;
                        }
                        addToSharedPref(mystocks);
                        setState(() {});
                      },
                      callBackSell: () {
                        mystocks
                            .firstWhere((element) => element.name == stock.name,
                                orElse: () {
                          return Stock();
                        }).amount = mystocks.firstWhere(
                                (element) => element.name == stock.name,
                                orElse: () {
                              return Stock();
                            }).amount! -
                            1;
                        user.balance = user.balance! + stock.cost!;
                        if (mystocks.firstWhere(
                                (element) => element.name == stock.name,
                                orElse: () {
                              return Stock();
                            }).amount ==
                            0) {
                          user.balance = user.balance! + stock.cost!;
                          mystocks.remove(stock);
                        }

                        addToSharedPref(mystocks);

                        setState(() {});
                      },
                    )),
          );
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.06),
              borderRadius: BorderRadius.circular(12)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                Image.asset(
                  stock.image!,
                  scale: 4.0,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  stock.name!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                    decoration: BoxDecoration(
                        color: stock.increasePercent!.isNegative
                            ? const Color(0xFFEB5757).withOpacity(0.14)
                            : const Color(0xFF32C370).withOpacity(0.14),
                        borderRadius: BorderRadius.circular(7)),
                    child: Row(children: [
                      stock.increasePercent!.isNegative
                          ? Image.asset(
                              'assets/down.png',
                            )
                          : Image.asset(
                              'assets/up.png',
                            ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                          '${stock.increasePercent!.toStringAsFixed(2).replaceAll('-', '')}%',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600,
                            color: stock.increasePercent!.isNegative
                                ? const Color(0xFFEB5757)
                                : const Color(0xFF32C370),
                          )),
                    ]),
                  ),
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/money.png',
                      scale: 1.5,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      stock.cost!.toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                )
              ],
            )
          ]),
        ),
      ));
      list.add(const SizedBox(
        height: 8,
      ));
    }
    return Column(
      children: list,
    );
  }

  Widget getMyStocks() {
    List<Widget> list = [];
    for (var stock in mystocks) {
      list.add(InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
                builder: (BuildContext context) => DescriptionStockPage(
                      stock: stock,
                      callBackBuy: () {
                        if (mystocks.firstWhere(
                                (element) => element.name == stock.name,
                                orElse: () {
                              return Stock();
                            }).cost ==
                            null) {
                          stock.amount = 1;
                          user.balance = user.balance! - stock.cost!;
                          mystocks.add(stock);
                        } else {
                          mystocks.firstWhere(
                              (element) => element.name == stock.name,
                              orElse: () {
                            return Stock();
                          }).amount = mystocks.firstWhere(
                                  (element) => element.name == stock.name,
                                  orElse: () {
                                return Stock();
                              }).amount! +
                              1;
                          user.balance = user.balance! - stock.cost!;
                        }
                        addToSharedPref(mystocks);
                        setState(() {});
                      },
                      callBackSell: () {
                        mystocks
                            .firstWhere((element) => element.name == stock.name,
                                orElse: () {
                          return Stock();
                        }).amount = mystocks.firstWhere(
                                (element) => element.name == stock.name,
                                orElse: () {
                              return Stock();
                            }).amount! -
                            1;
                        user.balance = user.balance! + stock.cost!;
                        if (mystocks.firstWhere(
                                (element) => element.name == stock.name,
                                orElse: () {
                              return Stock();
                            }).amount ==
                            0) {
                          user.balance = user.balance! + stock.cost!;
                          mystocks.remove(stock);
                        }

                        addToSharedPref(mystocks);

                        setState(() {});
                      },
                    )),
          );
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.06),
              borderRadius: BorderRadius.circular(12)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Image.asset(
                        stock.image!,
                        scale: 4.0,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        stock.name!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                    decoration: BoxDecoration(
                        color: stock.increasePercent!.isNegative
                            ? const Color(0xFFEB5757).withOpacity(0.14)
                            : const Color(0xFF32C370).withOpacity(0.14),
                        borderRadius: BorderRadius.circular(7)),
                    child: Row(children: [
                      stock.increasePercent!.isNegative
                          ? Image.asset(
                              'assets/down.png',
                            )
                          : Image.asset(
                              'assets/up.png',
                            ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                          '${stock.increasePercent!.toStringAsFixed(2).replaceAll('-', '')}%',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600,
                            color: stock.increasePercent!.isNegative
                                ? const Color(0xFFEB5757)
                                : const Color(0xFF32C370),
                          )),
                    ]),
                  ),
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/money.png',
                      scale: 1.5,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      stock.cost!.toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, top: 16),
                  child: Text(
                    'You have',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Image.asset('assets/mystocks.png'),
                      const SizedBox(
                        width: 4,
                      ),
                      if (stock.amount != 0 && stock.amount != null)
                        Text(
                          stock.amount!.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      if (stock.amount == 0 || stock.amount == null)
                        const Text(
                          '0',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/money.png',
                      scale: 1.5,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    if (stock.amount != 0 && stock.amount != null)
                      Text(
                        (stock.cost! * stock.amount!).toStringAsFixed(2),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    if (stock.amount == 0 || stock.amount == null)
                      const Text(
                        '0',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      )
                  ],
                )
              ],
            ),
          ]),
        ),
      ));
      list.add(const SizedBox(
        height: 8,
      ));
    }
    return Column(
      children: list,
    );
  }

  Future<void> addToSharedPref(
    List<Stock>? myStocks,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', jsonEncode(user));
    if (myStocks != null) {
      prefs.setString('myStocks', jsonEncode(myStocks));
    }
  }

  void getSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
      Map<String, dynamic> userMap = jsonDecode(prefs.getString('user')!);
      if (UserItem.fromJson(userMap).balance != 0.00) {
        user = UserItem.fromJson(userMap);
      }
    } else {
      user.balance = 10000.00;
    }
    final List<dynamic> jsonData =
        jsonDecode(prefs.getString('myStocks') ?? '[]');

    mystocks = jsonData.map<Stock>((jsonList) {
      {
        return Stock.fromJson(jsonList);
      }
    }).toList();
    setState(() {});
  }

  double doubleInRange(num start, num end) =>
      Random().nextDouble() * (end - start) + start;
}
