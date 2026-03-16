import 'gaun.dart';

class Penyewaan {
  final int? id;
  final String namaPenyewa;
  final String tanggalSewa;
  final String tanggalKembali;
  final int harga;
  final int idGaun;
  final Gaun? gaun;

  Penyewaan({
    this.id,
    required this.namaPenyewa,
    required this.tanggalSewa,
    required this.tanggalKembali,
    required this.harga,
    required this.idGaun,
    this.gaun,
  });

  factory Penyewaan.fromMap(Map<String, dynamic> map) {
    return Penyewaan(
      id: map['id'],
      namaPenyewa: map['nama_penyewa'],
      tanggalSewa: map['tanggal_sewa'],
      tanggalKembali: map['tanggal_kembali'],
      harga: map['harga'],
      idGaun: map['id_gaun'],
      gaun: map['Gaun'] != null ? Gaun.fromMap(map['Gaun']) : null,
    );
  }

  Map<String, dynamic> toMap() => {
    'nama_penyewa': namaPenyewa,
    'tanggal_sewa': tanggalSewa,
    'tanggal_kembali': tanggalKembali,
    'harga': harga,
    'id_gaun': idGaun,
  };
}
