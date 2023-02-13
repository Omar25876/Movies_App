import 'package:flutter/material.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/ui/screens/search_fragment/search_widget.dart';

class SearchTab extends StatefulWidget {

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  String query = '';
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color.fromRGBO(18, 19, 18, 1.0),
          toolbarHeight: MediaQuery.of(context).size.height*0.1,
          title:  Container(
            margin: EdgeInsets.all(6),
            child: TextFormField(
              style: TextStyle(color: Colors.white,
                fontSize: 21,
              ),
              controller: search,
              onChanged: (String value){
                setState(() {
                  query = value;
                });
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 1.0)),
                ),
                filled: true,
                fillColor: Color.fromRGBO(81, 79, 79, 1.0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 1.0)),
                ),
                prefixIcon: IconButton(onPressed: (){

                },
                  icon: Icon(Icons.search,size: 32,),
                  color: Colors.white,
                ),
                suffixIcon: IconButton(onPressed: (){
                  setState(() {
                    query = '';
                    search.clear();
                  });
                },icon: Icon(Icons.close,size: 32,),
                  color: Colors.white,
                ),
                hintText: 'Search',
                hintStyle: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.6)),
              ),
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(18, 19, 18, 1.0),
        body: query.isEmpty ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Image.asset('assets/iconmaterial.png')),
            SizedBox(height: 10,),
            Center(child: Text('No Movies Found',style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.6),
            ),
            ),
            ),
          ],
        ) :  FutureBuilder(
            future: ApiManager.getSearchMovies(query),
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
              return ListView.separated(
                separatorBuilder: (context, index) => Divider(color: Colors.grey,thickness: 1,indent: 25,endIndent: 25,),
                itemCount: snapShot.data!.results!.length,
                  itemBuilder: (context,index){
                  return SearchWidget(snapShot.data!.results![index]);
                  }
              );
            }
        ),
      ),
    );
  }
}
