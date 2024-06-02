class AjukanInformasi {
  final String namatanaman;
  final String judul;
  final String isi;
  final String gambarTanaman;
  final String keterangan;
  final String informasi;
  final String? tahapan;
  final String? gejala;
  final String? rekomendasi;
  final String? penyebab;
  final String? tindakanpencegahan;

  AjukanInformasi({
    required this.namatanaman,
    required this.judul,
    required this.isi,
    required this.gambarTanaman,
    required this.keterangan,
    required this.informasi,
    this.tahapan,
    this.gejala,
    this.rekomendasi,
    this.penyebab,
    this.tindakanpencegahan,
  });

  factory AjukanInformasi.fromJson(Map<String, dynamic> json) {
    return AjukanInformasi(
      namatanaman: json['namatanaman'],
      judul: json['judul'],
      isi: json['isi'],
      gambarTanaman: json['gambar_tanaman'],
      keterangan: json['keterangan'],
      informasi: json['informasi'],
      tahapan: json['tahapan'],
      gejala: json['gejala'],
      rekomendasi: json['rekomendasi'],
      penyebab: json['penyebab'],
      tindakanpencegahan: json['tindakanpencegahan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'namatanaman': namatanaman,
      'judul': judul,
      'isi': isi,
      'gambar_tanaman': gambarTanaman,
      'keterangan': keterangan,
      'informasi': informasi,
      'tahapan': tahapan,
      'gejala': gejala,
      'rekomendasi': rekomendasi,
      'penyebab': penyebab,
      'tindakanpencegahan': tindakanpencegahan,
    };
  }
}
