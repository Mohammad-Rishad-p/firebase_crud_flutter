import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateDonor extends StatefulWidget {
  const UpdateDonor({super.key});

  @override
  State<UpdateDonor> createState() => _UpdateDonorState();
}

class _UpdateDonorState extends State<UpdateDonor> {

  final bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  String? selectedGroup;
  // to acces data inside textfeild 
  TextEditingController donorName = TextEditingController();
  TextEditingController donorPhone = TextEditingController();

  //function to update donor
  void updateDonor(docId){
    final data = {'name': donorName.text, 'phone': donorPhone.text, 'group': selectedGroup};
    donor.doc(docId).update(data).then((value) => Navigator.pop(context));
  }
  

  // creating instance for firestore collection
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');


  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as Map;
    donorName.text = args['name'];
    donorPhone.text = args['phone'];
    selectedGroup = args['group'];
    final docId = args['id'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'Update Donor',
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
              value: selectedGroup,
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
              child: Text('Update', style: TextStyle(color: Colors.white, fontSize: 20),),
              onPressed: () {
                print(args);
                updateDonor(docId);
                // Navigator.pop(context);
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
