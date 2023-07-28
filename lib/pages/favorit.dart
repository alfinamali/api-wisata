import 'package:flutter/material.dart';
import 'package:SM1/Services/favoriteproviders.dart';
import 'package:SM1/pages/home.dart';
import 'package:SM1/pages/profil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  Future<String> _getImageUrl(String filename) async {
    return Uri.parse('https://wisata.surabayawebtech.com/api/file/$filename')
        .toString();
  }

  int _currentIndex = 1;

  void _onTabChange(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/favorite');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final favoriteList = favoriteProvider.getFavoriteIds();

    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
          child: GNav(
            backgroundColor: Colors.white,
            color: Colors.blue,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.blue,
            gap: 5,
            padding: EdgeInsets.all(10),
            selectedIndex: _currentIndex,
            onTabChange: _onTabChange,
            tabs: const [
              GButton(
                icon: Icons.home_outlined,
                text: 'Home',
              ),
              GButton(
                icon: Icons.favorite_border,
                text: 'Favorite',
              ),
              GButton(
                icon: Icons.person_outline,
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('Favorite Page'),
      ),
      body: ListView.builder(
        itemCount: favoriteList.length,
        itemBuilder: (context, index) {
          final destinasi = favoriteList[index];
          return FutureBuilder<String>(
            future: _getImageUrl(destinasi.images),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              final imageUrl = snapshot.data;
              return ListTile(
                leading: Image.network(
                  imageUrl.toString(),
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(destinasi.nama_destinasi),
                subtitle: Text(destinasi.lokasi),
                trailing: IconButton(
                  icon: Icon(
                    favoriteProvider.isFavorite(destinasi)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    favoriteProvider.toggleFavorite(destinasi);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
