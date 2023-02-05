import 'package:flutter/material.dart';
import 'package:movies_app/models/popular_movies_model.dart';

class PopularWidget extends StatelessWidget {
  Movies popular ;
  PopularWidget({required this.popular});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 4),
      child: Stack(
        children: [
          Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height*0.3,
              child: Image.network('${popular.backdropPath}',fit: BoxFit.fitWidth,),
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.25,
            width: MediaQuery.of(context).size.height*0.15,
            margin: EdgeInsets.fromLTRB(16, 120, 1, 1),
            child: Image.network('${popular.posterPath}',fit: BoxFit.fitWidth,),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(150, 260, 1, 1),
              child: Text('${popular.title}',style: TextStyle(color: Colors.cyan,fontSize: 23),)
          ),
          Container(
              margin: EdgeInsets.fromLTRB(150, 295, 1, 1),
              child: Text('${popular.releaseDate} ${popular.adult.toString()}  ${popular.genreIds.toString()}',style: TextStyle(color: Colors.cyan,fontSize: 16),)
          ),
        ],
      ),
    );
  }
}
