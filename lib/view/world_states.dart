
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Modal/WorldStatesModal.dart';
import '../Services/StateService.dart';
import 'countries_list.dart';

class WorldStates extends StatefulWidget {

  @override
  State<WorldStates> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<WorldStates> with TickerProviderStateMixin {
  late final AnimationController _controller =
  AnimationController(duration: const Duration(seconds: 3), vsync: this)
    ..repeat();

  final colorList = <Color>[
    Colors.orange,
    Colors.green,
    Colors.red,
  ];
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StateService stateservices = StateService();
    return Scaffold(
        body: Container(
          color: Colors.black12,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                FutureBuilder(
                    future: stateservices.fetchWorldStatesRecords(),
                    builder: (context, AsyncSnapshot<WorldStatesModal> snapshot) {
                      if (!snapshot.hasData) {
                        return Expanded(
                            flex: 1,
                            child: SpinKitFadingCircle(
                                color: Colors.blue,
                                size: 50,
                                controller: _controller));
                      } else {
                        return Column(
                          children: [
                            PieChart(
                              chartValuesOptions: const ChartValuesOptions(showChartValuesInPercentage: true),
                              dataMap: {
                                // "Total":200,
                                // "Recovered":100,
                                // "Deaths":10,
                                "Total":
                                double.parse(snapshot.data!.cases.toString()),
                                "Recovered":
                                double.parse(snapshot.data!.recovered.toString()),
                                "Deaths":
                                double.parse(snapshot.data!.deaths.toString())
                              },
                              colorList: colorList,
                              animationDuration: const Duration(seconds: 2),
                              chartType: ChartType.disc,
                              chartRadius: MediaQuery.of(context).size.width / 3.2,
                              legendOptions: const LegendOptions(
                                  legendPosition: LegendPosition.left),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                  MediaQuery.of(context).size.height * .06),
                              child: Card(
                                child: Column(
                                  children: [
                                    ReusableRow(title: 'Total', value: snapshot.data!.cases.toString()),
                                    ReusableRow(title: "Recovered", value: snapshot.data!.recovered.toString()),
                                    ReusableRow(title: "Deaths", value: snapshot.data!.deaths.toString()),
                                    ReusableRow(title: "Active", value: snapshot.data!.active.toString()),
                                    ReusableRow(title: "Critical", value: snapshot.data!.critical.toString()),
                                    ReusableRow(title: "Today Deaths", value: snapshot.data!.todayDeaths.toString()),
                                    ReusableRow(title: "Today Recovered", value: snapshot.data!.todayRecovered.toString()),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return const CountriesListScreen();
                                }));
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Center(child: Text('Track Countries')),
                              ),
                            )
                          ],
                        );
                      }
                    }),
              ],
            ),
          ),
        ));
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
          const SizedBox(height: 5),
          const Divider()
        ],
      ),
    );
  }
}