import 'package:concord/pages/authenticate/authenticate.dart';
import 'package:concord/pages/home/homescreen.dart';
import 'package:concord/pages/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserObject?>(context);

    if (user == null) return Authenticate();
    return Home();

  }
}
