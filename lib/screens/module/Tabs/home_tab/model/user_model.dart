import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? userId;
  String? privateKey;
  String? ipName;
  String? ipPwd;
  String? port;
  String? publicIP;
  String? clientcode;
  String? password;
  String? secretKey;
  String? username;
  String jwtToken ="";
  String? PNL;
  String? positionPNL;
  String? currentBalance;
  String? userLotSize;
  bool  ischecked = false;
  UserModel(
      {this.privateKey,
        this.userId ="",
        this.clientcode,
        this.ipName,
        this.ipPwd,
        this.port,
        this.publicIP,
        this.password,
        this.secretKey,
        this.username,
        this.jwtToken ="",
        this.PNL,
        this.currentBalance,
        this.positionPNL,
        this.userLotSize,
        this.ischecked = false,
      });

  UserModel.fromJson(Map<String, dynamic> json) {
    privateKey = json['PrivateKey'];
    clientcode = json['clientcode'];
    password = json['password'];
    secretKey = json['secretKey'];
    username = json['username'];
    jwtToken = json['jwtToken'] ?? "";
    PNL = json['PNL'];
    currentBalance = json['currentBalance'];
    userLotSize = json['lotsize'];
    ipName = json['ipName'];
    ipPwd = json['ipPwd'];
    port = json['port'];
    publicIP = json['publicIP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PrivateKey'] = this.privateKey;
    data['clientcode'] = this.clientcode;
    data['password'] = this.password;
    data['secretKey'] = this.secretKey;
    data['username'] = this.username;
    data['jwtToken'] = this.jwtToken;
    data['PNL'] = this.PNL;
    data['lotsize'] = this.userLotSize;
    data['currentBalance'] = this.currentBalance;
    data['ipName'] = this.ipName;
    data['ipPwd'] = this.ipPwd;
    data['port'] = this.port;
    data['publicIP'] = this.publicIP;
    return data;
  }

  // Map Firestore document → UserModel
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    print("id=> ${doc.id}");
    return UserModel(
      jwtToken: d['jwtToken']  ?? '',
      currentBalance: d['currentBalance']  ?? '',
      positionPNL:  d['positionPNL']  ?? '',
      userId:      doc.id,
      username:    d['username']  ?? '',
      password:    d['password']  ?? '',
      clientcode: d['clientCode'] ?? '',
      privateKey: d['privateKey'] ?? '',
      secretKey: d['secretKey'] ?? '',
      ipName: d['ipName'] ?? '',
      ipPwd: d['ipPassword'] ?? '',
      port: d['port'] ?? '',
      publicIP: d['publicIP'] ?? '',
    );
  }
}