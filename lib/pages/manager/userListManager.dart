import 'package:devoteam/pages/manager/userDetails.dart';
import 'package:devoteam/pages/manager/userEval.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../models/userModel.dart';
import '../../services/userService.dart';

class UserListManager extends StatefulWidget {



  @override
  _UserListManagerState createState() => _UserListManagerState();
}

class _UserListManagerState extends State<UserListManager> {
  UserService userService = UserService();
  TextEditingController editingController = TextEditingController();
  late Future<List<UserModel>> userList;
  @override
  void initState() {
    userList = userService.getListUsersByManager("");
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.92,
      color: Colors.redAccent,
      child: Container(
        height: 240,
        width: 240,
        margin: const EdgeInsets.only(left: 200, top: 100, bottom: 100,right: 200),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),color: Colors.white,),
        child: Column(

          children: [
            const SizedBox(height: 10,),
            TextFieldContainer(0.2, 18, Colors.blueGrey.shade50, 1, "Search", "Search", Feather.search, editingController),
            const SizedBox(height: 10,),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * 0.3,
                child: FutureBuilder(
                  future: userList,
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                    print(snapshot.data);
                    if(snapshot.data == null){
                      return const Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(

                        ),
                      );
                    }
                    else {
                      return ListView.builder(

                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index){

                            return Column(
                              children: [
                                Container(

                                  child: Column(
                                    children: [
                                      ListTile(

                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              snapshot.data[index].profileImageUrl
                                          ),
                                        ),
                                        title: Text(snapshot.data[index].username),
                                        subtitle: Text(snapshot.data[index].email),
                                        trailing: const Icon(Feather.eye),
                                        dense: true,
                                        tileColor: Colors.blueGrey.shade50,
                                        hoverColor: Colors.white,
                                        onTap: (){
                                          String str = snapshot.data[index].joinDate;

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => UserEval(user: UserModel(userId: snapshot.data[index].userId,
                                                  firstName: snapshot.data[index].firstName, lastName: snapshot.data[index].lastName,
                                                  username: snapshot.data[index].username, email: snapshot.data[index].email,
                                                  profileImageUrl: snapshot.data[index].profileImageUrl, joinDate: str.substring(0,10),
                                                  role: snapshot.data[index].role, rank: snapshot.data[index].rank, job: snapshot.data[index].job,
                                                  offre: snapshot.data[index].offre, prefoffre: snapshot.data[index].prefoffre,
                                                  experience: snapshot.data[index].experience, manager: snapshot.data[index].manager)),
                                            ),
                                          );
                                        },
                                      ),

                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors .blueGrey.shade100,
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                ),
                                const SizedBox(height: 10,),
                              ],
                            );}
                      );
                    }
                  },
                ),


              ),
            ),
          ],

        ),
      ),


    );
  }

  Widget TextFieldContainer( double width, double radius,
      Color color,
      int maxLines,
      String label,
      String hintText,
      IconData icon,
      TextEditingController controller){
    return Container(

      width: MediaQuery.of(context).size.width*width,

      decoration:  BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius),),
          color: color
      ),

      child:  TextField(
        maxLines: maxLines,
        controller: controller,
        decoration: InputDecoration(

          label: Text(label),
          hintText: hintText,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide(color: color,)


            // borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
          ),



        ),
        onChanged: (value){

          setState(() {
            userList = userService.getListUsersByManager(value);

          });
        },



      ),
    );
  }

}
