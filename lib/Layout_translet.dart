import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:translator/translator.dart';
import 'package:flutter_tts/flutter_tts.dart';
class TransletScreen extends StatefulWidget {
  @override
  State<TransletScreen> createState() => _TransletScreenState();
}

class _TransletScreenState extends State<TransletScreen> {
  var texttransleted = TextEditingController();

  var TextController = TextEditingController();
  String value='English To Arabic';

  String to='ar';
  String from='en';
  Color color = Colors.cyan;
  final FlutterTts flutterTts = FlutterTts();
  @override
  Widget build(BuildContext context) {

    Future speak1(text) async {
      await flutterTts.speak(text);
    }
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.translate),
          title: Text('المترجم',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),),),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFormField(
                          textAlign: from == 'ar' ? TextAlign.right : TextAlign.left,
                          decoration: InputDecoration(
                            hintText: from == 'ar' ? 'إدخال النص ' : 'enter text',
                            border: InputBorder.none,
                            prefix: TextController.text != '' ?
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: IconButton(icon: Icon(
                                  Icons.volume_up_sharp, size: 30,
                                  color: color), onPressed: () {
                                setState(() {
                                  speak1('${TextController.text}');
                                });
                              },),
                            ) :
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Icon(Icons.text_fields, color: color),
                            ),

                          ),
                              onEditingComplete:(){
                            setState(() {
                              validateAndTranslet();
                              SystemChannels.textInput.invokeMethod('TextInput.hide');
                            });


                              },
                          keyboardType: TextInputType.text,
                          maxLines: null,
                          style: TextStyle(fontSize: 18),
                          controller: TextController,
                        ),
                      ),
                      IconButton(icon: Icon(
                          Icons.highlight_remove, size: 30, color: color),
                        onPressed: () {
                          setState(() {
                            TextController.text = '';
                          });
                        },)

                    ],

                  ),
                ),
                SizedBox(height: 10,),
                Container(width: MediaQuery
                    .of(context)
                    .size
                    .width,
                    height: 2,
                    color: color
                ),
                SizedBox(height: 10,),
                Container(
                  color: color,
                  width: 200,
                  alignment: Alignment.center,
                  child: DropdownButton<String>(
                    value: value,
                    items: <String>['English To Arabic','Arabic To English']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value == 'Arabic To English') {
                        to = 'en';
                        from = 'ar';
                      }
                      else {
                        from = 'en';
                        to = 'ar';
                      }
                      setState(() {
                        this.value =value!;
                      });
                    },
                  ),
                ),
                SizedBox(height: 10,),
                InkWell(
                  onTap: validateAndTranslet,

                  child: Container(
                    color: color,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         Icon(Icons.translate),
                          Text('ترجم', style: TextStyle(fontSize: 20,)
                          )
                        ]
                    ),
                  ),
                ),

                SizedBox(height: 10,),
                Container(width: MediaQuery
                    .of(context)
                    .size
                    .width,
                    height: 2,
                    color: color
                ),
                SizedBox(height: 10,),
                if(texttransleted.text != '') Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(icon: Icon(
                          Icons.volume_up_sharp, size: 30, color: color),
                        onPressed: () {
                          setState(() {
                            speak1('${texttransleted.text}');
                          });
                        },),
                      Expanded(
                        child: TextFormField(
                          textAlign: to == 'ar' ? TextAlign.right : TextAlign
                              .left,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          enabled: true,
                          maxLines: null,
                          style: TextStyle(fontSize: 18),
                          controller: texttransleted,
                        readOnly: true,


                        ),
                      ),
                      IconButton(icon: Icon(
                          Icons.highlight_remove, size: 30, color: color),
                        onPressed: () {
                          setState(() {
                            texttransleted.text = '';
                          });
                        },)
                    ],
                  ),
                ),
              ]
          ),
        )
    );
  }

   void validateAndTranslet() {
      setState(() {
        var translator=GoogleTranslator();
        translator.translate(TextController.text,from: '$from',to: '$to').then((value){
          setState(() {
            texttransleted.text=value.toString();
          });
        });});

    }
}
