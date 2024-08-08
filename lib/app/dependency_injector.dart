

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:todo_list_app/data/data_source/task_data_source.dart';
import 'package:todo_list_app/domain/repository/task_repositry.dart';
import 'package:todo_list_app/domain/usecases/home_data_usecase.dart';
import 'package:todo_list_app/domain/usecases/auth/logout_usecase.dart';
import 'package:todo_list_app/domain/usecases/profile/password_update_usecase.dart';
import 'package:todo_list_app/domain/usecases/profile/profile_update_usecase.dart';
import 'package:todo_list_app/domain/usecases/profile/verify_otp_usecase.dart';
import 'package:todo_list_app/domain/usecases/profile/verify_phone_usecase.dart';
import 'package:todo_list_app/domain/usecases/todo_usecase/add_task.dart';
import 'package:todo_list_app/domain/usecases/todo_usecase/delete_task.dart';
import 'package:todo_list_app/domain/usecases/todo_usecase/fillter.dart';
import 'package:todo_list_app/domain/usecases/todo_usecase/toggle_task_completion.dart';
import 'package:todo_list_app/presentation/views/home/bloc/home_bloc.dart';
import 'package:todo_list_app/presentation/views/profile/bloc/profile_bloc.dart';
import 'package:todo_list_app/data/data_source/remote_data_source.dart';
import 'package:todo_list_app/data/network/api_client.dart';
import 'package:todo_list_app/data/network/dio_factory.dart';
import 'package:todo_list_app/data/network/network_info.dart';
import 'package:todo_list_app/data/repository/repository.dart';
import 'package:todo_list_app/domain/repository/repository.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app/app/app_pref.dart';
import 'package:todo_list_app/presentation/views/todo/bloc/todo_event.dart';
import 'package:todo_list_app/presentation/views/todo/todo_page.dart';

import '../presentation/views/todo/bloc/todo_bloc.dart';

class DependencyInjector {

  late SharedPreferences _sharedPreferences;
  late Repository _repository;
  late AppPreferences _appPreferences;
  //late Auth0 _auth0;
  late Dio dio;
  final taskDataSource = TaskDataSource();
 
  initPref() async {
    NetworkInfo netwotkInfo = NetworkInfoImplementation(InternetConnectionChecker());
    _sharedPreferences = await SharedPreferences.getInstance();
    _appPreferences = AppPreferences(_sharedPreferences);
    dio = await DioFactory(_appPreferences).getDio();
    ApiClient apiClient = ApiClient(dio);
    RemoteDataSource remoteData = RemoteDataSourceImplementation(apiClient);
    _repository = RepositoryImplementation(netwotkInfo, remoteData);


  }

  List<SingleChildWidget> inject(){
  
    TaskDataSource taskRepository = TaskDataSource(); // Initialize TaskDataSource

    return [
      Provider<Dio>(create: (_) => dio),
      Provider<SharedPreferences>(create: (_) => _sharedPreferences),
      Provider<AppPreferences>(create: (_) => _appPreferences),
      BlocProvider(create: (context) =>  HomeBloc(HomeDataUseCase(_repository), LogoutUseCase(_repository), _appPreferences)),

  // Future<void> addTask(Task task);
  // Future<void> deleteTask(String id);
  // Future<void> toggleTaskCompletion(String id);
  // Stream<List<Task>> getTasks();

 BlocProvider(
        create: (_) => TaskBloc(
          repository: TaskRepositoryImpl(taskDataSource),
          addTask: AddTask(TaskRepositoryImpl(taskDataSource)),
          deleteTask: DeleteTask(TaskRepositoryImpl(taskDataSource)),
          toggleTaskCompletion: ToggleTaskCompletion(TaskRepositoryImpl(taskDataSource)),
          filterTasks: FilterTasks(),
        )..add(LoadTasks()),
        child: TaskPage(),
      ),
      BlocProvider(create: (context) =>  ProfileBloc(UpdateProfileUsecase(_repository), UpdatePasswordUsecase(_repository), VerifyPhoneUsecase(_repository), VerifyOtpUsecase(_repository), _appPreferences)),
      ];
  }
}











   // BlocProvider(create: (context) =>  LoginBloc(LoginUseCase(_repository), GoogleLoginUseCase(_repository), _appPreferences, _auth0)),
      // BlocProvider(create: (context) =>  RegisterBloc(RegisterUseCase(_repository), GoogleLoginUseCase(_repository), _appPreferences, _auth0)),
   
 // BlocProvider(create: (context) =>  FavoriteBloc(FavoriteFestivalsUseCase(_repository), FavoritePlacesUseCase(_repository), _appPreferences)),
      // BlocProvider(create: (context) =>  CheckoutBloc(BookingUseCase(_repository), _appPreferences)),
      // BlocProvider(create: (context) =>  PlaceBookingBloc(TogglePlaceInBookingUseCase(_repository),_appPreferences)),
      // BlocProvider(create: (context) =>  FestivalBookingBloc(ToggleFestivalInBookingUseCase(_repository),_appPreferences)),
      // BlocProvider(create: (context) =>  HistoryBloc(GetBookingsUseCase(_repository),_appPreferences)),            
      // BlocProvider(create: (context) =>  EmotionsBloc(
      //   TogglePlaceInBookingUseCase(_repository), 
      //   ToggleFestivalInBookingUseCase(_repository), 
      //   ToggleActivityInBookingUseCase(_repository),
      //   _appPreferences
      // )),      
      
      // BlocProvider(create: (context) =>  PlacesBloc(
      //   AddFavoritePlaceUseCase(_repository),
      //   RemoveFavoritePlaceUseCase(_repository),
      //   FavoritePlacesUseCase(_repository),
      //   _appPreferences
      // )),
      
      // BlocProvider(create: (context) =>  FestivalsBloc(
      //   AddFavoriteFestivalUseCase(_repository),
      //   RemoveFavoriteFestivalUseCase(_repository),
      //   FavoriteFestivalsUseCase(_repository),
      //   _appPreferences
      // )),