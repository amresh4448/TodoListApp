// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:todo_list_app/domain/entities/activity.dart';
import 'package:todo_list_app/domain/entities/emotion.dart';
import 'package:todo_list_app/domain/entities/festival.dart';
import 'package:todo_list_app/domain/entities/place.dart';

class HomeDataObject {
  List<Place> places;
  List<Festival> festivals;
  List<Emotion> emotions;
  List<Activity> activities;
  HomeDataObject(
    this.places,
    this.festivals,
    this.emotions,
    this.activities,
  );


} 
