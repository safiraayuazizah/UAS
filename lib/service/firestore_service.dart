import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uas_safira/models/item.dart';
import 'package:uas_safira/models/kategori.dart';
import 'package:uas_safira/sign_in.dart';

class FirestoreService {
  CollectionReference _dbitem = FirebaseFirestore.instance.collection('items');
  CollectionReference _dbkategori =
      FirebaseFirestore.instance.collection('kategoris');

  //item
  Future<void> saveItem(Item item) {
    return _dbitem.doc(item.itemId).set(item.toMap());
  }

  Stream<List<Item>> getItems() {
    return _dbitem.where('userId', isEqualTo: uid).snapshots().map((snapshot) =>
        snapshot.docs
            .map((document) => Item.fromFirestore(document.data()))
            .toList());
  }

  Future<void> removeItem(String itemId) {
    return _dbitem.doc(itemId).delete();
  }

  //kategori
  Future<void> saveKategori(Kategori kategori) {
    return _dbkategori.doc(kategori.kategoriId).set(kategori.toMap());
  }

  Stream<List<Kategori>> getKategoris() {
    return _dbkategori.where('userId', isEqualTo: uid).snapshots().map(
        (snapshot) => snapshot.docs
            .map((document) => Kategori.fromFirestore(document.data()))
            .toList());
  }

  Future<void> removeKategori(String kategoriId) {
    return _dbkategori.doc(kategoriId).delete();
  }
}
