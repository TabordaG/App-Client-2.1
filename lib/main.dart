import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/constants.dart';
import 'package:food_app/details_screen.dart';
import 'package:food_app/widgets/category_title.dart';
import 'package:food_app/widgets/food_card.dart';
import 'package:food_app/widgets/soft_buttom.dart';
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
            headline5: TextStyle(fontWeight: FontWeight.bold),
            button: TextStyle(fontWeight: FontWeight.bold),
            headline6: TextStyle(fontWeight: FontWeight.bold),
            bodyText2: TextStyle(color: kTextColor),
          )),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final double offsetPage;

  HomeScreen({this.offsetPage});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  ScrollController controller;
  AnimationController _controller;
  double _height = 270, _topPadding = -90, _rightPadding = 20, valueScroll = 1;
  int _isSelected;
  bool _isExpanded = false;

  List categorias = [
    {'title': 'Todos', 'active': true},
    {'title': 'Frutas', 'active': false},
    {'title': 'Verduras', 'active': false},
    {'title': 'Legumes', 'active': false},
    {'title': 'Outros', 'active': false}
  ];

  @override
  void initState() {
    super.initState();
    _isSelected = 0;
    controller = ScrollController();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    
    if(widget.offsetPage != null && widget.offsetPage > 27) {
      setState(() {
        _height = 1;
        _topPadding = 20;
        controller = ScrollController(initialScrollOffset: widget.offsetPage);
      });
    }
    
    controller.addListener(() {
      if (controller.offset > 27 && _height == 270) {
        setState(() {
          _height = 1;
          controller.animateTo(1,
              duration: Duration(milliseconds: 400), curve: Curves.easeOut);
          _topPadding = 20;
        });
      } else if (controller.offset == 0 && _height == 1) {
        setState(() {
          _height = 270;
          _topPadding = -90;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    // controller.dispose();
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
              AnimatedPadding(
                duration: Duration(milliseconds: 800),
                curve: Curves.easeOut,
                padding: EdgeInsets.only(right: _rightPadding, top: 50),
                child: GestureDetector(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: RotationTransition(
                      turns: Tween(begin: 0.0, end: 0.5).animate(_controller),
                      child: SvgPicture.asset(
                        "assets/icons/menu.svg",
                        height: 12,
                      ),
                    ),
                  ),
                  onTap: () async {
                    if(!_isExpanded) {
                      setState(() {
                        _rightPadding = MediaQuery.of(context).size.width - 56;                        
                        _isExpanded = true;
                      });
                      Future.delayed(Duration(milliseconds: 200),() async {
                        await _controller.forward();
                        Toast.show(
                          "Abrir Drawer",
                          context,
                          duration: Toast.LENGTH_LONG,
                          gravity: Toast.CENTER,
                        );
                      });                      
                    }
                    else {
                      setState(() {
                        _rightPadding = 20;
                        _controller.reverse();
                        _isExpanded = false;
                      });                      
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Do melhor produto para\nsua casa",//"Simple way to find \nTasty food",
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
                            _height = 1;
                            controller.animateTo(1,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: SvgPicture.asset("assets/icons/search.svg"),
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (search.text != null && search.text.length > 3) {
                          setState(() {
                            _height = 1;
                            controller.animateTo(1,
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
                        controller: search,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 12.5),
                          border: InputBorder.none,
                          hintText: "Procurar",
                          hintStyle: TextStyle(
                            color: Color(0xFFA0A5BD),
                          ),
                        ),
                        onSubmitted: (value) {
                          if (search.text != null && search.text.length > 3) {
                            setState(() {
                              _height = 1;
                              controller.animateTo(1,
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
                    controller: controller,
                    child: StaggeredGridView.countBuilder(
                      controller: controller,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      itemCount: products.length,
                      itemBuilder: (contex, index) {
                        return FoodCard(
                            press: () {
                              setState(() {
                                scrollValue = controller.offset;
                              });
                              Navigator.push(context, PageRouteBuilder(
                                pageBuilder: (BuildContext context, _, __) {
                                  return DetailsScreen(products[index]);
                                },
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  var begin = Offset(0.0, 1.0);
                                  var end = Offset.zero;
                                  var tween = Tween(begin: begin, end: end);
                                  var offsetAnimation = animation.drive(tween);

                                  return SlideTransition(
                                    position: offsetAnimation,
                                    child: child,
                                  );
                                },
                                transitionDuration: Duration(milliseconds: 450),
                              ));
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
          AnimatedPositioned(
            duration: Duration(milliseconds: 600),
            curve: Curves.easeOut,
            top: _topPadding,
            left: MediaQuery.of(context).size.width / 2 - 45,
            child: GestureDetector(
              child: CircularSoftButton(
                icon: Icon(
                  Icons.keyboard_arrow_up,
                  size: 44,
                ),
              ),
              onTap: () async {
                if(controller.offset > 27) {
                  setState(() {                  
                    controller.animateTo(1,
                        duration: Duration(milliseconds: 400), curve: Curves.ease); 
                  });
                  await Future.delayed(Duration(milliseconds: 400));
                  setState(() {
                    _height = 270;
                    _topPadding = -90;
                  });
                } else {
                  setState(() {
                    controller.animateTo(1,
                        duration: Duration(milliseconds: 400), curve: Curves.ease); 
                    _height = 270;
                    _topPadding = -90;
                  });
                }
                
              }
            ),
          ),
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
    "title": "Mel Saché (900 g)",
    'image': "assets/images/melsache.png",
    'price': 45.0,
    "calories": "420Kcal",
    "description":
        "Mel produzido pela Associacao de Apicultores de Porto Esperidião. APA"
  },
  {
    "title": "Alface",
    'image': "assets/images/alface.png",
    'price': 6.0,
    "calories": "420Kcal",
    "description":
        "Produzido sem veneno com praticas agroecológicas"
  },
  {
    "title": "Pimenta Calabresa",
    'image': "assets/images/pimentacalabresa.png",
    'price': 10.0,
    "calories": "420Kcal",
    "description":
        "Pimenta tipo de cheiro picante para molhos e temperos ou conservas."
  },
  {
    "title": "Cabocla (cerveja artesanal)",
    'image': "assets/images/cabocla.png",
    'price': 8.5,
    "calories": "420Kcal",
    "description":
        "Cabocla (cerveja artesanal)"
  },
  {
    "title": "Abacaxi",
    'image': "assets/images/abacaxi.png",
    'price': 4.0,
    "calories": "420Kcal",
    "description":
        "Abacaxi."
  },
  {
    "title": "Limão Rosa",
    'image': "assets/images/limaorosa.png",
    'price': 70.2,
    "calories": "420Kcal",
    "description":
        "Limão Rosa."
  },
  {
    "title": "Cesta caminhos da agroecologia",
    'image': "assets/images/image_9.png",
    'price': 65.0,
    "calories": "420Kcal",
    "description":
        "Caminhos da agroecologia é uma cesta de produtos da agricultura familiar "
        "e agroecológicos 1 kg de fafirinha de mandioca. 2 kg de mandioca congelada "
        "2 kg de polpas de frutas 2 coco verdes com agua. OBS. VALE SOMENTE PARA PONTES E LACERDA. "
        "Em duvida faca contato no watzap: https://chat.whijatsapp.com/DxvxlRnievCBdGLjqVO9EF"
  },
  {
    "title": "Limão Taiti",
    'image': "assets/images/limao.png",
    'price': 8.0,
    "calories": "420Kcal",
    "description":
        "Limao taiti de quintal"
  },
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
];
