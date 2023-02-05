import 'package:flutter/material.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/models/popular_movies_model.dart';
import 'package:movies_app/ui/screens/Home_fragment/popular_list.dart';


class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: Scaffold(
        body: FutureBuilder<PopularMoviesModel>(
            future: ApiManager.getPopularMovies(),
            builder: (context, snapShot) {
               if (snapShot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Center(
                      child: Text(
                        'get popular movies error! ${snapShot.error.toString()}',
                        style: TextStyle(fontSize: 21, color: Colors.white),
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
               return Center(child: Text('${snapShot.data!.page}',style: TextStyle(color: Colors.cyanAccent),));
            }
            ),
      ),
    );
  }
}
