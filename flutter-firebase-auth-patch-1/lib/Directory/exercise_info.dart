import 'package:firebase_auth_demo/Directory/info_model.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';

class InfoInfo extends StatelessWidget {
  final DescriptionInfo info;
  InfoInfo(this.info);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(35),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Text(info.name),
          centerTitle: true,
          toolbarHeight: 20,
          backgroundColor: mainColor,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          Column(
            children: [
              Container(
                width: double.maxFinite,
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(info.imgUrl), fit: BoxFit.fill)),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Жим Свенда',
                      style: TextStyle(
                          fontSize: 22,
                          color: whiteColor,
                          fontWeight: FontWeight.w600),
                    ),
                    Container(
                      child: Text(
                        'Жим Свенда — упражнение, придуманное норвежским силовиком и культуристом Свендом Карлсенон (Svend Karlsen). Упражнение обычно выполняется в конце тренировки грудных мышц, когда дельты и грудные уже утомлены; в работе также участвуют широчайшие и трицепсы, мышцы кора.',
                        style: TextStyle(
                            fontSize: 16.5,
                            color: greyColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Инструкция по выполнению',
                      style: TextStyle(
                        fontSize: 16.5,
                        color: Color.fromARGB(168, 32, 96, 147),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 150,
                      padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(176, 158, 158, 158),
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 0,
                          ),
                          Text(
                            '1',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(168, 32, 96, 147),
                            ),
                          ),
                          Container(
                            width: 280,
                            child: Text(
                              'Плотно прижмите ладонями блины друг к другу. Ладони располагаются на уровне груди, руки согнуты в локтях. Так выглядит исходное положение.',
                              style: TextStyle(
                                fontSize: 17,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 100,
                      padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(176, 158, 158, 158),
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 0,
                          ),
                          Text(
                            '2',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(168, 32, 96, 147),
                            ),
                          ),
                          Container(
                            width: 280,
                            child: Text(
                              'Сделайте вдох, затем на выдохе, выжмите блины перед собой, выпрямляя руки и продолжая плотно сжимать ладони.',
                              style: TextStyle(
                                fontSize: 17,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 170,
                      padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(176, 158, 158, 158),
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 0,
                          ),
                          Text(
                            '3',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(168, 32, 96, 147),
                            ),
                          ),
                          Container(
                            width: 280,
                            child: Text(
                              'Возвращайтесь в исходное положение и, не разжимая ладоней, переходите к следующему повтору. Ориентируйтесь на 3–4 подхода по 10 повторений.',
                              style: TextStyle(
                                fontSize: 17,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '❗️ Внимание',
                      style: TextStyle(
                        fontSize: 16.5,
                        color: Color.fromARGB(255, 177, 12, 45),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 150,
                      padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(176, 158, 158, 158),
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 0,
                          ),
                          Text(
                            '*',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 177, 12, 45),
                            ),
                          ),
                          Container(
                            width: 280,
                            child: Text(
                              'Плотно прижмите ладонями блины друг к другу. Ладони располагаются на уровне груди, руки согнуты в локтях. Так выглядит исходное положение.',
                              style: TextStyle(
                                fontSize: 17,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
