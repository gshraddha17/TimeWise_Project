import 'package:flutter/material.dart';
import 'package:timewise/food_nexus.dart';
import './edit_profile.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffeae9e9),
        elevation: 5,
        toolbarHeight: 70,
        title: Text(
          'User Profile',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: Row(children: [
          const SizedBox(
            width: 8,
          ),
          InkWell(
            child: Container(
                // height: 60,
                // padding: const EdgeInsets.all(4.0),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 1,
                      ),
                    ]),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.black,
                  iconSize: 30,
                  onPressed: () {
                    Navigator.pop(
                        context); // Navigate back to the previous page
                  },
                )),
          ),
        ]),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Personal Info'),
            Tab(text: 'Food Nexus'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Personal Info tab
          EditProfilePage(),
          // Food Nexus tab
          FoodNexusTab(),
        ],
      ),
    );
  }
}

// class PersonalInfoTab extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Personal Info Tab Content'),
//     );
//   }
// }


