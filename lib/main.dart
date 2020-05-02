import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/constants.dart';
import 'package:food_app/details_screen.dart';
import 'package:food_app/widgets/category_title.dart';
import 'package:food_app/widgets/food_card.dart';

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

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        padding: EdgeInsets.all(5),
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kPrimaryColor.withOpacity(.26),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: kPrimaryColor,
          ),
          child: SvgPicture.asset("assets/icons/plus.svg"),
        ),
      ),
      body: Column(
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                CategoryTitle(title: "Todos", active: true),
                CategoryTitle(title: "Frutas"),
                CategoryTitle(title: "Verduras"),
                CategoryTitle(title: "Legumes"),
                CategoryTitle(title: "Outros"),
              ],
            ),
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
                    onSubmitted: (value) {
                      print(value);
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 1,
              itemCount: products.length,
              itemBuilder: (contex, index) {
                return FoodCard(
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) {
                        return DetailsScreen(products[index]);
                      }),
                    );
                  },
                  title: products[index].title,
                  image: products[index].image,
                  price: products[index].price,
                  calories: products[index].calories,
                  description: products[index].description
                );
              },
              staggeredTileBuilder: (index) => StaggeredTile.fit(1),
            ),
          ),
          //FoodListHorizontal(),
        ],
      ),
    );
  }
}

// class FoodListHorizontal extends StatelessWidget {
//   const FoodListHorizontal({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: <Widget>[
//           FoodCard(
//             press: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) {
//                   return DetailsScreen();
//                 }),
//               );
//             },
//             title: "Vegan salad bowl",
//             image: "assets/images/image_1.png",
//             price: 20,
//             calories: "420Kcal",
//             description:
//                 "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. ",
//           ),
//           FoodCard(
//             press: () {},
//             title: "Vegan salad bowl",
//             image: "assets/images/image_2.png",
//             price: 20,
//             calories: "420Kcal",
//             description:
//                 "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. ",
//           ),
//           SizedBox(width: 20),
//         ],
//       ),
//     );
//   }
// }

class Food {
  final String title;
  final String image;
  final double price;
  final String calories;
  final String description;

  Food(this.title, this.image, this.price, this.calories, this.description);
}

List<Food> products = productsData
    .map((item) => Food(item['title'], item['image'], item['price'], item['calories'], item['description']))
    .toList();

var productsData = [
  {
    "title": "Vegan salad bowl", 'image': "assets/images/image_1.png", 
    'price': 20.0, "calories": "420Kcal", 
    "description": "Contrary to popular belief, Lorem Ipsum is not simply random text. "
    "It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. "
  },
  {
    "title": "Vegan salad bowl", 'image': "assets/images/image_2.png", 
    'price': 20.0, "calories": "420Kcal", 
    "description": "Contrary to popular belief, Lorem Ipsum is not simply random text. "
    "It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. "
  },
];