
class PasswordRecoverEmailModel {
  PasswordRecoverEmailModel({
      String? status, 
      RecoverEmailDataModel? data,}){
    _status = status;
    _data = data;
}

  PasswordRecoverEmailModel.fromJson(dynamic json) {
    _status = json['status'];
    _data = json['data'] != null ? RecoverEmailDataModel.fromJson(json['data']) : null;
  }
  String? _status;
  RecoverEmailDataModel? _data;

  String? get status => _status;
  RecoverEmailDataModel? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

class RecoverEmailDataModel {
  RecoverEmailDataModel({
      List<String>? accepted, 
      List<dynamic>? rejected, 
      List<String>? ehlo, 
      int? envelopeTime, 
      int? messageTime, 
      int? messageSize, 
      String? response, 
      Envelope? envelope, 
      String? messageId,}){
    _accepted = accepted;
    _rejected = rejected;
    _ehlo = ehlo;
    _envelopeTime = envelopeTime;
    _messageTime = messageTime;
    _messageSize = messageSize;
    _response = response;
    _envelope = envelope;
    _messageId = messageId;
}

  RecoverEmailDataModel.fromJson(dynamic json) {
    _accepted = json['accepted'] != null ? json['accepted'].cast<String>() : [];
    if (json['rejected'] != null) {
      _rejected = [];
      json['rejected'].forEach((v) {
        _rejected?.add(RejectedItem.fromJson(v)); // Replace `RejectedItem` with the actual class
      });
    }
    _ehlo = json['ehlo'] != null ? json['ehlo'].cast<String>() : [];
    _envelopeTime = json['envelopeTime'];
    _messageTime = json['messageTime'];
    _messageSize = json['messageSize'];
    _response = json['response'];
    _envelope = json['envelope'] != null ? Envelope.fromJson(json['envelope']) : null;
    _messageId = json['messageId'];
  }
  List<String>? _accepted;
  List<dynamic>? _rejected;
  List<String>? _ehlo;
  int? _envelopeTime;
  int? _messageTime;
  int? _messageSize;
  String? _response;
  Envelope? _envelope;
  String? _messageId;

  List<String>? get accepted => _accepted;
  List<dynamic>? get rejected => _rejected;
  List<String>? get ehlo => _ehlo;
  int? get envelopeTime => _envelopeTime;
  int? get messageTime => _messageTime;
  int? get messageSize => _messageSize;
  String? get response => _response;
  Envelope? get envelope => _envelope;
  String? get messageId => _messageId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accepted'] = _accepted;
    if (_rejected != null) {
      map['rejected'] = _rejected?.map((v) => v.toJson()).toList();
    }
    map['ehlo'] = _ehlo;
    map['envelopeTime'] = _envelopeTime;
    map['messageTime'] = _messageTime;
    map['messageSize'] = _messageSize;
    map['response'] = _response;
    if (_envelope != null) {
      map['envelope'] = _envelope?.toJson();
    }
    map['messageId'] = _messageId;
    return map;
  }

}

/// from : "info@teamrabbil.com"
/// to : ["kazisirazib777@gmail.com"]

class Envelope {
  Envelope({
      String? from, 
      List<String>? to,}){
    _from = from;
    _to = to;
}

  Envelope.fromJson(dynamic json) {
    _from = json['from'];
    _to = json['to'] != null ? json['to'].cast<String>() : [];
  }
  String? _from;
  List<String>? _to;

  String? get from => _from;
  List<String>? get to => _to;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['from'] = _from;
    map['to'] = _to;
    return map;
  }

}


class RejectedItem {
  RejectedItem.fromJson(dynamic json) {}

  Map<String, dynamic> toJson() {
    return {};
  }
}