import 'package:redux_implement/models/App_State.dart';
import 'package:redux_implement/redux/Reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    bookState: booksReducers(state.bookState, action),
  );
}