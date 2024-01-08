import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../blocs/beer_details_bloc.dart';
import '../models/beer_model.dart';

class SpecificationItem extends StatelessWidget {
  final String title;
  final String value;

  SpecificationItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}

class NavigationItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  NavigationItem(
      {required this.title, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? Colors.blue : Colors.grey,
              width: 2.0,
            ),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.blue : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

class BeerDetailsScreen extends StatefulWidget {
  final int beerId;

  BeerDetailsScreen({required this.beerId});

  @override
  _BeerDetailsScreenState createState() => _BeerDetailsScreenState();
}

class _BeerDetailsScreenState extends State<BeerDetailsScreen> {
  String selectedSection = 'Description';

  @override
  void initState() {
    super.initState();
    beerDetailsBloc.fetchBeerDetails(widget.beerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beer Details'),
      ),
      body: StreamBuilder<BeerModel>(
        stream: beerDetailsBloc.beerDetailsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            BeerModel beer = snapshot.data!;
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        beer.imageUrl,
                        fit: BoxFit.contain,
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      beer.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      beer.tagline,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Divider(
                      height: 1.0,
                      thickness: 1.0,
                      indent: 0,
                      endIndent: 0,
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: NavigationItem(
                            title: 'Description',
                            isSelected: selectedSection == 'Description',
                            onTap: () {
                              setState(() {
                                selectedSection = 'Description';
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: NavigationItem(
                            title: 'Specifications',
                            isSelected: selectedSection == 'Specifications',
                            onTap: () {
                              setState(() {
                                selectedSection = 'Specifications';
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    if (selectedSection == 'Description')
                      Text(
                        beer.description,
                        style: TextStyle(fontSize: 16.0),
                      )
                    else if (selectedSection == 'Specifications')
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SpecificationItem(
                            title: 'ABV',
                            value: '${beer.abv.toStringAsFixed(1)}%',
                          ),
                          SpecificationItem(
                            title: 'IBU',
                            value: beer.ibu.toStringAsFixed(1),
                          ),
                          SpecificationItem(
                            title: 'Brewing Method',
                            value: beer.brewingMethod,
                          ),
                          SizedBox(height: 16.0),
                          SpecificationItem(
                            title: 'Ingredients',
                            value: beer.ingredients.join(', '),
                          ),
                          SizedBox(height: 16.0),
                          SpecificationItem(
                            title: 'Food Pairing',
                            value: beer.foodPairing.join(', '),
                          ),
                          SizedBox(height: 16.0),
                          SpecificationItem(
                            title: "Brewer's Tips",
                            value: beer.brewersTips,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
