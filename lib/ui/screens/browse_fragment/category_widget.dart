import 'package:flutter/material.dart';
import 'package:movies_app/models/category_model.dart';
import 'package:movies_app/ui/screens/browse_fragment/browse_results.dart';

class CategoryWidget extends StatelessWidget {
  Genres category;
  String img ;
  CategoryWidget(this.category, this.img);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, BrowseResults.routeName,arguments: category);
      },
      child: Container(
        margin: EdgeInsets.only(left: 12,right: 12),
        height: MediaQuery.of(context).size.width*0.1,
        width: MediaQuery.of(context).size.width*0.1,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset('$img',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width*1,
              height: MediaQuery.of(context).size.height*0.8,
              colorBlendMode: BlendMode.darken,
              color: Colors.grey,
            ),
            Text('${category.name}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
