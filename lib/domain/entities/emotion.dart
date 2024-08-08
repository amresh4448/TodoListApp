// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:todo_list_app/domain/entities/activity.dart';
import 'package:todo_list_app/domain/entities/place.dart';

class Emotion {
  final String img;
  final Place? place;
  final Activity? activity; 
  Emotion(
    this.img,
    this.place,
    this.activity,
  );

  Emotion copyWith({
    String? img,
    Place? place,
    Activity? activity,
  }) {
    return Emotion(
      img ?? this.img,
      place ?? this.place,
      activity ?? this.activity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'img': img,
      'place': place?.toMap(),
      'activity': activity?.toMap(),
    };
  }

  factory Emotion.fromMap(Map<String, dynamic> map) {
    return Emotion(
      map['img'] as String,
      map['place'] != null ? Place.fromMap(map['place'] as Map<String,dynamic>) : null,
      map['activity'] != null ? Activity.fromMap(map['activity'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Emotion.fromJson(String source) => Emotion.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Emotion(img: $img, place: $place,  activity: $activity)';
  }

  @override
  bool operator ==(covariant Emotion other) {
    if (identical(this, other)) return true;
  
    return 
      other.img == img &&
      other.place == place &&
      other.activity == activity;
  }

  @override
  int get hashCode {
    return img.hashCode ^
      place.hashCode ^
      activity.hashCode;
  }
}
