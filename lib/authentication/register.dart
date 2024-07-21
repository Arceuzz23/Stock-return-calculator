import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../services/auth.dart';
import '../shareds/const.dart';
import '../shareds/loading.dart';

class register extends StatefulWidget {
  final Function toggleview;
  const register({super.key, required this.toggleview});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> with SingleTickerProviderStateMixin{

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

  //text field state
  String email = '';
  String password = '';
  String error = '';

  bool isPassVisible = false;
  Icon pass = const Icon(
    Icons.visibility_off_outlined,
    color: Colors.black,
  );
  @override
  Widget build(BuildContext context) {

    return loading
        ? const Loading()
        : Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnimatedBuilder(
        animation: controller,
        builder: (context,_) {
          return Container(

              decoration:  BoxDecoration(
                  gradient: LinearGradient(colors: [
                    //     Color(0xffF99E43),
                    // Color(0xFFDA2323),
                    Color(0xff60e5fc),
                    Color(0xFF804BD9),
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
                Container(
                      height: 350,
                      width: 1000,
                      child: LottieBuilder.asset("assets/animations/flyingman.json")),
                  Text('Sign Up',style: GoogleFonts.bebasNeue(
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
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(45),
                                    borderSide:
                                    const BorderSide(color: Colors.lime)),
                                hintText: 'Email',
                              ),
                              validator: (val) =>
                              val!.isEmpty ? 'Enter an email' : null,
                              onChanged: (val) {
                                setState(() => email = val);
                              }),
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
                                  hintText: 'Password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  )),
                              validator: (val) => val!.length < 6
                                  ? 'Password must be more than 6 characters'
                                  : null,
                              obscureText: isPassVisible ? false : true,
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
                                    const Color(0xff01074f),),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() => loading = true);
                                    dynamic result = await _auth
                                        .registerWithEmailAndPassword(
                                        email, password);
                                    if (result == null) {
                                      setState(() {
                                        error = 'please supply a valid email';
                                        loading = false;
                                      });
                                    }
                                  }
                                },
                                child:Text('Register',
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
                                "Already a user? ",
                                style: GoogleFonts.robotoSlab(
                                  fontSize: 16,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  widget.toggleview();
                                },
                                child: Text(
                                  "Sign In",
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
                                color: Colors.red, fontSize: 14.0),
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
