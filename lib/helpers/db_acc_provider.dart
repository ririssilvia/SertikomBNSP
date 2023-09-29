import 'package:flutter/cupertino.dart';
import 'package:mycashbook/helpers/db.dart';
import 'package:mycashbook/model/Account.dart';
import 'package:uuid/uuid.dart';

class AccProvider extends ChangeNotifier {
  bool _isChecked = false;
  late DatabaseHelper _databaseHelper;

  bool get isChecked => _isChecked;
  AccProvider() {
    _databaseHelper = DatabaseHelper();
    _initPass();
  }
  Future<void> checkPass(String pass) async {
    _isChecked = await _databaseHelper.getPassword(pass);
    print(_isChecked);
    notifyListeners();
  }

  void changePass(String newPassword, String oldPassword) {
    _databaseHelper.updatePassword(newPassword, oldPassword);
    notifyListeners();
  }

  Future<void> _createPass() async {
    _databaseHelper.createPassword(
        Account(id: const Uuid().v1().toString(), password: "user"));
    notifyListeners();
  }

  Future<void> _initPass() async {
    var allPass = await _databaseHelper.getAllPassword();
    if (allPass.isEmpty) {
      _createPass();
    }
  }
}
