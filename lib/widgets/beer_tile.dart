import 'package:flutter/material.dart';
import '../models/beer_model.dart';
import '../screens/beer_details_screen.dart';

class CustomListTile extends StatelessWidget {
  final BeerModel beer;

  CustomListTile({required this.beer});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x30000000),
            blurRadius: 9,
            offset: Offset(0, 2.75),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x09000000),
            blurRadius: 3,
            offset: Offset(0, 0.25),
            spreadRadius: 0,
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            beer.imageUrl,
            fit: BoxFit.contain,
            height: MediaQuery.of(context).size.height * 0.2,
            width: 80.0,
          ),
        ),
        title: Text(
          beer.name,
          style: TextStyle(
            color: Colors.black.withOpacity(0.87),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          'ABV: ${beer.abv.toStringAsFixed(1)}% | IBU: ${beer.ibu.toStringAsFixed(1)}',
          style: TextStyle(
            color: Colors.black.withOpacity(0.6),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: Container(
          width: 40,
          height: 40,
          padding: const EdgeInsets.all(12),
        ),
        onTap: () => _navigateToBeerDetails(context),
      ),
    );
  }

  void _navigateToBeerDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BeerDetailsScreen(beerId: beer.id),
      ),
    );
  }
}
