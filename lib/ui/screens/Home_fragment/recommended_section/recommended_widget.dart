import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/ui/screens/Home_fragment/recommended_section/movie_widget_recommended.dart';


class RecommendedWidget extends StatefulWidget {
  List<Movie> movies;
  String sectionName;


  RecommendedWidget(this.movies,this.sectionName);

  @override
  State<RecommendedWidget> createState() => _RecommendedWidgetState();
}

class _RecommendedWidgetState extends State<RecommendedWidget> {
   bool bookmark = false ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(top: 30),
      color: Color.fromARGB(255, 40, 42, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('${widget.sectionName}',
              style: TextStyle(color: Colors.white, fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(
              enableInfiniteScroll: true,
              disableCenter: false,
              height: MediaQuery.of(context).size.height * 0.45,
              viewportFraction: 0.5,
            ),
            items: widget.movies.map((movie) {
              return Builder(
                builder: (BuildContext context) {
                    return MovieWidget(movie);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
