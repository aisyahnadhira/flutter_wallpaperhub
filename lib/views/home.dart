import 'package:flutter/material.dart';
import 'package:wallpaperhub/data/data.dart';
import 'package:wallpaperhub/model/categories_model.dart';
import 'package:wallpaperhub/widgets/widget.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategorieModel> categories = [];
  @override
  void initState() {
    categories = getCategories();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: brandName(),
        elevation: 0.0,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xfff5f8fd),
                borderRadius: BorderRadius.circular(30)
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              margin: EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search Wallpaper",  
                        border: InputBorder.none                      
                      ),
                    ),
                  ),
                  Icon(Icons.search)
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              height: 80,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24),
                itemCount: categories.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CategoriesTile(
                    title: categories[index].categorieName!,
                    imgUrl: categories[index].imgUrl!,
                          
                  );
                }),
            )
            
          ],
        ),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  String imgUrl, title;

  CategoriesTile({required this.imgUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 4.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(imgUrl, height: 50, width: 100, fit: BoxFit.cover),
           ),
          Container(
            color: Colors.black26,
            height: 50, width: 100,
            alignment: Alignment.center,
            child: Text(title, 
              style: TextStyle(
                color: Colors.white, 
                fontWeight: FontWeight.w500, 
                fontSize: 15),
                ),
          )
        ],
      ),
    );
  }
}