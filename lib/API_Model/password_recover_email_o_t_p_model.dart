class PasswordRecoverEmailOTPModel {
  PasswordRecoverEmailOTPModel({
    String? status,
    dynamic data, // Use dynamic to handle both String and PasswordRecoverEmailOTP types
  }) {
    _status = status;
    _data = data;
  }

  PasswordRecoverEmailOTPModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] is Map<String, dynamic>) {
      _data = PasswordRecoverEmailOTP.fromJson(json['data']);
    } else {
      _data = json['data']; // Assign as String directly
    }
  }

  String? _status;
  dynamic _data; // This can now hold either a String or PasswordRecoverEmailOTP

  String? get status => _status;
  dynamic get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data is PasswordRecoverEmailOTP) {
      map['data'] = (_data as PasswordRecoverEmailOTP).toJson();
    } else {
      map['data'] = _data; // Store as String directly
    }
    return map;
  }
}

class PasswordRecoverEmailOTP {
  PasswordRecoverEmailOTP({
    bool? acknowledged,
    int? modifiedCount,
    dynamic upsertedId,
    int? upsertedCount,
    int? matchedCount,
  }) {
    _acknowledged = acknowledged;
    _modifiedCount = modifiedCount;
    _upsertedId = upsertedId;
    _upsertedCount = upsertedCount;
    _matchedCount = matchedCount;
  }

  PasswordRecoverEmailOTP.fromJson(dynamic json) {
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
