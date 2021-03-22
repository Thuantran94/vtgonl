import 'dart:io';

import 'package:vtgonl/global/loan.dart';

import 'noti.dart';

class MUser {
  String active;
  String name;
  String phone;
  String email;
  String id;
  String birthday;
  String gender;
  String status;
  String province;
  String village;
  String address;
  String lifetime;

  String bankName;
  String bankUser;
  String bankNumber;
  String bankAddress;

  String edu;
  String job;
  String salary;
  String companyName;
  String companyAddress;
  String companyPhone;

  String relationName1;
  String relationRela1;
  String relationPhone1;
  String relationName2;
  String relationRela2;
  String relationPhone2;
  String facebook;

  String deviceinfo;
  String ip;

  String lat;
  String lng;

  String linkAVATAR;
  String linkCMND1;
  String linkCMND2;
  String linkSIM;
  String linkHDLD;
  String linkSAOKE1;
  String linkSAOKE2;
  String linkSAOKE3;
  String listCONTACT;
  String listSMS;
  String listCALL;

  File imageAVATAR;
  File imageCMND1;
  File imageCMND2;
  File imageSIM;
  File imageHDLD;
  File imageSAOKE1;
  File imageSAOKE2;
  File imageSAOKE3;

  String oncreated;

  List<Noti> _notis = List<Noti>();

  List<MLoan> _loans = List<MLoan>();

  MUser(
      {this.active,
      this.name,
      this.phone,
      this.email,
      this.id,
      this.birthday,
      this.gender,
      this.status,
      this.province,
      this.village,
      this.address,
      this.lifetime,
      this.bankName,
      this.bankUser,
      this.bankNumber,
      this.bankAddress,
      this.edu,
      this.job,
      this.salary,
      this.companyName,
      this.companyAddress,
      this.companyPhone,
      this.relationName1,
      this.relationRela1,
      this.relationPhone1,
      this.relationName2,
      this.relationRela2,
      this.relationPhone2,
      this.facebook,
      this.linkAVATAR,
      this.linkSIM,
      this.linkCMND1,
      this.linkCMND2,
      this.linkHDLD,
      this.linkSAOKE1,
      this.linkSAOKE2,
      this.linkSAOKE3,
      this.listCONTACT,
      this.listCALL,
      this.listSMS,
      this.lat,
      this.lng,
      this.deviceinfo,
      this.ip,
      this.oncreated});

  factory MUser.fromJson(Map<dynamic, dynamic> parsedJson) {
    return MUser(
        active: parsedJson['ACTIVE'],
        name: parsedJson['name'],
        phone: parsedJson['phone'],
        email: parsedJson['email'],
        id: parsedJson['id'],
        birthday: parsedJson['birthday'],
        gender: parsedJson['gender'],
        status: parsedJson['status'],
        province: parsedJson['province'],
        village: parsedJson['village'],
        address: parsedJson['address'],
        lifetime: parsedJson['lifeTime'],
        bankName: parsedJson['bankName'],
        bankUser: parsedJson['bankUser'],
        bankNumber: parsedJson['bankNumber'],
        bankAddress: parsedJson['bankAddress'],
        edu: parsedJson['edu'],
        job: parsedJson['job'],
        salary: parsedJson['salary'],
        companyName: parsedJson['companyName'],
        companyAddress: parsedJson['companyAddress'],
        companyPhone: parsedJson['companyPhone'],
        relationName1: parsedJson['relationName1'],
        relationPhone1: parsedJson['relationPhone1'],
        relationRela1: parsedJson['relationRela1'],
        relationName2: parsedJson['relationName2'],
        relationPhone2: parsedJson['relationPhone2'],
        relationRela2: parsedJson['relationRela2'],
        facebook: parsedJson['facebook'],
        linkAVATAR: parsedJson['linkAVATAR'],
        linkSIM: parsedJson['linkSIM'],
        linkCMND1: parsedJson['linkCMND1'],
        linkCMND2: parsedJson['linkCMND2'],
        linkHDLD: parsedJson['linkHDLD'],
        linkSAOKE1: parsedJson['linkSAOKE1'],
        linkSAOKE2: parsedJson['linkSAOKE2'],
        linkSAOKE3: parsedJson['linkSAOKE3'],
        listCONTACT: parsedJson['listCONTACT'],
        listSMS: parsedJson['listSMS'],
        listCALL: parsedJson['listCALL'],
        lat: parsedJson['lat'],
        lng: parsedJson['lng'],
        deviceinfo: parsedJson['deviceinfo'],
        ip: parsedJson['ip'],
        oncreated: parsedJson['onCreated']);
  }

  List<Noti> get notis => _notis;
  List<MLoan> get loans => _loans;

  set notis(List<Noti> value) {
    this._notis = value;
  }

  set loans(List<MLoan> value) {
    this._loans = value;
  }
}
