import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _bannersStream =
        FirebaseFirestore.instance.collection('banners').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _bannersStream,
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
            var bannerData = snapshot.data!.docs[index];

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
                          bannerData['Image'],
                        ),
                      ),
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
