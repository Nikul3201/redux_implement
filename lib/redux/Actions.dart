import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:redux/redux.dart';
import 'package:redux_implement/models/App_State.dart';
import 'package:redux_implement/models/bookState.dart';
import 'package:redux_thunk/redux_thunk.dart';

final String domain = 'https://3048b83259e4.ngrok.io';

class AppendBookDataAction {
  List<Books> books;

  AppendBookDataAction(this.books);
}

ThunkAction<AppState> getBookData() {
  return (Store<AppState> store) async {
    var response = await get(
      '$domain/api/books',
      headers: <String, String> {
        'Content-Type': 'application/json'
      },
    );
    // print(response);
    if(response.statusCode == 200) {
      print("==> Get request Successfully with status code ${response.statusCode}");
      // print(response.body);
      var dataList = jsonDecode(response.body);

      print("Success Results : ${dataList.toString()}");
      List<Books> books = new List<Books>();
      if (dataList != null) {
        dataList.forEach((v) {
          books.add(new Books.fromJson(v));
          store.dispatch(AppendBookDataAction(books));
          // print("got append data.............${books.toString()}");
        });

      }

    }else{
      print("Went wrong");
    }
  };

}

ThunkAction<AppState> postBookData(String title, int price) {

    return (Store<AppState> store) async{
      // print("Book title ==> $title");
      // print("Book price ==> $price");

      Map<String,dynamic> data = {
        "title": title,
        "price": price
      };

      String path = json.encode(data);
      print(path);
      var postData = await post(
        '$domain/api/books',
        headers: <String,String> {
          'Content-Type': 'application/json'
        },
        body: path,
      );
      if(postData.statusCode == 201) {
        print("Book data posted successfully.");
        store.dispatch(getBookData());
      }else {
        print("error in posting book data.");
      }

    };
}

ThunkAction<AppState> deleteBook(String id) {
  return (Store<AppState> store) async{
    print(id);
    var deleteData = await delete(
      '$domain/api/books/$id',
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if(deleteData.statusCode == 204) {
      print("Book Deleted Successfully");
      store.dispatch(getBookData());
    }else {
      print(deleteData.statusCode);
    }
  };
}