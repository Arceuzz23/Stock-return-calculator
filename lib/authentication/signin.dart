import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../services/auth.dart';
import '../shareds/const.dart';
import '../shareds/loading.dart';

class signin extends StatefulWidget {
  final Function toggleview;
  const signin({super.key,  required this.toggleview});

  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<Alignment> topAlignment;
  late Animation<Alignment> bottomAlignment;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    topAlignment=TweenSequence<Alignment>(<TweenSequenceItem<Alignment>>[
      TweenSequenceItem<Alignment>(
        tween: Tween<Alignment>(
          begin:Alignment.topLeft,
          end: Alignment.topRight,
        ),
        weight: 1.0,
      ),
      TweenSequenceItem<Alignment>(
        tween: Tween<Alignment>(
          begin:Alignment.topRight,
          end: Alignment.bottomRight,
        ),
        weight: 1.0,
      ),
      TweenSequenceItem<Alignment>(
        tween: Tween<Alignment>(
          begin:Alignment.bottomRight,
          end: Alignment.bottomLeft,
        ),
        weight: 1.0,
      ),
      TweenSequenceItem<Alignment>(
        tween: Tween<Alignment>(
          begin:Alignment.bottomLeft,
          end: Alignment.topLeft,
        ),
        weight: 1.0,
      ),
    ]).animate(controller);

    bottomAlignment=TweenSequence<Alignment>(<TweenSequenceItem<Alignment>>[

      TweenSequenceItem<Alignment>(
        tween: Tween<Alignment>(
          begin:Alignment.bottomRight,
          end: Alignment.bottomLeft,
        ),
        weight: 1.0,
      ),
      TweenSequenceItem<Alignment>(
        tween: Tween<Alignment>(
          begin:Alignment.bottomLeft,
          end: Alignment.topLeft,
        ),
        weight: 1.0,
      ),
      TweenSequenceItem<Alignment>(
        tween: Tween<Alignment>(
          begin:Alignment.topLeft,
          end: Alignment.topRight,
        ),
        weight: 1.0,
      ),
      TweenSequenceItem<Alignment>(
        tween: Tween<Alignment>(
          begin:Alignment.topRight,
          end: Alignment.bottomRight,
        ),
        weight: 1.0,
      ),
    ]).animate(controller);

    controller.repeat();
  }

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  bool isPassVisible = false;
  Icon pass = const Icon(
    Icons.visibility_off_outlined,
    color: Colors.black,
  );

  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading ? const Loading(): Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnimatedBuilder(
        animation: controller,
        builder: (context,_) {
          return Container(

          decoration:  BoxDecoration(
          gradient: LinearGradient(colors: [
          //     Color(0xffF99E43),
          // Color(0xFFDA2323),
            Color(0xff0ad981),
            Color(0xFF006C91),
          ],
          begin: topAlignment.value,
          end: bottomAlignment.value,)
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,

          padding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // const SizedBox(
                  //   height: 169,
                  // ),
                  Container(
                      height: 350,
                      width: MediaQuery.of(context).size.width,
                      child: LottieBuilder.asset("assets/animations/signin.json")),
              Text('Sign In',style: GoogleFonts.bebasNeue(
                fontSize: 65,
                fontFeatures: const [FontFeature.tabularFigures()],
                fontWeight: FontWeight.bold,
              ),
              ),

                  Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(

                              decoration: textInputDecoration.copyWith(
                                prefixIcon: const Icon(
                                  Icons.email_outlined,
                                  color: Colors.black,
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
                                    color: Colors.black,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isPassVisible = !isPassVisible;
                                        if (isPassVisible) {
                                          pass = const Icon(
                                            Icons.visibility,
                                            color: Colors.black,
                                          );
                                        } else {
                                          pass = const Icon(
                                            Icons.visibility_off_outlined,
                                            color: Colors.black,
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
                                    const Color(0xff00260c),),
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
                                child:Text('Sign in',
                                    style: GoogleFonts.robotoSlab(
                                      fontSize: 19,
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
                               Text(
                                "Need an account? ",
                                style: GoogleFonts.robotoSlab(
                                  fontSize: 16,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  widget.toggleview();
                                },
                                child: Text(
                                  "Sign Up",
                                  style: GoogleFonts.robotoSlab(
                                    fontSize: 16,
                                    color: Color(0xffff0000),
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
                                color: Color(0xffffffff), fontSize: 14.0),
                          )
                        ],
                      )),
                ],
              ));
        }
      ),
    );
  }
}