import 'package:todo_list_app/data/mappers/extensions.dart';
import 'package:todo_list_app/data/responses/responses.dart';
import 'package:todo_list_app/domain/entities/activity.dart';
import 'package:todo_list_app/domain/entities/authentication.dart';
import 'package:todo_list_app/domain/entities/emotion.dart';
import 'package:todo_list_app/domain/entities/home_data.dart';
import 'package:todo_list_app/domain/entities/location.dart';
import 'package:todo_list_app/domain/entities/place.dart';
import 'package:todo_list_app/domain/entities/user.dart';

const EMPTY = "";
const ZERO = 0;
final DEFAULT_LOCATION = Location(0, "Default");


extension AuthenticationResponseMapper on AuthResponse? {
  Authentication toDomain() {
    return Authentication(
      this?.token?.orEmpty() ?? EMPTY, 
      this?.user?.toDomain()
    );
  }
}

extension UserResponseMapper on UserResponse? {
  User toDomain() {
    return User(
      this?.id?.orZero() ?? ZERO,
      this?.first_name?.orEmpty() ?? EMPTY,
      this?.last_name?.orEmpty() ?? EMPTY,
      this?.email?.orEmpty() ?? EMPTY,
      this?.phone?.orEmpty() ?? EMPTY,
      this?.is_phone_verified?.orZero() ?? ZERO,
    );
  }
}

extension HomeDataResponseMapper on HomeDataResponse? {
  HomeDataObject toDomain() {
    return HomeDataObject(
      this?.places?.map((place) => place.toDomain()).toList() ?? <Place>[],
      this?.emotions?.map((emotion) => emotion.toDomain()).toList() ?? <Emotion>[],
      this?.activities?.map((activity) => activity.toDomain()).toList() ?? <Activity>[],
    );
  }
}

extension PlaceResponseMapper on PlaceResponse? {
  Place toDomain() {
    return Place(
      this?.id?.orZero() ?? ZERO,
      this?.name?.orEmpty() ?? EMPTY,
      this?.img?.orEmpty() ?? EMPTY,
      this?.description?.orEmpty() ?? EMPTY,
      this?.location?.toDomain()?? DEFAULT_LOCATION,
      this?.stars?.orZero() ?? ZERO,
      this?.people?.orZero() ?? ZERO,
      this?.price?.orZero() ?? ZERO,
      this?.activities?.map((activity) => activity.toDomain()).toList() ?? <Activity>[],
    );
  }
}


extension EmotionResponseMapper on EmotionResponse? {
  Emotion toDomain() {
    return Emotion(
      this?.img?.orEmpty() ?? EMPTY,
      this?.place?.toDomain(),
      this?.activity?.toDomain(),
    );
  }
}

extension LocationResponseMapper on LocationResponse? {
  Location toDomain() {
    return Location(
      this?.id?.orZero() ?? ZERO,
      this?.name?.orEmpty() ?? EMPTY,
    );
  }
}

extension ActivityResponseMapper on ActivityResponse? {
  Activity toDomain() {
    return Activity(
      this?.id?.orZero() ?? ZERO,
      this?.name?.orEmpty() ?? EMPTY,
      this?.img?.orEmpty() ?? EMPTY,
    );
  }
}


extension UserPlaceResponseMapper on UserPlaceResponse? {
  List<Place> toDomain() {
    return this?.places?.map((place) => place.toDomain()).toList() ?? <Place>[];
  }
}



