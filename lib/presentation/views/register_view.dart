import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/domain/entities/user_enitites.dart';
import 'package:firebase_app/presentation/state_mangement/login/login_event.dart';
import 'package:firebase_app/presentation/state_mangement/login/login_state.dart';
import 'package:firebase_app/presentation/views/user_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_app/presentation/views/login_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../components/constance.dart';
import '../components/show_diolge.dart';
import '../state_mangement/login/login_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final positionController = TextEditingController();
  final phoneController = TextEditingController();

  final nameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final positionFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();

  @override
  void dispose() {
    animationController.dispose();
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    positionController.dispose();
    phoneController.dispose();

    nameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    positionFocusNode.dispose();
    phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 20));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              animationController.reset();
              animationController.forward();
            }
          });
    animationController.forward();

    super.initState();
  }

  bool isShow = true;
  bool showLoading = false;
  IconData suifxxx = Icons.visibility;
  File? imageFile ;
    String?  Url;
  final FormKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;


  void SubmitRegister()async{
    final vaild = FormKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(vaild){

      try{
        if(imageFile == null){
          ShowDiolge(
              context: context,
              title: Row(
                children: [
                  Icon(Icons.logout_outlined),
                  Text('Error' , style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),

                ],
              ),
              content: Text('Plase chose an image to show' , style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),),
              action: [
                TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text('OK', style: TextStyle(
                      color: Colors.amber
                  ),),
                ),

              ]
          );
        }
        setState(() {
          showLoading= true;
        });
       await auth.createUserWithEmailAndPassword(
            email: emailController.text.toUpperCase().trim(),
            password: passwordController.text.trim(),
        );

       final User? user = auth.currentUser;
       final _uid= user!.uid;
       final ref = FirebaseStorage.instance.ref().child('UserImage').child(_uid+'.jpg');
       await ref.putFile(imageFile!);
        Url = await ref.getDownloadURL();
        await  BlocProvider.of<LoginBloc>(context)
          ..add(
            setUserDataEvent(
              userEntities: UserEntities(
                name: nameController.text,
                email: emailController.text,
                userImageUrl: Url,
                phoneNuber: phoneController.text,
                createdAt: Timestamp.now(),
                positionCompany: positionController.text,
                id: _uid,
              ),
            ),
          );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserState()));

        //  Navigator.canPop(context) ? Navigator.pop(context) : null;

      // Navigator.canPop(context) ? Navigator.pop(context) : null;

      }catch(error){
        setState(() {
          showLoading= false;
        });
        ShowDiolgeerror(error);

        print('error occurrt $error');
      }
    }else{
      print('error occerrt');
      setState(() {
        showLoading= false;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc , LoginStates>(
      listener: (context , state){

      },
      builder: (context , state){
        return Scaffold(
            body: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl:
                  'https://media.istockphoto.com/id/1431590199/photo/software-developers-at-the-office.jpg?b=1&s=170667a&w=0&k=20&c=45h34Dq14unlZCCjd_Dt7lQTF4CTZ-HowGef-_Aq3_0=',
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  alignment: FractionalOffset(animation.value, 0),
                  placeholder: (context, value) {
                    return Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://img.freepik.com/free-photo/grunge-dark-interior-with-smoky-atmosphere_1048-11822.jpg'),
                            fit: BoxFit.cover,
                          )),
                    );
                  },
                  errorWidget: (context, value, error) {
                    return Center(child: Text('error found'));
                  },
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Form(
                      key: FormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 70.0,
                          ),
                          Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Already Have an Account?',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: '    ',
                                ),
                                TextSpan(
                                  text: 'Login',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginView())),
                                  style: TextStyle(
                                    color: Colors.amberAccent,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 3,
                                child:
                                TextFormField(
                                  textInputAction: TextInputAction.next,
                                  focusNode: nameFocusNode,
                                  controller: nameController,
                                  keyboardType: TextInputType.name,
                                  onEditingComplete: (){
                                    FocusScope.of(context).requestFocus(emailFocusNode);
                                  },
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return 'Please Enter The Real UserName';
                                    }return null;
                                  },
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'UserName',
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                    prefixIcon:Icon(Icons.drive_file_rename_outline, color: Colors.white,) ,
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    enabledBorder:  UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                  ),

                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 70,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 0.92, color: Colors.white),
                                          borderRadius: BorderRadius.circular(10),
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: imageFile == null
                                              ? Image(
                                            image: AssetImage('assets/image/3.jpg'),
                                            fit: BoxFit.cover,
                                          )
                                              : Image.file(imageFile! , fit: BoxFit.cover,),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      //top: -20,
                                      top: 0,
                                      right: 0,
                                      child: InkWell(
                                        onTap: () {
                                          ShowDloigeImage();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.white, width: 0.1),
                                          ),
                                          child: Icon(
                                            imageFile == null
                                                ? Icons.camera_alt_outlined
                                                : Icons.edit,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            focusNode: emailFocusNode,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            onEditingComplete: (){
                              FocusScope.of(context).requestFocus(passwordFocusNode);
                            },
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Please Enter The Real Email';
                              }return null;
                            },
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                            decoration: InputDecoration(
                              hintText: 'Email Addres',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              prefixIcon:Icon(Icons.email, color: Colors.white,) ,
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              enabledBorder:  UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            focusNode: passwordFocusNode,
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            onEditingComplete: (){
                              FocusScope.of(context).requestFocus(positionFocusNode);
                            },
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Please Enter The Real Password';
                              }return null;
                            },
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                            obscureText: isShow,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),

                              suffixIcon: IconButton(
                                onPressed: (){
                                  setState(() {
                                    suifxxx = isShow? Icons.visibility : Icons.visibility_off;
                                    isShow =! isShow;
                                  });
                                },
                                icon: Icon(suifxxx , color: Colors.white,),
                              ),

                              prefixIcon:Icon(Icons.password, color: Colors.white,) ,
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              enabledBorder:  UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            focusNode: phoneFocusNode,
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            onEditingComplete: (){
                              FocusScope.of(context).requestFocus(positionFocusNode);
                            },
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Please Enter The Real Phone Number';
                              }return null;
                            },
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                            decoration: InputDecoration(
                              hintText: 'Phone Number',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              prefixIcon:Icon(Icons.phone, color: Colors.white,) ,
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              enabledBorder:  UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              ShowDiolge(
                                  height: 100,
                                  context: context,
                                  title: Row(
                                    children: const [
                                      Icon(Icons.person,color: Colors.pink,),
                                      Text('Position Company', style: TextStyle(
                                          color: Colors.pink,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25
                                      ),),

                                    ],
                                  ),
                                  content: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:Constances. Position.length,
                                      itemBuilder: (context , index){
                                        return Row(
                                          children: [
                                            Icon(Icons.cloud_done, color: Colors.pink,),
                                            TextButton(
                                                onPressed: (){
                                                  setState(() {
                                                    positionController.text = Constances.Position[index];
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: Text(Constances.Position[index],

                                                  style: TextStyle(
                                                    color: Colors.amber,
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,

                                                  ),)
                                            ),
                                          ],
                                        );
                                      }
                                  ),
                                  action: [
                                    TextButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                      child: Text('Close',
                                        style: TextStyle(
                                          color: Colors.pink,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,

                                        ),
                                      ),
                                    ),

                                  ]
                              );
                            },
                            child:  TextFormField(
                              textInputAction: TextInputAction.done,
                              focusNode: positionFocusNode,
                              controller: positionController,
                              keyboardType: TextInputType.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                              ),
                              enabled: false,
                              onEditingComplete: (){
                                //  FocusScope.of(context).requestFocus(positionFocusNode);
                              },
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Please Enter The Real Position';
                                }return null;
                              },

                              decoration: InputDecoration(

                                hintText: 'Position in the Company',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                ),

                                prefixIcon:Icon(Icons.person, color: Colors.white,) ,
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                  disabledBorder:UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                enabledBorder:  UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                         showLoading== true? Center(child: CircularProgressIndicator(color: Colors.amber,),)
                             : Center(
                            child: Container(
                              width: 120.0,
                              height: 40.0,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                color: Colors.pink,
                                onPressed: () {
                                  SubmitRegister();
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'SignUp',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    Icon(
                                      Icons.person_add,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ));
      },

    );
  }


  Future PickedImageGallery()async{
    try{
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery ,

      );
      if(image == null) return;
      File? img = File(image.path);
      img = await CropImage(imagePath: img);
      setState(() {
          imageFile =img   ;
        Navigator.of(context).pop();
      });


    } on PlatformException catch(e){
      print(e);
      Navigator.of(context).pop();

    }
  }

  Future PickedImageCamera()async{
    try{
      final image = await ImagePicker().pickImage(
        source: ImageSource.camera ,
      );
      if(image == null) return;
      File? img = File(image.path);
      img = await CropImage(imagePath: img);
      setState(() {
        imageFile = img    ;
        Navigator.of(context).pop();
      });

    } on PlatformException catch(e){
      print(e);
      Navigator.of(context).pop();

    }
  }

  Future<File?> CropImage({required File imagePath} )async{

    CroppedFile? cropImage = await ImageCropper().cropImage(sourcePath: imagePath.path) ;
    if(cropImage ==null)return null;
    return File(cropImage.path);

  }

  Future ShowDloigeImage() {
    return ShowDiolge(
      context: context,
      title: Text(
        'Please Chose an Option',
        style: TextStyle(
          color: Colors.amberAccent,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.pink, width: 2)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap:(){
              PickedImageCamera();
            },

            child: Row(
              children: [
                Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.amber,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Camera',
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              PickedImageGallery();
            },
            child: Row(
              children: [
                Icon(
                  Icons.image_outlined,
                  color: Colors.amber,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Gallery',
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void ShowDiolgeerror(error){
    ShowDiolge(
        context: context,
        title: Row(
          children: [
            Icon(Icons.error),
            Text('Sorry we made a error' , style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),),

          ],
        ),
        content: Text('error occurt $error' , style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),),
        action: [

          TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text('OK' , style: TextStyle(
                color: Colors.red
            ),),
          ),
        ]
    );
  }

  // void SubmitVaild()async{
  //   final vaild = FormKey.currentState!.validate();
  //   if(vaild){
  //     setState(() {
  //       showLoading=true;
  //     });
  //     try{
  //       await BlocProvider.of<LoginBloc>(context)
  //         ..add(
  //           getLoginEvent(
  //             email: emailController.text
  //                 .toUpperCase().trim(),
  //             password: passwordController.text
  //                 .trim(),
  //           ),
  //         );
  //     }catch(error){
  //       setState(() {
  //         showLoading=false;
  //       });
  //       ShowDiolgeerror(error);
  //       print('error occerte $error');
  //     }
  //   }else{
  //
  //     print('error occerte');
  //   }
  //   setState(() {
  //     showLoading=false;
  //   });
  // }
}
