import 'package:flutter/material.dart';
import 'package:uas_safira/service/firestore_service.dart';
import 'package:uuid/uuid.dart';
import 'package:uas_safira/models/kategori.dart';

class KategoriProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _kategoriId;
  String _kode;
  String _nama;
  int _stok;
  int _ukuran;
  String _warna;
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

  //read
  loadValues(Kategori kategori) {
    _kode = kategori.kode;
    _nama = kategori.nama;
    _stok = kategori.stok;
    _ukuran = kategori.ukuran;
    _warna = kategori.warna;
  }

//create/update
  saveKategori() {
    print(_kategoriId);
    if (_kategoriId == null) {
      var newKategori = Kategori(
          kode: kode,
          nama: nama,
          stok: stok,
          ukuran: ukuran,
          warna: warna,
          kategoriId: uuid.v4());
      firestoreService.saveKategori(newKategori);
    } else {
      //Update
      var updatedKategori = Kategori(
          kode: kode,
          nama: nama,
          stok: stok,
          ukuran: ukuran,
          warna: warna,
          kategoriId: _kategoriId);
      firestoreService.saveKategori(updatedKategori);
    }
  }

//delete
  removeKategori(String kategoriId) {
    firestoreService.removeKategori(kategoriId);
  }
}
