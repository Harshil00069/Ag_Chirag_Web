class PositionDataModel {
  PositionDataModel({
    required this.message,
    required this.results,
  });

  final String? message;
  final List<Result> results;

  factory PositionDataModel.fromJson(Map<String, dynamic> json){
    return PositionDataModel(
      message: json["message"],
      results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
    );
  }

}

class Result {
  Result({
    required this.data,
  });

  final List<PositionData> data;

  factory Result.fromJson(Map<String, dynamic> json){
    return Result(
      data: json["data"] == null ? [] : List<PositionData>.from(json["data"]!.map((x) => PositionData.fromJson(x))),
    );
  }

}

class PositionData {
  PositionData({
    required this.symboltoken,
    required this.symbolname,
    required this.instrumenttype,
    required this.priceden,
    required this.pricenum,
    required this.genden,
    required this.gennum,
    required this.precision,
    required this.multiplier,
    required this.boardlotsize,
    required this.exchange,
    required this.producttype,
    required this.tradingsymbol,
    required this.symbolgroup,
    required this.strikeprice,
    required this.optiontype,
    required this.expirydate,
    required this.lotsize,
    required this.cfbuyqty,
    required this.cfsellqty,
    required this.cfbuyamount,
    required this.cfsellamount,
    required this.buyavgprice,
    required this.sellavgprice,
    required this.avgnetprice,
    required this.netvalue,
    required this.netqty,
    required this.totalbuyvalue,
    required this.totalsellvalue,
    required this.cfbuyavgprice,
    required this.cfsellavgprice,
    required this.totalbuyavgprice,
    required this.totalsellavgprice,
    required this.netprice,
    required this.buyqty,
    required this.sellqty,
    required this.buyamount,
    required this.sellamount,
    required this.pnl,
    required this.realised,
    required this.unrealised,
    required this.ltp,
    required this.close,
    required this.client,
    required this.clientName,
  });

  final String? symboltoken;
  final String? symbolname;
  final String? instrumenttype;
  final String? priceden;
  final String? pricenum;
  final String? genden;
  final String? gennum;
  final String? precision;
  final String? multiplier;
  final String? boardlotsize;
  final String? exchange;
  final String? producttype;
  final String? tradingsymbol;
  final String? symbolgroup;
  final String? strikeprice;
  final String? optiontype;
  final String? expirydate;
  final String? lotsize;
  final String? cfbuyqty;
  final String? cfsellqty;
  final String? cfbuyamount;
  final String? cfsellamount;
  final String? buyavgprice;
  final String? sellavgprice;
  final String? avgnetprice;
  final String? netvalue;
  final String? netqty;
  final String? totalbuyvalue;
  final String? totalsellvalue;
  final String? cfbuyavgprice;
  final String? cfsellavgprice;
  final String? totalbuyavgprice;
  final String? totalsellavgprice;
  final String? netprice;
  final String? buyqty;
  final String? sellqty;
  final String? buyamount;
  final String? sellamount;
  final String? pnl;
  final String? realised;
  final String? unrealised;
  final String? ltp;
  final String? close;
  final String? client;
  String? clientName;

  bool get isPnlPositive => (double.tryParse(pnl ?? '') ?? 0) >= 0;

  factory PositionData.fromJson(Map<String, dynamic> json){
    return PositionData(
      symboltoken: json["symboltoken"],
      symbolname: json["symbolname"],
      instrumenttype: json["instrumenttype"],
      priceden: json["priceden"],
      pricenum: json["pricenum"],
      genden: json["genden"],
      gennum: json["gennum"],
      precision: json["precision"],
      multiplier: json["multiplier"],
      boardlotsize: json["boardlotsize"],
      exchange: json["exchange"],
      producttype: json["producttype"],
      tradingsymbol: json["tradingsymbol"],
      symbolgroup: json["symbolgroup"],
      strikeprice: json["strikeprice"],
      optiontype: json["optiontype"],
      expirydate: json["expirydate"],
      lotsize: json["lotsize"],
      cfbuyqty: json["cfbuyqty"],
      cfsellqty: json["cfsellqty"],
      cfbuyamount: json["cfbuyamount"],
      cfsellamount: json["cfsellamount"],
      buyavgprice: json["buyavgprice"],
      sellavgprice: json["sellavgprice"],
      avgnetprice: json["avgnetprice"],
      netvalue: json["netvalue"],
      netqty: json["netqty"],
      totalbuyvalue: json["totalbuyvalue"],
      totalsellvalue: json["totalsellvalue"],
      cfbuyavgprice: json["cfbuyavgprice"],
      cfsellavgprice: json["cfsellavgprice"],
      totalbuyavgprice: json["totalbuyavgprice"],
      totalsellavgprice: json["totalsellavgprice"],
      netprice: json["netprice"],
      buyqty: json["buyqty"],
      sellqty: json["sellqty"],
      buyamount: json["buyamount"],
      sellamount: json["sellamount"],
      pnl: json["pnl"],
      realised: json["realised"],
      unrealised: json["unrealised"],
      ltp: json["ltp"],
      close: json["close"],
      client: json["client"],
      clientName: json["clientName"],
    );
  }

}
