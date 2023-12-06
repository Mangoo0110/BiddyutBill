import 'package:e_bill/admin_panel/usersTab/data_layer/user_model.dart';
import 'package:e_bill/authentication/presentation_layer/logIn.dart';
import 'package:e_bill/constants/routes.dart';
import 'package:e_bill/user_panel/constants/ui_colors.dart';
import 'package:e_bill/user_panel/constants/ui_style.dart';
import 'package:flutter/material.dart';

class UserSideBar extends StatelessWidget {
  final User? user;
  const UserSideBar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return 
     Container(
            decoration: BoxDecoration(
              color: AppColors.secondaryBg,
            ),
            child:
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 12,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text("User details",style: AppStyle().headerOne,)),
                          Expanded(
                            child: 
                              Container(
                                child: (user==null)? const Center(child: CircularProgressIndicator())
                                :
                                Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(6),
                                                      border: Border.all(color: Colors.black,width: 3),
                                                      color: AppColors.primaryBg
                                                    ),
                                                    child: const Icon(Icons.person, size: 100,)
                                                    ),
                                                    (user!.isEmailVerified==true)?
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.green.shade200,
                                                          borderRadius: BorderRadius.circular(5),
                                                        ),
                                                        child: const Padding(
                                                          padding:  EdgeInsets.all(6.0),
                                                          child: Row(
                                                            children: [
                                                              Icon(Icons.verified),
                                                              Text("Verified"),
                                                            ],
                                                          ),
                                                        )
                                                      ),
                                                    )
                                                    :
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              color: Colors.red.shade200,
                                                              borderRadius: BorderRadius.circular(5),
                                                            ),
                                                            child: const Padding(
                                                              padding:  EdgeInsets.all(6.0),
                                                              child: Row(
                                                                children: [
                                                                  Icon(Icons.error),
                                                                  Text("Not Verified"),
                                                                ],
                                                              ),
                                                            )
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              
                                                            },
                                                            child: const Text("Verify yourself",style: TextStyle(fontStyle: FontStyle.italic,textBaseline: TextBaseline.alphabetic),),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  
                                                ],
                                              ),
                                            )),
                                              customTableRow(label1: "Id", label2: user!.id),
                                              customTableRow(label1: "Name", label2: user!.fullName),
                                              customTableRow(label1: "Occupation", label2: user!.occupation),
                                              customTableRow(label1: "Email", label2: user!.emailAdress),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                    onTap: (){
                            Navigator.pushReplacementNamed(context, loginRoute);
                          },
                      title: Container(
                         decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          height: 40,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 1,horizontal: 130),
                            child: Text("Logout",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20),),
                          ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        
  }
   Widget customTableRow({
    required String label1,
    required String label2,
  }){
    return 
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Table(
              columnWidths: const {0:FractionColumnWidth(.4),1:FractionColumnWidth(.6),},
              children: [
                TableRow(
                  children: [
                    boldLabelText(label: label1),
                    labelText(label: label2),
                  ]
                )
              ],
            ),
          );
                        
  }
  Widget labelText({
    required String label
    }){
    return Text(label, style: const TextStyle(color: Colors.black,fontSize: 17),);
  }
  Widget boldLabelText({
    required String label
    }){
    return Text(label, style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 17),);
  }
}