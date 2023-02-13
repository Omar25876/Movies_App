import 'package:flutter/material.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/ui/screens/Home_fragment/upcomming_section/upcomming_widget.dart';
import 'package:movies_app/ui/screens/Home_fragment/popular_section/popular_widget.dart';
import 'package:movies_app/ui/screens/Home_fragment/recommended_section/recommended_widget.dart';


class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder<MoviesModel>(
                    future: ApiManager.getPopularMovies(),
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
                       return PopularWidget(snapShot.data!.results!);
                    }
                    ),
////////////////////////////////////////////////////////////
                FutureBuilder<MoviesModel>(
                    future: ApiManager.getNewReleasesMovies(),
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
                      return UpcommingWidget(snapShot.data!.results!);
                    }
                ),

////////////////////////////////////////////////////////////
                FutureBuilder<MoviesModel>(
                    future: ApiManager.getTopRatedMovies(),
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
                      return RecommendedWidget(snapShot.data!.results!,'Recommended');
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
