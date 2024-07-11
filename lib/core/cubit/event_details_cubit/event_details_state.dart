part of 'event_details_cubit.dart';

@immutable
sealed class EventDetailsState {}

final class EventDetailsInitial extends EventDetailsState {}

class EventDetailsLoading extends EventDetailsState {}


class EventDetailsLoaded extends EventDetailsState {
  final Data data;
  EventDetailsLoaded({required this.data});
}


