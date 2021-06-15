import 'package:flutter/material.dart';
import 'package:uas_safira/service/firestore_service.dart';
import 'package:uuid/uuid.dart';
import 'package:uas_safira/models/kategori.dart';
import 'package:uas_safira/sign_in.dart';

class KategoriProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _kategoriId;
  String _kode;
  String _nama;
  int _stok;
  int _ukuran;
  String _warna;
  String _userId;
  var uuid = Uuid();

  //Getters
  String get kode => _kode;
  String get nama => _nama;
  int get stok => _stok;
  int get ukuran => _ukuran;
  String get warna => _warna;

  //Setters
  changeKode(String value) {
    _kode = value;
    notifyListeners();
  }

  changeNama(String value) {
    _nama = value;
    notifyListeners();
  }

  changeStok(String value) {
    _stok = int.parse(value);
    notifyListeners();
  }

  changeUkuran(String value) {
    _ukuran = int.parse(value);
    notifyListeners();
  }

  changeWarna(String value) {
    _warna = value;
    notifyListeners();
  }

  changeUser() {
    _userId = uid;
    notifyListeners();
  }

  //read
  loadValues(String kategoriId, String kode, String nama, int stok, int ukuran,
      String warna) {
    _kategoriId = kategoriId;
    _kode = kode;
    _nama = nama;
    _stok = stok;
    _ukuran = ukuran;
    _warna = warna;
    _userId = uid;
  }

//create/update
  saveKategori(String a) {
    print(_kategoriId);
    if (a == "nol") {
      var newKategori = Kategori(
          kode: kode,
          nama: nama,
          stok: stok,
          ukuran: ukuran,
          warna: warna,
          userId: uid,
          kategoriId: uuid.v4());
      firestoreService.saveKategori(newKategori);
    } else {
      //Update
      var updatedKategori = Kategori(
          kode: _kode,
          nama: _nama,
          stok: _stok,
          ukuran: _ukuran,
          warna: _warna,
          userId: uid,
          kategoriId: _kategoriId);
      firestoreService.saveKategori(updatedKategori);
    }
  }

//delete
  removeKategori(String kategoriId) {
    firestoreService.removeKategori(kategoriId);
  }
}
