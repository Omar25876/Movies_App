import 'package:flutter/material.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/models/category_model.dart';
import 'package:movies_app/ui/screens/browse_fragment/category_widget.dart';

class BrowseTab extends StatefulWidget {


  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  List<String> imgs = [
    'assets/action.jfif',
    'assets/adventure.jfif',
    'assets/animation.jfif',
    'assets/comedy.jfif',
    'assets/crime.jfif',
    'assets/documentry.jfif',
    'assets/mystery.jfif',
    'assets/fammily.jfif',
    'assets/fantasy.jfif',
    'assets/history.jfif',
    'assets/horror.jfif',
    'assets/music.jfif',
    'assets/mystery.jfif',
    'assets/rromance.jfif',
    'assets/sciencefiction.jfif',
    'assets/tvmovie.jfif',
    'assets/trailler.jfif',
    'assets/wwaarr.jfif',
    'assets/wwastern.jfif',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text('Browse Categories',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            FutureBuilder<Category>(
                future: ApiManager.getCategoryMovies(),
                builder: (context, snapShot) {
                  if(snapShot.hasError){
                    return Center(child: Text('${snapShot.error}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                      ),
                    ),
                    );
                  }
                  else if (snapShot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(
                      color: Color.fromRGBO(255, 187, 59, 1.0),
                    ),
                    );
                  }
                  return Expanded(
                    child: GridView.builder(
                        itemCount: snapShot.data!.genres!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 32,
                          crossAxisSpacing: 32,
                        ),
                        itemBuilder: (context, index) => CategoryWidget(snapShot.data!.genres![index],imgs[index])
                    ),
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}
