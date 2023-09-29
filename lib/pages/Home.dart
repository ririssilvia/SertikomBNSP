import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mycashbook/helpers/db_provider.dart';
import 'package:mycashbook/pages/Detail_cash_flow.dart';
import 'package:mycashbook/pages/Pengaturan.dart';
import 'package:mycashbook/pages/Tambah_pemasukan.dart';
import 'package:mycashbook/pages/Tambah_pengeluaran.dart';
import 'package:mycashbook/widgets/Grid_container.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final currencyFormatter = NumberFormat('#,##0.00', 'ID');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rangkuman Bulan ini"),
        backgroundColor: Colors.purple, // Change the app bar color to purple
      ),
      body: SafeArea(
        child: Consumer<DBProvider>(builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Pemasukan: Rp " +
                        currencyFormatter.format(int.parse(
                            value.totalPengeluaran == "null"
                                ? "0"
                                : value.totalPengeluaran)),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    "Pengeluaran: Rp " +
                        currencyFormatter.format(int.parse(
                            value.totalPemasukan == "null"
                                ? "0"
                                : value.totalPemasukan)),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GridView.count(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      primary: false,
                      crossAxisCount: 2,
                      children: <Widget>[
                       Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.purple,
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TambahPemasukan()),
                              );
                            },
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  'assets/icons/income.png',
                                  height:
                                      150, // Ubah ukuran gambar sesuai dengan keinginan Anda
                                  fit: BoxFit
                                      .cover, // Sesuaikan bagaimana gambar ditampilkan
                                ),
                                Text(
                                  'Tambah Pemasukan',
                                  style: TextStyle(
                                    color: Colors
                                        .white, // Ubah warna teks menjadi putih
                                    fontSize:
                                        16, // Sesuaikan ukuran teks sesuai dengan keinginan Anda
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.purple,
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TambahPengeluaran()),
                              );
                            },
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  'assets/icons/outcome.png',
                                  height:
                                      150, // Ubah ukuran gambar sesuai dengan keinginan Anda
                                  fit: BoxFit
                                      .cover, // Sesuaikan bagaimana gambar ditampilkan
                                ),
                                Text(
                                  'Tambah Pengeluaran',
                                  style: TextStyle(
                                    color: Colors
                                        .white, // Ubah warna teks menjadi putih
                                    fontSize:
                                        15, // Sesuaikan ukuran teks sesuai dengan keinginan Anda
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.purple,
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailCashFlow()),
                              );
                            },
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  'assets/icons/file.png',
                                  height:
                                      130, // Ubah ukuran gambar sesuai dengan keinginan Anda
                                  fit: BoxFit
                                      .cover, // Sesuaikan bagaimana gambar ditampilkan
                                ),
                                Text(
                                  'Detail Cash Flow',
                                  style: TextStyle(
                                    color: Colors
                                        .white, // Ubah warna teks menjadi putih
                                    fontSize:
                                        16, // Sesuaikan ukuran teks sesuai dengan keinginan Anda
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.purple,
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Pengaturan()),
                              );
                            },
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  'assets/icons/settings.png',
                                  height:
                                      130, // Ubah ukuran gambar sesuai dengan keinginan Anda
                                  fit: BoxFit
                                      .cover, // Sesuaikan bagaimana gambar ditampilkan
                                ),
                                Text(
                                  'Pengaturan',
                                  style: TextStyle(
                                    color: Colors
                                        .white, // Ubah warna teks menjadi putih
                                    fontSize:
                                        16, // Sesuaikan ukuran teks sesuai dengan keinginan Anda
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                )

              ],
            ),
          );
        }),
      ),
    );
  }
}
