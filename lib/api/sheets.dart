import 'package:gsheets/gsheets.dart';
import '../global.dart';

/// Your google auth credentials
///
/// how to get credentials - https://medium.com/@a.marenkov/how-to-get-credentials-for-google-sheets-456b7e88c430
const _credentials = r'''
{
  "type": "service_account",
  "project_id": "gsheets1-377308",
  "private_key_id": "2276d30290b5ac31f08ff560321558e15b480339",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDLn5K5nkob+jEK\neRShLto9hrD6StFIbLmRd5RFJBilnUTwaVHlYt91+IJ5p/pMN8nx48EvySTBT12+\nm4T8EiXdOsxuEIdLSYJea0yVzgXjlMGDIwYiC6xmPI4E26+tVpAZAV2CKWi/9NGt\nUpfDPRiEkopAifL2XguRZRd77M6tMU2YRrAam3EfRMdSptha44zHF2Wkfl4RgY1O\n53KlIT9olLnpB/5C3sQ/0P1cN3P/MT1P2f63HkP8WOH/YV6laUDJSi7umObhOGTk\ncKbWbov3u2k60ElfdOyfXwG4lnLH2gV+8Yn+hytO20ONDChFdWiP61wnQfk1C852\nn1u07+DBAgMBAAECggEAAZ4pDS0X4dgF8SAPWczkmM3yQWxvWqSoGfx575pLt2+K\nWPsLo24Hk3x5eoKRdDvFo+F1qy3TpNUlTAd+5RfQODOofllgRQKQNOej8KH16jeu\ncx6UnmTUWYcyo6qkXy6x/DJ5rgT3mzE63aZepINep5llQs6cLd8g0JnQ6wzX6YiL\namjNSGB0LVhmdA799OG69IERO6Be68/6Mrlh0GsqGTUxqreMv1idfmPiqMwPzTyQ\nD4KznOsZqlLBGeFYVf1cfLK90UhipeJiX9VCSYLclqbCkwr7XgCMM/n/7S16RH52\nKOCy+I88pjIWnZMm05USOv3a/kVE1snP91ux8MsiyQKBgQDwMs8f75YRsZ9YG0uZ\nFGT9Xc55seWYrszNAQ6S9fkZWoQPv7HBao5/3AZgsYLyw4DABHKSTnoxstI0mrN2\nGc/CYWKbFeE6aiNpqM2i/pACbz+Ae8heiTQpQeZRY41ONf2UJHhPfikLQJgZaI1l\nrYPnVMgC2uz5FoeszWyREfc+3QKBgQDZBM0D3OFoLhZqUe6imckf8C5z8KDcG51k\nj+8gYmvjmRsyyNGPWFtCqplGigASRP++f/rCF8I3pAdHp55p4VgRLp0idgrxgdVI\nzmBvrQXee61nvKSyv3uDJO5J+43dcUzB6jOvlSkShPnz+zaJZf5IBY49dU4DrhnC\n/AK1jPUBNQKBgCJ2d8dSPcreHEms6OTWy0KbAfPt9U45zkKfozKsvgfIN+h2jY99\ntWJc9EFNVsd0C3YBbVrWjauxx30qsRMB0xBFnrs3oXAbKGeRg6eeNJVU1tydZftC\nXkyJGv2UdgLBtldaADUPmd32b5w9pwPuqF05idT3CkcW13KQqsIJvNq1AoGBAIrN\nvEcVNoKIv8N+5e/QBsjLuRpktK4zZ2bTfLGs4a6v1aqUsRxK+gvYy7JHP6ZvxVdV\nyc/snEc0PYfCGNtFyysqMkzBTVyMmxs3DI1BEDjtx8pK6Nh/CoOl0lc1ctZIyjxZ\nDHfoIl36+VfovEgDGTF9hC2g4qYN6+I/h4gRQP9lAoGAJH8VqhS15WY1Gyu5Kbgl\n4AuG3Zn4wg8Z5EgBSvjtYmuUnblKVPGMxXkBEsSwakC9O7ovCmNj/06r/mhglyFT\nCDPntpQd+WUWQv9OpESn8OKZPI8pcOHAM4g8NJ7NXoUjcpVvDiwlpdFD8cM7pEPj\nH8kxnC10GioOIJO/0nDNU1o=\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets1@gsheets1-377308.iam.gserviceaccount.com",
  "client_id": "106307668193892841909",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets1%40gsheets1-377308.iam.gserviceaccount.com"
}
''';

/// Your spreadsheet id
///
/// It can be found in the link to your spreadsheet -
/// link looks like so https://docs.google.com/spreadsheets/d/YOUR_SPREADSHEET_ID/edit#gid=0
/// [15v2WZD2oWSszHmJGBYcHp_38IJgJU_SxMnAchBIY31M] in the path is the id your need
const _spreadsheetId = '15v2WZD2oWSszHmJGBYcHp_38IJgJU_SxMnAchBIY31M';

//check wether entered roll no is available in Students detail or not
Future<void> readStudent() async {
  // init GSheets
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);

  print(ss.data.namedRanges.byName.values
      .map((e) => {
            'name': e.name,
            'start':
                '${String.fromCharCode((e.range?.startColumnIndex ?? 0) + 97)}${(e.range?.startRowIndex ?? 0) + 1}',
            'end':
                '${String.fromCharCode((e.range?.endColumnIndex ?? 0) + 97)}${(e.range?.endRowIndex ?? 0) + 1}'
          })
      .join('\n'));
  // get worksheet by its title
  var sheet = ss.worksheetByTitle('Students');
  sheet!.cells;
  studentList = await sheet.cells.column(1, fromRow: 2);
}

//read electives and subjects to display dynamically in home page
Future<void> readElectives() async {
  // init GSheets
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);

  print(ss.data.namedRanges.byName.values
      .map((e) => {
            'name': e.name,
            'start':
                '${String.fromCharCode((e.range?.startColumnIndex ?? 0) + 97)}${(e.range?.startRowIndex ?? 0) + 1}',
            'end':
                '${String.fromCharCode((e.range?.endColumnIndex ?? 0) + 97)}${(e.range?.endRowIndex ?? 0) + 1}'
          })
      .join('\n'));
  // get worksheet by its title
  if (finalCourse == "BSC") {
    var sheet = ss.worksheetByTitle('BSCElectives');
    sheet!.cells;
    gsheetElectivescolumn = await sheet.cells.column(1, fromRow: 2);
    gsheetElectivesrow = await sheet.cells.row(2, fromColumn: 2, length: 3);
  } else {
    var sheet = ss.worksheetByTitle("MSCElectives");
    sheet!.cells;
    gsheetElectivescolumn = await sheet.cells.column(1, fromRow: 2);
    gsheetElectivesrow = await sheet.cells.row(2, fromColumn: 2, length: 3);
  }
}

Future<dynamic> readSubject() async {
  // init GSheets
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);

  print(ss.data.namedRanges.byName.values
      .map((e) => {
            'name': e.name,
            'start':
                '${String.fromCharCode((e.range?.startColumnIndex ?? 0) + 97)}${(e.range?.startRowIndex ?? 0) + 1}',
            'end':
                '${String.fromCharCode((e.range?.endColumnIndex ?? 0) + 97)}${(e.range?.endRowIndex ?? 0) + 1}'
          })
      .join('\n'));
  // get worksheet by its title
  if (finalCourse == "BSC") {
    var sheet = ss.worksheetByTitle('BSCElectives');
    sheet!.cells;
    gsheetElectivesrow =
        await sheet.cells.row(currentrow!, fromColumn: 2, length: 3);
    stock = await sheet.cells.row(currentrow!, fromColumn: 5, length: 3);
  } else {
    var sheet = ss.worksheetByTitle("MSCElectives");
    sheet!.cells;
    gsheetElectivesrow =
        await sheet.cells.row(currentrow!, fromColumn: 2, length: 3);
    stock = await sheet.cells.row(currentrow!, fromColumn: 5, length: 3);
  }
  return stock;
}

Future<void> updateStock() async {
  // init GSheets
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);

  print(ss.data.namedRanges.byName.values
      .map((e) => {
            'name': e.name,
            'start':
                '${String.fromCharCode((e.range?.startColumnIndex ?? 0) + 97)}${(e.range?.startRowIndex ?? 0) + 1}',
            'end':
                '${String.fromCharCode((e.range?.endColumnIndex ?? 0) + 97)}${(e.range?.endRowIndex ?? 0) + 1}'
          })
      .join('\n'));
  // get worksheet by its title
  if (finalCourse == "BSC") {
    var sheet = ss.worksheetByTitle('BSCElectives');
    sheet!.cells;
    //await sheet.values.insertValue( column: , row:);
  } else {
    var sheet = ss.worksheetByTitle('MSCElectives');
    sheet!.cells;
    //await sheet.values.insertValue(currentstockinstring!, column: column, row: row)
  }
}

Future<void> updateBooked() async {
  // init GSheets
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);

  print(ss.data.namedRanges.byName.values
      .map((e) => {
            'name': e.name,
            'start':
                '${String.fromCharCode((e.range?.startColumnIndex ?? 0) + 97)}${(e.range?.startRowIndex ?? 0) + 1}',
            'end':
                '${String.fromCharCode((e.range?.endColumnIndex ?? 0) + 97)}${(e.range?.endRowIndex ?? 0) + 1}'
          })
      .join('\n'));
  // get worksheet by its title
  var sheet = ss.worksheetByTitle('Students');
  sheet!.cells;
  await sheet.values
      .insertValue(gsheetsubjectvalue!, column: 3, row: stucurrentrow!);
}

  // create worksheet if it does not exist yet
  //sheet ??= await ss.addWorksheet('example');

  /*

  // update cell at 'B2' by inserting string 'new'
  await sheet.values.insertValue('new', column: 2, row: 2);
  // prints 'new'
  print(await sheet.values.value(column: 2, row: 2));
  // get cell at 'B2' as Cell object
  final cell = await sheet.cells.cell(column: 2, row: 2);
  // prints 'new'
  print(cell.value);
  // update cell at 'B2' by inserting 'new2'
  await cell.post('new2');
  // prints 'new2'
  print(cell.value);
  // also prints 'new2'
  print(await sheet.values.value(column: 2, row: 2));

  // insert list in row #1
  final firstRow = ['index', 'letter', 'number', 'label'];
  await sheet.values.insertRow(1, firstRow);
  // prints [index, letter, number, label]
  print(await sheet.values.row(1));

  // insert list in column 'A', starting from row #2
  final firstColumn = ['0', '1', '2', '3', '4'];
  await sheet.values.insertColumn(1, firstColumn, fromRow: 2);
  // prints [0, 1, 2, 3, 4, 5]
  print(await sheet.values.column(1, fromRow: 2));

  // insert list into column named 'letter'
  final secondColumn = ['a', 'b', 'c', 'd', 'e'];
  await sheet.values.insertColumnByKey('letter', secondColumn);
  // prints [a, b, c, d, e, f]
  print(await sheet.values.columnByKey('letter'));

  // insert map values into column 'C' mapping their keys to column 'A'
  // order of map entries does not matter
  final thirdColumn = {
    '0': '1',
    '1': '2',
    '2': '3',
    '3': '4',
    '4': '5',
  };
  await sheet.values.map.insertColumn(3, thirdColumn, mapTo: 1);
  // prints {index: number, 0: 1, 1: 2, 2: 3, 3: 4, 4: 5, 5: 6}
  print(await sheet.values.map.column(3));

  // insert map values into column named 'label' mapping their keys to column
  // named 'letter'
  // order of map entries does not matter
  final fourthColumn = {
    'a': 'a1',
    'b': 'b2',
    'c': 'c3',
    'd': 'd4',
    'e': 'e5',
  };
  await sheet.values.map.insertColumnByKey(
    'label',
    fourthColumn,
    mapTo: 'letter',
  );
  // prints {a: a1, b: b2, c: c3, d: d4, e: e5, f: f6}
  print(await sheet.values.map.columnByKey('label', mapTo: 'letter'));

  // appends map values as new row at the end mapping their keys to row #1
  // order of map entries does not matter
  final secondRow = {
    'index': '5',
    'letter': 'f',
    'number': '6',
    'label': 'f6',
  };
  await sheet.values.map.appendRow(secondRow);
  // prints {index: 5, letter: f, number: 6, label: f6}
  print(await sheet.values.map.lastRow());

  // get first row as List of Cell objects
  final cellsRow = await sheet.cells.row(1);
  // update each cell's value by adding char '_' at the beginning
  cellsRow.forEach((cell) => cell.value = '_${cell.value}');
  // actually updating sheets cells
  await sheet.cells.insert(cellsRow);
  // prints [_index, _letter, _number, _label]
  print(await sheet.values.row(1));
  */
