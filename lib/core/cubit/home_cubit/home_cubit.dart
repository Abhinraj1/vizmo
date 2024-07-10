import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vizmo/core/model/event_model.dart';
import 'package:vizmo/core/services/local_database.dart';

import '../../repository/main_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final MainRepo repo;

  HomeCubit({required this.repo}) : super(HomeInitial());
LocalDatabaseService databaseService = LocalDatabaseService();
  getData() async{
    EventsModel? eventsModel;
    emit(HomeLoading());
    final events = await databaseService.getData();
    final hasData = events?.data?.isNotEmpty ?? false;
    if(!hasData){
     eventsModel =  await repo.fetchEvents();
    }
    if(eventsModel != null){
       databaseService.setData(modelData: eventsModel.toJson());
    }
    hasData ? eventsModel = events : null;
    emit(HomeLoaded(events: eventsModel?.data ?? []));
  }
}
