import 'package:flutter/material.dart';
import 'package:SM1/model/model_pantai/repositorypantai.dart';
import 'package:SM1/pages/detail_view.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../model/listwisata.dart';

class ListPantai extends StatefulWidget {
  const ListPantai({Key? key}) : super(key: key);

  @override
  State<ListPantai> createState() => _ListPantaiState();
}

class _ListPantaiState extends State<ListPantai> {
  List<Destinasi> listDestinasi = [];
  RepositoryPantai repository = RepositoryPantai();
  int _currentIndex = 0;

  getData() async {
    listDestinasi = await repository.getData();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

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
      appBar: AppBar(
        title: Text('Daftar Pantai'),
      ),
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
      body: ListView.separated(
        itemBuilder: (context, index) {
          final destinasi = listDestinasi[index];
          final imageUrl = repository.getImageUrl(destinasi.images);
          return InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailView(
                  destinasi: destinasi,
                ),
              ),
            ),
            child: Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            listDestinasi[index].nama_destinasi,
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(listDestinasi[index].lokasi),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: listDestinasi.length,
      ),
    );
  }
}
