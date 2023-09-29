import 'package:flutter/cupertino.dart';
import 'package:mycashbook/helpers/db.dart';
import 'package:mycashbook/model/Cash.dart';

class DBProvider extends ChangeNotifier {
  List<Cash> _cashes = [];
  String _totalPemasukan = "0";
  String _totalPengeluaran = "0";
  late DatabaseHelper _databaseHelper;

  List<Cash> get cashes => _cashes;
  String get totalPemasukan => _totalPemasukan;
  String get totalPengeluaran => _totalPengeluaran;

  DBProvider() {
    _databaseHelper = DatabaseHelper();
    _getAllCash();
    _getTotalCash();
  }
  void _getAllCash() async {
    _cashes = await _databaseHelper.getCash();
    notifyListeners();
  }

  Future<void> addCash(Cash cash) async {
    await _databaseHelper.insertCash(cash);
    _getAllCash();
    _getTotalCash();
  }

  void _getTotalCash() async {
    _totalPemasukan = await _databaseHelper.getTotalPemasukan();
    _totalPengeluaran = await _databaseHelper.getTotalPengeluaran();
    notifyListeners();
  }
}
