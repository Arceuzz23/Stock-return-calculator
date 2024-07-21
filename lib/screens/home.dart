import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_return_calculator/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> with SingleTickerProviderStateMixin{
  final AuthService _auth = AuthService();

  List<dynamic> stocks=[];
  List<dynamic> data=[];
  String stock_name="";
  String open="";
  String high="";
  String low="";
  String close="";
  String volume="";
  String timeF="";

  String stock_search="";
  String exact_time="";
  String date1="";
  String date2="";
  String time="";
  String type="";//stores the interval type of trade
  String dropdownValue="TIME_SERIES_WEEKLY_ADJUSTED";
  String hintdate="Enter Date";
  String hinttime="Enter Time";
  String SelectInterval="Select Interval";

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  Icon calendar=const Icon(
    Icons.calendar_month_outlined,
    color: Colors.grey,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child:

          Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            decoration:  BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xffF99E43),
                  Color(0xFFDA2323),
                ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,)
            ),
            child: Padding(
              padding:  const EdgeInsets.fromLTRB(10, 0, 7.5, 0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Stockify',style: GoogleFonts.bebasNeue(
                          fontSize: 55,
                          fontFeatures: const [FontFeature.tabularFigures()],
                          fontWeight: FontWeight.bold,
                        ),

                        ),

                        SizedBox(width: 100),
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
                    SizedBox(height: 10),
                    Container(
                      height: 50,
                      width: 369,
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        decoration:  InputDecoration(
                          labelText: 'Search',
                          hintText: 'Search for stocks to invest or trade',
                          hintStyle: TextStyle(color: Colors.grey[900]),
                          labelStyle: TextStyle(color: Colors.grey[900]),
                          prefixIcon: Icon(Icons.search, color: Colors.grey[900]),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        onChanged: (value) {
                          stock_search = value;
                          fetchStocks();
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    Container(
                      height: 564,
                      width: 369,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: stocks.length,
                          itemBuilder: (context, index) {
                            final stock = stocks[index];
                            return Column(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 15,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    showDialog(context: context, builder: (context) {
                                      return AlertDialog(
                                        title: Text(stock['1. symbol']),
                                        content:Text(
                                            stock['2. name']),
                                        actions: [
                                          TextField(
                                            controller: dateController,
                                            style: const TextStyle(color: Colors.black),
                                            decoration: const InputDecoration(
                                              suffixIcon: Icon(
                                                Icons.calendar_month_outlined,
                                                color: Colors.black,),
                                              hintText: 'Choose date',
                                              hintStyle: TextStyle(color: Colors.grey),
                                              labelStyle: TextStyle(color: Colors.grey),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            readOnly: true,
                                            onTap: () {
                                              _selectDate(context);
                                            },
                                          ),
                                          const SizedBox(height: 10,),
                                          TextField(
                                            controller: timeController,
                                            style: const TextStyle(color: Colors.black),
                                            decoration: const InputDecoration(
                                              suffixIcon: Icon(Icons.access_time,
                                                color: Colors.black,),
                                              hintText: 'Choose time',
                                              hintStyle: TextStyle(color: Colors.grey),
                                              labelStyle: TextStyle(color: Colors.grey),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            readOnly: true,
                                            onTap: () {
                                              _selectTime(context);
                                            },
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                height: 50,
                                                width: 180,
                                                child: DropdownButton<String?>(
                                                  value: dropdownValue,
                                                  hint: Text('Select Interval'),
                                                  elevation: 16,
                                                  onChanged: (String? newvalue) {
                                                    setState(() {
                                                      dropdownValue = newvalue!;
                                                    });
                                                  },
                                                  items: const[
                                                    DropdownMenuItem<String>(
                                                      child: Text('Intraday'),
                                                      value: 'TIME_SERIES_INTRADAY',),
                                                    DropdownMenuItem<String>(
                                                      child: Text('Weekly'),
                                                      value: 'TIME_SERIES_WEEKLY_ADJUSTED',),
                                                    DropdownMenuItem<String>(
                                                      child: Text('Monthly'),
                                                      value: 'TIME_SERIES_MONTHLY_ADJUSTED',),
                                                  ],),
                                              ),

                                            ],
                                          ),


                                          const SizedBox(height: 10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              ElevatedButton(onPressed: () {
                                                setState(() {
                                                  stock_details();
                                                  final dataa=data[0]['$date1+" "+$time'];
                                                  open= dataa['1. open'];
                                                  high= dataa['2. high'];
                                                  low= dataa['3. low'];
                                                  close= dataa['4. close'];
                                                  volume= dataa['5. volume'];
                                                });
                                                exact_time = date1 + " " + time;
                                                print(exact_time);
                                                showDialog(context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            'Stock Details'),
                                                        content: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          height: 111,
                                                          width: 250,
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment
                                                                .start,
                                                            crossAxisAlignment: CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text('1. Open: $open'),
                                                              Text('2. High: $high'),
                                                              Text('3. Low: $low'),
                                                              Text('4. Close: $close'),
                                                              Text('5. Volume: $volume'),
                                                            ],
                                                          ),
                                                        ),
                                                        actions: [
                                                          ElevatedButton(onPressed: () {
                                                            Navigator.pop(context);
                                                          },
                                                              child: const Text(
                                                                  'Close')),
                                                        ],
                                                      );
                                                    });
                                              }, child: const Text('View')),
                                              const SizedBox(width: 10,),

                                              ElevatedButton(onPressed: () {
                                                Navigator.pop(context);
                                              }, child: const Text('Close')),
                                            ],
                                          ), // ElevatedButton(onPressed: (){


                                        ],
                                      );
                                    });
                                  },
                                  child: ListTile(
                                    leading: Container(
                                      height:30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(25.0),
                                      ),
                                      child: Text('${index + 1}',
                                        style: const TextStyle(
                                            color: Colors.white),),
                                    ),
                                    title: Text(stock['1. symbol'],
                                      style: const TextStyle(
                                          color: Colors.black),),
                                    subtitle: Text(stock['2. name'],
                                        style: const TextStyle(
                                            color: Colors.black)),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          }),
                    ),
                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked=await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),

    );
    if(picked!=null && picked!=DateTime.now()){
      dateController.text=picked.toString().split(" ")[0];
      date1=dateController.text;
      print(date1);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked=await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if(picked!=null && picked!=DateTime.now()){
      timeController.text=picked.toString().substring(10,15);
      time=timeController.text+":00";
      print(time);
    }
  }


  void fetchStocks() async{
    //fetch stocks from database
    //const url='https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&apikey=R8BKETMLB3MDF3FK';
    final url='https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=$stock_search&apikey=5X94ZZ8DPLJXDDLH';
    //const url='https://randomuser.me/api/?results=100';
    final uri=Uri.parse(url);
    final response=await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      stocks=json['bestMatches'];
    });
  }

  void stock_details() async{
    //fetch stock details
    final url='https://www.alphavantage.co/query?function=$dropdownValue&symbol=$stock_name&interval=5min&apikey=8X8G6Q7FY5GYD49Y';
    final uri=Uri.parse(url);
    final response=await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      data=json['Time Series (5min)'];
    });
  }
}