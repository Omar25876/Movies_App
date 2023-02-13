import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/ui/screens/Home_fragment/upcomming_section/movie_widget_upcoming.dart';


class UpcommingWidget extends StatefulWidget {
 List<Movie> movies;

  UpcommingWidget(this.movies);

  @override
  State<UpcommingWidget> createState() => _UpcommingWidgetState();
}

class _UpcommingWidgetState extends State<UpcommingWidget> {

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
            child: Text('New Releases',
              style: TextStyle(color: Colors.white, fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(
              enableInfiniteScroll: true,
              disableCenter: false,
              height: MediaQuery.of(context).size.height * 0.35,
              viewportFraction: 0.4,
            ),
            items: widget.movies.map((mov){
              return Builder(
                builder: (BuildContext context) {
                  return MovieUpcommingWidget(mov);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
