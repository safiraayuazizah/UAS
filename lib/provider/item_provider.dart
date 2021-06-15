import 'package:flutter/material.dart';
import 'package:uas_safira/service/firestore_service.dart';
import 'package:uuid/uuid.dart';
import 'package:uas_safira/models/item.dart';
import 'package:uas_safira/sign_in.dart';

class ItemProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _itemId;
  String _kode;
  String _merk;
  String _userId;
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

  changeUser() {
    _userId = uid;
    notifyListeners();
  }

  //read
  loadValues(String itemId, String kode, String merk) {
    _itemId = itemId;
    _kode = kode;
    _merk = merk;
  }

//create/update
  saveItem(String a) {
    print(_itemId);
    if (a == "nol") {
      var newItem =
          Item(kode: kode, merk: merk, userId: uid, itemId: uuid.v4());
      firestoreService.saveItem(newItem);
    } else {
      //Update
      var updatedItem =
          Item(kode: _kode, merk: _merk, userId: uid, itemId: _itemId);
      firestoreService.saveItem(updatedItem);
    }
  }

//delete
  removeItem(String itemId) {
    firestoreService.removeItem(itemId);
  }
}
