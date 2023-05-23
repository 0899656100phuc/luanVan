part of 'detail_item_hotel_bloc.dart';

abstract class DetailItemHotelEvent extends Equatable {
  const DetailItemHotelEvent();

  @override
  List<Object> get props => [];
}

class FetchDetailHotelEvent extends DetailItemHotelEvent {
  final int id;

  FetchDetailHotelEvent(this.id);
}
