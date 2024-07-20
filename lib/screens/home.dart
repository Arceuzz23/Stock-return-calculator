import 'dart:convert';
import 'dart:js_interop';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  List<dynamic> stocks=[];
  List<dynamic> data=[];
  String stock_name="";
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
    return Center(
      child: SafeArea(child: Container(

        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(7.5, 15, 7.5, 2),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Row(
                  children: <Widget>[
                    Text('Hello, Aryan', style: TextStyle(color: Colors.white, fontSize: 30),),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height:50,
                  width: 369,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Search',
                      hintText: 'Search for stocks to invest or trade',
                      hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    onChanged: (value) {
                      stock_search=value;
                      fetchStocks();
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 50,
                  width: 369,

                  child: ElevatedButton(
                    onPressed: (){
                      showDialog(context: context, builder: (context){
                        return AlertDialog(
                          title: const Text("IBM"),
                          content: const Text("International Business Machines Corporation"),
                          actions: [
                            TextField(
                              controller: dateController,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                suffixIcon: Icon(Icons.calendar_month_outlined, color: Colors.black,),
                                hintText: 'Choose date',
                                hintStyle: TextStyle(color: Colors.grey),
                                labelStyle: TextStyle(color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                              readOnly: true,
                              onTap:(){_selectDate(context);
                              },
                            ),
                            const SizedBox(height: 10,),
                            TextField(
                              controller: timeController,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                suffixIcon: Icon(Icons.access_time, color: Colors.black,),
                                hintText: 'Choose time',
                                hintStyle: TextStyle(color: Colors.grey),
                                labelStyle: TextStyle(color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                              readOnly: true,
                              onTap:(){_selectTime(context);},
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 180,
                                  child: DropdownButton<String?>(
                                    value:dropdownValue,
                                    hint: Text('Select Interval'),
                                    elevation: 16,
                                    onChanged: (String? newvalue){
                                      setState(() {
                                        dropdownValue=newvalue!;});
                                    },
                                    items :const[
                                    DropdownMenuItem<String>(child:  Text('Intraday'), value: 'TIME_SERIES_INTRADAY',),
                                    DropdownMenuItem<String>(child:  Text('Weekly'), value: 'TIME_SERIES_WEEKLY_ADJUSTED',),
                                    DropdownMenuItem<String>(child:  Text('Monthly'), value: 'TIME_SERIES_MONTHLY_ADJUSTED',),
                                  ], ),
                                ),

                              ],
                            ),



                            const SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(onPressed: (){
                                  exact_time=date1+" "+time;
                                  print(exact_time);
                                  showDialog(context: context, builder: (context){
                                    return AlertDialog(
                                      title: const Text('Stock Details'),
                                      content: Container(
                                        alignment: Alignment.centerLeft,
                                        height: 111,
                                        width: 250,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('1. Open: 121515.2'),
                                            Text('2. High: 15115.8'),
                                            Text('3. Low: 51ghd5'),
                                            Text('4. Close: 1215.69'),
                                            Text('5. Volume: 1287'),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        ElevatedButton(onPressed: (){
                                          Navigator.pop(context);
                                        }, child: const Text('Close')),
                                      ],
                                    );
                                  });


                                }, child: const Text('View')),
                                const SizedBox(width: 10,),
                                ElevatedButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: const Text('Close')),
                              ],
                            ),// ElevatedButton(onPressed: (){


                          ],
                        );
                      });

                    },
                    child: const Text('Stocks', style: TextStyle(color: Colors.black),),
                  ),
                ),

                Container(
                  height: 500,
                  width: 369,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: stocks.length,
                      itemBuilder: (context,index){
                        final stock = stocks[index];
                        return Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                              ),
                              onPressed: (){
                                stock_name=stock['1. symbol'];
                                stock_details();
                                showDialog(context: context, builder: (context){
                                  return AlertDialog(
                                    title: Text(stock['1. symbol']),
                                    content: Text(stock['2. name']),

                                    actions: [

                                      // TextField(
                                      //   style: const TextStyle(color: Colors.black),
                                      //   decoration: const InputDecoration(
                                      //     suffixIcon: Icon(Icons.calendar_month_outlined, color: Colors.black,),
                                      //     hintText: 'Enter date',
                                      //     hintStyle: TextStyle(color: Colors.grey),
                                      //     labelStyle: TextStyle(color: Colors.grey),
                                      //     enabledBorder: OutlineInputBorder(
                                      //       borderSide: BorderSide(color: Colors.black),
                                      //     ),
                                      //     focusedBorder: OutlineInputBorder(
                                      //       borderSide: BorderSide(color: Colors.black),
                                      //     ),
                                      //   ),
                                      //   readOnly: true,
                                      //   onTap:(){_selectDate(context);
                                      //     },
                                      //
                                      //
                                      // ),
                                      ElevatedButton(onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>stock(stock: stock)));
                                      }, child: const Text('View')),
                                      ElevatedButton(onPressed: (){
                                        Navigator.pop(context);
                                      }, child: const Text('Close')),
                                    ],
                                  );
                                });
                              },
                              child: ListTile(
                                leading: Text('${index+1}',style: const TextStyle(color: Colors.black),),
                                title: Text(stock['1. symbol'],style: const TextStyle(color: Colors.black),),
                                subtitle: Text(stock['2. name'],style: const TextStyle(color: Colors.black)),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),],
                        );


                      }),
                )

              ]
          ),
        ),

      )),
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
    final url='https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=$stock_name&interval=5min&apikey=R8BKETMLB3MDF3FK';
    final uri=Uri.parse(url);
    final response=await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      data=json['Time Series (5min)'];
    });
  }
}