import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/database_utils/database_utils.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/ui/screens/Home_fragment/recommended_section/recommended_widget.dart';

class MovieDetails extends StatefulWidget {
static const String routeName = 'MovieDetails';

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
String img = 'https://image.tmdb.org/t/p/w500';
int isSelected = 0;
bool f = true;
@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    Movie args = ModalRoute.of(context)!.settings.arguments as Movie;
    if(f){
      checkMovieInFireStore(args);
      f = false;
    }
    return Scaffold(
      backgroundColor: Color.fromRGBO(18, 19, 18, 1.0),
      appBar: AppBar(
        title: Text('${args.title}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 28
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.3,
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: "$img${args.backdropPath}",
                    imageBuilder: (context, imageProvider) => Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Center(child: Icon(Icons.error,color: Colors.red,size: 42,)),
                  ),
                  Positioned(
                      top: MediaQuery.of(context).size.height * 0.1,
                      left: MediaQuery.of(context).size.width * 0.45,
                      child: Image.asset('assets/playbutton.png')
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                '${args.title}',
                style: TextStyle(color: Colors.white, fontSize: 18,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0,bottom: 8),
              child: Text(
                '${args.releaseDate!.substring(0, 4)}  PG-13  ${args.originalLanguage}',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.3,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.5,
                      child: Stack(
                        children: [
                          Positioned(
                            width: MediaQuery.of(context).size.width * 0.32,
                            height: MediaQuery.of(context).size.height * 0.28,
                            top: MediaQuery.of(context).size.height * 0.01,
                            left:MediaQuery.of(context).size.height * 0.010 ,
                            child: CachedNetworkImage(
                              imageUrl: "$img${args.posterPath}",
                              imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => Center(child: Icon(Icons.error,color: Colors.red,size: 42,)),
                            ),
                          ),
                          Positioned(
                              top: MediaQuery.of(context).size.height * 0.01,
                              left: MediaQuery.of(context).size.width * 0.02,
                              child: InkWell(
                                  onTap: (){
                                    isSelected=1-isSelected;
                                    if(isSelected==1){
                                      DatabaseUtils.AddMoviesToFirebase(args);
                                    }
                                    else{
                                      DatabaseUtils.DeletTask('${args.DataBaseId}');
                                    }
                                    setState(() {

                                    });
                                  },
                                  child:  isSelected == 0 ? Image.asset('assets/bookmark.png'):Image.asset('assets/bookmarkSelected.png')
                              ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${args.overview}',
                            style: TextStyle(color: Colors.grey, fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 5,
                          ),
                          SizedBox(height: 8,),
                          Row(
                            children: [
                              Image.asset('assets/star.png'),
                              SizedBox(width: 4,),
                              Text(
                                '${args.voteAverage}',
                                style: TextStyle(color: Colors.white, fontSize: 16,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder<MoviesModel>(
                future: ApiManager.getSimilarMovies(args.id),
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
                  return RecommendedWidget(snapShot.data!.results!,'More Like This');
                }
            ),
          ],
        ),
      ),
    );
  }
Future<void> checkMovieInFireStore (Movie mv)async{
  QuerySnapshot<Movie> temp= await DatabaseUtils.readMovieFormFirebase(mv.id!);
  if(temp.docs.isEmpty){
  }else{
    mv.DataBaseId=temp.docs[0].data().DataBaseId;
    isSelected=1;
    setState(() {
    });
  }
}
}
