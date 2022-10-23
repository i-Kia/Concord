import 'package:concord/pages/services/auth.dart';
import 'package:concord/pages/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  const SignIn({Key? key, required this.toggleView }) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
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
              Image.asset(
                "assets/images/concord_logo_inverted.png",
                scale: 2,
              ),
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
                        "Sign In",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF9F86C0),
                        ),
                      ),
                    ),
                    TextFormField(
                      validator: (val) => val!.isEmpty ? 'Email is required' : null,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                        hintText: "Email Address",
                        fillColor: Color(0xFFE0B1CB),
                      ),
                      onTap: (){
                        setState((){

                        });
                      },
                      onChanged: (val){
                        setState(() =>
                        email = val
                        );
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      obscureText: _obscureText,
                      validator: (val) => val!.length < 6 ? 'Password must be 6+ characters long' : null,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        suffix: InkWell(

                          onTap: _togglePasswordView,
                          child: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off
                          ),
                        ),
                        border: const OutlineInputBorder(),
                        hintText: "Password",
                      ),
                      onChanged: (val){
                        setState(() =>
                        password = val
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
                            setState(() => loading = true);

                            dynamic result = await _auth.signInWithEmail(email, password);
                            if (result == 'No user found for that email.'){
                              setState(() {
                                error = 'No user found for that email';
                                loading = false;
                              });
                            } else if (result == 'Wrong password provided for that user.'){
                              setState(() {
                                error = 'Wrong password provided for that user';
                                loading = false;
                              });
                            } else if (result == null) {
                              setState(() {
                                error = 'Could not sign in with those credentials';
                                loading = false;
                              });
                            }
                          }
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Color(0xFF000000),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    InkWell(
                      onTap: () {
                        widget.toggleView();
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    InkWell(
                      onTap: () async {},
                      child: const Text(
                        'Forgot Password',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

  void _togglePasswordView(){
    setState(() {
      _obscureText = !_obscureText;
    });
  }

}

