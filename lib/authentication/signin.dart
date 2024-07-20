import 'package:flutter/material.dart';

import '../services/auth.dart';
import '../shareds/const.dart';
import '../shareds/loading.dart';

class signin extends StatefulWidget {
  final Function toggleview;
  const signin({super.key,  required this.toggleview});

  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  bool isPassVisible = false;
  Icon pass = const Icon(
    Icons.visibility_off_outlined,
    color: Colors.grey,
  );

  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading ? const Loading(): Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          height: 10000,
          width: 1000,
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/cal_blurr1.jpg"),
                fit: BoxFit.cover,
                opacity: 0.5,
              )),
          padding:
          const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 169,
              ),
              const Text(
                "SIGN IN",
                style: TextStyle(
                    fontSize: 50, fontFamily: 'Computo Monospace'),
              ),
              const SizedBox(
                height: 0,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(

                          decoration: textInputDecoration.copyWith(
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: Colors.grey,
                            ),
                            hintText: 'Email',
                          ),
                          validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          }
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          decoration: textInputDecoration.copyWith(
                              prefixIcon: const Icon(
                                Icons.lock_outline_rounded,
                                color: Colors.grey,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isPassVisible = !isPassVisible;
                                    if (isPassVisible) {
                                      pass = const Icon(
                                        Icons.visibility,
                                        color: Colors.grey,
                                      );
                                    } else {
                                      pass = const Icon(
                                        Icons.visibility_off_outlined,
                                        color: Colors.grey,
                                      );
                                    }
                                  });
                                },

                                icon: pass,
                              ),
                              hintText: 'Password'),
                          obscureText: isPassVisible ? false : true,
                          validator: (val) => val!.length < 6
                              ? 'Password must be more than 6 characters'
                              : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1),
                        ),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                const Color.fromRGBO(236, 61, 61, 1)),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() => loading = true);
                                dynamic result = await _auth
                                    .singInWithEmailAndPassword(
                                    email, password);
                                if (result == null) {
                                  setState(() {
                                    error = 'wrong credentials';
                                    loading = false;
                                  });
                                }
                              }
                            },
                            child: const Text('Sign in',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontFamily: 'Trito Writter',
                                  color:
                                  Color.fromARGB(255, 255, 255, 255),
                                ))),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Need an account? ",
                            style: TextStyle(
                              fontFamily: 'Trito Writter',
                              fontSize: 18,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              widget.toggleview();
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                fontFamily: 'Trito Writter',
                                fontSize: 18,
                                color: Color.fromRGBO(236, 61, 61, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        error,
                        style: const TextStyle(
                            color: Colors.red, fontSize: 14.0),
                      )
                    ],
                  )),
            ],
          )),
    );
  }
}