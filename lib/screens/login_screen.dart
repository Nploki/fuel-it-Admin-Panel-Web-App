import 'package:fuel_it_admin_panel/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fuel_it_admin_panel/screens/login_screen.dart';
import 'package:fuel_it_admin_panel/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class login_screen extends StatefulWidget {
  static const String id = "Login_screen";
  const login_screen({super.key});

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  bool _isVisible = false;
  bool _isLoading = false;
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  String email = '';
  String password = '';

  FirebaseServices _services = FirebaseServices();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late SimpleProgressDialog progressDialog;

  @override
  Widget build(BuildContext context) {
    _login({username, password}) async {
      progressDialog.start();
      _services.getAdminCredentials().then((value) {
        value.docs.forEach((doc) async {
          if (doc.get('username') == username) {
            if (doc.get('password') == password) {
              try {
                UserCredential userCredential =
                    await FirebaseAuth.instance.signInAnonymously();
                if (userCredential != null) {
                  progressDialog.dismiss();
                  Navigator.pushReplacementNamed(context, home_screen.id);
                }
              } catch (e) {
                progressDialog.dismiss();
                _showMyDialog(title: "Login", message: "${e.toString()}");
              }
            } else {
              progressDialog.dismiss();
              _showMyDialog(
                  title: "Incorrect password",
                  message:
                      "password you entred is incorrect, Please try again");
            }
          } else {
            progressDialog.dismiss();
            _showMyDialog(
                title: "Invalid User Name ",
                message: "UserName you entred is not valid, Please try again");
          }
        });
      });
    }

    progressDialog = SimpleProgressDialog(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade300,
        title: Text(
          "Admin Panel",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Connection Failed"));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.amber.shade300, Colors.white],
                  stops: [1.0, 1.0],
                  begin: Alignment.topCenter,
                  end: Alignment(0.0, 0.0),
                ),
              ),
              child: Center(
                child: Container(
                  width: 350,
                  height: 450,
                  child: Card(
                    elevation: 1,
                    color: Color.fromARGB(255, 251, 250, 250),
                    shape: Border.all(color: Colors.amber.shade300, width: 2),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 20,
                        left: 20,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.network(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOiqecMefR4bbxANVES17p7tIhKlQcXZ2SBw&usqp=CAU',
                              width: 200,
                              height: 150,
                            ),
                            Text(
                              "ADMIN",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.yatraOne(
                                  fontSize: 30, color: Colors.deepOrange),
                            ),
                            TextFormField(
                              controller: _emailTextController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter your Email Id';
                                }

                                // setState(() {
                                //   email = value;
                                // });
                                return null;
                              },
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.email_outlined),
                                  labelText: "E-Mail",
                                  hintText: "E-Mail",
                                  border: OutlineInputBorder()),
                            ),
                            TextFormField(
                              controller: _passwordTextController,
                              obscureText: _isVisible,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter your Password';
                                }
                                if (value.length < 6) {
                                  return 'Password is greater than 5 characters';
                                }
                                // setState(() {
                                //   password = value;
                                // });
                                return null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.fingerprint),
                                  labelText: "Password",
                                  hintText: "Password",
                                  suffixIcon: IconButton(
                                    icon: _isVisible
                                        ? const Icon(
                                            Icons.visibility_off_outlined)
                                        : const Icon(Icons.visibility_outlined),
                                    onPressed: () {
                                      setState(() {
                                        _isVisible = !_isVisible;
                                      });
                                    },
                                  ),
                                  border: const OutlineInputBorder()),
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.greenAccent.shade400,
                                      foregroundColor: Colors.white),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _login(
                                          username: _emailTextController.text,
                                          password:
                                              _passwordTextController.text);
                                    }
                                  },
                                  child: const Text(
                                    "Log-In",
                                    style: TextStyle(
                                        fontSize: 17.5,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<void> _showMyDialog({title, message}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class SimpleProgressDialog {
  final BuildContext context;
  late AlertDialog _dialog;

  SimpleProgressDialog(this.context);

  void start() {
    _dialog = const AlertDialog(
      content: Row(
        children: [
          CupertinoActivityIndicator(
            animating: true,
            radius: 30,
            color: Color.fromARGB(255, 0, 66, 120),
          ),
          SizedBox(width: 20),
          Text('Loading...'),
        ],
      ),
    );
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Color.fromARGB(163, 34, 207, 15),
      builder: (BuildContext context) {
        // ignore: deprecated_member_use
        return WillPopScope(
          onWillPop: () async => false,
          child: _dialog,
        );
      },
    );
  }

  void dismiss() {
    Navigator.of(context).pop();
  }
}
