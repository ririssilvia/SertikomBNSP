import 'package:flutter/material.dart';
import 'package:mycashbook/helpers/db_acc_provider.dart';
import 'package:mycashbook/pages/Home.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthPage extends StatefulWidget {
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController username = TextEditingController(text: "user");
  TextEditingController pass = TextEditingController(text: "user");
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Consumer<AccProvider>(builder: (context, acc, _) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/login.svg',
                    alignment: Alignment.center, // Set alignment
                    width: 300,
                    height: 300,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Riris Cashbook V 1.0",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Color.fromARGB(255, 54, 60, 65)),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  myTextField(context, "Username", "", false, username),
                  SizedBox(
                    height: 24,
                  ),
                  myTextField(context, "Password", "", true, pass),
                  SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        backgroundColor:
                            Colors.purple, // Set the button background color
                      ),
                      onPressed: () async {
                        await acc.checkPass(pass.text);
                        if (acc.isChecked) {
                          if (username.text != "user") {
                            SnackBar snackBar = SnackBar(
                              content: Text("Username tidak ditemukan"),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => HomePage()));
                          }
                        } else {
                          SnackBar snackBar = SnackBar(
                            content: Text("Password salah"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  )

                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget myTextField(
    BuildContext context,
    String label,
    String hint,
    bool isPassword,
    TextEditingController controller,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.purple, // Set the border color to purple
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.purple, // Set the label color to purple
              fontSize: 12,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  controller: controller,
                  obscureText: isPassword && !isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: hint,
                    isDense: true,
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors
                            .purple, // Set the focused border color to purple
                      ),
                    ),
                  ),
                ),
              ),
              if (isPassword) // Only show the visibility icon for password field
                IconButton(
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.purple, // Set the icon color to purple
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
