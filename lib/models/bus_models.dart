class DaftarBusModel {
  String? id_bus;
  String? kursi;
  String? asal;
  String? tujuan;
  String? nama;
  String? gambar;

  DaftarBusModel({
    this.id_bus,
    this.kursi,
    this.asal,
    this.tujuan,
    this.nama,
    this.gambar,
  });

  DaftarBusModel.fromJson(Map<String, dynamic> json) {
    id_bus = json['id_bus'];
    kursi = json['kursi'];
    asal = json['asal'];
    tujuan = json['tujuan'];
    nama = json['nama'];
    gambar = json['gambar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_bus'] = this.id_bus;
    data['kursi'] = this.kursi;
    data['asal'] = this.asal;
    data['tujuan'] = this.tujuan;
    data['nama'] = this.nama;
    data['gambar'] = this.gambar;
    return data;
  }
}
