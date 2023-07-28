import 'package:flutter/material.dart';
import 'package:SM1/model/listwisata.dart';
import 'package:SM1/pages/favorit.dart';
import 'package:SM1/pages/profil.dart';
import 'package:SM1/widget/list_bukit.dart';
import 'package:SM1/widget/list_pantai.dart';
import 'package:SM1/widget/list_pemandian.dart';
import 'package:SM1/widget/list_taman.dart';
import 'package:SM1/model/repositorywisata.dart';
import 'package:SM1/model/repositoryothers.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../widget/kategori.dart';
import 'detail_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Destinasi> listDestinasi = [];
  List<Destinasi> listOthers = [];
  List<Destinasi> searchResults = []; // New list to store search results
  RepositoryWisata repository = RepositoryWisata();
  RepositoryOthers repositoryothers = RepositoryOthers();

  TextEditingController searchController = TextEditingController();

  getData() async {
    listDestinasi = await repository.getData();
    listOthers = await repositoryothers.getData();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  void searchDestinasi(String query) {
    final lowerCaseQuery = query.toLowerCase();

    setState(() {
      searchResults = listDestinasi.where((destinasi) {
        final lowerCaseDestinasi = destinasi.nama_destinasi.toLowerCase();
        return lowerCaseDestinasi.contains(lowerCaseQuery);
      }).toList();
    });
  }

  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    FavoritePage(),
    ProfilePage(),
  ];

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
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 196, 230, 245),
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
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.only(left: 16),
                    height: 45,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: searchDestinasi,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        hintText: "Cari destinasi",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 45,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          child: InkWell(
                            onTap: () => Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const ListPantai();
                            })),
                            child: const Kategori(
                                imagePath: "assets/image/pantai.png",
                                imageName: "Pantai"),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          child: InkWell(
                            onTap: () => Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ListBukit();
                            })),
                            child: const Kategori(
                                imagePath: "assets/image/bukit.png",
                                imageName: "Bukit"),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          child: InkWell(
                            onTap: () => Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const ListTaman();
                            })),
                            child: const Kategori(
                                imagePath: "assets/image/taman.png",
                                imageName: "Taman"),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          child: InkWell(
                            onTap: () => Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const ListPemandian();
                            })),
                            child: const Kategori(
                                imagePath: "assets/image/kolam.png",
                                imageName: "Pemandian"),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.68,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        final destinasi = listDestinasi[index];
                        final imageUrl =
                            repository.getImageUrl(destinasi.images);
                        return Row(
                          children: [
                            SizedBox(
                              child: Stack(
                                children: [
                                  InkWell(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailView(
                                          destinasi:
                                              destinasi, // Pass the selected item to the DetailView
                                        ),
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image.network(imageUrl),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        destinasi.nama_destinasi,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10.0),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 120,
                      height: 40,
                      child: const Kategori(
                          imagePath: "assets/image/tourism.png",
                          imageName: "Lainnya"),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        final others = listOthers[index];
                        final imageUrl =
                            repositoryothers.getOthersImage(others.images);
                        return Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.white,
                              ),
                              width: 250,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      child: InkWell(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailView(
                                                        destinasi: others))),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                          child: Image.network(
                                            imageUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(15),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(others.nama_destinasi),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
            // Conditional rendering of search results
            if (searchResults.isNotEmpty)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: Color.fromARGB(241, 255, 255, 255),
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final destinasi = searchResults[index];
                        final imageUrl =
                            repository.getImageUrl(destinasi.images);
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailView(
                                  destinasi: destinasi,
                                ),
                              ),
                            );
                          },
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(imageUrl),
                          ),
                          title: Text(destinasi.nama_destinasi),
                        );
                      },
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
