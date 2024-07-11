import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meta/meta.dart';
import 'package:vizmo/core/model/event_model.dart';
import 'package:vizmo/core/services/local_database.dart';

import '../../../widgets/custom/custom_snackbar.dart';
import '../../repository/main_repo.dart';

part 'event_details_state.dart';



class EventDetailsCubit extends Cubit<EventDetailsState> {


  EventDetailsCubit() : super(EventDetailsInitial());
LocalDatabaseService databaseService = LocalDatabaseService();



  showDetails({required String id}) async{
    emit(EventDetailsLoading());
   final data = await databaseService.getData();
   Get.toNamed("/event_details_screen");
   Data eventData = Data();
   data?.data?.forEach((element) {
     if(element.id!.contains(id)){
       eventData = element;
     }
   },);
    emit(EventDetailsLoaded(data: eventData));
  }

  editData({required Data updatedData}) async{
    emit(EventDetailsLoading());
    final data = await databaseService.getData();
   int? index = data?.data?.indexWhere((element) {
      return element.id!.contains(updatedData.id.toString());
    },);
   if(index != null){
     data?.data?[index] = updatedData;
   }

    databaseService.setData(modelData: data?.toJson() ?? {});
    customSnackBar(message: "Edited Successfully");
    emit(EventDetailsLoaded(data: updatedData));
  }

  deleteData({required String id}) async{
    emit(EventDetailsLoading());

    final data = await databaseService.getData();
    data?.data?.removeWhere((element) {
     return element.id!.contains(id);
    },);

    databaseService.setData(modelData: data?.toJson() ?? {});
    Get.back();
    customSnackBar(message: "Deleted Successfully");
  }
}
