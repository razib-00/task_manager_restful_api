/// status : "success"
/// data : {"title":"My Task","description":"My Task","status":"New","email":"kazisirazib777@gmail.com","createdDate":"2025-01-22T18:46:22.147Z","_id":"67935cebf569705949e39d6b"}

class GetTaskListModel {
  String? status;
  List<GetTaskListDataModel>? getTaskListData;

  GetTaskListModel(this.status, this.getTaskListData);

  GetTaskListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null && json['data'] is List) {
      getTaskListData = <GetTaskListDataModel>[];
      for (var v in (json['data'] as List)) {
        getTaskListData!.add(GetTaskListDataModel.fromJson(v));
      }
    }
  }



  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (getTaskListData != null) {
      map['data'] = getTaskListData?.map((v)=>v.toJson()).toList();
    }
    return map;
  }

}

/// title : "My Task"
/// description : "My Task"
/// status : "New"
/// email : "kazisirazib777@gmail.com"
/// createdDate : "2025-01-22T18:46:22.147Z"
/// _id : "67935cebf569705949e39d6b"

class GetTaskListDataModel {
  String? title;
  String? description;
  String? status;
  String? email;
  String? createdDate;
  String? id;

  GetTaskListDataModel.fromJson(Map<String,dynamic> json) {
    title = json['title'];
    description = json['description'];
    status = json['status'];
    email = json['email'];
    createdDate = json['createdDate'];
    id = json['_id'];
  }
  

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    map['status'] = status;
    map['email'] = email;
    map['createdDate'] = createdDate;
    map['_id'] = id;
    return map;
  }

}