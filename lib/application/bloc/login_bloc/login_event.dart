abstract class LoginEvent{}

class LoginButtonClicked extends LoginEvent{
  final String email;
  final String password;

  LoginButtonClicked({required this.email, required this.password});
}