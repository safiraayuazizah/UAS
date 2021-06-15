class Item {
  final String itemId;
  final String kode;
  final String merk;
  final String userId;

  Item({this.itemId, this.kode, this.merk, this.userId});

  Map<String, dynamic> toMap() {
    return {'itemId': itemId, 'kode': kode, 'merk': merk, 'userId': userId};
  }

  Item.fromFirestore(Map<String, dynamic> firestore)
      : itemId = firestore['itemId'],
        kode = firestore['kode'],
        merk = firestore['merk'],
        userId = firestore['userId'];
}
