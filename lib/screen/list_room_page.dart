import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/hotel_data.dart';
import '../style/const/colors.dart';
import 'check_info.dart';
import 'info_user.dart';

class ListRoom extends StatefulWidget {
  final DetailDataHotel detailDataHotel;
  const ListRoom({required this.detailDataHotel, super.key});

  @override
  State<ListRoom> createState() => _ListRoomState();
}

class _ListRoomState extends State<ListRoom> {
  int _currentIndex = 0;
  bool _showBottomSheet = false;
  late String typeRoom;
  late List<ServiceRoom> _servicesRoom;
  List<int> _currentIndexList = [];
  late int curentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách phòng'),
        backgroundColor: Color(0xff003580),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.detailDataHotel.rooms.length,
              itemBuilder: (context, index) {
                final dateItem = widget.detailDataHotel.rooms;
                List<int> _currentIndexList = List.generate(
                  widget.detailDataHotel.rooms.length,
                  (index) => 0,
                );
                return Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                CarouselSlider(
                                  options: CarouselOptions(
                                    viewportFraction: 1.0,
                                    initialPage: 0,
                                    pauseAutoPlayOnTouch: true,
                                    onPageChanged: (pageIndex, reason) {
                                      setState(() {
                                        _currentIndexList[index] = pageIndex;
                                      });
                                    },
                                  ),
                                  items: dateItem[index].imageRoom.map((item) {
                                    return Container(
                                      child: Center(
                                        child: CachedNetworkImage(
                                          imageUrl: item.image,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Image.asset(
                                                  'assets/images/noimage.png'),
                                          width: size.width,
                                          height: 200,
                                          fit: BoxFit.cover,
                                          imageBuilder:
                                              (context, imageProvider) {
                                            return Container(
                                                decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ));
                                          },
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                Positioned(
                                  bottom: 18,
                                  right: 10,
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: Icon(
                                            Icons.picture_in_picture_outlined,
                                            size: 17,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          '${_currentIndexList[index] + 1} / ${widget.detailDataHotel.images.length}',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                _servicesRoom = widget
                                    .detailDataHotel.rooms[index].serviceRoom;
                                showBottomSheet(context, dateItem, index, size);
                              },
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      dateItem[index].typeRoom.name ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                  Icon(Icons.navigate_next)
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.people_outlined,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  dateItem[index].typeRoom.numberOfPeople ?? '',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'US\$' +
                                      dateItem[index]
                                          .typeRoom
                                          .price
                                          .toString() +
                                      ' /đêm',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: size.width * 1 / 4,
                                  child: MaterialButton(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    color: AppColors.button,
                                    splashColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    onPressed: () {
                                      typeRoom = dateItem[index]
                                          .typeRoom
                                          .price
                                          .toString();

                                      print(typeRoom);
                                      setState(() {
                                        _showBottomSheet = true;
                                      });
                                    },
                                    child: const Text(
                                      'Chọn phòng',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: size.width,
                        height: 8,
                        color: Colors.grey[350],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          _showBottomSheet
              ? Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6.0,
                      spreadRadius: 2.0,
                      offset: Offset(0.0, 0.0),
                    )
                  ]),
                  child: BottomSheet(
                      enableDrag: false,
                      onClosing: () {},
                      builder: (context) => Container(
                            height: 70,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Tổng giá (Bao gồm thuế & phí)'),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          ' US\$' + typeRoom,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 2 / 5,
                                    child: MaterialButton(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 13),
                                      color: AppColors.button,
                                      splashColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => CheckInfo(),
                                            ));
                                      },
                                      child: const Text(
                                        'Đặt phòng',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                )
              : Container()
        ],
      ),
    );
  }

  void showBottomSheet(
      BuildContext context, List<Room> dateItem, int index, Size size) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          height: size.height * 0.85,
          child: StatefulBuilder(
            builder: (context, setState) {
              return SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.close)),
                          Expanded(
                            child: Center(
                              child: Text(
                                dateItem[index].typeRoom.name ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.detailDataHotel.name),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Stack(
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                              viewportFraction: 1.0,
                              initialPage: 0,
                              pauseAutoPlayOnTouch: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                            ),
                            items: dateItem[index].imageRoom.map((item) {
                              return Container(
                                child: Center(
                                  child: CachedNetworkImage(
                                    imageUrl: item.image,
                                    width: size.width,
                                    height: 200,
                                    fit: BoxFit.cover,
                                    imageBuilder: (context, imageProvider) {
                                      return Container(
                                          decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ));
                                    },
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          Positioned(
                            bottom: 18,
                            right: 10,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Icon(
                                      Icons.picture_in_picture_outlined,
                                      size: 17,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '${_currentIndex + 1} / ${widget.detailDataHotel.images.length}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(dateItem[index].description),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(dateItem[index]
                                .typeRoom
                                .numberOfPeople
                                .toString()),
                          ),
                          Expanded(
                            child: Text('Diện tích ' +
                                dateItem[index].typeRoom.area.toString() +
                                'm\u00B2'),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 30,
                        color: Colors.grey,
                        thickness: 2,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Tiện ích',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                          child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: (_servicesRoom.length / 2).ceil(),
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 8.0,
                            ),
                            child: Wrap(
                              spacing: 2.0, // khoảng cách giữa các item
                              children: [
                                Container(
                                  width: (MediaQuery.of(context).size.width -
                                          24.0) /
                                      2, // tính toán chiều rộng của item
                                  child: Text(
                                      '- ${_servicesRoom[index * 2].service}'),
                                ),
                                Container(
                                  width: (MediaQuery.of(context).size.width -
                                          24.0) /
                                      2, // tính toán chiều rộng của item
                                  child: (index * 2 + 1 < _servicesRoom.length)
                                      ? Text(
                                          '- ${_servicesRoom[index * 2 + 1].service}')
                                      : SizedBox(),
                                ),
                              ],
                            ),
                          );
                        },
                      )),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
