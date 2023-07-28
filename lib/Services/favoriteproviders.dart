import 'package:flutter/material.dart';
import 'package:SM1/model/listwisata.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider extends ChangeNotifier {
  List<Destinasi> _favorites = [];
  List<Destinasi> get favorites => _favorites;

  bool isFavorite(Destinasi destinasi) {
    return _favorites.contains(destinasi);
  }

  void toggleFavorite(Destinasi destinasi) {
    if (_favorites.contains(destinasi)) {
      _favorites.remove(destinasi);
    } else {
      _favorites.add(destinasi);
    }
    notifyListeners();
  }

  List<Destinasi> getFavoriteIds() {
    return _favorites;
  }

  Future<void> saveFavoritesToStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        'favoriteIds', _favorites.map((d) => d.id.toString()).toList());
  }

  Future<void> loadFavoritesFromStorage(List<Destinasi> listDestinasi) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteIds = prefs.getStringList('favoriteIds') ?? [];
    _favorites = favoriteIds
        .map(
          (id) => listDestinasi.firstWhere(
            (d) => d.id.toString() == id,
            orElse: () => Destinasi(
              id: '', // Corrected type to BigInt
              nama_destinasi: '',
              destinasi_id: '', // Corrected type to BigInt
              images: '', // Corrected type to List<String>
              deskripsi: '',
              lokasi: '',
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
