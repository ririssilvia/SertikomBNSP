import 'package:flutter/material.dart';
import 'package:mycashbook/helpers/db_provider.dart';
import 'package:mycashbook/model/Cash.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class TambahPengeluaran extends StatefulWidget {
  const TambahPengeluaran({Key? key}) : super(key: key);

  @override
  State<TambahPengeluaran> createState() => _TambahPemasukanState();
}

class _TambahPemasukanState extends State<TambahPengeluaran> {
  DateTime date = DateTime.now();

  TextEditingController nominal = new TextEditingController(text: "");
  TextEditingController keterangan = new TextEditingController(text: "");
  String temp = "";

  @override
  Widget build(BuildContext context) {
    temp = '${date.day}/${date.month}/${date.year}';
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Pengeluaran"),
        backgroundColor: Colors.purple,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  children: [
                    Text('${date.day}/${date.month}/${date.year}'),
                    Spacer(),
                    ElevatedButton(
                        onPressed: () async {
                          DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: date,
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100));
                          if (newDate == null) return;
                          setState(() {
                            date = newDate;
                            temp = "${date.day}/${date.month}/${date.year}";
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors
                              .purple, // Atur warna latar belakang tombol menjadi ungu
                        ),
                        child: Text("pick date")),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              myTextField(context, "Nominal", "cth: 10000", nominal, true),
              SizedBox(
                height: 16,
              ),
              myTextField(context, "Keterangan", "cth: Beli Makan",
                  keterangan, false),
              SizedBox(
                height: 32,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      if (nominal.text != "") {
                        final cash = Cash(
                            id: Uuid().v1().toString(),
                            nominal: int.parse(nominal.text),
                            keterangan: keterangan.text,
                            date: temp,
                            isAdd: false);
                        print(cash.isAdd);
                        Provider.of<DBProvider>(context, listen: false)
                            .addCash(cash);
                        print(cash);
                        final snackBar = SnackBar(
                            content: Text("Pengeluaran anda sudah tercatat"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        final snackBar = SnackBar(
                            content: Text("Isi nominalnya terlebih dahulu"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors
                          .purple, // Atur warna latar belakang tombol menjadi ungu
                    ),
                    child: Text("Simpan")),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors
                          .purple, // Atur warna latar belakang tombol menjadi ungu
                    ),
                    child: Text("Kembali")),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget myTextField(BuildContext context, String label, hint,
      TextEditingController controller, bool isNumber) {
    return Container(
  width: double.infinity,
  decoration: BoxDecoration(
    border: Border.all(
      width: 1,
      color: Colors.purple, // Ubah warna border menjadi ungu
      style: BorderStyle.solid,
    ),
    borderRadius: BorderRadius.circular(8), // Ubah warna latar belakang form menjadi ungu
  ),
  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(color: Colors.purple, fontSize: 12), // Ubah warna label menjadi putih
      ),
      TextField(
        style: TextStyle(fontWeight: FontWeight.bold),
        keyboardType: isNumber ? TextInputType.number : null,
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          isDense: true,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.purple, // Ubah warna border saat difokuskan menjadi putih
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white, // Ubah warna border saat tidak difokuskan menjadi putih
              width: 1.0,
            ),
          ),
          labelStyle: TextStyle(
            color: Colors.white, // Ubah warna label saat difokuskan menjadi putih
          ),
        ),
      ),
    ],
  ),
);

  }
}
