import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:todoappnew/moduel/todoapp/cubit/cubit.dart';
import 'package:todoappnew/shared/CasheHelper/CasheHelper.dart';


Widget BuildTextFormFieldDefault({
  required String LabelText,
  required InputBorder border,
  required IconData icon,
  required TextEditingController controller,
  void Function()? ontap,
  void Function(String)? onChange,
  void Function(String)? submit,
  void Function()? OnPressIcon,
  IconData ?Suffixicon,
   var ObseucreText=false,
   String? Function(String?)? validate
})=>TextFormField(
  decoration: InputDecoration(
      labelText: LabelText,
      border: border,
      prefixIcon: Icon(
          icon
      ),
    suffixIcon: IconButton(
      onPressed: OnPressIcon,
       icon:Icon(
        Suffixicon
      ),
    )

  ),
  onTap:ontap,
  obscureText: ObseucreText,
  onFieldSubmitted:submit ,
  onChanged:onChange ,
  validator:validate ,
  keyboardType: TextInputType.text,
  controller:controller,
);

Widget BuildTaskItem(var x,context)=>Dismissible(
  key:Key(x['id'].toString()) ,
  onDismissed: (direction){
    TodoCubit.get(context).DeleteFromDataBase(id: x['id']);


  },
  background: Container(color: Colors.red,),
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Column(

      children: [

        Row(

          children: [

            CircleAvatar(

              backgroundColor: Colors.blue,

              radius: 45,

              child: Text(

                '${x['time']}',

                style: TextStyle(

                    color: Colors.white,

                    fontWeight: FontWeight.bold,

                    fontSize:20

                ),

              ),

            ),

            SizedBox(

              width: 10,

            ),

            Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(

                  '${x['task']}',

                  style: TextStyle(

                      color: Colors.black,

                      fontWeight: FontWeight.bold,

                      fontSize: 20

                  ),



                ),

                SizedBox(

                  height: 5,

                ),

                Text(

                  '${x['date']}',

                  style: TextStyle(

                      color: Colors.grey

                  ),

                )

              ],

            ),

            Spacer(),

            IconButton(

                onPressed: (){

                  TodoCubit.get(context).UpdateDataFromDataBase('done', x['id']);



                },

                icon: Icon(

                  Icons.check_box,

                  color: Colors.green,

                )),

            IconButton(

                onPressed: (){

                  TodoCubit.get(context).UpdateDataFromDataBase('archive', x['id']);





                },

                icon: Icon(

                    Icons.archive,

                  color: Colors.grey,

                ))



          ],

        )

      ],

    ),

  ),
);

//////////////////////////////News App //////////////////////////////////
Widget BuildNewsItem(context,dynamic x)=>InkWell(
  onTap: (){

  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Container(

      clipBehavior: Clip.antiAliasWithSaveLayer,

      decoration: BoxDecoration(

        borderRadius:BorderRadiusDirectional.circular(20),

      ),

      child: Column(

        children: [

          ClipRect(
            child: Row(
              children: [
                Container(
                  child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/error.png',
                      image: x['urlToImage']??'https://cdn.pixabay.com/photo/2017/02/12/21/29/false-2061131_640.png'),
                  height: 170,
                  width: 170,
                ),

                SizedBox(

                  width: 15,

                ),

                Expanded(

                  child: Container(

                    height: 170,

                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        Expanded(
                          child: Text(

                            '${x['title']}',

                            overflow: TextOverflow.ellipsis,

                            maxLines: 5,

                            style: Theme.of(context).textTheme.titleLarge,

                          ),
                        ),

                        Spacer(),

                        Text(

                          '${x['publishedAt']}',

                          style: Theme.of(context).textTheme.titleSmall!.copyWith(

                              color: Colors.grey

                          ),

                        )

                      ],

                    ),

                  ),

                )

              ],

            ),
          )

        ],

      ),

    ),

  ),
);

Widget BuildDeafaultButton(context,{
  required void Function()? onpress,
  required String text,
  required Color color
})=>Container(
  width: double.infinity,
  clipBehavior: Clip.antiAliasWithSaveLayer,
  decoration: BoxDecoration(
    color: color,
    borderRadius: BorderRadiusDirectional.circular(20),
  ),
  child:   MaterialButton(
      onPressed:onpress,
    child: Text(
      text,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
        color: Colors.white
      ),

    ),

  ),
);
Widget BuildDefaultTextButton({
  required void Function()? onpress,
  required String text
})=>TextButton(
    onPressed: onpress,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 18,
        color: Colors.blue[800],
        fontWeight: FontWeight.bold
      ),

    ));
MaterialColor primayColor=Colors.deepOrange;


Widget SignOut(context,Widget widget)=>TextButton(
  onPressed: (){
    CasheHelper.ClearData(key: 'login').then((value) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>widget), (route) => false);
    });

  },
  child: Text(
      'Sign out'
  ),
);
dynamic login_token='';
