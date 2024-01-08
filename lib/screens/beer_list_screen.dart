import 'package:flutter/material.dart';
import '../blocs/beer_list_bloc.dart';
import '../models/beer_model.dart';
import '../widgets/beer_tile.dart';

class BeerListScreen extends StatefulWidget {
  @override
  _BeerListScreenState createState() => _BeerListScreenState();
}

class _BeerListScreenState extends State<BeerListScreen> {
  @override
  void initState() {
    super.initState();
    beerListBloc.fetchBeers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBeerListStream(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('Beer List'),
      actions: [
        IconButton(
          icon: Icon(Icons.filter_list),
          onPressed: () => showFilterDialog(context),
        ),
      ],
    );
  }

  Widget buildBeerListStream() {
    return StreamBuilder<List<BeerModel>>(
      stream: beerListBloc.beerListStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return buildBeerList(snapshot.data!);
        } else if (snapshot.hasError) {
          return buildErrorWidget(snapshot.error);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget buildBeerList(List<BeerModel> beers) {
    return ListView.builder(
      itemCount: beers.length,
      itemBuilder: (context, index) {
        return CustomListTile(beer: beers[index]);
      },
    );
  }

  Widget buildErrorWidget(dynamic error) {
    return Center(
      child: Text('Error: $error'),
    );
  }

  void showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter Beers'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                items: [
                  'ABV High to Low',
                  'ABV Low to High',
                  'IBU High to Low',
                  'IBU Low to High'
                ]
                    .map((filter) => DropdownMenuItem<String>(
                          value: filter,
                          child: Text(filter),
                        ))
                    .toList(),
                onChanged: (selectedFilter) {
                  if (selectedFilter != null) {
                    switch (selectedFilter) {
                      case 'ABV High to Low':
                        beerListBloc.filterByABVHighToLow();
                        break;
                      case 'ABV Low to High':
                        beerListBloc.filterByABVLowToHigh();
                        break;
                      case 'IBU High to Low':
                        beerListBloc.filterByIBUHighToLow();
                        break;
                      case 'IBU Low to High':
                        beerListBloc.filterByIBULowToHigh();
                        break;
                    }
                  }
                },
                hint: Text('Select Filter'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Clear filters
                beerListBloc.fetchBeers();
              },
              child: Text('Clear Filters'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Apply Filters'),
            ),
          ],
        );
      },
    );
  }
}
