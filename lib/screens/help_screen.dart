import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'How to Use LensLend',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const ListTile(
              leading: Icon(Icons.person_add, color: Colors.blue),
              title: Text(
                'Sign up or log in to your account.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.camera_alt, color: Colors.blue),
              title: Text(
                'Browse through the available photography equipment.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.shopping_cart, color: Colors.blue),
              title: Text(
                'Select the equipment you want to rent and proceed to checkout.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.access_time, color: Colors.blue),
              title: Text(
                'Enjoy your rented equipment and return it on time.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Frequently Asked Questions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Q: How do I create an account?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'A: You can create an account by clicking on the "Sign Up" button on the home screen.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Q: What payment methods are accepted?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'A: We accept all major credit cards and PayPal.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Q: How do I return the equipment?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'A: You can return the equipment by following the instructions provided during the rental process.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
