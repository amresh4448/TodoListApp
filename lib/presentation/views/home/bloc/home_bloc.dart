// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:todo_list_app/app/app_pref.dart';
import 'package:todo_list_app/domain/entities/activity.dart';
import 'package:todo_list_app/domain/entities/emotion.dart';
import 'package:todo_list_app/domain/entities/place.dart';
import 'package:todo_list_app/domain/usecases/home_data_usecase.dart';
import 'package:todo_list_app/domain/usecases/auth/logout_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  HomeDataUseCase? _homeDataUseCase;
  LogoutUseCase? _logoutUseCase;
  AppPreferences _appPreferences;


  HomeBloc(
    this._homeDataUseCase,
    this._logoutUseCase,
    this._appPreferences,
  ) : super(HomeInitial()) {
    on<GetDataEvent>((event, emit) {
      _getData();
    });
    on<LogoutEvent>((event, emit) {
      _logOut();
    });
    
  }

  _getData() async {
    try {
      (await _homeDataUseCase!.execute(HomeDataUseCaseInput())).fold(
        (failure) {
          print(failure.code);
          emit(HomeError(failure.code.toString()+": "+failure.message));
        }, 
        (entity) {
          //Store token
          emit(HomeLoaded(entity.places,  entity.emotions, entity.activities));
        }
      );
    } catch (e) {
      print(e.toString());
    }
  }

  _logOut() async {
    try {
      (await _logoutUseCase!.execute(LogoutUseCaseInput())).fold(
        (failure) {
          print(failure.code);
          emit(HomeError(failure.code.toString()+": "+failure.message));
        }, 
        (entity) {
          _appPreferences.setUser(null);
          emit(HomeError("Logout Successful"));
        }
      );
    } catch (e) {
      print(e.toString());
    }
  }


}
