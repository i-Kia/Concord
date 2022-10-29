import 'package:concord/pages/models/concorduser.dart';
import 'package:concord/pages/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:concord/pages/services/database.dart';
import 'package:provider/provider.dart';
import 'package:concord/pages/home/directmessages.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<ConcordUser>>.value(
      initialData: [],
      value: DataBaseService().users,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Text("Direct Messages"),
          backgroundColor: const Color(0xFF231942),
          elevation: 0.0,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () async {

            },
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
        body: DirectMessagesList(),
      ),
    );
  }
}

