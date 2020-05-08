import 'package:flutter/material.dart';
import 'package:food_app/constants.dart';
import 'package:food_app/widgets/card_cart.dart';
import 'package:food_app/widgets/food_card.dart';
import 'package:food_app/widgets/soft_buttom.dart';

import 'main.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    print(cart.length);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 70),
            color: Color.fromRGBO(154, 141, 128, .1),
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Opacity(
                opacity: .1,
                child: Image.asset(
                  'assets/images/leaf2.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 35.0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(width: 10,),
                    Text(
                    "Carrinho", //"Simple way to find \nTasty food",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Icon(Icons.shopping_basket, size: 28,),
                    )
                  ],
                ),
              ),
              Expanded(                
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Produtor 1", //"Simple way to find \nTasty food",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 205,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: cart.length,
                        itemBuilder: (context, index) {
                          print(cart.length);
                          if(cart == null || cart.isEmpty)  return Center(child: Text('Carrinho Vazio'),);
                          return CartCard(
                            press: () {},
                            title: cart[index].title,
                            image: cart[index].image,
                            price: cart[index].price,
                            calories: cart[index].calories,
                            description: cart[index].description
                          );
                        }
                      ),
                    ),

                    SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Produtor 2", //"Simple way to find \nTasty food",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 205,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: cart.length,
                        itemBuilder: (context, index) {
                          print(cart.length);
                          if(cart == null || cart.isEmpty)  return Center(child: Text('Carrinho Vazio'),);
                          return CartCard(
                            press: () {},
                            title: cart[index].title,
                            image: cart[index].image,
                            price: cart[index].price,
                            calories: cart[index].calories,
                            description: cart[index].description
                          );
                        }
                      ),
                    ),

                    SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Expanded(child: Container()),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24)),
                  border: Border.all(color: Colors.black26, width: .4),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,                  
                  children: <Widget>[
                    Text(
                      'Total: R\$23.50',
                      style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 16),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: kPrimaryColor)
                      ),
                      color: kPrimaryColor,
                      onPressed: () {
                        print('Comprar');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.attach_money),
                            Text(
                              "Comprar",
                              style:Theme.of(context).textTheme.button.copyWith(fontSize: 20)
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: CircularSoftButton(
              icon: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 28,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (BuildContext context, _, __) {
                          return HomeScreen();
                        },
                      )
                    );
                  }
                ),
              radius: 22,
            ),
          ),
        ],
      ),
    );
  }
}