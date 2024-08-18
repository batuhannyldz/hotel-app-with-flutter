import 'package:flutter/material.dart';
import 'package:airbnb/model/hotel_model.dart';
import 'package:airbnb/pages/hotel_info.dart';

class FavoriteHotels extends StatelessWidget {
  final List<HotelModel> favoriteHotels;

  const FavoriteHotels({Key? key, required this.favoriteHotels}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Ekranda iki sütun
            childAspectRatio: 2 / 3, // Kartların en boy oranı
            mainAxisSpacing: 16.0, // Kartlar arası dikey boşluk
            crossAxisSpacing: 16.0, // Kartlar arası yatay boşluk
          ),
          itemCount: favoriteHotels.length,
          itemBuilder: (context, index) {
            final HotelModel hotel = favoriteHotels[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HotelDetailScreen(hotel: hotel),
                  ),
                );
              },
              child: Card(
                margin: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Image.asset(
                        hotel.image!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Text('Image not found'),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hotel.name!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Fiyat: ${hotel.price} TL',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}