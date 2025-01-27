/// status : "success"
/// data : {"acknowledged":true,"modifiedCount":0,"upsertedId":null,"upsertedCount":0,"matchedCount":1}

class RecoverResetPass {
  RecoverResetPass({
      String? status, 
      Data? data,}){
    _status = status;
    _data = data;
}

  RecoverResetPass.fromJson(dynamic json) {
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _status;
  Data? _data;

  String? get status => _status;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// acknowledged : true
/// modifiedCount : 0
/// upsertedId : null
/// upsertedCount : 0
/// matchedCount : 1

class Data {
  Data({
      bool? acknowledged, 
      int? modifiedCount, 
      dynamic upsertedId, 
      int? upsertedCount, 
      int? matchedCount,}){
    _acknowledged = acknowledged;
    _modifiedCount = modifiedCount;
    _upsertedId = upsertedId;
    _upsertedCount = upsertedCount;
    _matchedCount = matchedCount;
}

  Data.fromJson(dynamic json) {
    _acknowledged = json['acknowledged'];
    _modifiedCount = json['modifiedCount'];
    _upsertedId = json['upsertedId'];
    _upsertedCount = json['upsertedCount'];
    _matchedCount = json['matchedCount'];
  }
  bool? _acknowledged;
  int? _modifiedCount;
  dynamic _upsertedId;
  int? _upsertedCount;
  int? _matchedCount;

  bool? get acknowledged => _acknowledged;
  int? get modifiedCount => _modifiedCount;
  dynamic get upsertedId => _upsertedId;
  int? get upsertedCount => _upsertedCount;
  int? get matchedCount => _matchedCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['acknowledged'] = _acknowledged;
    map['modifiedCount'] = _modifiedCount;
    map['upsertedId'] = _upsertedId;
    map['upsertedCount'] = _upsertedCount;
    map['matchedCount'] = _matchedCount;
    return map;
  }

}