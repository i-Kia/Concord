import 'package:flutter/material.dart';
import 'package:concord/pages/shared/loading.dart';
import 'package:concord/pages/services/database.dart';
import 'package:provider/provider.dart';
import 'package:concord/pages/models/user.dart';

class SetupAccount extends StatefulWidget {
  @override
  _SetupAccountState createState() => _SetupAccountState();
}

class _SetupAccountState extends State<SetupAccount> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String username = '';
  String error = '';

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserObject?>(context);

    // ignore: prefer_const_constructors
    return loading ? Loading() : Scaffold(
      backgroundColor: const Color(0xFF231942),
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background_two.png"),
              fit:  BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(height: 20.0),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  decoration: const BoxDecoration(
                    color: Color(0xFF5E548E),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40.0,
                        child: Text(
                          "Account",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF9F86C0),
                          ),
                        ),
                      ),
                      TextFormField(
                        validator: (val) {
                          if (val!.length > 32) return 'Maximum of 32 characters';
                          return val.isEmpty ? 'Username is required' : null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Username",
                          fillColor: Color(0xFFE0B1CB),
                        ),
                        onChanged: (val){
                          setState(() =>
                          username = val
                          );
                        },
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        error,
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 20.0,),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFF9F86C0)),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()){

                              if (await DataBaseService().userExists(username)){
                                setState(() {
                                  error = 'Username already in use';
                                });
                              } else {
                                setState(() => loading = true);
                                await DataBaseService(uid: user!.uid).updateUserData(username, "photoUrl");
                                user.username = username;
                              }
                            }
                          },
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                              color: Color(0xFF000000),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
