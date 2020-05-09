import 'package:flutter/material.dart';
import 'package:food_app/constants.dart';
import 'package:food_app/widgets/card_cart.dart';
import 'package:food_app/widgets/soft_buttom.dart';
import 'package:palette_generator/palette_generator.dart';
import 'main.dart';

List<Pedido> pedidos;

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    super.initState();
    pedidos = [];
    obterPedidos();
  }

  @override
  Widget build(BuildContext context) {
    
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
                child: FutureBuilder<List<Pedido>>(
                  future: obterPedidos(),
                  builder: (context, snapshot) {
                    if(snapshot.hasError) return Center(child: Text('Error'));
                    List<Pedido> cestas = snapshot.data;
                    switch(snapshot.connectionState) {
                      case ConnectionState.none:
                        return Center(child: Text('Não conectado'));
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator(),);
                      default:
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: cestas.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Produtor: ${cestas[index].produtor}', //"Simple way to find \nTasty food",
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
                                    itemCount: cestas[index].produtos.length,
                                    itemBuilder: (context, index2) {
                                      if(cart == null || cart.isEmpty)  return Center(child: Text('Carrinho Vazio'),);
                                      return CartCard(
                                        press: () {},
                                        title: cestas[index].produtos[index2].title,
                                        image: cestas[index].produtos[index2].image,
                                        price: cestas[index].produtos[index2].price,
                                        produtor: cestas[index].produtos[index2].produtor,
                                        description: cestas[index].produtos[index2].description,
                                        color: cestas[index].produtos[index2].color,
                                      );
                                    }
                                  ),
                                ),
                                SizedBox(height: 20),
                              ],
                            );
                          }
                        );
                    }                                        
                  }
                ),
              ),
              Container(height: 60,),
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

Future<List<Pedido>> obterPedidos() async {
  bool verificado = false;
  PaletteGenerator paletteGenerator;
  pedidos = [];
  cart.forEach((element) async {
    paletteGenerator = await PaletteGenerator.fromImageProvider(AssetImage(element.image));
    element.color = paletteGenerator.dominantColor?.color;
    verificado = false;
    for (var pedido in pedidos) {
      if(pedido.produtor == element.produtor) {
        pedido.produtos.add(element);
        verificado = true;
        break;
      }
    }
    if(!verificado) {
      pedidos.add(Pedido(
      produtor: element.produtor,
      produtos: [element],
      ));
    }
    print('For: ${pedidos.length}');
  });
  print(pedidos.length);
  return pedidos;
}

class Pedido {
  final String produtor;
  final List<Food> produtos;

  Pedido({
    this.produtos,
    this.produtor
  });
}