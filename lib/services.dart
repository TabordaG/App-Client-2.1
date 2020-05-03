import 'package:toast/toast.dart';
import 'dart:convert' show base64, json, utf8;

class Basicos  {
  static String  ip = "http://200.129.247.236:8000"; // variavel publica com anderline na frente private
  //static String  ip = "http://200.129.247.242"; // ip servidor de produção
  static String categoria_usada ='*';//categorias id
  static String categoria_usada_desc =' ';//categorias descricao
  static String empresa_id = '';
  static String local_retirada_id = ''; //identifica local de reitrada na tabela de cliente

  //-----------controle de produtos
  static int offset=0; // posiciona a tela de home na posição inicial apos rolagens
  static List product_list = []; // carrega o lista da tela de home e vi preenchendo com as rolagens
  static double pagina =1; // contas as paginas na rolagem do home

  // ------------controle de pedidos
  static List meus_pedidos = [];

  // armazena consulta de produtos temporariamente
  static String buscar_produto_home='';


  static codifica(String cod) {
      // codifica o string a ser enviado ao servidor
      var bytes_utf8 = utf8
          .encode(cod.substring(39, cod.length)); //converte carateres em inteiro
      var dados = base64.encode(bytes_utf8); // converte inteiros para base64
      String temp = dados.substring(0, 2);
      String temp2 = dados.substring(2, dados.length);
      dados = temp + 'l' + temp2;
      return cod.substring(0, 39) + dados; // envia os dados
  }

  static decodifica(String cod) {
      // decodifica base64 que vem do servidor
      //print(cod);
      String temp = cod.substring(0, 5); //
      String temp2 = cod.substring(6, cod.length);
      cod = temp + temp2;
      String dados =
      (utf8.decode(base64.decode(cod.substring(3, cod.length - 2))))
          .replaceAll('\'', '"');
      dados = dados.replaceAll('Decimal(',''); // remove esse tido de retorno Decimal("111.000")
      dados = dados.replaceAll(')', ''); // remove o ")"
      return dados;
  }
}

Future<List> buscaProdutos(String categoria, String busca) async {
    //print(widget.id_sessao.toString() + '-');
    // if (widget.id_sessao == 0) {
    //   // verifica se a entrada é anonima sem login
    //   id_local_retirada = '0'; // > 0 todos os  locais de retirada
    // } else {
    //   await busca_id_local_retirada(); //local de retirada
    // }
    // //print(id_local_retirada);
    // if (id_local_retirada == '') {
    //   // mensagem de erro
    //   Toast.show("Erro ao selecionar a Empresa", context,
    //       duration: Toast.LENGTH_LONG,
    //       gravity: Toast.CENTER,
    //       backgroundRadius: 0.0);
    // } else {
      //print(id_empresa);
      //print(Basicos.buscar_produto_home);
      String link = '';
      if (widget.id_sessao == 0) {
        link = Basicos.codifica("${Basicos.ip}/crud/?"
            "crud=consult-5.${categoria},${id_local_retirada},10,${Basicos.offset},${Basicos.buscar_produto_home}%"); //lista produto pela categoria, empresa e limit e offset
      } else {
        link = Basicos.codifica("${Basicos.ip}/crud/?"
            "crud=consulta5.${categoria},${id_local_retirada},10,${Basicos.offset},${Basicos.buscar_produto_home}%"); //lista produto pela categoria, empresa e limit e offset
      }
      var res1 = await http
          .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});

      var res = Basicos.decodifica(res1.body);
      //print(res);
      if (res1.body.length > 2) {
        if (res1.statusCode == 200) {
          // converte a lista de consulta em uma lista dinamica
          List list = json.decode(res).cast<Map<String, dynamic>>();
          //print(list);
          for (var i = 0; i < list.length; i++)
            Basicos.product_list.add(list[i]);
          Basicos.buscar_produto_home = '';
          //print(Basicos.product_list);
          return list;
        }
      }
    //}
  }