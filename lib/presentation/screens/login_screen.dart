import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main_project/application/bloc/home_bloc/home_bloc.dart';
import 'package:main_project/application/bloc/home_bloc/home_event.dart';
import 'package:main_project/application/bloc/login_bloc/login_bloc.dart';
import 'package:main_project/application/bloc/login_bloc/login_event.dart';
import 'package:main_project/application/bloc/login_bloc/login_state.dart';
import 'package:main_project/presentation/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  final emailController=TextEditingController();
  final passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: BlocConsumer<LoginBloc,LoginState>(
        listener: (context, state) {
          if(state is LoginErrorState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
          }
          if(state is LoginSuccessState){
             Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx){
                return const HomeScreen();
              }), (route) => false);
          }
        },
        builder: (context, state) {
          return Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             const Text('Login',style: TextStyle(
              color: Colors.purple,
              fontWeight: FontWeight.bold,
              fontSize: 20
             ),),
             Padding(
               padding: const EdgeInsets.all(15.0),
               child: TextFormField(
                controller: emailController,   
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'email',
                  labelText: 'Email'
                ),
               ),
             ),
             Padding(
               padding: const EdgeInsets.all(15.0),
               child: TextFormField(
                controller: passwordController,   
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'password',
                  labelText: 'Password'
                ),
               ),
             ),
             ElevatedButton(onPressed: ()async{
              context.read<LoginBloc>().add(LoginButtonClicked(email: emailController.text, password: passwordController.text));
              context.read<HomeBloc>().add(LoadingHomePageEvent());
             
             }, child:state is LoginLoadingState ? const CircularProgressIndicator() : const Text('Submit'))
            ],
          ),
        );
        },
      ),
    ));
  }
}
