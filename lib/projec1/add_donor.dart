import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddDonor extends StatefulWidget {
  const AddDonor({super.key});

  @override
  State<AddDonor> createState() => _AddDonorState();
}

class _AddDonorState extends State<AddDonor> {

  final bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  String? selectedGroup;
  // to acces data inside textfeild 
  TextEditingController donorName = TextEditingController();
  TextEditingController donorPhone = TextEditingController();
  

  // creating instance for firestore collection
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');

  // create function to add donor
  void addDonor() {
    final data = {'name': donorName.text, 'phone': donorPhone.text, 'group': selectedGroup};
    donor.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'Add Donor',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: TextField(
              controller: donorName,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text('donor name')),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: TextField(
              controller: donorPhone,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text('phone Number')),
              maxLength: 10,
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: DropdownButtonFormField(
              decoration: InputDecoration(label: Text('select blood group')),
              items: bloodGroups
                  .map((group) => DropdownMenuItem(
                        child: Text(group),
                        value: group,
                      ))
                  .toList(),
              onChanged: (val) {
                selectedGroup = val as String?;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: ElevatedButton(
              child: Text('Submit', style: TextStyle(color: Colors.white, fontSize: 20),),
              onPressed: () {
                addDonor();
                Navigator.pop(context);
                },
              style: ButtonStyle(
                minimumSize:
                    MaterialStateProperty.all(Size(double.infinity, 50)),
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
            ),
          )
        ],
      ),
    );
  }
}
