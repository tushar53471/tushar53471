import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _categoriesStream =
        FirebaseFirestore.instance.collection('category').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _categoriesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.cyan,
            ),
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              'No Categories\n Added yet',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 30,
              ),
            ),
          );
        }
        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: snapshot.data!.size,
          itemBuilder: (context, index) {
            var categoryData = snapshot.data!.docs[index];

            return Column(
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.network(
                          categoryData['categoryImage'],
                          width: double.infinity,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          categoryData['categoryName'],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
