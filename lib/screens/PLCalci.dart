import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_return_calculator/services/auth.dart';

class pl_calci extends StatefulWidget {
  const pl_calci({super.key});

  @override
  State<pl_calci> createState() => _pl_calciState();
}

class _pl_calciState extends State<pl_calci> with SingleTickerProviderStateMixin {
  final AuthService _auth = AuthService();


  String shares="";
  String cost_per_share="";
  String target_price="";
  String cost="0.00";
  String profit_loss="₹0.00";
  String net="0%";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:SafeArea(
          child: Center(
            child:
            Container(
              decoration:  BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xffF99E43),
                    Color(0xFFDA2323),
                  ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,)
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,

              child: Padding(
                padding: const EdgeInsets.fromLTRB(7.5, 5, 7.5, 2),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text('Profit Loss Calculator',style: GoogleFonts.bebasNeue(
                              fontSize: 40,
                              // fontFeatures: const [FontFeature.tabularFigures()],
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                          ],
                        ),



                        PopupMenuButton(
                            color: Colors.black,
                            iconColor: Colors.black,
                            itemBuilder: (context) =>
                            [
                              PopupMenuItem(
                                child: TextButton.icon(
                                    icon: const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                    onPressed: () async {
                                      await _auth.signout();
                                    },
                                    label: const Text('Logout',
                                        style: TextStyle(
                                          fontFamily: 'Trito Writter',
                                          color: Colors.white,
                                        ))),
                              )
                            ]),
                      ],
                    ),

                    Card(
                      elevation: 25,
                      color:Color(0xFF230500),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 150,
                        width: 400,
                        child: Center(
                          child: Column(
                            children: [
                              FittedBox(

                                  child: AutoSizeText('$profit_loss', style: TextStyle(color: Colors.white, fontSize: 50),)),
                              AutoSizeText('Net Profit ($net)', style: TextStyle(color: Colors.grey[200], fontSize: 13),),
                              AutoSizeText('Cost: ₹'+'$cost', style: TextStyle(color: Colors.grey[200], fontSize: 13),),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Current Position:', style: GoogleFonts.robotoSlab(color: Colors.black, fontSize: 20),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 369,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'No. of Shares',
                              labelStyle: TextStyle(color: Colors.grey[900],fontSize: 15),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                shares=value;
                              });
                              print(shares);
                            },
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 50,
                          width: 369,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Cost per Share',
                              labelStyle: TextStyle(color: Colors.grey[900],fontSize: 15),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              cost_per_share=value;
                              setState(() {
                                profit_loss = '-₹' +
                                    (double.parse(cost_per_share) *
                                        double.parse(shares)).toStringAsFixed(2);
                                cost = (double.parse(cost_per_share) *
                                    double.parse(shares)).toStringAsFixed(2);
                                net = "-100%";
                              },
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 50,
                          width: 369,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Target Price',
                              labelStyle: TextStyle(color: Colors.grey[900],fontSize: 15),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              target_price=value;
                              setState(() {
                                profit_loss=profit_loss.substring(2);
                                profit_loss=((double.parse(target_price)-double.parse(cost_per_share))*double.parse(shares)).toStringAsFixed(2);
                                net=(((double.parse(target_price)-double.parse(cost_per_share))*double.parse(shares))/(double.parse(cost_per_share) *
                                    double.parse(shares))).toStringAsFixed(2)+'%';
                                if(double.parse(profit_loss)>0)
                                  profit_loss='₹'+profit_loss;
                                else
                                {
                                  profit_loss=profit_loss.substring(1);
                                  profit_loss='-₹'+profit_loss;
                                }

                                print(profit_loss);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
