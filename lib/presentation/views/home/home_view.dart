import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/app/app_pref.dart';
import 'package:todo_list_app/domain/entities/user.dart';
import 'package:todo_list_app/presentation/base/toast.dart';
import 'package:todo_list_app/presentation/views/home/bloc/home_bloc.dart';

import '../todo/todo_page.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  User? user;

  @override
  void initState() {
    super.initState();

    //push getdataevent
    context.read<HomeBloc>().add(GetDataEvent());
    _getUser();
  }

  _getUser() async {
    User? result = await context.read<AppPreferences>().getUser();
    setState(() {
      user = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
       // drawer: _buildDrawer(context),
        body: TaskPage(),
        
        
        // BlocBuilder<HomeBloc, HomeState>(
        //   builder: (context, state) {
        //     if (state is HomeError) {
        //       //Display Toastbar
        //       showErrorToastbar(state.message);
        //     }
        //     if (state is HomeLoaded) {
        //       print("Printing State Variables");
        //       print(state.places);
        //       print(state.festivals);
        //       print(state.emotions);

        //       //HomeView Body
        //       return Center(child: Text("Home"),);
              
        //       //_buildHomeView(state);
        //     } else {
        //       return const Center(
        //           child: SizedBox(
        //         child: CircularProgressIndicator(),
        //       ));
        //     }
        //   },
        // )
        
        
        );
  }

  // Widget _buildHomeView(HomeLoaded state) {
  //   List<Place> placesInfo = state.places;
  //   List<Festival> festivalsInfo = state.festivals;
  //   List<Emotion> emotionsInfo = state.emotions;
  //   List<Activity> activitiesInfo = state.activities;
  //   List<Widget> tabs = [
  //    // PlacesTab(info: placesInfo),
  //     FestivalsTab(info: festivalsInfo),
  //   //  EmotionsTab(info: emotionsInfo)
  //   ];
  //   TabController _tabController = TabController(length: tabs.length, vsync: this);
  //   return Container(
  //     padding: EdgeInsets.all(20),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         //Header with Menu Icon and Profile Image
  //         Container(
  //           padding: const EdgeInsets.only(top: 40),
  //           child: Row(
  //             children: [
  //               Expanded(child: Container()),
  //               InkWell(
  //                 onTap: () async {
  //                   print(_scaffoldKey.currentState);
  //                   await _getUser();
  //                   return _scaffoldKey.currentState!.openDrawer();
  //                 },
  //                 child: Container(
  //                   width: 50,
  //                   height: 50,
  //                   decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(10),
  //                       color: ColorManager.mainColor),
  //                   child: Icon(
  //                     Icons.menu,
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //         const SizedBox(height: 10),

  //         //Tab Title
  //         AppLargeText(text: "Discover"),
  //         const SizedBox(height: 20),

  //         //TabBar - Header
  //         Container(
  //           child: TabBar(
  //             labelPadding: EdgeInsets.only(left: 20, right: 20),
  //             controller: _tabController,
  //             labelColor: Colors.black,
  //             unselectedLabelColor: Colors.grey,
  //             isScrollable: true,
  //             indicatorSize: TabBarIndicatorSize.label,
  //             indicator:
  //                 CircleTabIndiator(color: ColorManager.mainColor, radius: 4),
  //             tabs: const [
  //               Tab(text: "Festivals"),
  //             ]),
  //         ),

  //         //TabView - Body
  //         Container(
  //           height: 300,
  //           width: double.maxFinite,
  //           child: TabBarView(
  //             controller: _tabController,
  //             children: tabs,
  //           ),
  //         ),
  //         SizedBox(height: 5),

  //         //Explore More Section
  //         Container(
  //           margin:
  //               const EdgeInsets.only(top: 20, left: 0, right: 20, bottom: 10),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               AppLargeText(
  //                 text: "Activities",
  //                 size: 22,
  //               ),
  //             ],
  //           ),
  //         ),

  //         //Activities Section
  //         Container(
  //           //ListView - Requires Horizontal Bounds
  //           height: 80,
  //           margin: const EdgeInsets.only(right: 20, left: 20),
  //           child: ListView.builder(
  //               scrollDirection: Axis.horizontal,
  //               itemCount: activitiesInfo.length,
  //               itemBuilder: (context, index) {
  //                 context.read<ActivityBookingBloc>().add(GetBookingState(activitiesInfo[index]));
  //                 return InkWell(
  //                   onTap: () => _bookActivity(activitiesInfo[index]),
  //                   child: Container(
  //                     margin: const EdgeInsets.only(right: 15, left: 15),
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.center,
  //                       children: [
  //                         //Image
  //                         BlocBuilder<ActivityBookingBloc, HomeState>(
  //                           builder: (context, state) {
  //                             if(state is BookingLoading){
  //                               return Container(
  //                                 child: Center(
  //                                   child: CircularProgressIndicator(),
  //                                 ),
  //                               );
  //                             }
  //                             else {
  //                               bool booked = false;
  //                               if(state is AddedToBooking) {
  //                                 booked = state.booking.activities.contains(activitiesInfo[index])? true: false;
  //                               }
  //                               if(state is RemovedFromBooking) {
  //                                 booked = state.booking.activities.contains(activitiesInfo[index])? true: false;
  //                               }

  //                               return Container(
  //                                 width:  AppSize.s40,
  //                                 height:  AppSize.s40,
  //                                 child: Stack(
  //                                   children: [
  //                                     CachedNetworkImage(
  //                                       imageUrl: AppConstants.baseUrl +
  //                                           "/images/" +
  //                                           activitiesInfo[index].img,
  //                                       fit: BoxFit.cover,
  //                                     ),
  //                                     booked? Center(
  //                                       child: Icon(Icons.check_circle_outline_outlined, size: AppSize.s40, color: ColorManager.mainColor),
  //                                     ): Container()
  //                                   ],
  //                                 ),
  //                               );
  //                             }

  //                           },
  //                         ),
  //                         //Text
  //                         Container(
  //                           margin: EdgeInsets.only(top: 2),
  //                           child: AppText(
  //                             text: activitiesInfo[index].name,
  //                             color: ColorManager.textColor2,
  //                             size: 12,
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                 );
  //               }),
  //         )
  //       ],
  //     ),
  //   );
  // }






}





