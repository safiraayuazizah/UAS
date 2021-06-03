import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uas_safira/models/item.dart';
import 'package:uas_safira/models/kategori.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  //item
  Future<void> saveItem(Item item) {
    return _db.collection('items').doc(item.itemId).set(item.toMap());
  }

  Stream<List<Item>> getItems() {
    return _db.collection('items').snapshots().map((snapshot) => snapshot.docs
        .map((document) => Item.fromFirestore(document.data()))
        .toList());
  }

  Future<void> removeItem(String itemId) {
    return _db.collection('items').doc(itemId).delete();
  }

  //kategori
  Future<void> saveKategori(Kategori kategori) {
    return _db
        .collection('kategoris')
        .doc(kategori.kategoriId)
        .set(kategori.toMap());
  }

  Stream<List<Kategori>> getKategoris() {
    return _db.collection('kategoris').snapshots().map((snapshot) => snapshot
        .docs
        .map((document) => Kategori.fromFirestore(document.data()))
        .toList());
  }

  Future<void> removeKategori(String kategoriId) {
    return _db.collection('kategoris').doc(kategoriId).delete();
  }
}
