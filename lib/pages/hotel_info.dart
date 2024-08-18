import 'package:flutter/material.dart';
import 'package:airbnb/model/hotel_model.dart';

class HotelDetailScreen extends StatelessWidget {
  final HotelModel hotel;

  const HotelDetailScreen({Key? key, required this.hotel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hotel.name!),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(hotel.image!),
            SizedBox(height: 16.0),
            Text(
              hotel.name!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Fiyat: ${hotel.price} TL',
              style: TextStyle(fontSize: 20),
            ),
            // Burada otel detaylarını gösterebilirsiniz
          ],
        ),
      ),
    );
  }
}
