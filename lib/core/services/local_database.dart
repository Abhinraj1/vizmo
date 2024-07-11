import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vizmo/core/model/event_model.dart';

class LocalDatabaseService {
  final box = GetStorage();

  Future<EventsModel?> getData() async {
    final data = box.read('data');
    return data!=null? EventsModel.fromJson(data) : null;
  }

  setData({required Map modelData}) async {
    try{
      box.write('data', modelData);
  }catch(e){
      if (kDebugMode) {
        print("ERROR saving data======$e");
      }
    }
  }
}
