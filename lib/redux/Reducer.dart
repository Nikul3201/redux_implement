import 'package:redux/redux.dart';
import 'package:redux_implement/models/bookState.dart';
import 'package:redux_implement/redux/Actions.dart';

final booksReducers = combineReducers<BookState>([
  TypedReducer<BookState, AppendBookDataAction>(_appendBooksData),
]);


BookState _appendBooksData(BookState state, AppendBookDataAction action){
  // print('got state of BookState is :: '+action.books.toString());
  BookState book = state ?? new BookState();
  return book.copyWith(books: action.books);
}