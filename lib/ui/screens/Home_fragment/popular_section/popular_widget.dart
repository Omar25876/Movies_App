import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/ui/screens/Home_fragment/popular_section/movie_widget_popular.dart';

import '../../../../models/movie_model.dart';

class PopularWidget extends StatefulWidget {
  List<Movie> movies;

  PopularWidget(this.movies);

  @override
  State<PopularWidget> createState() => _PopularWidgetState();
}

class _PopularWidgetState extends State<PopularWidget> {


  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(seconds: 3),
        autoPlayInterval: Duration(seconds: 10),
        pauseAutoPlayOnTouch: true,
        autoPlayCurve: Curves.fastLinearToSlowEaseIn,
        height: MediaQuery.of(context).size.height * 0.4,
        viewportFraction: 1.0,
      ),
      items: widget.movies.map((movie) {
        return Builder(
          builder: (BuildContext context) {
            return MoviePopularWidget(movie);
          },
        );
      }).toList(),
    );
  }
}
