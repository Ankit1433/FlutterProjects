import 'package:covideapp/Services/StateService.dart';
import 'package:covideapp/view/detailscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen>
    with TickerProviderStateMixin {
  TextEditingController searchController = new TextEditingController();
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StateService stateService = StateService();
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('Countries List'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    hintText: 'Search with country name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                    future: stateService.fetchCountryListApi(),
                    builder:
                        (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if (!snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade500,
                                highlightColor: Colors.grey.shade100,
                                child: Column(children: [
                                  ListTile(
                                      leading: Container(
                                        height: 50,
                                        width: 50,
                                        color: Colors.white,
                                      ),
                                      title: Container(
                                        height: 10,
                                        width: 89,
                                        color: Colors.white,
                                      ),
                                      subtitle: Container(
                                        height: 10,
                                        width: 89,
                                        color: Colors.white,
                                      ))
                                ]),
                              );
                            });
              
                        // SpinKitFadingCircle(
                        //     color: Colors.black,
                        //     size: 50,
                        //     controller: _controller);
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              String name = snapshot.data![index]['country'];
                              if (searchController.text.isEmpty) {
                                return Column(children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailScreen(
                                                  name: snapshot.data![index]
                                                      ['country'],
                                                  image: snapshot.data![index]
                                                      ['countryInfo']['flag'],
                                                  totalCases: snapshot
                                                      .data![index]['cases'],
                                                  totalDeaths: snapshot
                                                      .data![index]['deaths'],
                                                  totalRecovered:
                                                      snapshot.data![index]
                                                          ['recovered'],
                                                  active: snapshot
                                                      .data![index]['active'],
                                                  critical:
                                                      snapshot.data![index]
                                                          ['critical'],
                                                  todayRecovered:
                                                      snapshot.data![index]
                                                          ['todayRecovered'],
                                                  test: snapshot.data![index]
                                                      ['tests'],
                                                )),
                                      );
                                    },
                                    child: SizedBox(
                                      child: ListTile(
                                        leading: Image(
                                            height: 50,
                                            width: 50,
                                            image: NetworkImage(
                                                snapshot.data![index]
                                                    ['countryInfo']['flag'])),
                                        title: Text(
                                            snapshot.data![index]['country']),
                                        subtitle: Text(snapshot.data![index]
                                                ['cases']
                                            .toString()),
                                      ),
                                    ),
                                  )
                                ]);
                              } else if (name.toLowerCase().contains(
                                  searchController.text.toLowerCase())) {
                                return Column(children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
                                                    name:
                                                        snapshot.data![index]
                                                            ['country'],
                                                    image: snapshot
                                                                .data![index]
                                                            ['countryInfo']
                                                        ['flag'],
                                                    totalCases:
                                                        snapshot.data![index]
                                                            ['cases'],
                                                    totalDeaths:
                                                        snapshot.data![index]
                                                            ['deaths'],
                                                    totalRecovered:
                                                        snapshot.data![index]
                                                            ['recovered'],
                                                    active:
                                                        snapshot.data![index]
                                                            ['active'],
                                                    critical:
                                                        snapshot.data![index]
                                                            ['critical'],
                                                    todayRecovered: snapshot
                                                            .data![index]
                                                        ['todayRecovered'],
                                                    test:
                                                        snapshot.data![index]
                                                            ['tests'],
                                                  )));
                                    },
                                    child: ListTile(
                                      leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(
                                              snapshot.data![index]
                                                  ['countryInfo']['flag'])),
                                      title: Text(
                                          snapshot.data![index]['country']),
                                      subtitle: Text("Cases: ${snapshot.data![index]['cases']}"),
                                    ),
                                  )
                                ]);
                              } else {
                                return Container();
                              }
                            });
                      }
                    }),
              )
            ],
          ),
        ));
  }
}
