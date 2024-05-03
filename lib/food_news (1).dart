import 'package:flutter/material.dart';

class FoodNews extends StatelessWidget {
  final List<List<dynamic>> newsData;
  const FoodNews({
    super.key,
    this.newsData = const [
      [
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
        'Steve Smith',
        '29 Jan',
        '11:00 am',
        'https://tse1.mm.bing.net/th?id=OIP.L4WKHsB30JW9Qmc7A870AAHaE8&pid=Api&P=0&h=180',
      ],
      [
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
        'Steve Smith',
        '29 Jan',
        '11:00 am',
        'https://tse1.mm.bing.net/th?id=OIP.L4WKHsB30JW9Qmc7A870AAHaE8&pid=Api&P=0&h=180',
      ],
      [
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
        'Steve Smith',
        '29 Jan',
        '11:00 am',
        'https://tse1.mm.bing.net/th?id=OIP.L4WKHsB30JW9Qmc7A870AAHaE8&pid=Api&P=0&h=180',
      ],
      [
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
        'Steve Smith',
        '29 Jan',
        '11:00 am',
        'https://tse1.mm.bing.net/th?id=OIP.L4WKHsB30JW9Qmc7A870AAHaE8&pid=Api&P=0&h=180',
      ],
      [
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
        'Steve Smith',
        '29 Jan',
        '11:00 am',
        'https://tse1.mm.bing.net/th?id=OIP.L4WKHsB30JW9Qmc7A870AAHaE8&pid=Api&P=0&h=180',
      ],
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        toolbarHeight: 90,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: Row(children: [
          const SizedBox(
            width: 13,
          ),
          InkWell(
            child: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 1,
                      ),
                    ]),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 35,
                )),
          ),
        ]),
        title: const Text(
          'Food News',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 10,
          bottom: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Today\u0027s News',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ...newsData
                  .map((singleNews) => SingleNewsSection(singleNews: singleNews)),
            ],
          ),
        ),
      ),
    );
  }
}

class SingleNewsSection extends StatelessWidget {
  final List<dynamic> singleNews;
  const SingleNewsSection({super.key, required this.singleNews});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 8,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 250,
                child: Column(
                  children: [
                    Text(
                      trimString(singleNews[0], 80),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(singleNews[1]),
                          const SizedBox(width: 10,),
                          Container(
                            child: Row(
                              children: [
                                 Icon(
                                  Icons.circle,
                                  size: 8,
                                  color: Colors.grey[300],
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(singleNews[2]),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Container(
                            child: Row(
                              children: [
                                 Icon(
                                  Icons.circle,
                                  size: 8,
                                  color: Colors.grey[300],
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(singleNews[3]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  singleNews[4],
                  fit: BoxFit.cover,
                  height: 130,
                  width: 100,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15,),
          Divider(
            color: Colors.grey[300],
            height: 20,
            thickness: 2,
          ),
        ],
      ),
    );
  }

  String trimString(String input, int maxLength) {
    if (input.length <= maxLength) {
      return input;
    } else {
      return input.substring(0, maxLength) + "...";
    }
  }
}
