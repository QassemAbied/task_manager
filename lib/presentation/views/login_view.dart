import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_app/presentation/views/register_view.dart';
import 'package:firebase_app/presentation/views/user_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/show_diolge.dart';
import '../state_mangement/login/login_bloc.dart';
import '../state_mangement/login/login_state.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double>  animation;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final FormKey = GlobalKey<FormState>();
  bool showLoading = false;




  @override
  void initState() {
    animationController = AnimationController(vsync: this , duration: Duration(seconds: 20));
    animation = CurvedAnimation(parent: animationController, curve: Curves.linear)..addListener(() {
      setState(() {
        //animation = animationController;
      });
    })..addStatusListener((animationStatus) {
      if(animationStatus == AnimationStatus.completed){
        animationController.reset();
        animationController.forward();
      }

    });
    animationController.forward();


    super.initState();
  }
  @override
  void dispose() {
    animationController.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }
  final FirebaseAuth auth = FirebaseAuth.instance;


 void SubmitLogin()async{
   final vaild = FormKey.currentState!.validate();
   FocusScope.of(context).unfocus();
   if(vaild){
     setState(() {
       showLoading= true;
     });
     try{
       await auth.signInWithEmailAndPassword(
         email: emailController.text.toUpperCase().trim(),
         password: passwordController.text.trim(),
       );
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserState()));
      // Navigator.canPop(context) ? Navigator.pop(context) : null;

     }catch(error){
       setState(() {
         showLoading= false;
         ShowDiolgeerror(error);

       });
       print('error occerte $error');
     }
   }else{
     print('error occerte');
     setState(() {
       showLoading= false;

     });
   }
 }
  bool isShow = true;
  Widget suificon= Icon(Icons.visibility, color: Colors.white);
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<LoginBloc , LoginStates>(
      builder: (context , state){
        return Scaffold(
            body: Stack(
              children: [

                CachedNetworkImage(
                  imageUrl: 'https://media.istockphoto.com/id/1431590199/photo/software-developers-at-the-office.jpg?b=1&s=170667a&w=0&k=20&c=45h34Dq14unlZCCjd_Dt7lQTF4CTZ-HowGef-_Aq3_0=',
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  alignment: FractionalOffset(animation.value , 0 ),


                  placeholder: (context , value){
                    return   Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(

                          image: DecorationImage(
                            image: NetworkImage(''
                                'https://img.freepik.com/free-photo/grunge-dark-interior-with-smoky-atmosphere_1048-11822.jpg'),
                            fit: BoxFit.cover,
                          )),
                    );
                  },
                  errorWidget: (context , value , error){
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
                        children:  [
                          SizedBox(
                            height: 70.0,
                          ),
                          Text('Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),),
                          SizedBox(
                            height: 6.0,
                          ),
                          RichText(
                            text:TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Don\'t Have an Account?',
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
                                  text: 'Register',
                                  recognizer: TapGestureRecognizer()..onTap=()=>
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterView())),
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
                            //  FocusScope.of(context).requestFocus(positionFocusNode);
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
                                      suificon = isShow?Icon(Icons.visibility, color: Colors.white):Icon(Icons.visibility_off_sharp, color: Colors.white);
                                      isShow =!isShow;
                                    });
                                  },
                                  icon: suificon,
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
                          Align(
                            alignment: Alignment.topRight,
                            child: TextButton(
                              onPressed: (){},
                              child:Text('Forget Your Password ?',
                                style: TextStyle(
                                  color: Colors.amberAccent,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.underline,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black,
                                      offset: Offset.fromDirection(0.2 , 1.0),
                                      blurRadius: 0.3,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          showLoading== true? Center(child: CircularProgressIndicator(color: Colors.amber,),)
                      :  Center(
                            child: Container(
                              width: 100.0,
                              height: 40.0,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

                                color: Colors.pink,
                                onPressed: (){
                                  SubmitLogin();
                                },
                                child: Row(
                                  children:  [
                                    Text('Login',  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.underline,
                                    ),),
                                    Icon(Icons.login, color: Colors.white,),

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
            )
        );
      },

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
}
