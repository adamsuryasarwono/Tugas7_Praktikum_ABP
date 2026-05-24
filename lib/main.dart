import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Map<String, String>> foods = [
    {
      'name': 'Nasi Goreng',
      'image': 'assets/nasigoreng.png',
      'desc': 'Makanan khas Indonesia yang sangat populer.'
    },
    {
      'name': 'Sate',
      'image': 'assets/sate.jpg',
      'desc': 'Daging tusuk dengan bumbu kacang lezat.'
    },
    {
      'name': 'Mie Ayam',
      'image': 'assets/mieayam.jpg',
      'desc': 'Masakan mie dengan daging ayam yang manis.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Makanan Favorit',
      home: HomePage(foods: foods),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Map<String, String>> foods;

  const HomePage({super.key, required this.foods});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Makanan Favorit'),
        backgroundColor: Colors.orange,
      ),
      body: ListView.builder(
        itemCount: foods.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Image.asset(
                  foods[index]['image']!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),

                SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        foods[index]['name']!,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 8),

                      Text(foods[index]['desc']!),

                      SizedBox(height: 10),

                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                name: foods[index]['name']!,
                                image: foods[index]['image']!,
                                desc: foods[index]['desc']!,
                              ),
                            ),
                          );
                        },
                        child: Text('Lihat Detail'),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  final String name;
  final String image;
  final String desc;

  const DetailPage({
    super.key,
    required this.name,
    required this.image,
    required this.desc,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              widget.image,
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
            ),

            SizedBox(height: 15),

            Text(
              widget.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(widget.desc),

            SizedBox(height: 20),

            TextField(
              controller: commentController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Masukkan komentar',
              ),
            ),

            SizedBox(height: 15),

            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Komentar: ${commentController.text}',
                    ),
                  ),
                );
              },
              child: Text('Kirim'),
            )
          ],
        ),
      ),
    );
  }
}