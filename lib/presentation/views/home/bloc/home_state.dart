// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  List<Place> places;
  List<Emotion> emotions;
  List<Activity> activities;
  
  HomeLoaded(
    this.places,
    this.emotions,
    this.activities,
  );
}

class HomeError extends HomeState {
  String message;
  HomeError(
    this.message,
  );

  @override 
  List<Object> get props => [message];
  
}

class BookingLoading extends HomeState {}



