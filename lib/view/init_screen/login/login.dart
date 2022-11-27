import 'package:ecommagix/imports.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  var users;
  login(username, password) async {
    final baseUrl = 'fakestoreapi.com';
    final _url = '/auth/login';
    var res = await http.post(
      Uri.https(baseUrl, _url),
      body: jsonEncode(
          <String, String>{'username': username, 'password': password}),
    );
    dev.log('Request: ${res.request!.url.toString()}');

    var data = jsonDecode(res.body);
    if (data['token']) {
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (_) => Home()), (route) => false);
    } else {
      Fluttertoast.showToast(msg: "Invalid Credential");
    }
    users = await data;
    if (kDebugMode) {
      dev.log('Response: ${data.toString()}');
    }
    //  data;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppName(),
              const SizedBox(height: 30.0),
              TextBuilder(
                text: 'Login',
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 10.0),
              TextBuilder(
                text: 'Please sign in to continue.',
                fontSize: 15.0,
                color: Colors.black,
              ),
              const SizedBox(height: 20.0),
              CustomTextField(
                  controller: _emailController,
                  labelText: 'Email',
                  hintText: 'example@ideamagix.com',
                  prefixIcon: Icons.email),
              const SizedBox(height: 20.0),
              CustomTextField(
                  controller: _passwordController,
                  labelText: 'Password',
                  hintText: 'Password',
                  prefixIcon: Icons.lock),
              const SizedBox(height: 30.0),
              Center(
                child: MaterialButton(
                  height: 55.0,
                  color: Colors.black,
                  minWidth: 250,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  onPressed: () {
                    login(_emailController.text, _passwordController.text);
                    // print(users[1]['email']);
                    // Navigator.pushAndRemoveUntil(
                    //     context,
                    //     MaterialPageRoute(builder: (_) => Home()),
                    //     (route) => false);
                  },
                  child: TextBuilder(
                    text: 'Login',
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                  child: InkWell(
                onTap: (() {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => Home()),
                      (route) => false);
                }),
                child: TextBuilder(
                  text: "SKIP",
                  fontSize: 18,
                ),
              )),
              const SizedBox(height: 50.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextBuilder(
                    text: "Don't have an account? ",
                    color: Colors.black,
                  ),
                  TextBuilder(
                    text: 'Sign Up',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
