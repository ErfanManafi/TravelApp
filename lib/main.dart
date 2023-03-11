import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/services.dart';
import 'models/content.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(200, 0, 0, 0), // Set status bar color here
    ));
  }

  bool isFavourited = true;
  int selectedIndex = 0;
  double buttonSize = 70.0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(children: [
              Container(
                width: double.infinity,
                height: size.height / 2.3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(contentList[selectedIndex].image))),
              ),
              Positioned(
                top: 10,
                left: 300,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      favouriteState();
                    });
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(210, 58, 58, 58),
                    ),
                    child: isFavourited
                        ? Icon(
                            Icons.favorite,
                            color: Colors.black,
                          )
                        : Icon(Icons.favorite_outline),
                  ),
                ),
              ),
              Positioned(
                top: 300.0,
                right: 8.0,
                left: 8.0,
                bottom: 20.0,
                child: Container(
                  width: size.width / 3.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11.0),
                      color: const Color.fromARGB(210, 58, 58, 58)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 7.0,
                        ),
                        Text(
                          contentList[selectedIndex].city,
                          style: const TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ]),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                height: size.height,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 40,
                        width: double.maxFinite,
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 10.0,
                            );
                          },
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: contentList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () => setState(() {
                                selectedIndex = index;
                              }),
                              child: AnimatedContainer(
                                curve: Curves.bounceOut,
                                duration: const Duration(seconds: 1),
                                height: selectedIndex == index
                                    ? buttonSize + 10.0
                                    : buttonSize,
                                width: selectedIndex == index
                                    ? buttonSize + 10.0
                                    : buttonSize,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: selectedIndex == index
                                        ? Colors.black
                                        : Color.fromARGB(255, 208, 208, 208)),
                                child: Center(
                                  child: Text(
                                    contentList[index].city,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Text(
                                contentList[selectedIndex].title,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            children: [
                              Text(
                                contentList[selectedIndex].description,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 170, 170, 170),
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        height: 220,
                        width: 400,
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: contentList.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              width: 10.0,
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              shadowColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: SizedBox(
                                height: 250,
                                width: 200,
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20)),
                                      child: Image(
                                        image: AssetImage(
                                            contentList[selectedIndex].image),
                                        fit: BoxFit.fill,
                                        height: 130,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                contentList[selectedIndex]
                                                    .title,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 170, 170, 170),
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5.0,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                contentList[selectedIndex]
                                                    .description,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 8.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 55,
        child: CustomNavigationBar(
          selectedColor: Colors.black,
          items: [
            CustomNavigationBarItem(
              icon: Icon(Icons.explore),
            ),
            CustomNavigationBarItem(
              icon: Icon(Icons.place),
            ),
            CustomNavigationBarItem(
              icon: Icon(Icons.bookmark),
            ),
            CustomNavigationBarItem(
              icon: Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }

  void favouriteState() {
    if (isFavourited) {
      isFavourited = false;
    } else {
      isFavourited = true;
    }
  }
}
// chatGPT api key
// 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
