import 'package:concord/pages/models/concorduser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:concord/pages/home/usertile.dart';

class DirectMessagesList extends StatefulWidget {
  const DirectMessagesList({Key? key}) : super(key: key);

  @override
  _DirectMessagesListState createState() => _DirectMessagesListState();
}

class _DirectMessagesListState extends State<DirectMessagesList> {
  @override
  Widget build(BuildContext context) {

    final users = Provider.of<List<ConcordUser>>(context);
    //for (var user in users) {
    //  print(user);
    //}

    return Container(
      color: const Color(0xFF322957),
      child: ListView.builder(

        itemCount: users.length,
        itemBuilder: (context, index) {
          return UserTile(user: users[index]);
        },
      ),
    );
  }
}
