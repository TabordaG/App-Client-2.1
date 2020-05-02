import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/constants.dart';
import 'package:food_app/details_screen.dart';
import 'package:food_app/widgets/category_title.dart';
import 'package:food_app/widgets/food_card.dart';
import 'package:toast/toast.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food App',
      theme: ThemeData(
          fontFamily: "Poppins",
          scaffoldBackgroundColor: kWhiteColor,
          primaryColor: kPrimaryColor,
          textTheme: TextTheme(
            headline: TextStyle(fontWeight: FontWeight.bold),
            button: TextStyle(fontWeight: FontWeight.bold),
            title: TextStyle(fontWeight: FontWeight.bold),
            body1: TextStyle(color: kTextColor),
          )),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _controller;
  double _height = 270 , _topPadding = -50;
  TextEditingController _search = TextEditingController();
  List categorias = [
    {'title': 'Todos', 'active': true},
    {'title': 'Frutas', 'active': false},
    {'title': 'Verduras', 'active': false},
    {'title': 'Legumes', 'active': false},
    {'title': 'Outros', 'active': false}
  ];
  int _isSelected;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _isSelected = 0;

    _controller.addListener(() {
      if (_controller.offset > 27 && _height == 270) {
        setState(() {
          _height = 50;
          _controller.animateTo(1,
              duration: Duration(milliseconds: 400), curve: Curves.easeOut);
          _topPadding = 20;
        });
      } else if (_controller.offset == 0 && _height == 50) {
        setState(() {
          _height = 270;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kPrimaryColor.withOpacity(.26),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kPrimaryColor,
              ),
              child: SvgPicture.asset("assets/icons/bag.svg"),
            ),
            Positioned(
              right: 15,
              bottom: 10,
              child: Container(
                alignment: Alignment.center,
                height: 21,
                width: 21,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kWhiteColor,
                ),
                child: Text(
                  carrinho.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: kPrimaryColor, fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 50),
                child: Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset(
                    "assets/icons/menu.svg",
                    height: 8,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Simple way to find \nTasty food",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Container(
                width: double.infinity,
                height: 20,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categorias.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            categorias[_isSelected]['active'] = false;
                            categorias[index]['active'] = true;
                            _isSelected = index;
                            _height = 50;
                            _controller.animateTo(1,
                                duration: Duration(milliseconds: 400),
                                curve: Curves.easeOut);
                            _topPadding = 20;
                          });
                        },
                        child: CategoryTitle(
                          title: categorias[index]['title'],
                          active: categorias[index]['active'],
                        ),
                      );
                    }),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: kBorderColor),
                ),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      child: SvgPicture.asset("assets/icons/search.svg"),
                      onTap: () {
                        print('search');
                        if (_search.text != null && _search.text.length > 3) {
                          setState(() {
                            _height = 50;
                            _controller.animateTo(1,
                                duration: Duration(milliseconds: 400),
                                curve: Curves.easeOut);
                            _topPadding = 20;
                          });
                        } else {
                          Toast.show(
                            "A busca deve possuir mais do que 3 caractéres",
                            context,
                            duration: Toast.LENGTH_LONG,
                            gravity: Toast.CENTER,
                          );
                        }
                      },
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        // maxLength: 26,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 12.5),
                          border: InputBorder.none,
                          hintText: "Procurar",
                          hintStyle: TextStyle(
                            color: Color(0xFFA0A5BD),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _search.text = value;
                          });
                        },
                        onSubmitted: (value) {
                          print(value);
                          if (_search.text != null && _search.text.length > 3) {
                            setState(() {
                              _height = 50;
                              _controller.animateTo(1,
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.easeOut);
                              _topPadding = 20;
                            });
                          } else {
                            print('Vazio');
                            Toast.show(
                              "A busca deve possuir mais do que 3 caractéres",
                              context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.CENTER,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              AnimatedContainer(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeOut,
                height: _height,
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Scrollbar(
                    controller: _controller,
                    child: StaggeredGridView.countBuilder(
                      controller: _controller,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      itemCount: products.length,
                      itemBuilder: (contex, index) {
                        return FoodCard(
                            press: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return DetailsScreen(products[index]);
                                }),
                              );
                            },
                            title: products[index].title,
                            image: products[index].image,
                            price: products[index].price,
                            calories: products[index].calories,
                            description: products[index].description);
                      },
                      staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                    ),
                  ),
                ),
              ),
            ],
          ),
          _height == 50 
            ? AnimatedContainer(
              duration: Duration(microseconds: 1500),
              curve: Curves.ease,
              // padding: EdgeInsets.only(top: _topPadding, left: MediaQuery.of(context).size.width / 2 - 25,),
              child: Positioned(
                top: _topPadding,
                left: MediaQuery.of(context).size.width / 2 - 25,
                child: IconButton(
                  icon: Icon(Icons.keyboard_arrow_down, size: 50,), 
                  onPressed: () {
                    setState(() {
                      _height = 270;
                      _controller.animateTo(1,
                          duration: Duration(milliseconds: 400), curve: Curves.easeOut);
                      _topPadding = -50;
                    });
                  }
                ),
              ),
            )
            : Container(),
        ],
      ),
    );
  }
}

class Food {
  final String title;
  final String image;
  final double price;
  final String calories;
  final String description;

  Food(this.title, this.image, this.price, this.calories, this.description);
}

List<Food> products = productsData
    .map((item) => Food(item['title'], item['image'], item['price'],
        item['calories'], item['description']))
    .toList();

var productsData = [
  {
    "title": "Vegan salad bowl",
    'image': "assets/images/image_1.png",
    'price': 20.0,
    "calories": "420Kcal",
    "description":
        "Contrary to popular belief, Lorem Ipsum is not simply random text. "
            "It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. "
  },
  {
    "title": "Vegan salad bowl",
    'image': "assets/images/image_2.png",
    'price': 20.0,
    "calories": "420Kcal",
    "description":
        "Contrary to popular belief, Lorem Ipsum is not simply random text. "
            "It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. "
  },
  {
    "title": "Vegan salad bowl",
    'image': "assets/images/image_3.png",
    'price': 20.0,
    "calories": "420Kcal",
    "description":
        "Contrary to popular belief, Lorem Ipsum is not simply random text. "
            "It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. "
  },
  {
    "title": "Vegan salad bowl",
    'image': "assets/images/image_4.png",
    'price': 20.0,
    "calories": "420Kcal",
    "description":
        "Contrary to popular belief, Lorem Ipsum is not simply random text. "
            "It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. "
  },
];
