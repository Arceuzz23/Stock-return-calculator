import 'package:flutter/material.dart';

class pl_calci extends StatefulWidget {
  const pl_calci({super.key});

  @override
  State<pl_calci> createState() => _pl_calciState();
}

class _pl_calciState extends State<pl_calci> {
  String shares="";
  String cost_per_share="";
  String target_price="";
  String cost="0.00";
  String profit_loss="0.00";
  String net="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(7.5, 15, 7.5, 2),
              child: Column(
                children: <Widget>[
                  Row
                    (mainAxisAlignment: MainAxisAlignment.start ,
                    children: [
                      SizedBox(height: 50,),
                      Text('Profit Loss Calculator', style: TextStyle(color: Colors.white, fontSize: 30),),
                    ],
                  ),
                  Card(
                    color: Colors.amber[800],
                    child: Container(
                      height: 150,
                      width: 400,
                      child: Center(
                        child: Column(
                          children: [
                            Text('$profit_loss', style: TextStyle(color: Colors.white, fontSize: 45),),
                            Text('Net Profit ($net)', style: TextStyle(color: Colors.white, fontSize: 20),),
                            Text('Cost: ₹'+'$cost', style: TextStyle(color: Colors.white, fontSize: 20),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Text('Current Position:', style: TextStyle(color: Colors.white, fontSize: 20),),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 50,
                        width: 120,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'No. of Shares',
                            labelStyle: TextStyle(color: Colors.white,fontSize: 13),
                            border: OutlineInputBorder(),

                          ),
                          onChanged: (value) {
                            shares=value;
                            print(shares);
                          },
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        height: 50,
                        width: 120,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Cost per Share',
                            labelStyle: TextStyle(color: Colors.white,fontSize: 13),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            cost_per_share=value;
                            setState(() {
                              profit_loss = '-₹' +
                                  (double.parse(cost_per_share) *
                                      double.parse(shares)).toString();
                              cost = (double.parse(cost_per_share) *
                                  double.parse(shares)).toString();
                              net = "-100%";
                            },
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        height: 50,
                        width: 120,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Target Price',
                            labelStyle: TextStyle(color: Colors.white,fontSize: 13),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            target_price=value;
                            setState(() {
                              profit_loss=profit_loss.substring(2);
                              profit_loss=((double.parse(target_price)-double.parse(cost_per_share))*double.parse(shares)).toString();
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
        )
    );
  }
}
