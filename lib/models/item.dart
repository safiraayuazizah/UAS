class Item {
  final String itemId;
  final String kode;
  final String merk;

  Item({this.itemId, this.kode, this.merk});

  Map<String, dynamic> toMap() {
    return {'itemId': itemId, 'kode': kode, 'merk': merk};
  }

  Item.fromFirestore(Map<String, dynamic> firestore)
      : itemId = firestore['itemId'],
        kode = firestore['kode'],
        merk = firestore['merk'];
}
