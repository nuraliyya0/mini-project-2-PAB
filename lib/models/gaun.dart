class Gaun {
  final int idGaun;
  final String nama;
  final String ukuran;
  final int harga;

  Gaun({
    required this.idGaun,
    required this.nama,
    required this.ukuran,
    required this.harga,
  });

  factory Gaun.fromMap(Map<String, dynamic> map) {
    return Gaun(
      idGaun: map['id_gaun'],
      nama: map['nama'],
      ukuran: map['ukuran'],
      harga: map['harga'],
    );
  }
}
