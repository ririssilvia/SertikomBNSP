import 'package:flutter/material.dart';
import 'package:mycashbook/pages/Home.dart';
import 'package:mycashbook/pages/Tambah_pemasukan.dart';
import 'package:mycashbook/pages/Tambah_pengeluaran.dart';

class GridCont extends StatelessWidget {
  final dynamic destination;
  final String imgUrl, featureName;
  const GridCont(
      {required this.destination,
      required this.imgUrl,
      required this.featureName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => destination)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.blue,
        ),
        padding: const EdgeInsets.all(8),
        child: Center(
            child: Column(
          children: [
            Spacer(),
            Image.asset(
              imgUrl,
              height: 80,
            ),
            Spacer(),
            Text(
              featureName,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            )
          ],
        )),
      ),
    );
  }
}
