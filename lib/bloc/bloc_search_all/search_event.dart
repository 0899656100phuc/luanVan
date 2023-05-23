import 'package:equatable/equatable.dart';

abstract class HotelEvent extends Equatable {
  const HotelEvent();
}

class SearchAllDataEvent extends HotelEvent {
  final String address;
  final String checkinDate;
  final String checkoutDate;
  final int numberPeople;
  final int numberRooms;

  const SearchAllDataEvent(
      {required this.address,
      required this.checkinDate,
      required this.checkoutDate,
      required this.numberPeople,
      required this.numberRooms});

  @override
  List<Object> get props =>
      [address, checkinDate, checkoutDate, numberPeople, numberRooms];
  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}
