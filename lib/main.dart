import 'package:covid_details/hepler/apihelper.dart';
import 'package:covid_details/models/covid.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CovidApp(),
  ));
}

class CovidApp extends StatefulWidget {
  const CovidApp({super.key});

  @override
  State<CovidApp> createState() => _CovidAppState();
}

class _CovidAppState extends State<CovidApp> {
  List country = [];
  dynamic selectedCountry;
  dynamic a;
  List flag = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.withOpacity(0.8),
      appBar: AppBar(
        title: const Text("Covid-19 Case Tracker"),
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                bottom: 20,
                top: 8,
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: FutureBuilder(
                future: ApiHelper.apiHelper.fetchCoviData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error : ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    List<CovidData> data = snapshot.data as List<CovidData>;
                    country = data.map((e) => e.name).toList();
                    return Container(
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.all(8),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: DropdownButtonFormField(
                                iconSize: 35,
                                icon: const Icon(Icons.arrow_drop_down_sharp),
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30.0),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue.withOpacity(0.1),
                                ),
                                hint: const Text("Select Country"),
                                value: selectedCountry,
                                onChanged: (val) {
                                  setState(() {
                                    selectedCountry = val;
                                    a = country.indexOf(val);
                                  });
                                },
                                items: country.map((e) =>
                                   DropdownMenuItem(
                                    value: e,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.50,
                                      child: Text(e),
                                    ),
                                  )
                                ).toList(),
                              ),
                            ),
                            (a != null)
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 20),
                                      Card(
                                        elevation: 10,
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black)),
                                                height: 150,
                                                width: double.infinity,
                                                child: Image.network(
                                                  data[a].flag,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Text("Total Population Of ${data[a].name} is ${data[a].population}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 100,
                                        width: double.infinity,
                                        child: Card(
                                          elevation: 5,
                                          shadowColor: Colors.grey,
                                          color: Colors.blueGrey.shade200,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "Confirmed",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color:
                                                          Colors.grey.shade600),
                                                ),
                                                Text(
                                                  "${data[a].totalConfirmed}",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.brown),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      SizedBox(height: 20,),
                                       Container(
                                        height: 100,
                                        width: double.infinity,
                                        //  decoration: BoxDecoration(border: Border.all(color: Colors.brown)),
                                        child: Card(
                                          elevation: 5,
                                          shadowColor: Colors.grey,
                                          color: Colors.green,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "Recovered",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color:
                                                          Colors.white),
                                                ),
                                                Text(
                                                  "${data[a].totalRecovered}",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      SizedBox(height: 20,),
                                      Container(
                                        height: 100,
                                        width: double.infinity,
                                        //  decoration: BoxDecoration(border: Border.all(color: Colors.brown)),
                                        child: Card(
                                          elevation: 5,
                                          shadowColor: Colors.grey,
                                          color: Colors.red,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "Deaths",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  "${data[a].totalDeaths}",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      SizedBox(height: 20,),
                                      Container(
                                        height: 100,
                                        width: double.infinity,
                                        //  decoration: BoxDecoration(border: Border.all(color: Colors.brown)),
                                        child: Card(
                                          elevation: 5,
                                          shadowColor: Colors.grey,
                                          color: Colors.amber,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "Active",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.deepPurple),
                                                ),
                                                Text(
                                                  "${data[a].totalActive}",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.deepPurple),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      SizedBox(height: 20,),
                                      Container(
                                        height: 100,
                                        width: double.infinity,
                                        //  decoration: BoxDecoration(border: Border.all(color: Colors.brown)),
                                        child: Card(
                                          elevation: 5,
                                          shadowColor: Colors.grey,
                                          color: Colors.blue.shade200,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "Critical",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.indigo),
                                                ),
                                                Text(
                                                  "${data[a].totalCritical}",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.indigo),
                                                ),
                                              ]),
                                        ),
                                      ),
                                    ],
                                  )
                                : Text("No data Found"),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
