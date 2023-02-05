import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/ui/screens/Home_fragment/popular_widget.dart';

import '../../../models/popular_movies_model.dart';

class PopularList extends StatelessWidget {
  List<Movies> pages;

  PopularList(this.pages);


  @override
  Widget build(BuildContext context) {
    return Container(
        child: CarouselSlider(
          options: CarouselOptions(
            disableCenter: true,
          ),
          items: pages.map((page) =>
              Container(
                child: PopularWidget(popular: page,),
              )).toList(),
        )
    );
  }
}
