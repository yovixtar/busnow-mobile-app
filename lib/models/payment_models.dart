class DaftarPesananModel {
  String? id_pesanan;
  String? nama;
  String? keberangkatan;
  String? kelas;
  String? tanggal;
  String? metode_pembayaran;
  String? total;
  String? waktu_pesan;

  DaftarPesananModel({
    this.id_pesanan,
    this.nama,
    this.keberangkatan,
    this.kelas,
    this.tanggal,
    this.metode_pembayaran,
    this.total,
    this.waktu_pesan,
  });

  DaftarPesananModel.fromJson(Map<String, dynamic> json) {
    id_pesanan = json['id_pesanan'];
    nama = json['nama'];
    keberangkatan = json['keberangkatan'];
    kelas = json['kelas'];
    tanggal = json['tanggal'];
    metode_pembayaran = json['metode_pembayaran'];
    total = json['total'];
    waktu_pesan = json['waktu_pesan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_pesanan'] = this.id_pesanan;
    data['nama'] = this.nama;
    data['keberangkatan'] = this.keberangkatan;
    data['kelas'] = this.kelas;
    data['tanggal'] = this.tanggal;
    data['metode_pembayaran'] = this.metode_pembayaran;
    data['total'] = this.total;
    data['waktu_pesan'] = this.waktu_pesan;
    return data;
  }
}
