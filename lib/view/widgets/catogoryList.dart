import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  CategoryList({super.key});

  final List<String> imageUrls = const [
    'https://freepngimg.com/thumb/fruit/4-2-fruit-png-image-thumb.png',
    'https://static.vecteezy.com/system/resources/previews/022/984/730/non_2x/vegetable-transparent-free-png.png',
    'https://static.vecteezy.com/system/resources/thumbnails/035/135/256/small_2x/ai-generated-five-spice-ingredient-free-png.png',
    'https://atlas-content-cdn.pixelsquid.com/stock-images/small-bottle-of-milk-rv2NEl2-600.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcRv7nBLc4iPRtcJFc6c41nudS-j8EGbnj5UCP-ZPXIw&s',
  ];
  final List<String> categoryName = [
    'Fruit',
    'Veggie',
    'Spice',
    'Diary',
    'Bread'
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
            child: SizedBox(
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    SizedBox(
                      width: 80,
                      height: 65,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: Image.network(
                          imageUrls[index],
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Text(
                      categoryName[index],
                      style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
