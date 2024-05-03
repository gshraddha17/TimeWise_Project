import 'package:flutter/material.dart';
import 'article_news.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Stack(
          children: [
            Image.asset(
              'assets/images/background_image.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            AppBar(
              title: Text('Food News'),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
              'assets/images/background_image.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          Center(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 50.0,
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Enter your search query',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),

                       ElevatedButton(
                        onPressed: () {
                           Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArticleListPage(query: _searchController.text),
                      ),
                    );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Color(0xFF004AAD),
                          backgroundColor: Colors.white, // Highlighted color
                          side: BorderSide(color: Color(0xFF004AAD)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        ),
                        child: const Text("Search for Food News"),
                      
                    ),

                // ElevatedButton(
                   
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => ArticleListPage(query: _searchController.text),
                //       ),
                //     );
                //   },
                //   child: const Text("Search for Food News"),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
