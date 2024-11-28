import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  final TextEditingController instructionsController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  final List<String> mealTypes = ['Breakfast', 'Brunch', 'Lunch', 'Dinner', 'Dessert'];
  List<String> selectedMealTypes = [];
  bool isLoading = false;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveRecipe() async {
    if (nameController.text.isEmpty || ingredientsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all required fields.')),
      );
      return;
    }

    final newRecipe = {
      'name': nameController.text.trim(),
      'description': descriptionController.text.trim(),
      'ingredients': ingredientsController.text.split(',').map((e) => e.trim()).toList(),
      'instructions': instructionsController.text.trim(),
      'image': imageUrlController.text.isNotEmpty ? imageUrlController.text.trim() : null,
      'mealTypes': selectedMealTypes,
      'favorite': false, // Default favorite status
      'createdAt': FieldValue.serverTimestamp(), // Timestamp for creation
    };

    setState(() {
      isLoading = true;
    });

    try {
      await _firestore.collection('recipes').add(newRecipe);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recipe saved successfully!')),
      );
      Navigator.pop(context); // Return to the previous screen
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving recipe: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Recipe'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Recipe Name'),
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  TextField(
                    controller: ingredientsController,
                    decoration: const InputDecoration(labelText: 'Ingredients (comma separated)'),
                  ),
                  TextField(
                    controller: instructionsController,
                    decoration: const InputDecoration(labelText: 'Instructions'),
                    maxLines: 4,
                  ),
                  TextField(
                    controller: imageUrlController,
                    decoration: const InputDecoration(labelText: 'Image URL'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Select Meal Types:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: mealTypes.map((type) {
                      return CheckboxListTile(
                        title: Text(
                          type,
                          style: const TextStyle(
                            color: Color(0xffe17aa0), // Custom color for meal type text
                          ),
                        ),
                        value: selectedMealTypes.contains(type),
                        onChanged: (bool? selected) {
                          setState(() {
                            if (selected == true) {
                              selectedMealTypes.add(type);
                            } else {
                              selectedMealTypes.remove(type);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: saveRecipe,
                    child: const Text('Save Recipe'),
                  ),
                ],
              ),
            ),
    );
  }
}
