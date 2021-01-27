import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostoreapplication/Blocs/UserDetailUpdateBloc/update_bloc.dart';
import 'package:neostoreapplication/Model/UserModel/user.dart';
import 'package:neostoreapplication/NetworkApi/AuthService/auth_service.dart';
import 'package:neostoreapplication/Session/user_session.dart';

import 'home_events.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  StreamSubscription _streamSubscription;
  UpdateBloc updateBloc;
  HomeBloc(UpdateBloc updateBloc) : super(HomeInitialState()) {
    /*  this.updateBloc = updateBloc;
    _streamSubscription = this.updateBloc.listen((states) async {
      if(states is UpdateSuccesfully){

        var result = await UserSession().getSessionDetails();
        print(result);
        add();
      }
    });*/
  }

  @override
  Stream<HomeStates> mapEventToState(HomeEvents event) async* {
    if (event is FetchUserDetails) {
      print("Access Token----->${event.accessToken}");
      Response response = await AuthService().fetchUser(event.accessToken);
      if (response.statusCode == 200) {
        var userResponse = json.decode(response.data);
        print("_-----------------------------------------------");
        print(userResponse["data"]);
        print("_-----------------------------------------------");
        User userData = User.fromJson(userResponse);
        print("User Data---------------->");
        print(userData.data.userData.firstName);
        print("<----------------------");
        yield FetchUserState(user: userData);
      } else {
        var errorResponse = json.decode(response.data);
        print(errorResponse);
        yield FetchIncompleteState();
      }
    }
    if (event is AccountUpdateEvent) {
      var accessToken = await UserSession().getSessionDetails();
      print("HOME SCREEN UPDATE : AccessToken: $accessToken");
      Response response = await AuthService().fetchUser(accessToken);
      if (response.statusCode == 200) {
        var userResponse = json.decode(response.data);
        print("_----------------UPDATING-------------------------------");
        print(userResponse["data"]);
        print("_-----------------------------------------------");
        User userData = User.fromJson(userResponse);
        print("User Data Updating---------------->");
        print(userData.data.userData.firstName);
        print("<----------------------");
        yield FetchUserState(user: userData);
      } else {
        var errorResponse = json.decode(response.data);
        print(errorResponse);
        yield FetchIncompleteState();
      }
    }
  }

  @override
  Future<Function> close() {
    _streamSubscription.cancel();
  }
}
