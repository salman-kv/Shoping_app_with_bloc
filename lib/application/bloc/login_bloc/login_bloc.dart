import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main_project/application/bloc/login_bloc/login_event.dart';
import 'package:main_project/application/bloc/login_bloc/login_state.dart';
import 'package:main_project/domain/api_calling/product_api.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<LoginButtonClicked>((event, emit) async {
      emit(LoginLoadingState());
      var val= await loginChecking(event.email,event.password);
      if(val){
        emit(LoginSuccessState());
      }
      else{
        emit(LoginErrorState(error: 'Invalid user name or password'));
      }
      // if (!(event.email=='eve.holt@reqres.in') || !(event.password=='pistol')) {
      //   emit(LoginErrorState(error: 'invalid email or password'));
      //   return;
      // }
      // await Future.delayed(const Duration(seconds: 3));

      // emit(LoginSuccessState());
    });
  }
}
