
import 'package:flutter/material.dart';

class SimilarOutfitsPage extends StatelessWidget {
  final List<String> wardrobeItems = ['Outfit 1', 'Outfit 2', 'Outfit 3', 'Outfit 4'];
  final List<Map<String, String>> nearbyStores = [
    {'name': 'Store 1', 'location': '0.5 miles away'},
    {'name': 'Store 2', 'location': '1.2 miles away'},
    {'name': 'Store 3', 'location': '2 miles away'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Similar Outfits'),
      ),
      body: Column(
        children: [
          // Similar Items in Wardrobe
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Similar Items in Wardrobe',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: wardrobeItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.image, color: Colors.purple),
                  title: Text(wardrobeItems[index]),
                  subtitle: Text("Last worn: Recently"), // Add relevant details here
                  onTap: () {
                    // Action on selecting similar item in wardrobe
                  },
                );
              },
            ),
          ),
          Divider(),
          // Nearby Stores
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Stores Near You',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: nearbyStores.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.store, color: Colors.blue),
                  title: Text(nearbyStores[index]['name']!),
                  subtitle: Text(nearbyStores[index]['location']!),
                  onTap: () {
                    // Action on selecting store
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

