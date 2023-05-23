import 'package:booking_hotel/bloc/bloc_search_all/search_event.dart';
import 'package:booking_hotel/bloc/bloc_search_all/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/search_all.dart';

class SearchAllDataBloc extends Bloc<HotelEvent, SearchAllDataState> {
  SearchAllData searchAllData;
  SearchAllDataBloc(this.searchAllData) : super(SearchAllDataInitial()) {
    on<SearchAllDataEvent>((event, emit) async {
      emit(SearchAllDataLoading());
      try {
        final search = await searchAllData.searchAllData(
            event.address,
            event.checkinDate,
            event.checkoutDate,
            event.numberPeople,
            event.numberRooms);
        emit(SearchAllDataLoaded(search));
      } catch (e) {
        emit(SearchAllDataError('Failed to load data: $e'));
      }
    });
  }
}
