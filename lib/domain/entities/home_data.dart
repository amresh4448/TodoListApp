// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:todo_list_app/domain/entities/activity.dart';
import 'package:todo_list_app/domain/entities/emotion.dart';
import 'package:todo_list_app/domain/entities/place.dart';

class HomeDataObject {
  List<Place> places;
  List<Emotion> emotions;
  List<Activity> activities;
  HomeDataObject(
    this.places,
    this.emotions,
    this.activities,
  );


} 
