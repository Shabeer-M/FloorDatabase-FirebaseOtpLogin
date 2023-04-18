import 'package:flutter/material.dart';
import 'package:places/database/entity/place.dart';
import 'package:places/view/place_details/screens/places_details.dart';

class GridViewPlaceCard extends StatelessWidget {
  final List<Place> list;

  const GridViewPlaceCard({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: (150 / 212),
      children: [
        for (int i = 0; i < list.length; i++)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 8,
                )
              ],
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PlaceDetails(
                                  img: list[i].image,
                                  description: list[i].description,
                                  title: list[i].title,
                                )));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Image.network(
                      list[i].image,
                      width: 110,
                      fit: BoxFit.contain,
                      height: 160,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          list[i].title,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
