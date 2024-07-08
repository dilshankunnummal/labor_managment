import 'package:flutter/material.dart';
import 'package:labor_managment/components/user_drawer.dart';
import 'package:labor_managment/model/worker_model.dart';
import 'package:labor_managment/user/workers_list_page.dart';
import 'package:labor_managment/worker/worker_details_page.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<UserHome> {
  bool _isSearching = false;
  List<String> _searchList = [];

  // final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  List imageList = [
    {"id": 1, "image_path": 'assets/images/clean.jpg'},
    {"id": 2, "image_path": 'assets/images/electrician.jpg'},
    {"id": 3, "image_path": 'assets/images/plumber.jpg'},
  ];
  final List<IconData> _jobTypeIcons = [
    Icons.format_paint,
    Icons.child_care,
    Icons.plumbing,
    Icons.cleaning_services,
    Icons.restaurant,
    Icons.electrical_services,
    Icons.fitness_center,
    Icons.security
  ];

  @override
  Widget build(BuildContext context) {
    void _handleCategoryTap(String selectedCategory) {
      Navigator.pushNamed(context, '/workersList',
          arguments: {'jobCategory': selectedCategory});
    }

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search...',
                ),
                autofocus: true,
                style: const TextStyle(
                    fontSize: 16, letterSpacing: 1, color: Colors.black),
                onChanged: (val) {
                  _searchList = WorkerModel.jobTypes
                      .where((job) =>
                          job.toLowerCase().contains(val.toLowerCase()))
                      .toList();
                  setState(() {});
                },
              )
            : const Text(
                'Search',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
        backgroundColor: Colors.white, // Assuming primaryColor is blue
        actions: [
          IconButton(
            icon: Icon(
              _isSearching ? Icons.cancel : Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchList.clear();
                }
              });
            },
          ),
        ],
      ),
      drawer: const DrawerUser(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white, // Assuming primaryColor is blue
              Colors.lightBlueAccent, // Assuming secondaryColor is light blue
            ],
          ),
        ),
        child: ListView(
          children: <Widget>[
            const Card(
              color: Colors.white, // Assuming primaryColor is blue
              child: Center(
                  // child: CarouselSlider(
                  //   items: imageList
                  //       .map(
                  //         (item) => Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Material(
                  //             shadowColor: Colors.black,
                  //             elevation: 2,
                  //             borderRadius: BorderRadius.circular(10),
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(10),
                  //                 image: DecorationImage(
                  //                   image: AssetImage(item['image_path']),
                  //                   fit: BoxFit.fill,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       )
                  //       .toList(),
                  //   carouselController: carouselController,
                  //   options: CarouselOptions(
                  //     scrollPhysics: const BouncingScrollPhysics(),
                  //     autoPlay: true,
                  //     aspectRatio: 1.6,
                  //     viewportFraction: 1,
                  //     onPageChanged: (index, reason) {
                  //       setState(() {
                  //         currentIndex = index;
                  //       });
                  //     },
                  //   ),
                  // ),
                  ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two items per row
                ),
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: _isSearching
                    ? _searchList.length
                    : WorkerModel.jobTypes.length,
                itemBuilder: (BuildContext context, int index) {
                  final jobType = _isSearching
                      ? _searchList[index]
                      : WorkerModel.jobTypes[index];
                  final icon = _jobTypeIcons[index % _jobTypeIcons.length];
                  return Card(
                    color: Colors.white, // Assuming primaryColor is blue
                    elevation: 4.0,
                    margin: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListTile(
                          subtitle: Column(
                            children: [
                              const SizedBox(
                                height: 40,
                              ),
                              Icon(
                                icon,
                                size: 70,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          title: Text(jobType,
                              style: TextStyle(color: Colors.black)),
                          onTap: () {
                            _handleCategoryTap(jobType);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
