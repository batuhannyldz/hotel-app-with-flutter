import 'package:flutter/material.dart';
import 'package:airbnb/model/hotel_model.dart';
import 'package:airbnb/hotel_data.dart'; // Verilerinizi içeren dosya
import 'package:airbnb/pages/hotel_info.dart';
import 'package:airbnb/pages/profile_screen.dart'; // Profil sayfası
import 'package:airbnb/pages/favorite_hotels.dart'; // Favori oteller sayfası
import 'package:airbnb/pages/map_screen.dart'; // Harita sayfası
import 'package:airbnb/pages/about_us.dart'; // Hakkımızda sayfası
import 'package:airbnb/pages/settings.dart'; // Ayarlar sayfası
import 'package:airbnb/pages/contact_us.dart'; // İletişim sayfası

class HotelList extends StatefulWidget {
  const HotelList({super.key});

  @override
  State<HotelList> createState() => _HotelListState();
}

class _HotelListState extends State<HotelList> {
  late List<HotelModel> hotelModelList;
  late List<HotelModel> filteredHotelList;
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    hotelModelList = hotelJsonList.map((json) => HotelModel.fromJson(json)).toList();
    filteredHotelList = hotelModelList;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  void _filterHotels(String query) {
    setState(() {
      filteredHotelList = hotelModelList
          .where((hotel) =>
              hotel.name!.toLowerCase().contains(query.toLowerCase()) ||
              hotel.price.toString().contains(query))
          .toList();
    });
  }

  void _toggleFavorite(HotelModel hotel) {
    setState(() {
      hotel.isFavorite = !hotel.isFavorite;
    });
  }

  Widget _buildHotelList() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Ekranda iki sütun
          childAspectRatio: 2 / 3, // Kartların en boy oranı
          mainAxisSpacing: 16.0, // Kartlar arası dikey boşluk
          crossAxisSpacing: 16.0, // Kartlar arası yatay boşluk
        ),
        itemCount: filteredHotelList.length,
        itemBuilder: (context, index) {
          final HotelModel hotel = filteredHotelList[index];
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
                  Stack(
                    children: [
                      Image.asset(
                        hotel.image!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 150,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Text('Image not found'),
                          );
                        },
                      ),
                      Positioned(
                        top: 8.0,
                        right: 8.0,
                        child: IconButton(
                          icon: Icon(
                            hotel.isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: hotel.isFavorite ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            _toggleFavorite(hotel);
                          },
                        ),
                      ),
                    ],
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0
              ? 'PB-HOTEL'
              : _selectedIndex == 1
                  ? 'Profil'
                  : _selectedIndex == 2
                      ? 'Favori Oteller'
                      : 'Harita',
        ),
        backgroundColor: Colors.red,
        bottom: _selectedIndex == 0
            ? PreferredSize(
                preferredSize: const Size.fromHeight(48.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: _filterHotels,
                    decoration: InputDecoration(
                      hintText: 'Otel Ara...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              )
            : null,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.red,
              ),
              child: const Text(
                'Menü',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Hakkımızda'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutUsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Ayarlar'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail),
              title: const Text('İletişim'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactUsScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          _buildHotelList(),
          const ProfileScreen(),
          FavoriteHotels(
            favoriteHotels: hotelModelList.where((hotel) => hotel.isFavorite).toList(),
          ),
          const MapScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Otel Listesi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoriler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Harita',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}