import 'package:concord/pages/models/user.dart';

abstract class IUserService {
  Future<UserObject> connect(UserObject user);
  Future<List<UserObject>> online();
  Future<void> disconnect(UserObject user);
}