import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/models/category_model.dart';
import 'package:movies_app/ui/screens/search_fragment/search_widget.dart';

class BrowseResults extends StatelessWidget {
  static const String routeName = 'Browse Results';
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Genres;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${args.name}',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevation: 0.0,
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(
        children: [
          FutureBuilder(
              future: ApiManager.getCategoryMoviesList(args.id),
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
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                      itemCount: snapShot.data!.results!.length,
                      itemBuilder: (context, index) => SearchWidget(snapShot.data!.results![index]),
                  ),
                );
              }
          ),
        ],
      ),

    );
  }
}
