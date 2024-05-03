import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher_string.dart';

class ArticleListPage extends StatefulWidget {
  final String query;

  const ArticleListPage({Key? key, required this.query}) : super(key: key);

  @override
  State<ArticleListPage> createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  List<Map<String, dynamic>> articles = [];
  bool isLoading = false;

  Future<void> _fetchFoodNews(String query) async {
    const apiKey = '3bb380acdf2e49b7ac9f985a13fe53aa';
    const endpoint = 'https://newsapi.org/v2/everything';

    print("fetching data");
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.get(
        Uri.parse('$endpoint?q=$query&apiKey=$apiKey'),
      );
      print("data fetched");
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['articles'] != null) {
          final articlesData = data['articles'];
          setState(() {
            articles = List<Map<String, dynamic>>.from(articlesData);
          });
        }
      } else {
        print('Failed to fetch food news');
      }
    } catch (e) {
      print('error occurred: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchFoodNews(widget.query);
  }

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
              title: Text(
                'Food News',
                style: TextStyle(
                  color: Color(0xFF004AAD), // Set title text color
                  fontWeight: FontWeight.bold,
                ),
              ),
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
            child: isLoading
                ? CircularProgressIndicator()
                : articles.isNotEmpty
                ? ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300], // Grey background color
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // Darker shadow color
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Card(
                      elevation: 0, // Remove default Card elevation
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(
                              article['title'],
                              style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF004AAD)), // Set title text color and bold font
                            ),
                            subtitle: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    article['description'] ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                ClipRRect( // Add border radius to image
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    article['urlToImage'] ?? '',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ArticleDetailsScreen(article: article),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(color: Color(0xFF004AAD)), // Border color
                              ),
                              child: Text(
                                'Read More',
                                style: TextStyle(color: Color(0xFF004AAD)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
                : Center(
              child: Text('No articles found'),
            ),
          ),
        ],
      ),
    );
  }
}

class ArticleDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> article;

  const ArticleDetailsScreen({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final content = article['content'] ?? '';
    final website = article['url'] ?? '';

    const initialCharsToShow = 200;
    final hasMoreChars = content.length > initialCharsToShow;
    final visibleContent = hasMoreChars ? content.substring(0, initialCharsToShow) : content;
    final remainingContent = hasMoreChars ? content.substring(initialCharsToShow) : '';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          article['title'],
          style: TextStyle(color: Color(0xFF004AAD)), // Set title text color
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Source: ${article['source']['name']}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Image.network(article['urlToImage'] ?? ''),
            SizedBox(height: 16.0),
            Text(
              '$visibleContent${hasMoreChars ? '...' : ''}',
              style: TextStyle(fontSize: 16),
            ),
            if (remainingContent.isNotEmpty)
              Text(
                'Remaining content: $remainingContent',
                style: TextStyle(fontSize: 16),
              ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                launchUrl(website);
              },
              child: Text(
                'Website: $website',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.blue, decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void launchUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
