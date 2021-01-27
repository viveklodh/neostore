import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostoreapplication/Session/user_session.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  AuthBloc() : super(AuthInitialState());

  @override
  Stream<AuthState> mapEventToState(AuthEvents event) async* {
    if (event is InitAuthProcess) {
      print("Initial State");
      String accessToken = await UserSession().getSessionDetails();
      if (accessToken != null) {
        print("GOT ACCESSTOKEN");
        yield AuthenticatedState(acessToken: accessToken);
      } else {
        yield UnAuthenticatedState();
        print("No User Found");
      }
    }
  }
}
