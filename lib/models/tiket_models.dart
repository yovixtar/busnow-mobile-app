class DaftarTiketModel {
  String? id_tiket;
  String? nama_bus;
  String? kelas;
  String? tanggal_berangkat;
  String? jam_berangkat;
  String? jam_sampai;
  String? asal;
  String? tujuan;
  String? gambar_bis;
  String? kursi_tiket;
  String? tarif;

  DaftarTiketModel({
    this.id_tiket,
    this.nama_bus,
    this.kelas,
    this.tanggal_berangkat,
    this.jam_berangkat,
    this.jam_sampai,
    this.asal,
    this.tujuan,
    this.gambar_bis,
    this.kursi_tiket,
    this.tarif,
  });

  DaftarTiketModel.fromJson(Map<String, dynamic> json) {
    id_tiket = json['id_tiket'];
    nama_bus = json['nama_bus'];
    kelas = json['kelas'];
    tanggal_berangkat = json['tanggal_berangkat'];
    jam_berangkat = json['jam_berangkat'];
    jam_sampai = json['jam_sampai'];
    asal = json['asal'];
    tujuan = json['tujuan'];
    gambar_bis = json['gambar_bis'];
    kursi_tiket = json['kursi_tiket'];
    tarif = json['tarif'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id_tiket': id_tiket,
      'nama_bus': nama_bus,
      'kelas': kelas,
      'tanggal_berangkat': tanggal_berangkat,
      'jam_berangkat': jam_berangkat,
      'jam_sampai': jam_sampai,
      'asal': asal,
      'tujuan': tujuan,
      'gambar_bis': gambar_bis,
      'kursi_tiket': kursi_tiket,
      'tarif': tarif,
    };
  }
}
