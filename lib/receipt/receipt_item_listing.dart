import 'collection_style.dart';
import 'receipt_alignment.dart';
import 'receipt_text_size_type.dart';
import 'receipt_text_style.dart';
import 'receipt_text_style_type.dart';

class ReceiptItemListing {

  ReceiptItemListing(
      this.itemList, this.maxChar
      );

  // The outer list is the list of items
  // The inner list (inner) represents a single item
  // inner[0] = Description
  // inner[1] = UOM
  // inner[2] = Qty
  final List<List<String>> itemList;
  final int maxChar;

  String generateRows(){
    String result = "";
    String extended = '''
    <tr>
      <td></td>
      <td>Item 1</td>
      <td></td>
      <td></td>
    </tr>
    ''';

    int index = 1;
    for(List<String> item in itemList){
      int totalLength = item.join().length;
      if(totalLength <= maxChar){
         result+='''
          <tr>
            <td align= "left" width="10%">${index.toString()}</td>
            <td align= "left" width="60%">${item[0]}</td>
            <td align= "left" width="10%">${item[1]}</td>
            <td align= "left" width="20%">${item[2]}</td>
          </tr>
          ''';
      }
      else{
        int descLength = maxChar - index.toString().length - item[1].length - item[2].length;
        int iter = (item[0].length/descLength).floor();
        int start = 0;

        for (int i=0;i<iter;i++){
          if(i==0){
            result+='''
            <tr>
              <td align= "left" width="10%">${index.toString()}</td>
              <td align= "left" width="60%">${item[0].substring(start,start+descLength)}</td>
              <td align= "left" width="10%">${item[1]}</td>
              <td align= "left" width="20%">${item[2]}</td>
            </tr>
            ''';
          }
          else{
            result+='''
          <tr>
            <td align= "left" width="10%"></td>
            <td align= "left" width="60%">${item[0].substring(start,start+descLength)}</td>
            <td align= "left" width="10%"></td>
            <td align= "left" width="20%"></td>
          </tr>
          ''';
          }

          start+=descLength;
        }

        result+='''
          <tr>
            <td align= "left" width="10%"></td>
            <td align= "left" width="60%">${item[0].substring(start,item[0].length)}</td>
            <td align= "left" width="10%"></td>
            <td align= "left" width="20%"></td>
          </tr>
          ''';
      }
      index += 1;
    }

    return result;
  }

  String get html => '''
    <style>
      table {
        border-collapse: collapse;
      }
      th{
        border-bottom-style: dashed;
        padding-right: 10px;
      }
      td{
        text-align: left;
        padding-right: 10px;
      }
    </style>
     <table>
      <tr>
        <th align= "left" width="10%">No</th>
        <th align= "left" width="60%">Description</th>
        <th align= "left" width="10%">UOM</th>
        <th align= "left" width="20%">Qty</th>
      </tr>
    '''
      +generateRows()
      + '''</table>''';

}

class ReceiptItemListingV2 {
  ReceiptItemListingV2(this.itemList, this.maxChar,);

  // The outer list is the list of items
  // The inner list (inner) represents a single item
  // inner[0] = Description
  // inner[1] = Qty
  // inner[2] = UOM
  // inner[3] = Unit Price
  // inner[4] = Subtotal
  final List<List<String>> itemList;
  final int maxChar;

  // String generateRows() {
  //   String result = "";
  //
  //   for (final List<String> item in itemList) {
  //     result += '''
  //       <tr>
  //         <td width="100%" colspan="4">${item[0]}</td>
  //       </tr>
  //       ''';
  //     result += '''
  //       <tr>
  //         <td width="25%">${item[1]}</td>
  //         <td width="25%">${item[2]}</td>
  //         <td width="25%">${item[3]}</td>
  //         <td width="25%">${item[4]}</td>
  //       </tr>
  //       ''';
  //   }
  //
  //   return result;
  // }

  String generateRows() {
    String result = "";

    for (final List<String> item in itemList) {
      result += '''
        <tr>
          <td width="100%" colspan="5">${item[0]}</td>
        </tr>
        ''';
      result += '''
        <tr>
          <td width="20%">${item[1]} ${item[2]}</td>
          <td width="20%">${item[3]}</td>
          <td width="20%">${item[4]}</td>
          <td width="20%">${item[5]}</td>
          <td width="20%">${item[6]}</td>
        </tr>
        ''';
    }

    return result;
  }

  // String get html => '''
  //   <style>
  //     table {
  //       border-collapse: collapse;
  //     }
  //   </style>
  //    <table>
  //     <tr>
  //       <th width="100%" colspan="4">Description</th>
  //     </tr>
  //     <tr>
  //       <th width="50%" colspan="2" style="border-bottom-style:dashed;">Qty</th>
  //       <th width="25%" style="border-bottom-style:dashed;">Unit Price</th>
  //       <th width="25%" style="border-bottom-style:dashed;">Sub Total</th>
  //     </tr>
  //   '''
  //     + generateRows()
  //     + '''</table>''';

  String get html => '''
  <style>
    table {
      border-collapse: collapse;
    }
  </style>
   <table>
    <tr>
      <th width="20%" style="border-top-style:dashed;">DESC</th>
      <th width="20%" style="border-top-style:dashed;">PRICE</th>
      <th width="20%" style="border-top-style:dashed;">DISC</th>
      <th width="20%" style="border-top-style:dashed;">AMOUNT</th>
      <th width="20%" style="border-top-style:dashed;">TAX CODE</th>
    </tr>
    <tr>
      <th width="20%" style="border-bottom-style:dashed;">QTY</th>
      <th width="20%" style="border-bottom-style:dashed;">RM</th>
      <th width="20%" style="border-bottom-style:dashed;"></th>
      <th width="20%" style="border-bottom-style:dashed;">RM</th>
      <th width="20%" style="border-bottom-style:dashed;"></th>
    </tr>
  '''
      + generateRows()
      + '''</table>''';

}
