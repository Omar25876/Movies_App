import 'package:flutter/material.dart';
import 'package:movies_app/ui/screens/Home_fragment/home_fragment.dart';
import 'package:movies_app/ui/screens/browse_fragment/browse_fragment.dart';
import 'package:movies_app/ui/screens/search_fragment/search_fragment.dart';
import 'package:movies_app/ui/screens/watchlist_fragment/watchlist_fragment.dart';



class HomeMainScreen extends StatefulWidget {

  static String routeName = 'Home Screen';

  @override
  State<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  int currentIndex = 0;

  List<Widget> tabs = [
    HomeTab(),
    SearchTab(),
    BrowseTab(),
    WatchlistTab(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            currentIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                icon: const ImageIcon(
                  AssetImage('assets/home.png'),
                  size: 40,
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
                label: 'HOME',
            ),
            BottomNavigationBarItem(
                icon: const ImageIcon(
                  AssetImage(
                    'assets/search.png',
                  ),
                  size: 40,
                ),
              label: 'SEARCH',
            ),
            BottomNavigationBarItem(
                icon: const ImageIcon(
                  AssetImage(
                    'assets/movie.png',
                  ),
                  size: 40,
                ),
              label: 'BROWSE',
            ),
            BottomNavigationBarItem(
                icon: const ImageIcon(
                  AssetImage(
                    'assets/bookmarks.png',
                  ),
                  size: 40,
                ),
              label: 'WATCHLIST',
            ),
          ],
      ),


      body: tabs[currentIndex],
    );
  }
}
