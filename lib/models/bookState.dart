import 'dart:convert';

class BookState{
  String requestPath;
  List<Books> books;

  BookState({this.books,this.requestPath});

  BookState copyWith({List<Books> books}){
    return new BookState(
      books: books ?? this.books,
    );
  }

  BookState setPath(String requestPath) {
    return new BookState(
      books: this.books,
    );
  }


  factory BookState.fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson['schemaVersion'] == 1) {
      try {
        return BookState(
            books: Books.parseFromJson(parsedJson['books']),
            requestPath: parsedJson['requestPath'],
        );
      } catch (e) {
        print("Failed to convert json to BookState" + e.toString());
        throw e;
      }
    } else {
      return null;
    }
  }


  dynamic toJson() => {
    'schemaVersion': 1,
    if (books != null) 'books': books,
    if (requestPath != null) 'requestPath': requestPath,
  };

  @override
  String toString() {
    return 'BookState: ${JsonEncoder.withIndent('  ').convert(this)}';
  }


}

class Books {
  String id;
  String title;
  int price;

  Books({this.id, this.title, this.price});

  Books.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    return data;
  }

  static List<Books> parseFromJson(List<dynamic> jsonArray) {
    return jsonArray?.map((e) => Books.fromJson(e))?.toList();
  }
}
