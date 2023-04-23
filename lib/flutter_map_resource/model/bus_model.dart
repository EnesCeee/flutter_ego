class BusModel {
  List<Data>? data;

  BusModel({this.data});

  BusModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  List<Table>? table;
  String? status;
  String? message;

  Data({this.table, this.status, this.message});

  Data.fromJson(Map<String, dynamic> json) {
     if (json['data'] != null) {
      
      table = <Table>[];
      json['table'].forEach((v) {
        table!.add(new Table.fromJson(v));
      });
    }
    if (json['table'] != null) {
      table = <Table>[];
      json['table'].forEach((v) {
        table!.add(new Table.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.table != null) {
      data['table'] = this.table!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class Table {
  String? aracNo;
  String? sure;
  String? detay;
  String? plakaNo;
  String? lat;
  String? lng;
  String? hiz;
  String? durakNo;
  String? oncekiDurakNo;
  String? hatNo;
  String? durakSiraNo;
  String? aci;
  String? doluluk;
  String? saniye;
  String? seciliDurakNo;
  String? seciliDurakSiraNo;
  String? yon;
  String? konum;

  Table(
      {this.aracNo,
      this.sure,
      this.detay,
      this.plakaNo,
      this.lat,
      this.lng,
      this.hiz,
      this.durakNo,
      this.oncekiDurakNo,
      this.hatNo,
      this.durakSiraNo,
      this.aci,
      this.doluluk,
      this.saniye,
      this.seciliDurakNo,
      this.seciliDurakSiraNo,
      this.yon,
      this.konum});

  Table.fromJson(Map<String, dynamic> json) {
    aracNo = json['arac_no'];
    sure = json['sure'];
    detay = json['detay'];
    plakaNo = json['plaka_no'];
    lat = json['lat'];
    lng = json['lng'];
    hiz = json['hiz'];
    durakNo = json['durak_no'];
    oncekiDurakNo = json['onceki_durak_no'];
    hatNo = json['hat_no'];
    durakSiraNo = json['durak_sira_no'];
    aci = json['aci'];
    doluluk = json['doluluk'];
    saniye = json['saniye'];
    seciliDurakNo = json['secili_durak_no'];
    seciliDurakSiraNo = json['secili_durak_sira_no'];
    yon = json['yon'];
    konum = json['konum'];
  }

  get busNo => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['arac_no'] = this.aracNo;
    data['sure'] = this.sure;
    data['detay'] = this.detay;
    data['plaka_no'] = this.plakaNo;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['hiz'] = this.hiz;
    data['durak_no'] = this.durakNo;
    data['onceki_durak_no'] = this.oncekiDurakNo;
    data['hat_no'] = this.hatNo;
    data['durak_sira_no'] = this.durakSiraNo;
    data['aci'] = this.aci;
    data['doluluk'] = this.doluluk;
    data['saniye'] = this.saniye;
    data['secili_durak_no'] = this.seciliDurakNo;
    data['secili_durak_sira_no'] = this.seciliDurakSiraNo;
    data['yon'] = this.yon;
    data['konum'] = this.konum;
    return data;
  }
}
