import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sus_app/colors/colors.dart';

List<dynamic> galleryItems = ['assets/1.jpg', 'assets/2.jpg', 'assets/3.jpg'];

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({
    Key? key,
    required this.description,
    required this.title,
    required this.author,
    required this.tag,
    required this.location,
    required this.upvotes,
  }) : super(key: key);
  final String title;
  final String author;
  final String description;
  final String tag;
  final String location;
  final int upvotes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Information'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            CarouselSlider.builder(
              itemCount: galleryItems.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                return SizedBox(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: SizedBox(
                      //height: 100,
                      //width: 100,
                      child: Image.asset(
                        galleryItems[itemIndex],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                autoPlay: false,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title),
                  const SizedBox(
                    height: 12,
                  ),
                  Text("By $author"),
                  const SizedBox(
                    height: 12,
                  ),
                  Text("Location: $location"),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(description),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                        onPressed: () {},
                        color: textColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Text(
                          'Apply',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
