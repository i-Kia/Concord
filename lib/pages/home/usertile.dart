import 'package:concord/pages/models/concorduser.dart';
import 'package:flutter/material.dart';
import 'package:concord/pages/models/user.dart';

class UserTile extends StatelessWidget {

  final ConcordUser user;
  const UserTile({Key? key,  required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        color: const Color(0xFF231942),
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.black,
          ),
          title: Text(
            user.username,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            "Last message they sent",
            style: const TextStyle(
              color: Colors.white38,
            ),
          ),
        ),
      ),
    );
  }
}
