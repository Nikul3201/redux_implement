import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:redux_implement/models/App_State.dart';
import 'package:redux_implement/models/bookState.dart';
import 'package:redux_implement/redux/Actions.dart';
import 'package:redux_implement/redux/appReducers.dart';
import 'package:redux_implement/routers.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() {
  final store = Store<AppState>(
      appReducer,
      initialState: AppState(bookState: BookState()),
      middleware: [thunkMiddleware],
  );

  print("initialState : ${store.state}");
  runApp(StoreProvider<AppState>(store: store, child: MyHomePage()));

}


class MyHomePage extends StatefulWidget {
  Store<AppState> store;

  MyHomePage({
    Key key,
    this.store,
  }) : super(key: key);
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    StoreProvider.of<AppState>(context, listen: false)
        .dispatch(getBookData());


    return StoreConnector<AppState, List<Books>>(
      converter: (Store<AppState> store) =>
      store.state?.bookState?.books ?? List<Books>(),
      builder: (BuildContext context, List<Books> books) {

        List<Widget> booksData = [];
        // print("books==> : $books}");
        books.asMap().forEach((i, Books book) {
          // print("My books => $books");
          booksData.add(
            Card(
              child: Column(
                children: [
                  ListTile(
                    title: Text(book.title),
                    subtitle: Text("${book.price}"),
                    onTap: () {
                      deleteBookAndNavigate(context, book.id);
                    },
                  ),
                ],
              ),
            ),
          );
        });

        return MaterialApp(
          onGenerateRoute: Routers.generateRoute,
          initialRoute: '/',
          title: "REST API",
          home: Scaffold(
            appBar: AppBar(title: Text("REST DATA of Books")),
            body: ListView(
              children: [
                Column(
                  children: booksData,
                ),
                Builder(
                  builder: (context) => Center(
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/postBookData');
                      },
                      child: Text("NEXT PAGE"),
                      color: Colors.green,
                      textColor: Colors.white,
                    ),
                  )
                )
              ],
            ),

          ),
        );
      },
    );
  }

  void deleteBookAndNavigate(BuildContext context, String id) {
    StoreProvider.of<AppState>(context).dispatch(deleteBook(id));
  }
}



class postBookDataScreen extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final priceController = TextEditingController();

  // Future<void> getVersion() async {
  //   String platformVersion;
  //
  //   try {
  //     platformVersion = await PlatformCode.platformVersion;
  //   }catch(e) {
  //     print(e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text("Post Book Data"),),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: titleController,
                decoration: new InputDecoration(
                  hintText: "Enter book title"
                ),
              ),
              TextField(
                controller: priceController,
                decoration: new InputDecoration(
                    hintText: "Enter book price"
                ),
              ),
              FlatButton(
                  onPressed: () {
                    String title = titleController.text;
                    int price = int.parse(priceController.text);
                    saveAndNavtigateTo(context);
                  },
                  child: Text("Post Data"),
                  color: Colors.green,
                  textColor: Colors.white,
              ),
              Text('Version: '),
            ],
          ),
        )
      ),
    );
  }

  void saveAndNavtigateTo(BuildContext context) {
    // StoreProvider.of<AppState>(context).dispatch(new Books(
    //     titleController.text,
    //     priceController.text,
    // ));


    StoreProvider.of<AppState>(context).dispatch(
        postBookData(titleController.text,int.parse(priceController.text))
    );
    Navigator.pushNamed(context, '/');
  }
}


//
// class PlatformCode {
//   static const MethodChannel _channel = const MethodChannel('platform_version');
//   static Future<String> get platformVersion async {
//     final String version = await _channel.invokeMethod('getPlaformVersion');
//     return version;
//   }
// }












// method channel invokation
// native code
// android to flutter etc...





