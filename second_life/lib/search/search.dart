import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class search extends StatefulWidget {
  const search({super.key});

  @override
  State<search> createState() => _searchState();
}

List results = [];

class _searchState extends State<search> {
  getOrgs() async {
    await FirebaseFirestore.instance
        .collection('orgs')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        results.add(doc);
      });
    });
    setState(() {
      results;
    });
  }

  @override
  void initState() {
    getOrgs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Center(
            child: Text(
              "Find organization",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
        ),
        body: results.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      width: 150,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: Color.fromARGB(255, 160, 232, 162))
                        ],
                      ),
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage("assets/login.png"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Organization name : ${results[i]['orgnisation']}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "Phone number : ${results[i]['phone']}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "Address : ${results[i]['adr']}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }));
  }
}
