class Destinasi {
  final String id;
  final String nama_destinasi;
  final String destinasi_id;
  final String images;
  final String deskripsi;
  final String lokasi;
  bool isFavorite;

  Destinasi({
    required this.id,
    required this.nama_destinasi,
    required this.destinasi_id,
    required this.images,
    required this.deskripsi,
    required this.lokasi,
    this.isFavorite = false,
  });

  factory Destinasi.fromJson(Map<String, dynamic> json) {
    return Destinasi(
      id: json['id'].toString(),
      nama_destinasi: json['nama_destinasi'].toString(),
      destinasi_id: json['destinasi_id'].toString(),
      images: json['images'].toString(),
      deskripsi: json['deskripsi'].toString(),
      lokasi: json['lokasi'].toString(),
    );
  }
}
