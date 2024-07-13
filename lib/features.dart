import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mechanic_app/imagescreen.dart';
import 'package:mechanic_app/taskmodel.dart';

class Camera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text('Unit Detials')),
              Center(
                child: Text(
                  'Samsung S02EV6', // Replace with actual device name
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
          bottom: TabBar(
            // indicator: BoxDecoration(backgroundBlendMode: , color: Colors.white),
            labelColor: Colors.blue, // Selected tab color
            unselectedLabelColor: Colors.grey, // Unselected tab color
            indicatorColor: Colors.blue, // Indicator color
            tabs: [
              Tab(
                text: 'Specification',
              ),
              Tab(text: 'Docs'),
              Tab(text: 'Part List'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SpecificationScreen(),
            DocsScreen(),
            PartListScreen(),
          ],
        ),
      ),
    );
  }
}

class SpecificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Samsung S02EV6',
                    style: TextStyle(color: Colors.black, fontSize: 24),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Washing machine . Samsung',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('tasks')
                      .snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    List<Taskmodel> tasks = snapshot.data!.docs
                        .map((doc) => Taskmodel.frommap(doc.data()))
                        .toList();

                    return SizedBox(
                      height: _mediaQuery.size.height * 0.1 * 1.8,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          Taskmodel task = tasks[index];

                          // Assuming task.photo is a List<String> of image URLs
                          return Row(
                            children: List.generate(
                              task.photo.length,
                              (photoIndex) => Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: _mediaQuery.size.height * 0.02),
                                child: Product_Image(
                                  mediaQuery: _mediaQuery,
                                  image: task.photo[photoIndex],
                                ),
                              ),
                            ).toList(),
                          );
                        },
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Performance',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                        Performance_List(
                            text: 'Engine Type                : V6'),
                        Performance_List(
                            text: 'Horsepower                : 300 HP'),
                        Performance_List(
                            text: 'Torque                         : 400 Nm'),
                        Performance_List(
                            text: 'Fuel Efficiency            : 25 mpg'),
                        Performance_List(
                            text: 'Engine Oil Level          : Good'),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Features',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                        Performance_List(
                            text: 'Engine Type                : V6'),
                        Performance_List(
                            text: 'Horsepower                : 300 HP'),
                        Performance_List(
                            text: 'Torque                         : 400 Nm'),
                        Performance_List(
                            text: 'Fuel Efficiency            : 25 mpg'),
                        Performance_List(
                            text: 'Engine Oil Level          : Good'),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Performance_List extends StatelessWidget {
  const Performance_List({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class Product_Image extends StatelessWidget {
  const Product_Image({
    super.key,
    required MediaQueryData mediaQuery,
    required this.image,
  }) : _mediaQuery = mediaQuery;

  final MediaQueryData _mediaQuery;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => FullScreenImage(image: image),
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: _mediaQuery.size.height * .22,
          width: _mediaQuery.size.width * .45,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.fill)),
        ),
      ),
    );
  }
}

class DocsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Docs Content Here'),
    );
  }
}

class PartListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Part List Content Here'),
    );
  }
}
