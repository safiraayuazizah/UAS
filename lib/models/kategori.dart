class Kategori {
  final String kategoriId;
  final String kode;
  final String nama;
  final int stok;
  final int ukuran;
  final String warna;
  final String userId;

  Kategori(
      {this.kategoriId,
      this.kode,
      this.nama,
      this.stok,
      this.ukuran,
      this.warna,
      this.userId});

  Map<String, dynamic> toMap() {
    return {
      'kategoriId': kategoriId,
      'kode': kode,
      'nama': nama,
      'stok': stok,
      'ukuran': ukuran,
      'warna': warna,
      'userId': userId
    };
  }

  Kategori.fromFirestore(Map<String, dynamic> firestore)
      : kategoriId = firestore['kategoriId'],
        kode = firestore['kode'],
        nama = firestore['nama'],
        stok = firestore['stok'],
        ukuran = firestore['ukuran'],
        warna = firestore['warna'],
        userId = firestore['userId'];
}
