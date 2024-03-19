import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stake_casino_app2/model/stock_item.dart';
import 'package:stake_casino_app2/pages/home_page.dart';

class DescriptionStockPage extends StatefulWidget {
  const DescriptionStockPage(
      {super.key,
      required this.stock,
      required this.callBackSell,
      required this.callBackBuy});
  final Stock stock;
  final Function() callBackSell;
  final Function() callBackBuy;

  @override
  State<DescriptionStockPage> createState() => _DescriptionStockPageState();
}

class _DescriptionStockPageState extends State<DescriptionStockPage> {
  Timer? timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(seconds: 2),
      (timer) {
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 65, 16, 26),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      timer!.cancel();
                      Navigator.pop(context);
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.chevron_left,
                          color: Color(0xFF9B51E0),
                        ),
                        Text(
                          'Back',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Color(0xFF9B51E0),
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
                Text(
                  '${widget.stock.name!} Stock',
                  style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                const Expanded(flex: 1, child: SizedBox()),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 26),
                    child: Image.asset(
                      widget.stock.image!,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget.stock.name!,
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
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 2, 8, 2),
                                    decoration: BoxDecoration(
                                        color: widget.stock.increasePercent!
                                                .isNegative
                                            ? const Color(0xFFEB5757)
                                                .withOpacity(0.14)
                                            : const Color(0xFF32C370)
                                                .withOpacity(0.14),
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Row(children: [
                                      widget.stock.increasePercent!.isNegative
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
                                          '${widget.stock.increasePercent!.toStringAsFixed(2).replaceAll('-', '')}%',
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w600,
                                            color: widget.stock.increasePercent!
                                                    .isNegative
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
                                      widget.stock.cost!.toStringAsFixed(2),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'You have',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  children: [
                                    Image.asset('assets/mystocks.png'),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    if (mystocks.firstWhere(
                                            (element) =>
                                                element.name ==
                                                widget.stock.name, orElse: () {
                                          return Stock();
                                        }).amount !=
                                        null)
                                      Text(
                                        mystocks
                                            .firstWhere(
                                                (element) =>
                                                    element.name ==
                                                    widget.stock.name,
                                                orElse: () {
                                              return Stock();
                                            })
                                            .amount
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    if (mystocks.firstWhere(
                                                (element) =>
                                                    element.name ==
                                                    widget.stock.name,
                                                orElse: () {
                                              return Stock();
                                            }).amount ==
                                            null ||
                                        (mystocks.firstWhere(
                                                (element) =>
                                                    element.name ==
                                                    widget.stock.name,
                                                orElse: () {
                                              return Stock();
                                            }).amount ==
                                            0))
                                      const Text(
                                        '0',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/money.png',
                                      scale: 1.5,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    if (mystocks.firstWhere(
                                            (element) =>
                                                element.name ==
                                                widget.stock.name, orElse: () {
                                          return Stock();
                                        }).amount !=
                                        null)
                                      Text(
                                        (widget.stock.cost! *
                                                mystocks.firstWhere(
                                                    (element) =>
                                                        element.name ==
                                                        widget.stock.name,
                                                    orElse: () {
                                                  return Stock();
                                                }).amount!)
                                            .toStringAsFixed(2),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    if (mystocks.firstWhere(
                                            (element) =>
                                                element.name ==
                                                widget.stock.name, orElse: () {
                                          return Stock();
                                        }).amount ==
                                        null)
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
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Last event',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                widget.stock.increasePercent!.isNegative
                                    ? widget.stock.negativeArticle!
                                    : widget.stock.positiveArticle!,
                                style: const TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  widget.stock.increasePercent!.isNegative
                                      ? widget.stock.negativeText!
                                      : widget.stock.positiveText!,
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    child: Row(
                      mainAxisAlignment: mystocks.firstWhere(
                                  (element) =>
                                      element.name == widget.stock.name,
                                  orElse: () {
                                return Stock();
                              }).cost ==
                              null
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.spaceBetween,
                      children: [
                        if (mystocks.firstWhere(
                                (element) => element.name == widget.stock.name,
                                orElse: () {
                              return Stock();
                            }).cost !=
                            null)
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                showSellBuyModalSheet(true);
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 11, 0, 11),
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.06),
                                    borderRadius: BorderRadius.circular(16)),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/arrow-up.png',
                                        color: const Color(0xFF9B51E0),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      const Text(
                                        'Sell',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: Color(0xFF9B51E0),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              showSellBuyModalSheet(false);
                            },
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(0, 11, 0, 11),
                              decoration: BoxDecoration(
                                  color: const Color(0xFF9B51E0),
                                  borderRadius: BorderRadius.circular(16)),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/arrow-down.png'),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    const Text(
                                      'Buy',
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
          )
        ],
      ),
    );
  }

  void showSellBuyModalSheet(bool isSellDialog) {
    showModalBottomSheet(
        showDragHandle: true,
        backgroundColor: Colors.white,
        context: context,
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 400),
        builder: (context) {
          return SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isSellDialog
                              ? 'Sell ${widget.stock.name} Stock'
                              : 'Buy ${widget.stock.name} Stock',
                          style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                        InkWell(
                            onTap: () {
                              timer!.cancel();
                              Navigator.pop(context);
                            },
                            child: Image.asset('assets/close.png'))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 8, left: 16, right: 16, top: 28),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'You have',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  children: [
                                    Image.asset('assets/mystocks.png'),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    if (widget.stock.amount != 0 &&
                                        widget.stock.amount != null)
                                      Text(
                                        widget.stock.amount!.toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    if (widget.stock.amount == 0 ||
                                        widget.stock.amount == null)
                                      const Text(
                                        '0',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/money.png',
                                      scale: 1.5,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    if (widget.stock.amount != 0 &&
                                        widget.stock.amount != null)
                                      Text(
                                        (widget.stock.cost! *
                                                widget.stock.amount!)
                                            .toStringAsFixed(2),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    if (widget.stock.amount == 0 ||
                                        widget.stock.amount == null)
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
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isSellDialog ? 'Sell price' : 'Buy price',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  children: [
                                    Image.asset('assets/mystocks.png'),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    const Text(
                                      '1',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
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
                                      widget.stock.cost!.toStringAsFixed(2),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: InkWell(
                      onTap: () {
                        if (isSellDialog) {
                          widget.callBackSell();
                        } else {
                          widget.callBackBuy();
                        }
                        timer!.cancel();
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 11, 0, 11),
                        decoration: BoxDecoration(
                            color: isSellDialog
                                ? Colors.black.withOpacity(0.06)
                                : const Color(0xFF9B51E0),
                            borderRadius: BorderRadius.circular(16)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (isSellDialog)
                                Image.asset(
                                  'assets/arrow-up.png',
                                  color: const Color(0xFF9B51E0),
                                ),
                              if (!isSellDialog)
                                Image.asset(
                                  'assets/arrow-down.png',
                                ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                isSellDialog ? 'Sell' : 'Buy',
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: isSellDialog
                                        ? const Color(0xFF9B51E0)
                                        : Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
