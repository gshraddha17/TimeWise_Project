import 'package:flutter/material.dart';

class ParticularNews extends StatelessWidget {
  const ParticularNews({super.key});

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
      body: SingleChildScrollView(
        child:  Padding(
          padding: const EdgeInsets.only(
            left: 18,
            right: 18,
            bottom:10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              const Text('Lorem Ipsum is simply dummy text of the printing.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(0, 74, 173, 1),
                fontSize: 21,
              ),),
              const SizedBox(height: 8,),
              const Text('By ABCDEFGH', style: TextStyle(
                fontSize: 15,
              ),),
              const SizedBox(height: 8,),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  "https://cdn.perishablenews.com/2022/09/a-p1.jpg",
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 15,),
              const Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'),
            ],
          ),
        ),
      ),
    );
  }
}
