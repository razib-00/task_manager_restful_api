/// status : "success"
/// data : [{"_id":"New","sum":9}]

class TaskStatusCountModel {
  TaskStatusCountModel({
      String? status, 
      List<TaskStatusDataCount>? data,}){
    _status = status;
    _data = data;
}

  TaskStatusCountModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TaskStatusDataCount.fromJson(v));
      });
    }
  }
  String? _status;
  List<TaskStatusDataCount>? _data;

  String? get status => _status;
  List<TaskStatusDataCount>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "New"
/// sum : 9

class TaskStatusDataCount {
  TaskStatusDataCount({
      String? id, 
      int? sum,}){
    _id = id;
    _sum = sum;
}

  TaskStatusDataCount.fromJson(dynamic json) {
    _id = json['_id'];
    _sum = json['sum'];
  }
  String? _id;
  int? _sum;

  String? get id => _id;
  int? get sum => _sum;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['sum'] = _sum;
    return map;
  }

}