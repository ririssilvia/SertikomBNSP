import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mycashbook/constants/color.dart';
import 'package:mycashbook/model/Cash.dart';

class CashFlowTile extends StatelessWidget {
  final Cash cash;
  CashFlowTile({required this.cash});
  final currencyFormatter = NumberFormat('#,##0.00', 'ID');

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border(),
          color: (cash.isAdd ?? false) ? lSuccess : lError),
      width: double.infinity,
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Rp " + currencyFormatter.format(cash.nominal),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Icon(
                    (cash.isAdd ?? false)
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
                    color: (cash.isAdd ?? false) ? success : error,
                  ),
                ],
              ),
              Text(cash.keterangan!),
              Text(cash.date!)
            ],
          ),
          Icon(
            cash.isAdd! ? Icons.arrow_back : Icons.arrow_forward,
            color: cash.isAdd! ? success : error,
            size: 40,
          )
        ],
      ),
    );
  }
}
