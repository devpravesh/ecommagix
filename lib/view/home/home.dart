import 'package:http/http.dart' as http;
import 'dart:developer' as dev;
import 'package:ecommagix/imports.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<dynamic>>? futureProduct;
  Future<List<dynamic>> fetchProducts() async {
    final baseUrl = 'fakestoreapi.com';
    final _url = '/products';
    var res = await http.get(Uri.https(baseUrl, _url));
    dev.log('Request: ${res.request!.url.toString()}');

    var data = jsonDecode(res.body);
    if (kDebugMode) {
      dev.log('Response: ${data.toString()}');
    }
    return data;
  }

  Future<List<dynamic>> fetchfilteredProducts(String filter) async {
    final baseUrl = 'fakestoreapi.com';
    final _url = '/products/category/$filter';
    var res = await http.get(Uri.https(baseUrl, _url));
    dev.log('Request: ${res.request!.url.toString()}');

    var data = jsonDecode(res.body);
    if (kDebugMode) {
      dev.log('Response: ${data.toString()}');
    }
    return data;
  }

  @override
  void initState() {
    super.initState();
    futureProduct = fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        title: AppName(),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Cart()));
              },
              icon: Icon(
                Icons.shopping_bag,
                color: Colors.black,
              ))
        ],
      ),
      drawer: DrawerMenu(),
      body: Column(
        children: [
          const Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search Products",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7.0)),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  futureProduct = fetchProducts();
                  setState(() {});
                },
                child: Text(
                  "All",
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  primary: Colors.red.withOpacity(0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(2),
                      ),
                      side: BorderSide(color: Colors.black)),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  futureProduct = fetchfilteredProducts("jewelery");
                  setState(() {});
                },
                child: Text(
                  "Jewelery",
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  primary: Colors.red.withOpacity(0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(2),
                      ),
                      side: BorderSide(color: Colors.black)),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  futureProduct = fetchfilteredProducts("women's clothing");
                  setState(() {});
                },
                child: Text(
                  "Women",
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  primary: Colors.red.withOpacity(0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(2),
                      ),
                      side: BorderSide(color: Colors.black)),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  futureProduct = fetchfilteredProducts("electronics");
                  setState(() {});
                },
                child: Text(
                  "Electronic",
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  primary: Colors.red.withOpacity(0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(2),
                      ),
                      side: BorderSide(color: Colors.black)),
                ),
              ),
            ],
          ),
          Flexible(
            child: FutureBuilder<List<dynamic>>(
              future: futureProduct,
              builder: (context, data) {
                if (data.hasData) {
                  return GridView.builder(
                    padding: EdgeInsets.all(15),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2 / 3,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15),
                    itemCount: data.data!.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (BuildContext context, int i) {
                      return ProductCardTile(data: data.data![i]);
                    },
                  );
                } else if (data.hasError) {
                  return Text("${data.error}");
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
