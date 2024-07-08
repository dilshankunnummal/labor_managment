import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:labor_managment/components/user_drawer.dart';
import 'package:labor_managment/model/worker_model.dart';
import 'package:labor_managment/worker/worker_details_page.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<UserHome> {
  bool _isSearching = false;
  List<String> _searchList = [];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  List imageList = [
    {"id": 1, "image_path": 'assets/images/img1.jpg'},
    {"id": 2, "image_path": 'assets/images/img2.jpg'},
    {"id": 3, "image_path": 'assets/images/img3.jpg'}
  ];
  final List<IconData> _jobTypeIcons = [
    Icons.cookie_outlined,
    Icons.home,
    Icons.pets,
    Icons.face
  ];

  @override
  Widget build(BuildContext context) {
    void _handleCategoryTap(String selectedCategory) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => WorkerList(jobType: selectedCategory),
        ),
      );
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
                    fontSize: 16, letterSpacing: 1, color: black),
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
                  color: black,
                ),
              ),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon:
                Icon(_isSearching ? Icons.cancel : Icons.search, color: black),
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
              primaryColor,
              secondaryColor,
            ],
          ),
        ),
        child: ListView(
          children: <Widget>[
            Card(
              color: primaryColor,
              child: Center(
                child: CarouselSlider(
                  items: imageList
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            shadowColor: black,
                            elevation: 2,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage(item['image_path']),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  carouselController: carouselController,
                  options: CarouselOptions(
                    scrollPhysics: const BouncingScrollPhysics(),
                    autoPlay: true,
                    aspectRatio: 1.6,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                ),
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
                    color: primaryColor,
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
                                color: black,
                              ),
                            ],
                          ),
                          title: Text(jobType, style: TextStyle(color: black)),
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

