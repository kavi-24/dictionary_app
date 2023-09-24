// ignore_for_file: unnecessary_string_escapes

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dictionary_app/common/api_key.dart';

/*
{
  "word": word,
  "type": noun|verb|adj/...,
  "pronounciation": Optional(pronounciation)
  "meanings": List<String>,
  "examples": List<String>
}
*/

class GetMeaning {
  Future<Map> getMeaningDictAPIColl(String query) async {
    String url =
        "https://www.dictionaryapi.com/api/v3/references/collegiate/json/$query?key=$dictionaryAPICollegiateKey";
    http.Response response = await http.get(Uri.parse(url));
    String resp = response.body;
    // String resp =
    //     '[{"meta":{"id":"voluminous","uuid":"0d01b967-971f-4ec5-8fe0-10513d29c39b","sort":"220130400","src":"collegiate","section":"alpha","stems":["voluminous","voluminously","voluminousness","voluminousnesses"],"offensive":false},"hwi":{"hw":"vo*lu*mi*nous","prs":[{"mw":"v\u0259-\u02c8l\u00fc-m\u0259-n\u0259s","sound":{"audio":"volumi02","ref":"c","stat":"1"}}]},"fl":"adjective","def":[{"sseq":[[["sense",{"sn":"1 a","dt":[["text","{bc}having or marked by great {a_link|volume} or bulk {bc}{sx|large||} "],["vis",[{"t":"long {wi}voluminous{\/wi} tresses"}]]],"sdsense":{"sd":"also","dt":[["text","{bc}{sx|full||} "],["vis",[{"t":"a {wi}voluminous{\/wi} skirt"}]]]}}],["sense",{"sn":"b","dt":[["text","{bc}{sx|numerous||} "],["vis",[{"t":"trying to keep track of {wi}voluminous{\/wi} slips of paper"}]]]}]],[["sense",{"sn":"2 a","dt":[["text","{bc}filling or capable of filling a large volume or several {a_link|volumes} "],["vis",[{"t":"a {wi}voluminous{\/wi} literature on the subject"}]]]}],["sense",{"sn":"b","dt":[["text","{bc}writing or speaking much or at great length "],["vis",[{"t":"a {wi}voluminous{\/wi} correspondent"}]]]}]],[["sense",{"sn":"3","dt":[["text","{bc}consisting of many folds, coils, or convolutions {bc}{sx|winding|winding:2|}"]]}]]]}],"uros":[{"ure":"vo*lu*mi*nous*ly","fl":"adverb"},{"ure":"vo*lu*mi*nous*ness","fl":"noun"}],"et":[["text","Late Latin {it}voluminosus{\/it}, from Latin {it}volumin-, volumen{\/it}"]],"date":"1611{ds||3||}","shortdef":["having or marked by great volume or bulk : large; also : full","numerous","filling or capable of filling a large volume or several volumes"]}]';
    // "["tambala","tambalas","Batdambang","Battambang","matzo ball","Bambara","Calamba","Catamarca","Chambal","ataman","atamans","cabal…"
    Map map = List.from(jsonDecode(resp))[0];
    // print(map);

    String word = map["meta"]["id"];
    String type = map["fl"];
    // check if map["hwi"]["prs"] is present
    String pronounciation = map["hwi"]["prs"] != null
        ? map["hwi"]["prs"][0]["mw"]
        : map["hwi"]["hw"];
    List<String> meanings = [];
    List<String> examples = [];

    List sseq = map["def"][0]["sseq"];

    meanings.add(map["shortdef"][0].toString());
    for (var i in sseq) {
      try {
        meanings.add(
          i[0][1]["dt"][0][1]
              .replaceAll(RegExp(r'\{.*?\}'), '')
              .replaceAll(RegExp(r'\s+'), ' ')
              .toString(),
        );
      } catch (e) {
        continue;
      }
    }

    if (meanings.isEmpty) {
      meanings.add("No meanings found");
    }

    for (var i in sseq) {
      try {
        examples.add(
          i[0][1]["dt"][1][1][0]["t"]
              .replaceAll(RegExp(r'\{.*?\}'), '')
              .replaceAll(RegExp(r'\s+'), ' ')
              .toString(),
        );
      } catch (e) {
        continue;
      }
    }

    if (examples.isEmpty) {
      examples.add("No examples found");
    }

    Map<String, dynamic> meaningDict = {
      "word": word,
      "type": type,
      "pronounciation": pronounciation,
      "meanings": meanings,
      "examples": examples
    };

    return meaningDict;

    /*
    [{"meta":{"id":"voluminous","uuid":"0d01b967-971f-4ec5-8fe0-10513d29c39b","sort":"220130400","src":"collegiate","section":"alpha","stems":["voluminous","voluminously","voluminousness","voluminousnesses"],"offensive":false},"hwi":{"hw":"vo*lu*mi*nous","prs":[{"mw":"v\u0259-\u02c8l\u00fc-m\u0259-n\u0259s","sound":{"audio":"volumi02","ref":"c","stat":"1"}}]},"fl":"adjective","def":[{"sseq":[[["sense",{"sn":"1 a","dt":[["text","{bc}having or marked by great {a_link|volume} or bulk {bc}{sx|large||} "],["vis",[{"t":"long {wi}voluminous{\/wi} tresses"}]]],"sdsense":{"sd":"also","dt":[["text","{bc}{sx|full||} "],["vis",[{"t":"a {wi}voluminous{\/wi} skirt"}]]]}}],["sense",{"sn":"b","dt":[["text","{bc}{sx|numerous||} "],["vis",[{"t":"trying to keep track of {wi}voluminous{\/wi} slips of paper"}]]]}]],[["sense",{"sn":"2 a","dt":[["text","{bc}filling or capable of filling a large volume or several {a_link|volumes} "],["vis",[{"t":"a {wi}voluminous{\/wi} literature on the subject"}]]]}],["sense",{"sn":"b","dt":[["text","{bc}writing or speaking much or at great length "],["vis",[{"t":"a {wi}voluminous{\/wi} correspondent"}]]]}]],[["sense",{"sn":"3","dt":[["text","{bc}consisting of many folds, coils, or convolutions {bc}{sx|winding|winding:2|}"]]}]]]}],"uros":[{"ure":"vo*lu*mi*nous*ly","fl":"adverb"},{"ure":"vo*lu*mi*nous*ness","fl":"noun"}],"et":[["text","Late Latin {it}voluminosus{\/it}, from Latin {it}volumin-, volumen{\/it}"]],"date":"1611{ds||3||}","shortdef":["having or marked by great volume or bulk : large; also : full","numerous","filling or capable of filling a large volume or several volumes"]}]
    */
  }

  Future<Map> getMeaningDictAPIInter(String query) async {
    String url =
        "https://www.dictionaryapi.com/api/v3/references/sd3/json/$query?key=$intermediateDictAPIKey";
    http.Response response = await http.get(Uri.parse(url));
    String resp = response.body;
    // String resp =
    //     '[{"meta":{"id":"endorse","uuid":"41627e49-2cd7-4428-8a6a-bda027326fbc","src":"int_dict","section":"alpha","stems":["endorse","endorsable","endorsed","endorsee","endorsees","endorser","endorsers","endorses","endorsing","indorse","indorsed","indorses","indorsing"],"offensive":false},"hwi":{"hw":"en*dorse"},"vrs":[{"vl":"also","va":"in*dorse","prs":[{"mw":"in-\u02c8d\u022f(\u0259)rs"}]}],"fl":"verb","ins":[{"if":"en*dorsed"},{"if":"en*dors*ing"}],"def":[{"sseq":[[["sense",{"sn":"1","dt":[["text","{bc}to sign the back of (a check, bank note, or bill) especially to receive payment, to indicate method of payment, or to transfer to someone else"]]}]],[["sense",{"sn":"2","dt":[["text","{bc}to show support or approval of "],["vis",[{"t":"{it}endorse{\/it} a candidate"}]]]}]]]}],"uros":[{"ure":"en*dors*ee","prs":[{"mw":"in-\u02ccd\u022f(\u0259)r-\u02c8s\u0113","sound":{"audio":"endors03"}}],"fl":"noun"},{"ure":"en*dors*er","fl":"noun"}],"shortdef":["to sign the back of (a check, bank note, or bill) especially to receive payment, to indicate method of payment, or to transfer to someone else","to show support or approval of"]},{"meta":{"id":"indorse","uuid":"011d76df-053a-4653-8dec-2b29bfdca719","src":"int_dict","section":"alpha","stems":["indorse","indorsement","endorse","endorsement","indorsed","indorsements","indorses","indorsing"],"offensive":false},"hwi":{"hw":"indorse"},"ahws":[{"hw":"indorsement"}],"cxs":[{"cxl":"variant of","cxtis":[{"cxt":"endorse"},{"cxt":"endorsement"}]}],"shortdef":[]}]';
    // "["catamaran","mambas","material","materials","maternal","catamarans","materially","maternally"]"
    Map map = List.from(jsonDecode(resp))[0];
    // print(map);

    String word = map["meta"]["id"];
    String type = map["fl"];
    // check if map["hwi"]["prs"] is present
    String pronounciation = map["hwi"]["prs"] != null
        ? map["hwi"]["prs"][0]["mw"]
        : map["hwi"]["hw"];
    List<String> meanings = [];
    List<String> examples = [];

    List sseq = map["def"][0]["sseq"];

    meanings.add(map["shortdef"][0].toString());
    for (var i in sseq) {
      try {
        meanings.add(
          i[0][1]["dt"][0][1]
              .replaceAll(RegExp(r'\{.*?\}'), '')
              .replaceAll(RegExp(r'\s+'), ' ')
              .toString(),
        );
      } catch (e) {
        continue;
      }
    }

    for (var i in sseq) {
      try {
        examples.add(
          i[0][1]["dt"][1][1][0]["t"]
              .replaceAll(RegExp(r'\{.*?\}'), '')
              .replaceAll(RegExp(r'\s+'), ' ')
              .toString(),
        );
      } catch (e) {
        continue;
      }
    }

    Map<String, dynamic> meaningDict = {
      "word": word,
      "type": type,
      "pronounciation": pronounciation,
      "meanings": meanings,
      "examples": examples
    };

    return meaningDict;

    /*
    [{"meta":{"id":"voluminous","uuid":"0d01b967-971f-4ec5-8fe0-10513d29c39b","sort":"220130400","src":"collegiate","section":"alpha","stems":["voluminous","voluminously","voluminousness","voluminousnesses"],"offensive":false},"hwi":{"hw":"vo*lu*mi*nous","prs":[{"mw":"v\u0259-\u02c8l\u00fc-m\u0259-n\u0259s","sound":{"audio":"volumi02","ref":"c","stat":"1"}}]},"fl":"adjective","def":[{"sseq":[[["sense",{"sn":"1 a","dt":[["text","{bc}having or marked by great {a_link|volume} or bulk {bc}{sx|large||} "],["vis",[{"t":"long {wi}voluminous{\/wi} tresses"}]]],"sdsense":{"sd":"also","dt":[["text","{bc}{sx|full||} "],["vis",[{"t":"a {wi}voluminous{\/wi} skirt"}]]]}}],["sense",{"sn":"b","dt":[["text","{bc}{sx|numerous||} "],["vis",[{"t":"trying to keep track of {wi}voluminous{\/wi} slips of paper"}]]]}]],[["sense",{"sn":"2 a","dt":[["text","{bc}filling or capable of filling a large volume or several {a_link|volumes} "],["vis",[{"t":"a {wi}voluminous{\/wi} literature on the subject"}]]]}],["sense",{"sn":"b","dt":[["text","{bc}writing or speaking much or at great length "],["vis",[{"t":"a {wi}voluminous{\/wi} correspondent"}]]]}]],[["sense",{"sn":"3","dt":[["text","{bc}consisting of many folds, coils, or convolutions {bc}{sx|winding|winding:2|}"]]}]]]}],"uros":[{"ure":"vo*lu*mi*nous*ly","fl":"adverb"},{"ure":"vo*lu*mi*nous*ness","fl":"noun"}],"et":[["text","Late Latin {it}voluminosus{\/it}, from Latin {it}volumin-, volumen{\/it}"]],"date":"1611{ds||3||}","shortdef":["having or marked by great volume or bulk : large; also : full","numerous","filling or capable of filling a large volume or several volumes"]}]
    */

    /*
    [{"meta":{"id":"hello","uuid":"6c7c8af7-eb8e-4864-9cb7-ef35093ff994","src":"int_dict","section":"alpha","stems":["hello","hellos"],"offensive":false},"hwi":{"hw":"hel*lo","prs":[{"mw":"h\u0259-\u02c8l\u014d","sound":{"audio":"hello001"}},{"mw":"he-"}]},"fl":"noun","ins":[{"il":"plural","if":"hellos"}],"def":[{"sseq":[[["sense",{"dt":[["text","{bc}an expression or gesture of greeting "],["uns",[[["text","used in greeting, in answering the telephone, or to express surprise"]]]]]}]]]}],"shortdef":["an expression or gesture of greeting \u2014used in greeting, in answering the telephone, or to express surprise"]}]
    */
    /*
    [{"meta":{"id":"endorse","uuid":"41627e49-2cd7-4428-8a6a-bda027326fbc","src":"int_dict","section":"alpha","stems":["endorse","endorsable","endorsed","endorsee","endorsees","endorser","endorsers","endorses","endorsing","indorse","indorsed","indorses","indorsing"],"offensive":false},"hwi":{"hw":"en*dorse"},"vrs":[{"vl":"also","va":"in*dorse","prs":[{"mw":"in-\u02c8d\u022f(\u0259)rs"}]}],"fl":"verb","ins":[{"if":"en*dorsed"},{"if":"en*dors*ing"}],"def":[{"sseq":[[["sense",{"sn":"1","dt":[["text","{bc}to sign the back of (a check, bank note, or bill) especially to receive payment, to indicate method of payment, or to transfer to someone else"]]}]],[["sense",{"sn":"2","dt":[["text","{bc}to show support or approval of "],["vis",[{"t":"{it}endorse{\/it} a candidate"}]]]}]]]}],"uros":[{"ure":"en*dors*ee","prs":[{"mw":"in-\u02ccd\u022f(\u0259)r-\u02c8s\u0113","sound":{"audio":"endors03"}}],"fl":"noun"},{"ure":"en*dors*er","fl":"noun"}],"shortdef":["to sign the back of (a check, bank note, or bill) especially to receive payment, to indicate method of payment, or to transfer to someone else","to show support or approval of"]},{"meta":{"id":"indorse","uuid":"011d76df-053a-4653-8dec-2b29bfdca719","src":"int_dict","section":"alpha","stems":["indorse","indorsement","endorse","endorsement","indorsed","indorsements","indorses","indorsing"],"offensive":false},"hwi":{"hw":"indorse"},"ahws":[{"hw":"indorsement"}],"cxs":[{"cxl":"variant of","cxtis":[{"cxt":"endorse"},{"cxt":"endorsement"}]}],"shortdef":[]}]
    */
    /*
    keys: (meta, hwi, vrs, fl, ins, def, uros, shortdef)
    */
    /*
    values:
    {id: endorse, uuid: 41627e49-2cd7-4428-8a6a-bda027326fbc, src: int_dict, section: alpha, stems: [endorse, endorsable, endorsed, endorsee, endorsees, endorser, endorsers, endorses, endorsing, indorse, indorsed, indorses, indorsing], offensive: false}
    {hw: en*dorse}
    [{vl: also, va: in*dorse, prs: [{mw: in-ˈdȯ(ə)rs}]}]
    verb
    [{if: en*dorsed}, {if: en*dors*ing}]
    [{sseq: [[[sense, {sn: 1, dt: [[text, {bc}to sign the back of (a check, bank note, or bill) especially to receive payment, to indicate method of payment, or to transfer to someone else]]}]], [[sense, {sn: 2, dt: [[text, {bc}to show support or approval of ], [vis, [{t: {it}endorse{/it} a candidate}]]]}]]]}]
    [{ure: en*dors*ee, prs: [{mw: in-ˌdȯ(ə)r-ˈsē, sound: {audio: endors03}}], fl: noun}, {ure: en*dors*er, fl: noun}]
    [to sign the back of (a check, bank note, or bill) especially to receive payment, to indicate method of payment, or to transfer to someone else, to show support or approval of]
    */
  }

  Future<Map> getMeaningAPIDict(String query) async {
    String url = "https://api.dictionaryapi.dev/api/v2/entries/en/$query";
    http.Response response = await http.get(Uri.parse(url));
    String resp = response.body.substring(1, response.body.length - 1);
    // String resp =
    //     '{word: voluminous, phonetic: /vəˈl(j)uː.mɪ.nəs/, phonetics: [{text: /vəˈl(j)uː.mɪ.nəs/, audio: }, {text: /vəˈlu.mə.nəs/, audio: }], meanings: [{partOfSpeech: adjective, definitions: [{definition: Of or pertaining to volume or volumes., synonyms: [], antonyms: []}, {definition: Consisting of many folds, coils, or convolutions., synonyms: [], antonyms: []}, {definition: Of great volume, or bulk; large., synonyms: [], antonyms: []}, {definition: Having written much, or produced many volumes, synonyms: [copious, diffuse], antonyms: [], example: a voluminous writer}], synonyms: [copious, diffuse], antonyms: []}], license: {name: CC BY-SA 3.0, url: https://creativecommons.org/licenses/by-sa/3.0}, sourceUrls: [https://en.wiktionary.org/wiki/voluminous]}';
    // ""title":"No Definitions Found","message":"Sorry pal, we couldn't find definitions for the word you were looking for.","resolutio…"
    Map map = jsonDecode(resp);
    // print(map);

    String word = map["word"];
    String type = map["meanings"][0]["partOfSpeech"];
    String pronounciation = map["phonetic"];
    List<String> meanings = [];
    List<String> examples = [];

    for (var i = 0; i < map["meanings"].length; i++) {
      for (var j = 0; j < map["meanings"][i]["definitions"].length; j++) {
        meanings.add(map["meanings"][i]["definitions"][j]["definition"]);
        if (map["meanings"][i]["definitions"][j]["example"] != null) {
          examples.add(map["meanings"][i]["definitions"][j]["example"]);
        }
      }
    }

    Map<String, dynamic> meaningDict = {
      "word": word,
      "type": type,
      "pronounciation": pronounciation,
      "meanings": meanings,
      "examples": examples
    };

    return meaningDict;

    /*
    {word: voluminous, phonetic: /vəˈl(j)uː.mɪ.nəs/, phonetics: [{text: /vəˈl(j)uː.mɪ.nəs/, audio: }, {text: /vəˈlu.mə.nəs/, audio: }], meanings: [{partOfSpeech: adjective, definitions: [{definition: Of or pertaining to volume or volumes., synonyms: [], antonyms: []}, {definition: Consisting of many folds, coils, or convolutions., synonyms: [], antonyms: []}, {definition: Of great volume, or bulk; large., synonyms: [], antonyms: []}, {definition: Having written much, or produced many volumes, synonyms: [copious, diffuse], antonyms: [], example: a voluminous writer}], synonyms: [copious, diffuse], antonyms: []}], license: {name: CC BY-SA 3.0, url: https://creativecommons.org/licenses/by-sa/3.0}, sourceUrls: [https://en.wiktionary.org/wiki/voluminous]}
    */
    /*
    [{word: endorse, phonetic: /ɪnˈdɔːs/, phonetics: [{text: /ɪnˈdɔːs/, audio: }, {text: /ɪnˈdɔːs/, audio: https://api.dictionaryapi.dev/media/pronunciations/en/endorse-uk.mp3, sourceUrl: https://commons.wikimedia.org/w/index.php?curid=90826775, license: {name: BY-SA 4.0, url: https://creativecommons.org/licenses/by-sa/4.0}}, {text: /ɛnˈdɔɹs/, audio: }], meanings: [{partOfSpeech: noun, definitions: [{definition: A diminutive of the pale, usually appearing in pairs on either side of a pale., synonyms: [], antonyms: []}], synonyms: [], antonyms: []}, {partOfSpeech: verb, definitions: [{definition: To support, to back, to give one's approval to, especially officially or by signature., synonyms: [], antonyms: []}, {definition: To write one's signature on the back of a cheque, or other negotiable instrument, when transferring it to a third party, or cashing it., synonyms: [], antonyms: []}, {definition: To give an endorsement., synonyms: [], antonyms: []}], synonyms: [], antonyms: []}], license: {name: CC BY-SA 3.0, url: https://creativecommons.org/licenses/by-sa/3.0}, sourceUrls: [https://en.wiktionary.org/wiki/endorse]}]
    */
  }
}


// void main(List<String> args) async {
//   GetMeaning getMeaning = GetMeaning();
//   await getMeaning.getMeaningDictAPIColl("voluminous");
//   print("\n");
//   await getMeaning.getMeaningDictAPIInter("voluminous");
//   print("\n");
//   await getMeaning.getMeaningAPIDict("voluminous");
// }

  /*
  [{"meta":{"id":"cosmopolis","uuid":"73c5144f-6aa2-4016-b594-445d4bb3eec1","sort":"035636400","src":"collegiate","section":"alpha","stems":["cosmopolis","cosmopolises"],"offensive":false},"hwi":{"hw":"cos*mop*o*lis","prs":[{"mw":"k\u00e4z-\u02c8m\u00e4-p\u0259-l\u0259s","sound":{"audio":"cosmop01","ref":"c","stat":"1"}}]},"fl":"noun","def":[{"sseq":[[["sense",{"dt":[["text","{bc}a {a_link|cosmopolitan} city"]]}]]]}],"et":[["text","New Latin, back-formation from {it}cosmopolites{\/it}"]],"date":"1849","shortdef":["a cosmopolitan city"]}]

  [{"meta":{"id":"hello","uuid":"0cdef8d5-c9d1-431b-b397-2077a127c328","sort":"080126800","src":"collegiate","section":"alpha","stems":["hello","hellos"],"offensive":false},"hwi":{"hw":"hel*lo","prs":[{"mw":"h\u0259-\u02C8l\u014D","sound":{"audio":"hello001","ref":"c","stat":"1"}},{"mw":"he-"}]},"fl":"noun","ins":[{"il":"plural","if":"hel*los"}],"def":[{"sseq":[[["sense",{"dt":[["text","{bc}an expression or gesture of greeting "],["uns",[[["text","used interjectionally in greeting, in answering the telephone, or to express surprise "],["vis",[{"t":"{wi}hello{/wi} there"},{"t":"waved {wi}hello{/wi}"}]]]]]]}]]]}],"et":[["text","alteration of {it}hollo{/it}"]],"date":"1834","shortdef":["an expression or gesture of greeting \u2014used interjectionally in greeting, in answering the telephone, or to express surprise"]},{"meta":{"id":"hullo","uuid":"a8b26bf8-dba0-44d5-b1de-4a9a69e5ef10","sort":"080299200","src":"collegiate","section":"alpha","stems":["hello","hullo","hullos"],"offensive":false},"hwi":{"hw":"hul*lo","prs":[{"mw":"(\u02CC)h\u0259-\u02C8l\u014D","sound":{"audio":"hullo001","ref":"c","stat":"1"}}]},"cxs":[{"cxl":"chiefly British spelling of","cxtis":[{"cxt":"hello"}]}],"shortdef":[]}]
  */


/*
{meta: {id: voluminous, uuid: 0d01b967-971f-4ec5-8fe0-10513d29c39b, sort: 220130400, src: collegiate, section: alpha, stems: [voluminous, voluminously, voluminousness, voluminousnesses], offensive: false}, hwi: {hw: vo*lu*mi*nous, prs: [{mw: və-ˈlü-mə-nəs, sound: {audio: volumi02, ref: c, stat: 1}}]}, fl: adjective, def: [{sseq: [[[sense, {sn: 1 a, dt: [[text, {bc}having or marked by great {a_link|volume} or bulk {bc}{sx|large||} ], [vis, [{t: long {wi}voluminous{/wi} tresses}]]], sdsense: {sd: also, dt: 
[[text, {bc}{sx|full||} ], [vis, [{t: a {wi}voluminous{/wi} skirt}]]]}}], [sense, {sn: b, dt: [[text, {bc}{sx|numerous||} ], [vis, [{t: trying to keep track of {wi}voluminous{/wi} slips of paper}]]]}]], [[sense, {sn: 2 a, dt: [[text, {bc}filling or capable of filling a large volume or several {a_link|volumes} ], [vis, [{t: a {wi}voluminous{/wi} literature on the subject}]]]}], [sense, {sn: b, dt: [[text, {bc}writing or speaking much or at great length ], [vis, [{t: a {wi}voluminous{/wi} correspondent}]]]}]], [[sense, {sn: 3, dt: [[text, {bc}consisting of many folds, coils, or convolutions {bc}{sx|winding|winding:2|}]]}]]]}], uros: [{ure: vo*lu*mi*nous*ly, fl: adverb}, {ure: vo*lu*mi*nous*ness, fl: noun}], et: [[text, Late Latin {it}voluminosus{/it}, from Latin {it}volumin-, volumen{/it}]], date: 1611{ds||3||}, shortdef: [having or marked 
by great volume or bulk : large; also : full, numerous, filling or capable of filling a large volume or several volumes]}


{meta: {id: voluminous, uuid: bc8d0c9f-616f-40f6-95ba-0b31d047266c, src: int_dict, section: alpha, stems: [voluminous, voluminously, voluminousness, voluminousnesses], offensive: false}, hwi: {hw: vo*lu*mi*nous, prs: [{mw: və-ˈlü-mə-nəs, sound: {audio: volumi02}}]}, fl: adjective, def: [{sseq: [[[sense, {sn: 1 a, dt: [[text, {bc}having or marked by great volume or bulk {bc}{sx|large||} ], [vis, [{t: a {it}voluminous{/it} discharge of lava}]]]}], [sense, {sn: b, dt: [[text, {bc}{sx|full||3b} ], [vis, [{t: 
{it}voluminous{/it} curtains}]]]}]], [[sense, {sn: 2, dt: [[text, {bc}filling or capable of filling a large volume or several volumes ], [vis, [{t: {it}voluminous{/it} research}]]]}]]]}], uros: [{ure: vo*lu*mi*nous*ly, fl: adverb}, {ure: vo*lu*mi*nous*ness, fl: noun}], shortdef: [having or marked by great volume or bulk : large, full, filling or capable of filling a large volume or several volumes]}


{word: voluminous, phonetic: /vəˈl(j)uː.mɪ.nəs/, phonetics: [{text: /vəˈl(j)uː.mɪ.nəs/, audio: }, {text: /vəˈlu.mə.nəs/, audio: }], meanings: [{partOfSpeech: adjective, definitions: [{definition: Of or pertaining to volume or volumes., synonyms: [], antonyms: []}, {definition: Consisting of many folds, coils, or convolutions., synonyms: [], antonyms: []}, {definition: Of great volume, or bulk; large., synonyms: [], antonyms: []}, {definition: Having written much, or produced many volumes, synonyms: [copious, diffuse], antonyms: [], example: a voluminous writer}], synonyms: [copious, diffuse], antonyms: []}], license: {name: CC BY-SA 3.0, url: https://creativecommons.org/licenses/by-sa/3.0}, sourceUrls: [https://en.wiktionary.org/wiki/voluminous]}
*/

/*
[
    {
      "word": "hello",
      "phonetic": "həˈləʊ",
      "phonetics": [
        {
          "text": "həˈləʊ",
          "audio": "//ssl.gstatic.com/dictionary/static/sounds/20200429/hello--_gb_1.mp3"
        },
        {
          "text": "hɛˈləʊ"
        }
      ],
      "origin": "early 19th century: variant of earlier hollo ; related to holla.",
      "meanings": [
        {
          "partOfSpeech": "exclamation",
          "definitions": [
            {
              "definition": "used as a greeting or to begin a phone conversation.",
              "example": "hello there, Katie!",
              "synonyms": [],
              "antonyms": []
            }
          ]
        },
        {
          "partOfSpeech": "noun",
          "definitions": [
            {
              "definition": "an utterance of ‘hello’; a greeting.",
              "example": "she was getting polite nods and hellos from people",
              "synonyms": [],
              "antonyms": []
            }
          ]
        },
        {
          "partOfSpeech": "verb",
          "definitions": [
            {
              "definition": "say or shout ‘hello’.",
              "example": "I pressed the phone button and helloed",
              "synonyms": [],
              "antonyms": []
            }
          ]
        }
      ]
    }
  ]
*/

/*
"meta":{  
 "id":"voluminous",
 "uuid":"0d01b967-971f-4ec5-8fe0-10513d29c39b",
 "sort":"220130400",
 "src":"collegiate",
 "section":"alpha",
 "stems":[  
    "voluminous",
    "voluminously",
    "voluminousness",
    "voluminousnesses"
 ],
 "offensive":false
},
"hwi":{  
 "hw":"vo*lu*mi*nous",
 "prs":[  
    {  
       "mw":"v\u0259-\u02c8l\u00fc-m\u0259-n\u0259s",
       "sound":{  
          "audio":"volumi02",
          "ref":"c",
          "stat":"1"
       }
    }
 ]
},
"fl":"adjective",
"def":[
  {
    "sseq":[  
       [  
          [  
             "sense",
             {  
                "sn":"1 a",
                "dt":[  
                   [  
                      "text",
                      "{bc}having or marked by great {a_link|volume} or bulk {bc}{sx|large||} "
                   ],
                   [  
                      "vis",
                      [  
                         {  
                            "t":"long {wi}voluminous{\/wi} tresses"
                         }
                      ]
                   ]
                ],
                "sdsense":{  
                   "sd":"also",
                   "dt":[  
                      [  
                         "text",
                         "{bc}{sx|full||} "
                      ],
                      [  
                         "vis",
                         [  
                            {  
                               "t":"a {wi}voluminous{\/wi} skirt"
                            }
                         ]
                      ]
                   ]
                }
             }
          ],
          [  
             "sense",
             {  
                "sn":"b",
                "dt":[  
                   [  
                      "text",
                      "{bc}{sx|numerous||} "
                   ],
                   [  
                      "vis",
                      [  
                         {  
                            "t":"trying to keep track of {wi}voluminous{\/wi} slips of paper"
                         }
                      ]
                   ]
                ]
             }
          ]
       ],
       [  
          [  
             "sense",
             {  
                "sn":"2 a",
                "dt":[  
                   [  
                      "text",
                      "{bc}filling or capable of filling a large volume or several {a_link|volumes} "
                   ],
                   [  
                      "vis",
                      [  
                         {  
                            "t":"a {wi}voluminous{\/wi} literature on the subject"
                         }
                      ]
                   ]
                ]
             }
          ],
          [  
             "sense",
             {  
                "sn":"b",
                "dt":[  
                   [  
                      "text",
                      "{bc}writing or speaking much or at great length "
                   ],
                   [  
                      "vis",
                      [  
                         {  
                            "t":"a {wi}voluminous{\/wi} correspondent"
                         }
                      ]
                   ]
                ]
             }
          ]
       ],
       [  
          [  
             "sense",
             {  
                "sn":"3",
                "dt":[  
                   [  
                      "text",
                      "{bc}consisting of many folds, coils, or convolutions {bc}{sx|winding||}"
                   ]
                ]
             }
          ]
       ]
    ]
 }
],
"uros":[  
 {  
    "ure":"vo*lu*mi*nous*ly",
    "fl":"adverb"
 },
 {  
    "ure":"vo*lu*mi*nous*ness",
    "fl":"noun"
 }
],
"et":[  
 [  
    "text",
    "Late Latin {it}voluminosus{\/it}, from Latin {it}volumin-, volumen{\/it}"
 ]
],
"date":"1611{ds||3||}",
"ld_link":{  
 "link_hw":"voluminous",
 "link_fl":"adjective"
},
"suppl":{  
 "examples":[  
    {  
       "t":"the building\u0027s high ceilings and {it}voluminous{\/it} spaces"
    },
    {  
       "t":"a writer of {it}voluminous{\/it} output"
    }
 ],
 "ldq":{  
    "ldhw":"voluminous",
    "fl":"adjective",
    "def":[  
       {  
          "sls":[  
             "formal"
          ],
          "sseq":[  
             [  
                [  
                   "sense",
                   {  
                      "dt":[  
                         [  
                            "text",
                            "{bc}very large {bc}containing a lot of space"
                         ]
                      ]
                   }
                ]
             ],
             [  
                [  
                   "sense",
                   {  
                      "sls":[  
                         "of clothing"
                      ],
                      "dt":[  
                         [  
                            "text",
                            "{bc}using large amounts of fabric {bc}very full"
                         ]
                      ]
                   }
                ]
             ],
             [  
                [  
                   "sense",
                   {  
                      "dt":[  
                         [  
                            "text",
                            "{bc}having very many words or pages"
                         ]
                      ]
                   }
                ]
             ]
          ]
       }
    ]
 }
},
"shortdef":[  
 "having or marked by great volume or bulk : large; also : full",
 "numerous",
 "filling or capable of filling a large volume or several volumes"
]
*/