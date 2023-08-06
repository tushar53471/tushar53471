import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mega_web_admin/views/screens/side_bar_screens/widgets/category_widget.dart';

class CategoriesScreen extends StatefulWidget {
  static const String routeName = '\CategoriesScreen';
  const CategoriesScreen({super.key});
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String categoryName;
  dynamic _image;
  String? fileName;

  _pickImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);

    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;

        fileName = result.files.first.name;
      });
    }
  }

  _uploadCategoryBannerToStorage(dynamic image) async {
    Reference ref = _firebaseStorage.ref().child('category').child(fileName!);

    UploadTask uploadTask = ref.putData(image!);

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }

  uploadToFirebase() async {
    EasyLoading.show();
    if (_formKey.currentState!.validate()) {
      if (_image != null) {
        String imageUrl = await _uploadCategoryBannerToStorage(_image);
        print(imageUrl);
        await _firestore.collection('category').doc(fileName).set({
          'categoryImage': imageUrl,
          'categoryName': categoryName,
        }).whenComplete(() {
          setState(() {
            _formKey.currentState!.reset();
            _image = null;

            EasyLoading.dismiss();
          });
        });
      } else {
        EasyLoading.dismiss();
      }
    } else {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Category',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 36,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        children: [
                          Container(
                            height: 140,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade500,
                              border: Border.all(
                                color: Colors.grey.shade800,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: _image != null
                                  ? Image.memory(_image)
                                  : Text('Category'),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.yellow.shade900,
                            ),
                            onPressed: () {
                              _pickImage();
                            },
                            child: Text(
                              'Upload Image',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 200,
                      child: TextFormField(
                        onChanged: (value) {
                          categoryName = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Category Name Must Not be empty';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Enter Category Name',
                          hintText: 'Enter Category Name',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.yellow.shade900,
                      ),
                      onPressed: () {
                        uploadToFirebase();
                      },
                      child: Text('Save'),
                    )
                  ],
                ),
                Divider(
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                CategoryWidget()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
