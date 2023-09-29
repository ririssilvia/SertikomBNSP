import 'package:flutter/material.dart';
import 'package:mycashbook/helpers/db_provider.dart';
import 'package:mycashbook/model/Cash.dart';
import 'package:mycashbook/widgets/Cash_flow_tile.dart';
import 'package:provider/provider.dart';

class DetailCashFlow extends StatelessWidget {
  Cash cash = Cash(
      id: "01",
      nominal: 2000,
      keterangan: "Beli",
      date: DateTime.now().toString(),
      isAdd: true);
  Cash cash2 = Cash(
      id: "02",
      nominal: 2000,
      keterangan: "Beli",
      date: DateTime.now().toString(),
      isAdd: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detail Cash Flow"),
           backgroundColor: Colors.purple,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 8,
              ),
              Consumer<DBProvider>(
                builder: (context, value, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.cashes.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CashFlowTile(cash: value.cashes[index]);
                    },
                  );
                },
              ),
              SizedBox(
                height: 16,
              )
            ],
          ),
        ));
  }
}
