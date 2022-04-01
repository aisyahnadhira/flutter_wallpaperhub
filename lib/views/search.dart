import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wallpaperhub/widgets/widget.dart';
import 'package:wallpaperhub/model/wallpaper_model.dart';
import 'package:http/http.dart' as http;

import '../data/data.dart';

class Search extends StatefulWidget {
  final String searchQuery;
  Search({required this.searchQuery});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  List<WallpaperModel> wallpapers = [];

  getSearchWallpapers(String query) async{
    var response = await http.get(Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=15&page=1"), 
    headers: {"Authorization": apiKey});

    // print(response.body.toString());

    Map<String,dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element){
      // print(element);
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {
      
    });
  }

  @override
  void initState() {
    getSearchWallpapers(widget.searchQuery);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: "Search Wallpaper",  
                          border: InputBorder.none                      
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                      Navigator.push(context,MaterialPageRoute(
                        builder: (context) => Search(searchQuery: searchController.text,
                        ),
                        ),
                      );
                      },
                      child: Container(
                        child: Icon(Icons.search)),
                    )
                  ],
                ),
              ),
            ],
          )
      )
    );
  }
}