import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharptrack/skeleton.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController control = TextEditingController();

  @override
  void initState() {
    super.initState();
    control.text = Provider.of<Skeleton>(context, listen: false).name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back),
        ),
        title: const Text('Edit Profile'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 40, left: 40, right: 40),
        child: Column(
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
                  child: Consumer<Skeleton>(
                    builder: (context, value, child) => Text(
                      value.name[0],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: TextFormField(
                  controller: control,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(), icon: Icon(Icons.edit)),
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Center(
                child: SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    var name = control.text;
                    Provider.of<Skeleton>(context, listen: false).setName =
                        name;
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('Saved!')));
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  )),
            ))
          ],
        ),
      ),
    );
  }
}
