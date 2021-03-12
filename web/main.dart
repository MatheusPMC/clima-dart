import 'dart:html';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  var cities = [];
  cities.add('Nova Friburgo');
  cities.add('Rio de Janeiro');
  cities.add('Itaperuma');
  cities.add('São Paulo');
  cities.add('Campinas');
  cities.add('Londres');

  loadData(cities);
}

Future getWeather(String city) {
  var url =
      'https://api.hgbrasil.com/weather/?format=json-cors&locale=pt&key=3b7c61b0&city_name=$city';
  return http.get(Uri.parse(url));
}

void loadData(List cities) {
  var empty = querySelector('#empty');

  if (empty != null) empty.remove();

  cities.forEach((city) {
    insertData(getWeather(city));
  });
}

void insertData(Future data) async {
  var insertData = await data;
  var body = json.decode(insertData.body);
  if (body['results']['forecast'].length > 0) {
    var html = '<div class="row">';
    html += formatedHTML(body['results']['city_name']);
    html += formatedHTML(body['results']['temp']);
    html += formatedHTML(body['results']['description']);
    html += formatedHTML(body['results']['wind_speedy']);
    html += formatedHTML(body['results']['sunrise']);
    html += formatedHTML(body['results']['sunset']);
    html += '</div>';

    querySelector('.table').innerHtml += html;
  }
}

String formatedHTML(var data) {
  return '<div class="cell">$data</div>';
}
