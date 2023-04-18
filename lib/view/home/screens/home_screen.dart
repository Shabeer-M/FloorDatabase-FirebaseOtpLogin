import 'package:flutter/material.dart';
import 'package:places/database/entity/place.dart';
import 'package:places/main.dart';
import 'package:places/view/home/dummyData.dart';
import 'package:places/view/home/widgets/place_card_widget.dart';
import 'package:places/view/login/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  navigation({required bool isStatus}) {
    if (isStatus == false) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Place> lakes = [];
    List<Place> all = [];
    List<Place> mountains = [];
    List<Place> beaches = [];
    List<Place> cities = [];

    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: placeDaoMain?.getAllPlace(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print("adding data ${!snapshot.hasData}");
            for (int i = 0; i < toAddData.length; i++) {
              placeDaoMain?.insertPlace(toAddData[i]);
            }
          }
          if (snapshot.hasData) {
            all.addAll(snapshot.data!);
            for (int i = 0; i < all.length; i++) {
              if (all[i].id == 1) {
                lakes.add(all[i]);
              } else if (all[i].id == 2) {
                mountains.add(all[i]);
              } else if (all[i].id == 3) {
                beaches.add(all[i]);
              } else if (all[i].id == 4) {
                cities.add(all[i]);
              }
            }
            lakes.length;

            print("value ejeee ${snapshot.data?[0]}");
            if (snapshot.data?[0] != null)
              print("have data ${!snapshot.hasData}");

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: ()  async{
                              await sharedPreferences.setBool("isLogged", false);


                            },
                            child: Icon(
                              Icons.sort_rounded,
                              color: Colors.white.withOpacity(0.5),
                              size: 35,
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.exit_to_app,
                              color: Colors.white.withOpacity(0.5),
                              size: 35,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Plan Your Trip withUs ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.blueGrey[900],
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Find your places",
                            hintStyle:
                                TextStyle(color: Colors.white.withOpacity(0.5)),
                            prefixIcon: Icon(
                              Icons.search,
                              size: 30,
                              color: Colors.white.withOpacity(0.5),
                            )),
                      ),
                    ),
                    TabBar(
                      controller: _tabController,
                      labelColor: Colors.deepOrangeAccent,
                      unselectedLabelColor: Colors.white.withOpacity(0.5),
                      isScrollable: true,
                      indicator: const UnderlineTabIndicator(
                        borderSide: BorderSide(
                          width: 3,
                          color: Colors.deepOrangeAccent,
                        ),
                        insets: EdgeInsets.symmetric(horizontal: 16),
                      ),
                      labelStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                      labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                      tabs: const [
                        Tab(
                          text: "Lakes",
                        ),
                        Tab(
                          text: "Mountains",
                        ),
                        Tab(
                          text: "Sea",
                        ),
                        Tab(
                          text: "Cities",
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: [
                        GridViewPlaceCard(list: lakes),
                        GridViewPlaceCard(list: mountains),
                        GridViewPlaceCard(list: beaches),
                        GridViewPlaceCard(list: cities),
                      ][_tabController.index],
                    )
                  ],
                ),
              ),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Failed to Load",
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        },
      ),
    );
  }
}
