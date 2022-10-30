import 'package:concord/pages/models/concorduser.dart';
import 'package:concord/pages/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:concord/pages/services/database.dart';
import 'package:provider/provider.dart';
import 'package:concord/pages/home/directmessages.dart';

import 'package:concord/pages/settings/editprofile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

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
        backgroundColor: const Color(0xFF231942),
        appBar: AppBar(
          title: const Text("Direct Messages"),
          backgroundColor: const Color(0xFF231942),
          elevation: 0.0,
          leading: Builder(
            builder: (context){
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: (){
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          actions: <Widget>[
            Builder(
              builder: (context){
                return IconButton(
                  icon: const Icon(Icons.person),
                  onPressed: (){
                    Scaffold.of(context).openEndDrawer();
                    //await _auth.signOut();
                  },
                );
              },
            )
          ],
        ),
        body: DirectMessagesList(),
        drawerEdgeDragWidth: MediaQuery.of(context).size.width,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF231942),
                ),
                child: Text(
                  'Drawer Header',
                ),
              )
            ],
          ),
        ),
        endDrawer: Drawer(
          backgroundColor: const Color(0xFF231942),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(height: 30.0,),
              ListTile(
                leading: const Icon(Icons.account_box_rounded, color: Colors.white,),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 15.0,),
                title: const Text(
                  'Account',
                  style: TextStyle(color: Colors.white,),
                ),
                onTap: () {},
                tileColor: const Color(0xFF231942),
              ),
              ListTile(
                leading: const Icon(Icons.edit, color: Colors.white,),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 15.0,),
                title: const Text(
                  'User Profile',
                  style: TextStyle(color: Colors.white,),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EditProfile()),
                  );
                },
                tileColor: const Color(0xFF231942),
              ),
              ListTile(
                leading: const Icon(Icons.send, color: Colors.white,),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 15.0,),
                title: const Text(
                  'Friend Requests',
                  style: TextStyle(color: Colors.white,),
                ),
                onTap: () {},
                tileColor: const Color(0xFF231942),
              ),
              ListTile(
                leading: const Icon(Icons.qr_code_rounded, color: Colors.white,),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 15.0,),
                title: const Text(
                  'QR Code',
                  style: TextStyle(color: Colors.white,),
                ),
                onTap: () {},
                tileColor: const Color(0xFF231942),
              ),
              const Divider(
                color: Color(0xFF9F86C0),
              ),
              const Center(
                child: Text(
                  "App Settings",
                  style: TextStyle(
                    color: Color(0xFF9F86C0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.color_lens_rounded, color: Colors.white,),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 15.0,),
                title: const Text(
                  'Appearance',
                  style: TextStyle(color: Colors.white,),
                ),
                onTap: () {},
                tileColor: const Color(0xFF231942),
              ),
              ListTile(
                leading: const Icon(Icons.translate, color: Colors.white,),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 15.0,),
                title: const Text(
                  'Language',
                  style: TextStyle(color: Colors.white,),
                ),
                onTap: () {},
                tileColor: const Color(0xFF231942),
              ),
              ListTile(
                leading: const Icon(Icons.notification_important_rounded, color: Colors.white,),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 15.0,),
                title: const Text(
                  'Notifications',
                  style: TextStyle(color: Colors.white,),
                ),
                onTap: () {},
                tileColor: const Color(0xFF231942),
              ),
              const Divider(
                color: Color(0xFF9F86C0),
              ),
              const Center(
                child: Text(
                  "Account",
                  style: TextStyle(
                    color: Color(0xFF9F86C0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app_rounded, color: Colors.white,),
                title: const Text(
                  'Log Out',
                  style: TextStyle(color: Colors.white,),
                ),
                onTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    backgroundColor: const Color(0xFF231942),
                    title: const Text(
                      'LOG OUT',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    content: const Text(
                      'Are you sure you want to log out?',
                      style: TextStyle(color: Colors.white),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context, 'OK');
                          _auth.signOut();
                          },
                        child: const Text(
                          'Log Out',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      ),
                    ],
                  ),
                ),
                tileColor: const Color(0xFF231942),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF231942),
          onPressed: (){},
          child: const Icon(
            Icons.add,
            color: Color(0xFF0F8E35),
          ),
        ),
      ),
    );
  }
}

