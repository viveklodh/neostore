import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostoreapplication/Blocs/UserDetailUpdateBloc/update_events.dart';
import 'package:neostoreapplication/Blocs/UserDetailUpdateBloc/update_states.dart';
import 'package:neostoreapplication/NetworkApi/AuthService/auth_service.dart';

class UpdateBloc extends Bloc<UpdateEvents, UpdateStates> {
  UpdateBloc() : super(InitialData());

  @override
  Stream<UpdateStates> mapEventToState(UpdateEvents event) async* {
    if (event is AccountDetailUpdateEvent) {
      yield UpdateLoading();
      Response response = await AuthService().updateUserInfo(
          event.accessToken,
          event.firstName,
          event.lastName,
          event.email,
          event.phoneNo,
          event.dob,
          event.profilePic);
      if (response.statusCode == 200) {
        var data = json.decode(response.data);
        print(data["message"]);
        yield UpdateSuccesfully();
      } else {
        var data = json.decode(response.data);
        print(data["message"]);
        yield UpdateFailed();
      }
    }
  }
}
