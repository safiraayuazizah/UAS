import 'package:flutter/material.dart';
import 'package:uas_safira/service/firestore_service.dart';
import 'package:uuid/uuid.dart';
import 'package:uas_safira/models/item.dart';

class ItemProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _itemId;
  String _kode;
  String _merk;
  var uuid = Uuid();

  //Getters
  String get kode => _kode;
  String get merk => _merk;

  //Setters
  changeKode(String value) {
    _kode = value;
    notifyListeners();
  }

  changeMerk(String value) {
    _merk = value;
    notifyListeners();
  }

  //read
  loadValues(Item item) {
    _itemId = item.itemId;
    _kode = item.kode;
    _merk = item.merk;
  }

//create/update
  saveItem() {
    print(_itemId);
    if (_itemId == null) {
      var newItem = Item(kode: kode, merk: merk, itemId: uuid.v4());
      firestoreService.saveItem(newItem);
    } else {
      //Update
      var updatedItem = Item(kode: _kode, merk: _merk, itemId: _itemId);
      firestoreService.saveItem(updatedItem);
    }
  }

//delete
  removeItem(String itemId) {
    firestoreService.removeItem(itemId);
  }
}
