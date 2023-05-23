import 'package:booking_hotel/screen/result_page.dart';
import 'package:booking_hotel/screen/search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/bloc/profile_bloc.dart';
import '../service/profile.dart';
import '../service/register.dart';
import '../util/component/item_showbottom.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _dateRangeController = TextEditingController();

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 1));
  final String _textCountRoom = ' phòng';
  TextEditingController _textController = TextEditingController();
  TextEditingController _searchController = TextEditingController();

  void _showDateRangePicker(BuildContext context) async {
    DateTimeRange? selectedDates = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(Duration(days: 365)),
      initialDateRange: DateTimeRange(start: _startDate, end: _endDate),
      confirmText: 'Apply',
      cancelText: 'Cancel',
    );

    if (selectedDates != null) {
      setState(() {
        _startDate = selectedDates.start;
        _endDate = selectedDates.end;
        _dateRangeController.text =
            '${DateFormat('EE, dd MMM', 'vi').format(selectedDates.start)} - ${DateFormat('EE, dd MMM', 'vi').format(selectedDates.end)} (${selectedDates.duration.inDays} đêm)';
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
    getCurrentDay();

    _textController.text =
        '$countRoom phòng - $countPeople người lớn - $countPeopleChild trẻ em';
    _searchController.text = 'Nhập điểm đến';
  }

  DateTime nowStart = DateTime.now();
  DateTime nowEnd = DateTime.now().add(Duration(days: 1));
  String resultDate = '';
  String? formattedDateStart;
  String? formattedDateEnd;
  getCurrentDay() async {
    await initializeDateFormatting('vi_VN', null);

    formattedDateStart = DateFormat('EE, dd MMM', 'vi').format(nowStart);
    formattedDateEnd = DateFormat('EE, dd MMM', 'vi').format(nowEnd);
    _dateRangeController.text = '$formattedDateStart - $formattedDateEnd';
  }

  int countRoom = 1;
  int countPeople = 1;
  int countPeopleChild = 0;
  var result = 'Nhập điểm đến';

  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? counterRoomData = prefs.getInt('countRoom');
    final int? countPeopleData = prefs.getInt('countPeople');
    final int? countPeopleChildData = prefs.getInt('countPeopleChild');
    setState(() {
      countRoom = counterRoomData ?? 2;
      _textController.text =
          '$countRoom phòng - $countPeople người lớn - $countPeopleChild trẻ em';
    });

    print('counterRoom----');
    print(counterRoomData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff003580),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Travel',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: IconButton(
              // icon: Image.asset('assets/images/messenger.png'),
              icon: Icon(
                Icons.notifications_none_rounded,
                size: 30,
              ),
              tooltip: 'Closes application',
              onPressed: () => () {},
            ),
          ),
        ],
        /*  leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset(
            'assets/images/logo.png',
          ),
        ), */
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.amber, width: 4),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchPage(),
                              ));
                          print('ket qua: $result');
                          try {
                            setState(() {
                              _searchController.text = result;
                            });
                          } catch (e) {
                            print('Error: $e');
                          }
                        },
                        child: TextField(
                          enabled: false,
                          controller: _searchController,
                          enableInteractiveSelection: false,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _showDateRangePicker(context);
                        },
                        child: TextField(
                          enabled: false,
                          enableInteractiveSelection: false,
                          focusNode: FocusNode(),
                          controller: _dateRangeController,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.calendar_today_outlined)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final result = await showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25.0),
                              ),
                            ),
                            builder: (context) => SizedBox(
                              child: StatefulBuilder(
                                builder: (context, setState) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              height: 3,
                                              width: 50.0,
                                              margin: const EdgeInsets.only(
                                                  bottom: 25.0, top: 10),
                                            ),
                                          ],
                                        ),
                                        const Text(
                                          'Chọn phòng và khách',
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Row(
                                            children: [
                                              const Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                    'Phong',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              Row(
                                                children: [
                                                  RawMaterialButton(
                                                    constraints:
                                                        const BoxConstraints(
                                                      minWidth: 0,
                                                      minHeight: 0,
                                                      maxWidth: 60,
                                                      maxHeight: 60,
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      side: const BorderSide(
                                                          color: Colors.blue),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        countRoom++;
                                                      });
                                                    },
                                                    child: const Icon(Icons.add,
                                                        color: Colors.blue),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 6),
                                                    child: Text('$countRoom'),
                                                  ),
                                                  RawMaterialButton(
                                                    constraints:
                                                        const BoxConstraints(
                                                      minWidth: 0,
                                                      minHeight: 0,
                                                      maxWidth: 60,
                                                      maxHeight: 60,
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      side: BorderSide(
                                                          color: countRoom == 1
                                                              ? Colors.grey
                                                              : Colors.blue),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        if (countRoom == 1)
                                                          return;
                                                        countRoom--;
                                                        print(countRoom);
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: countRoom == 1
                                                          ? Colors.grey
                                                          : Colors.blue,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Row(
                                            children: [
                                              const Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                    'Người lớn',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              Row(
                                                children: [
                                                  RawMaterialButton(
                                                    constraints:
                                                        const BoxConstraints(
                                                      minWidth: 0,
                                                      minHeight: 0,
                                                      maxWidth: 60,
                                                      maxHeight: 60,
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      side: const BorderSide(
                                                          color: Colors.blue),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        countPeople++;
                                                      });
                                                    },
                                                    child: const Icon(Icons.add,
                                                        color: Colors.blue),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 6),
                                                    child: Text('$countPeople'),
                                                  ),
                                                  RawMaterialButton(
                                                    constraints:
                                                        const BoxConstraints(
                                                      minWidth: 0,
                                                      minHeight: 0,
                                                      maxWidth: 60,
                                                      maxHeight: 60,
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      side: BorderSide(
                                                          color: countPeople ==
                                                                  1
                                                              ? Colors.grey
                                                              : Colors.blue),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        if (countPeople == 1)
                                                          return;
                                                        countPeople--;
                                                        print(countRoom);
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: countPeople == 1
                                                          ? Colors.grey
                                                          : Colors.blue,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Row(
                                            children: [
                                              const Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                    'Trẻ em',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              Row(
                                                children: [
                                                  RawMaterialButton(
                                                    constraints:
                                                        const BoxConstraints(
                                                      minWidth: 0,
                                                      minHeight: 0,
                                                      maxWidth: 60,
                                                      maxHeight: 60,
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      side: const BorderSide(
                                                          color: Colors.blue),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        countPeopleChild++;
                                                      });
                                                    },
                                                    child: const Icon(Icons.add,
                                                        color: Colors.blue),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 6),
                                                    child: Text(
                                                        '$countPeopleChild'),
                                                  ),
                                                  RawMaterialButton(
                                                    constraints:
                                                        const BoxConstraints(
                                                      minWidth: 0,
                                                      minHeight: 0,
                                                      maxWidth: 60,
                                                      maxHeight: 60,
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      side: BorderSide(
                                                          color:
                                                              countPeopleChild ==
                                                                      0
                                                                  ? Colors.grey
                                                                  : Colors
                                                                      .blue),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        if (countPeopleChild ==
                                                            1) return;
                                                        countPeopleChild--;
                                                        print(countRoom);
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.remove,
                                                      color:
                                                          countPeopleChild == 0
                                                              ? Colors.grey
                                                              : Colors.blue,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 13),
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: MaterialButton(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 15),
                                                color: const Color(0xff006CE4),
                                                splashColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                onPressed: () async {
                                                  Navigator.pop(context, {
                                                    'countRoom': countRoom,
                                                    'countPeopleChild':
                                                        countPeopleChild,
                                                    'countPeople': countPeople
                                                  });

                                                  SharedPreferences prefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  await prefs.setInt(
                                                      'countRoom', countRoom);
                                                  await prefs.setInt(
                                                      'countPeople',
                                                      countPeople);
                                                  await prefs.setInt(
                                                      'countPeopleChild',
                                                      countPeopleChild);

                                                  print(countRoom);
                                                },
                                                child: const Text('Áp dụng',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                          setState(() {
                            if (result != null) {
                              countRoom = result['countRoom'];
                              countPeople = result['countPeople'];
                              countPeopleChild = result['countPeopleChild'];
                              _textController.text =
                                  '$countRoom phòng - $countPeople người lớn - $countPeopleChild trẻ em';
                            }
                          });
                        },
                        child: TextField(
                          enabled: false,
                          controller: _textController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person_outline_outlined)),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: MaterialButton(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                          onPressed: () async {
                            if (result.contains('Nhập điểm đến')) {
                              result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchPage(),
                                  ));
                              print('ket qua: $result');
                              setState(() {
                                _searchController.text = result;
                              });
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ResultPage(
                                      result: result,
                                      dateResult: _dateRangeController.text,
                                      formattedDateStart:
                                          formattedDateStart ?? '',
                                      formattedDateEnd: formattedDateEnd ?? '',
                                      countPeople: countPeople,
                                      countRoom: countRoom,
                                    ),
                                  ));
                            }
                          },
                          color: const Color(0xff006CE4),
                          child: const Text(
                            'Tìm',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const ListTile(
                                dense: true,
                                contentPadding:
                                    EdgeInsets.only(left: 0.0, right: 0.0),
                                title: Text(
                                  'Tìm nhà nghỉ dưỡng phù hợp cho mình',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                    'chỗ nghỉ dễ đặt nhưng thật khó rời xa',
                                    style: TextStyle(fontSize: 15)),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              MaterialButton(
                                color: Color(0xff006CE4),
                                onPressed: () {},
                                child: const Text(
                                  'Bắt đầu khám phá',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Container(
                                height: 200,
                                width: 150,
                                child: Image.asset(
                                  'assets/images/splash.jpeg',
                                  fit: BoxFit.fill,
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Khám phá thêm',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Column(
                              children: [
                                Container(
                                    height: 200,
                                    child: Image.asset(
                                      'assets/images/splash.jpeg',
                                      fit: BoxFit.cover,
                                    )),
                                const ListTile(
                                  dense: true,
                                  contentPadding:
                                      EdgeInsets.only(left: 0.0, right: 0.0),
                                  title: Text(
                                    'Lưu trú dài ngày',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                      'Thoải mái du lịch với đợt lưu trú trên 10 đêm',
                                      style: TextStyle(fontSize: 15)),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Column(
                              children: [
                                Container(
                                    height: 100,
                                    child: Image.asset(
                                      'assets/images/splash.jpeg',
                                      fit: BoxFit.fill,
                                    )),
                                const ListTile(
                                  dense: true,
                                  contentPadding:
                                      EdgeInsets.only(left: 0.0, right: 0.0),
                                  title: Text(
                                    'Lưu trú dài ngày',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                      'Thoải mái du lịch với đợt lưu trú trên 10 đêm',
                                      style: TextStyle(fontSize: 15)),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Column(
                              children: [
                                Container(
                                    height: 100,
                                    child: Image.asset(
                                      'assets/images/splash.jpeg',
                                      fit: BoxFit.fill,
                                    )),
                                const ListTile(
                                  dense: true,
                                  contentPadding:
                                      EdgeInsets.only(left: 0.0, right: 0.0),
                                  title: Text(
                                    'Lưu trú dài ngày',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                      'Thoải mái du lịch với đợt lưu trú trên 10 đêm',
                                      style: TextStyle(fontSize: 15)),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRoomCounter(VoidCallback onPressed, onPressed2, int count) {
    return Row(
      children: [
        RawMaterialButton(
          constraints: const BoxConstraints(
            minWidth: 0,
            minHeight: 0,
            maxWidth: 60,
            maxHeight: 60,
          ),
          padding: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(color: Colors.blue),
          ),
          onPressed: onPressed,
          child: const Icon(Icons.add, color: Colors.blue),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Text('$count'),
        ),
        RawMaterialButton(
          constraints: const BoxConstraints(
            minWidth: 0,
            minHeight: 0,
            maxWidth: 60,
            maxHeight: 60,
          ),
          padding: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
              color: count == 1 ? Colors.grey : Colors.blue,
            ),
          ),
          onPressed: onPressed2,
          child: const Icon(
            Icons.remove,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
