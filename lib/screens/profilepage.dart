import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back),
        ),
        title: Text('Edit Profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(blurRadius: 5, color: Colors.black, spreadRadius: 2)
              ],
            ),
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width / 5,
              backgroundColor: Colors.white,
              child: GestureDetector(
                onTap: () {
                  print('Tapped');
                },
                child: const Text(
                  'S',
                  style: TextStyle(color: Colors.black, fontSize: 40.0),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              child: TextFormField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(), icon: Icon(Icons.edit)),
                style: TextStyle(fontSize: 18.0),
                initialValue: 'Saurabh',
              ),
            ),
          ),
          SizedBox(
            height: 180.0,
          ),
          Center(
              child: SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Saved!')));
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                )),
          ))
        ],
      ),
    );
  }
}
