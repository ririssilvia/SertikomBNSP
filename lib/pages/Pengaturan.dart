import 'package:flutter/material.dart';
import 'package:mycashbook/helpers/db_acc_provider.dart';
import 'package:mycashbook/model/Account.dart';
import 'package:provider/provider.dart';

class Pengaturan extends StatelessWidget {
  TextEditingController pass = new TextEditingController();
  TextEditingController newPass = new TextEditingController();
  bool isPasswordVisible = false; // Add this state variable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Pengaturan"),
        backgroundColor: Colors.purple,
        automaticallyImplyLeading: false,
      ),
      body: Consumer<AccProvider>(builder: (context, acc, _) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16,
              ),
              myTextField(context , "Password Saat ini", "cth: user", pass, isPasswordVisible),
              SizedBox(
                height: 16,
              ),
              myTextField(context, "Password Baru", "cth: user1", newPass,
                  isPasswordVisible),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      acc.checkPass(pass.text);
                      if (acc.isChecked) {
                        if (newPass.text.isNotEmpty) {
                          acc.changePass(pass.text, newPass.text);
                          SnackBar snackBar = SnackBar(
                              content: Text("Password berhasil diubah"));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          SnackBar snackBar = SnackBar(
                              content: Text("Isi kolom password baru"));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      } else {
                        SnackBar snackBar =
                            SnackBar(content: Text("Password lama salah"));
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
              ),
              Spacer(),
              Container(
                height: 120,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: FittedBox(
                          child: Image.asset("assets/icons/me.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "About this App",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        Text("Aplikasi ini dibuat oleh" +
                            "\nNama: Riris Silvia Zahri" +
                            "\nNIM: 2241727029" +
                            "\nTanggal: 28 September 2023"),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget myTextField(BuildContext context, String label, hint,
      TextEditingController controller, bool obscureText) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.purple, // Ubah warna border menjadi ungu
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(8) // Ubah warna latar belakang Container menjadi ungu
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
                color: Colors.purple,
                fontSize: 12), // Ubah warna teks label menjadi putih
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  controller: controller,
                  obscureText: obscureText, // Toggle password visibility
                  decoration: InputDecoration(
                    hintText: hint,
                    isDense: true,
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors
                            .purple, // Ubah warna border saat difokuskan menjadi putih
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors
                            .white, // Ubah warna border saat tidak difokuskan menjadi putih
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.purple, // Ubah warna ikon menjadi putih
                ),
                onPressed: () {
                  // Toggle password visibility when the icon button is pressed
                  isPasswordVisible = !isPasswordVisible;
                  // Ensure that the UI is updated
                  Provider.of<AccProvider>(context, listen: false)
                      .notifyListeners();
                },
              ),
            ],
          ),
        ],
      ),
    );

  }
}
