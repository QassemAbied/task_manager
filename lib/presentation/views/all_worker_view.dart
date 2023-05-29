import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_app/presentation/views/my_account_view.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/drawer_widget.dart';
import '../components/task_card.dart';

class AllWorkerView extends StatefulWidget {
  const AllWorkerView({Key? key}) : super(key: key);

  @override
  State<AllWorkerView> createState() => _AllWorkerViewState();
}

class _AllWorkerViewState extends State<AllWorkerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: DrawerWidget(),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text('All Worker', style: TextStyle(
            color: Colors.black
        ),),

        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              // height:5000,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('User').snapshots(),
                builder: (context , snapshot){
                  if(snapshot.connectionState ==ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(color: Colors.amber,),);
                  }else if(snapshot.connectionState ==ConnectionState.active){
                    if(snapshot.data!.docs.isNotEmpty){
                      return ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context , index){
                          return CardTaskScreen(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=>MyAccountView(UserId: snapshot.data!.docs[index]['id'],)));
                            },
                            leading:Container(
                              height: 200,
                              width: 60,
                              decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(width: 0.5, color: Colors.pink,),
                                    bottom: BorderSide(width: 0.5, color: Colors.pink,),
                                    right: BorderSide(width: 0.5, color: Colors.pink,),
                                    left: BorderSide(width: 0.5, color: Colors.pink,),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage('${snapshot.data!.docs[index]['userImageUrl']}', ), fit: BoxFit.fill,
                                  )
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: (){
                                _launchUrlmail(snapshot.data!.docs[index]['email']);
                              },
                              icon: Icon(Icons.email_outlined, color: Colors.pink,),
                            ),
                            title: snapshot.data!.docs[index]['name'],
                            subtitle:'${snapshot.data!.docs[index]['positionCompany']} /${snapshot.data!.docs[index]['phoneNuber']}',
                          );
                        },
                        separatorBuilder: (context , index){
                          return SizedBox(
                            height: 7.0,
                          );
                        },

                      );
                    }else{
                      return Center(child:  Text('No User Has Been Uploaded'),);
                    }
                  }
                  return Center(child:  Text('No User Has Been Uploaded'),);
                },
              ),
            )
          ],
        ),
      ),
    );

  }
  Future<void> _launchUrlmail(email) async {
    final Uri _url = Uri.parse('mailto:$email');

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch ');
    }
  }

}
