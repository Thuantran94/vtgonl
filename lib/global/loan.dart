class MLoan {
  String shd;
  String trangthai;
  String name, phone, email;
  String sotien;
  String thoihan;
  String sotientramoithang;
  String sotienconno;
  String laisuatconno;
  String phidichvu;
  String phiquahan;
  String songayquahan;
  String tongsothangdatra;

  String mucdich;
  String kehoachtra;

  String ghichu;

  String ngaytao;
  String ngayvay;
  String ngayketthuc;
  String ngaytratieptheo;

  String facebook;
  double lat;
  double lng;

  MLoan(
      {this.shd,
      this.trangthai,
      this.name,
      this.phone,
      this.email,
      this.sotien,
      this.thoihan,
      this.sotientramoithang,
      this.mucdich,
      this.kehoachtra,
      this.facebook,
      this.ghichu,
      this.lat,
      this.lng,
      this.ngaytao});

  factory MLoan.fromJson(Map<dynamic, dynamic> parsedJson) {
    return MLoan(
        shd: parsedJson['SHD'],
        trangthai: parsedJson['STATUS'],
        name: parsedJson['name'],
        phone: parsedJson['phone'],
        email: parsedJson['email'],
        sotien: parsedJson['sotien'],
        thoihan: parsedJson['thoihan'],
        sotientramoithang: parsedJson['sotientramoithang'],
        mucdich: parsedJson['mucdich'],
        kehoachtra: parsedJson['kehoachtra'],
        facebook: parsedJson['facebook'],
        ghichu: parsedJson['note'],
        lat: parsedJson['lat'],
        lng: parsedJson['lng'],
        ngaytao: parsedJson['ngaytao']);
  }
}
