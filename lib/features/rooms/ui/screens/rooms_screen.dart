import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/features/rooms/bloc/room_bloc.dart';
import 'package:millima/features/rooms/bloc/room_event.dart';
import 'package:millima/features/rooms/bloc/room_state.dart';
import 'package:millima/features/rooms/ui/screens/manage_rooms.dart';
import 'package:millima/features/user/ui/widgets/custom_drawer_for_admin.dart';


class RoomScreen extends StatefulWidget {
  const RoomScreen({super.key});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RoomBloc>().add(GetRoomsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Rooms",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      drawer: CustomDrawerForAdmin(),
      body: BlocBuilder<RoomBloc, RoomState>(builder: (context, state) {
        if (state is RoomLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is RoomErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state is RoomLoadedState) {
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20),
            itemCount: state.rooms.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => GroupInformationScreen(
                      //         groupModel: state.rooms[index],
                      //       ),
                      //     ));
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Room Name: ${state.rooms[index].name}",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          Text(
                            "Descripstion: ${state.rooms[index].description}",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Capacity: ${state.rooms[index].capacity}",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ManageRoom(
                                                roomModel: state.rooms[index],
                                              ),
                                            ));
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        size: 30,
                                        color: Colors.white,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        context.read<RoomBloc>().add(
                                            DeleteRoomEvent(
                                                roomId: state.rooms[index].id));
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        size: 30,
                                        color: Colors.red,
                                      )),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              );
            },
          );
        }
        return Center(
          child: Text("Grouplar topilmadi!"),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ManageRoom(
                  roomModel: null,
                ),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}