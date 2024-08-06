import 'package:todo_list_app/domain/entities/user.dart';

class Authentication {
  final String? token;
  final User? user;

  Authentication(this.token, this.user);
}