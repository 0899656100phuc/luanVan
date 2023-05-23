import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/hotel_data.dart';
import '../../service/detail_hotel.dart';

part 'detail_item_hotel_event.dart';
part 'detail_item_hotel_state.dart';

class DetailItemHotelBloc
    extends Bloc<DetailItemHotelEvent, DetailItemHotelState> {
  DetailHotelService detailHotelService;
  DetailItemHotelBloc(this.detailHotelService)
      : super(DetailItemHotelInitial()) {
    on<FetchDetailHotelEvent>((event, emit) async {
      emit(DetailDataHotelLoading());
      try {
        var hotel = await detailHotelService.fetchSearchData(event.id);
        print('hotel-----');
        print(hotel);

        emit(DetailDataHotelLoaded(hotel));
      } catch (e) {
        emit(DetailDataHotelError('Failed to load data: $e'));
      }
    });
  }
}
