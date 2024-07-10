
class EventsModel {
  List<Data>? data;

  EventsModel({this.data});

  EventsModel.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
  }

  static List<EventsModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => EventsModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Data {
  String? createdAt;
  String? title;
  String? description;
  String? status;
  String? startAt;
  int? duration;
  String? id;
  List<String>? images;

  Data({this.createdAt, this.title, this.description, this.status, this.startAt, this.duration, this.id, this.images});

  Data.fromJson(Map<String, dynamic> json) {
    createdAt = json["createdAt"];
    title = json["title"];
    description = json["description"];
    status = json["status"];
    startAt = json["startAt"];
    duration = json["duration"];
    id = json["id"];
    images = json["images"] == null ? null : List<String>.from(json["images"]);
  }

  static List<Data> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Data.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["createdAt"] = createdAt;
    _data["title"] = title;
    _data["description"] = description;
    _data["status"] = status;
    _data["startAt"] = startAt;
    _data["duration"] = duration;
    _data["id"] = id;
    if(images != null) {
      _data["images"] = images;
    }
    return _data;
  }
}