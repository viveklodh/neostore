import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostoreapplication/Blocs/SignUpBloc/signup_events.dart';
import 'package:neostoreapplication/Blocs/SignUpBloc/signup_states.dart';
import 'package:neostoreapplication/NetworkApi/AuthService/auth_service.dart';

class SignUpBloc extends Bloc<SignUpEvents, SignUpStates> {
  SignUpBloc() : super(SignUpInitialState());

  @override
  Stream<SignUpStates> mapEventToState(SignUpEvents event) async* {
    if (event is SignUpButtonPressed) {
      yield SignUpLoadingState();
      Response response = await AuthService().registerUser(
          event.email,
          event.password,
          event.con_password,
          event.firstname,
          event.lastname,
          event.gender,
          event.number);
      var data = json.decode(response.data);
      if (response.statusCode == 200) {
        yield SignUpSuccessState(msg: data["user_msg"]);
      } else {
        yield SignUpFailedState(msg: data["user_msg"]);
      }
    }
  }
}
