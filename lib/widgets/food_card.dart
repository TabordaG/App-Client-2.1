import 'package:flutter/material.dart';
import 'package:food_app/constants.dart';

class FoodCard extends StatelessWidget {
  final String title;
  final String ingredient;
  final String image;
  final double price;
  final String calories;
  final String description;
  final Function press;

  const FoodCard({
    Key key,
    this.title,
    this.ingredient,
    this.image,
    this.price,
    this.calories,
    this.description,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(left: 20),
        height: 340,
        width: 270,
        child: Stack(
          children: <Widget>[
            // Big light background
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                height: 320,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(34),
                  color: kPrimaryColor.withOpacity(.06),
                ),
              ),
            ),
            // Rounded background
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                height: 110,//181,
                width: 110,//181,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kPrimaryColor.withOpacity(.15),
                ),
              ),
            ),
            // Food Image
            Positioned(
              top: 0,
              left: -30,
              child: Container(
                height: 112,//184,
                width: 168,//276,
                child: Hero(
                  tag: image,
                  child: Image(
                    image: AssetImage(image),
                  ),
                ),
              ),
            ),
            // Price
            Positioned(
              right: 10,
              top: 100,
              child: Text(
                "\$${price.toString()}",
                style: Theme.of(context)
                    .textTheme
                    .headline
                    .copyWith(color: kPrimaryColor),
              ),
            ),
            Positioned(
              top: 145,
              left: 15,
              child: Container(                
                width: MediaQuery.of(context).size.width / 3, //width: 160,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    Text(
                      "With red tomato",
                      style: TextStyle(
                        color: kTextColor.withOpacity(.4),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      description,
                      maxLines: 3,
                      style: TextStyle(
                        color: kTextColor.withOpacity(.65),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      calories,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
