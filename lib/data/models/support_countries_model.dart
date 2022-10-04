import 'dart:convert';

class SupportCountriesModel {
  List<CountryInfo> countries;
  SupportCountriesModel({required this.countries});

  factory SupportCountriesModel.fromMap(Map<String, dynamic> map) {
    return SupportCountriesModel(
        countries: Map<String, String>.from(map)
            .entries
            .map<CountryInfo>((e) => CountryInfo(isoCode: e.key, name: e.value))
            .toList());
  }
  static SupportCountriesModel fromDBMap(Map<dynamic, dynamic> map) {
    final list = List.from(json.decode(map['countries']));
    return SupportCountriesModel(
        countries: List<CountryInfo>.generate(
            list.length, (i) => CountryInfo.fromMap(list[i])));
  }

  Map<String, dynamic> toDBMap() => {
        'countries': json.encode(countries.map((e) => e.toMap()).toList()),
        'id': 1
      };
}

class CountryInfo {
  final String isoCode;
  final String name;
  CountryInfo({required this.isoCode, required this.name});

  static CountryInfo fromMap(Map<String, dynamic> map) {
    return CountryInfo(isoCode: map['isoCode']!, name: map['name']!);
  }

  CountryInfo copyWith({
    String? isoCode,
    String? name,
  }) {
    return CountryInfo(
      isoCode: isoCode ?? this.isoCode,
      name: name ?? this.name,
    );
  }

  Map<String, String> toMap() => {'isoCode': isoCode, 'name': name};
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CountryInfo &&
        other.isoCode == isoCode &&
        other.name == name;
  }

  @override
  int get hashCode => isoCode.hashCode ^ name.hashCode;

  String fromIso3166ToIsoCode3166_1() {
    switch (isoCode.toUpperCase()) {
      case 'AF':
        return 'AFG';
      case 'AX':
        return 'ALA';
      case 'AL':
        return 'ALB';
      case 'DZ':
        return 'DZA';
      case 'AS':
        return 'ASM';
      case 'AD':
        return 'AND';
      case 'AO':
        return 'AGO';
      case 'AI':
        return 'AIA';
      case 'AQ':
        return 'ATA';
      case 'AG':
        return 'ATG';
      case 'AR':
        return 'ARG';
      case 'AM':
        return 'ARM';
      case 'AW':
        return 'ABW';
      case 'AU':
        return 'AUS';
      case 'AT':
        return 'AUT';
      case 'AZ':
        return 'AZE';
      case 'BS':
        return 'BHS';
      case 'BH':
        return 'BHR';
      case 'BD':
        return 'BGD';
      case 'BB':
        return 'BRB';
      case 'BY':
        return 'BLR';
      case 'BE':
        return 'BEL';
      case 'BZ':
        return 'BLZ';
      case 'BJ':
        return 'BEN';
      case 'BM':
        return 'BMU';
      case 'BT':
        return 'BTN';
      case 'BO':
        return 'BOL';
      case 'BQ':
        return 'BES';
      case 'BA':
        return 'BIH';
      case 'BW':
        return 'BWA';
      case 'BV':
        return 'BVT';
      case 'BR':
        return 'BRA';
      case 'IO':
        return 'IOT';
      case 'BN':
        return 'BRN';
      case 'BG':
        return 'BGR';
      case 'BF':
        return 'BFA';
      case 'BI':
        return 'BDI';
      case 'CV':
        return 'CPV';
      case 'KH':
        return 'KHM';
      case 'CM':
        return 'CMR';
      case 'CA':
        return 'CAN';
      case 'KY':
        return 'CYM';
      case 'CF':
        return 'CAF';
      case 'TD':
        return 'TCD';
      case 'CL':
        return 'CHL';
      case 'CN':
        return 'CHN';
      case 'CX':
        return 'CXR';
      case 'CC':
        return 'CCK';
      case 'CO':
        return 'COL';
      case 'KM':
        return 'COM';
      case 'CG':
        return 'COG';
      case 'CD':
        return 'COD';
      case 'CK':
        return 'COK';
      case 'CR':
        return 'CRI';
      case 'CI':
        return 'CIV';
      case 'HR':
        return 'HRV';
      case 'CU':
        return 'CUB';
      case 'CW':
        return 'CUW';
      case 'CY':
        return 'CYP';
      case 'CZ':
        return 'CZE';
      case 'DK':
        return 'DNK';
      case 'DJ':
        return 'DJI';
      case 'DM':
        return 'DMA';
      case 'DO':
        return 'DOM';
      case 'EC':
        return 'ECU';
      case 'EG':
        return 'EGY';
      case 'SV':
        return 'SLV';
      case 'GQ':
        return 'GNQ';
      case 'ER':
        return 'ERI';
      case 'EE':
        return 'EST';
      case 'SZ':
        return 'SWZ';
      case 'ET':
        return 'ETH';
      case 'FK':
        return 'FLK';
      case 'FO':
        return 'FRO';
      case 'FJ':
        return 'FJI';
      case 'FI':
        return 'FIN';
      case 'FR':
        return 'FRA';
      case 'GF':
        return 'GUF';
      case 'PF':
        return 'PYF';
      case 'TF':
        return 'ATF';
      case 'GA':
        return 'GAB';
      case 'GM':
        return 'GMB';
      case 'GE':
        return 'GEO';
      case 'DE':
        return 'DEU';
      case 'GH':
        return 'GHA';
      case 'GI':
        return 'GIB';
      case 'GR':
        return 'GRC';
      case 'GL':
        return 'GRL';
      case 'GD':
        return 'GRD';
      case 'GP':
        return 'GLP';
      case 'GU':
        return 'GUM';
      case 'GT':
        return 'GTM';
      case 'GG':
        return 'GGY';
      case 'GN':
        return 'GIN';
      case 'GW':
        return 'GNB';
      case 'GY':
        return 'GUY';
      case 'HT':
        return 'HTI';
      case 'HM':
        return 'HMD';
      case 'VA':
        return 'VAT';
      case 'HN':
        return 'HND';
      case 'HK':
        return 'HKG';
      case 'HU':
        return 'HUN';
      case 'IS':
        return 'ISL';
      case 'IN':
        return 'IND';
      case 'ID':
        return 'IDN';
      case 'IR':
        return 'IRN';
      case 'IQ':
        return 'IRQ';
      case 'IE':
        return 'IRL';
      case 'IM':
        return 'IMN';
      case 'IL':
        return 'ISR';
      case 'IT':
        return 'ITA';
      case 'JM':
        return 'JAM';
      case 'JP':
        return 'JPN';
      case 'JE':
        return 'JEY';
      case 'JO':
        return 'JOR';
      case 'KZ':
        return 'KAZ';
      case 'KE':
        return 'KEN';
      case 'KI':
        return 'KIR';
      case 'KP':
        return 'PRK';
      case 'KR':
        return 'KOR';
      case 'KW':
        return 'KWT';
      case 'KG':
        return 'KGZ';
      case 'LA':
        return 'LAO';
      case 'LV':
        return 'LVA';
      case 'LB':
        return 'LBN';
      case 'LS':
        return 'LSO';
      case 'LR':
        return 'LBR';
      case 'LY':
        return 'LBY';
      case 'LI':
        return 'LIE';
      case 'LT':
        return 'LTU';
      case 'LU':
        return 'LUX';
      case 'MO':
        return 'MAC';
      case 'MG':
        return 'MDG';
      case 'MW':
        return 'MWI';
      case 'MY':
        return 'MYS';
      case 'MV':
        return 'MDV';
      case 'ML':
        return 'MLI';
      case 'MT':
        return 'MLT';
      case 'MH':
        return 'MHL';
      case 'MQ':
        return 'MTQ';
      case 'MR':
        return 'MRT';
      case 'MU':
        return 'MUS';
      case 'YT':
        return 'MYT';
      case 'MX':
        return 'MEX';
      case 'FM':
        return 'FSM';
      case 'MD':
        return 'MDA';
      case 'MC':
        return 'MCO';
      case 'MN':
        return 'MNG';
      case 'ME':
        return 'MNE';
      case 'MS':
        return 'MSR';
      case 'MA':
        return 'MAR';
      case 'MZ':
        return 'MOZ';
      case 'MM':
        return 'MMR';
      case 'NA':
        return 'NAM';
      case 'NR':
        return 'NRU';
      case 'NP':
        return 'NPL';
      case 'NL':
        return 'NLD';
      case 'NC':
        return 'NCL';
      case 'NZ':
        return 'NZL';
      case 'NI':
        return 'NIC';
      case 'NE':
        return 'NER';
      case 'NG':
        return 'NGA';
      case 'NU':
        return 'NIU';
      case 'NF':
        return 'NFK';
      case 'MK':
        return 'MKD';
      case 'MP':
        return 'MNP';
      case 'NO':
        return 'NOR';
      case 'OM':
        return 'OMN';
      case 'PK':
        return 'PAK';
      case 'PW':
        return 'PLW';
      case 'PS':
        return 'PSE';
      case 'PA':
        return 'PAN';
      case 'PG':
        return 'PNG';
      case 'PY':
        return 'PRY';
      case 'PE':
        return 'PER';
      case 'PH':
        return 'PHL';
      case 'PN':
        return 'PCN';
      case 'PL':
        return 'POL';
      case 'PT':
        return 'PRT';
      case 'PR':
        return 'PRI';
      case 'QA':
        return 'QAT';
      case 'RE':
        return 'REU';
      case 'RO':
        return 'ROU';
      case 'RU':
        return 'RUS';
      case 'RW':
        return 'RWA';
      case 'BL':
        return 'BLM';
      case 'SH':
        return 'SHN';
      case 'KN':
        return 'KNA';
      case 'LC':
        return 'LCA';
      case 'MF':
        return 'MAF';
      case 'PM':
        return 'SPM';
      case 'VC':
        return 'VCT';
      case 'WS':
        return 'WSM';
      case 'SM':
        return 'SMR';
      case 'ST':
        return 'STP';
      case 'SA':
        return 'SAU';
      case 'SN':
        return 'SEN';
      case 'RS':
        return 'SRB';
      case 'SC':
        return 'SYC';
      case 'SL':
        return 'SLE';
      case 'SG':
        return 'SGP';
      case 'SX':
        return 'SXM';
      case 'SK':
        return 'SVK';
      case 'SI':
        return 'SVN';
      case 'SB':
        return 'SLB';
      case 'SO':
        return 'SOM';
      case 'ZA':
        return 'ZAF';
      case 'GS':
        return 'SGS';
      case 'SS':
        return 'SSD';
      case 'ES':
        return 'ESP';
      case 'LK':
        return 'LKA';
      case 'SD':
        return 'SDN';
      case 'SR':
        return 'SUR';
      case 'SJ':
        return 'SJM';
      case 'SE':
        return 'SWE';
      case 'CH':
        return 'CHE';
      case 'SY':
        return 'SYR';
      case 'TW':
        return 'TWN';
      case 'TJ':
        return 'TJK';
      case 'TZ':
        return 'TZA';
      case 'TH':
        return 'THA';
      case 'TL':
        return 'TLS';
      case 'TG':
        return 'TGO';
      case 'TK':
        return 'TKL';
      case 'TO':
        return 'TON';
      case 'TT':
        return 'TTO';
      case 'TN':
        return 'TUN';
      case 'TR':
        return 'TUR';
      case 'TM':
        return 'TKM';
      case 'TC':
        return 'TCA';
      case 'TV':
        return 'TUV';
      case 'UG':
        return 'UGA';
      case 'UA':
        return 'UKR';
      case 'AE':
        return 'ARE';
      case 'GB':
        return 'GBR';
      case 'US':
        return 'USA';
      case 'UM':
        return 'UMI';
      case 'UY':
        return 'URY';
      case 'UZ':
        return 'UZB';
      case 'VU':
        return 'VUT';
      case 'VE':
        return 'VEN';
      case 'VN':
        return 'VNM';
      case 'VG':
        return 'VGB';
      case 'VI':
        return 'VIR';
      case 'WF':
        return 'WLF';
      case 'EH':
        return 'ESH';
      case 'YE':
        return 'YEM';
      case 'ZM':
        return 'ZMB';
      case 'ZW':
        return 'ZWE';
      default:
        return 'USA';
    }
  }

  static String fromIso4017ToIso3166(String key) {
    switch (key) {
      case 'AFG':
        return 'AF';
      case 'ALA':
        return 'AX';
      case 'ALB':
        return 'AL';
      case 'DZA':
        return 'DZ';

      case 'ASM':
        return 'AS';

      case 'AND':
        return 'AD';

      case 'AGO':
        return 'AO';

      case 'AIA':
        return 'AI';

      case 'ATA':
        return 'AQ';

      case 'ATG':
        return 'AG';

      case 'ARG':
        return 'AR';

      case 'ARM':
        return 'AM';

      case 'ABW':
        return 'AW';

      case 'AUS':
        return 'AU';

      case 'AUT':
        return 'AT';

      case 'AZE':
        return 'AZ';

      case 'BHS':
        return 'BS';

      case 'BHR':
        return 'BH';

      case 'BGD':
        return 'BD';

      case 'BRB':
        return 'BB';

      case 'BLR':
        return 'BY';

      case 'BEL':
        return 'BE';

      case 'BLZ':
        return 'BZ';

      case 'BEN':
        return 'BJ';

      case 'BMU':
        return 'BM';

      case 'BTN':
        return 'BT';

      case 'BOL':
        return 'BO';

      case 'BES':
        return 'BQ';

      case 'BIH':
        return 'BA';

      case 'BWA':
        return 'BW';

      case 'BVT':
        return 'BV';

      case 'BRA':
        return 'BR';

      case 'IOT':
        return 'IO';

      case 'BRN':
        return 'BN';

      case 'BGR':
        return 'BG';

      case 'BFA':
        return 'BF';

      case 'BDI':
        return 'BI';

      case 'CPV':
        return 'CV';

      case 'KHM':
        return 'KH';

      case 'CMR':
        return 'CM';

      case 'CAN':
        return 'CA';

      case 'CYM':
        return 'KY';

      case 'CAF':
        return 'CF';

      case 'TCD':
        return 'TD';

      case 'CHL':
        return 'CL';

      case 'CHN':
        return 'CN';

      case 'CXR':
        return 'CX';

      case 'CCK':
        return 'CC';

      case 'COL':
        return 'CO';

      case 'COM':
        return 'KM';

      case 'COD':
        return 'CD';

      case 'COG':
        return 'CG';

      case 'COK':
        return 'CK';

      case 'CRI':
        return 'CR';

      case 'CIV':
        return 'CI';

      case 'HRV':
        return 'HR';

      case 'CUB':
        return 'CU';

      case 'CUW':
        return 'CW';

      case 'CYP':
        return 'CY';

      case 'CZE':
        return 'CZ';

      case 'DNK':
        return 'DK';

      case 'DJI':
        return 'DJ';

      case 'DMA':
        return 'DM';

      case 'DOM':
        return 'DO';

      case 'ECU':
        return 'EC';

      case 'EGY':
        return 'EG';

      case 'SLV':
        return 'SV';

      case 'GNQ':
        return 'GQ';

      case 'ERI':
        return 'ER';

      case 'EST':
        return 'EE';

      case 'SWZ':
        return 'SZ';

      case 'ETH':
        return 'ET';

      case 'FLK':
        return 'FK';

      case 'FRO':
        return 'FO';

      case 'FJI':
        return 'FJ';

      case 'FIN':
        return 'FI';

      case 'FRA':
        return 'FR';

      case 'GUF':
        return 'GF';

      case 'PYF':
        return 'PF';

      case 'ATF':
        return 'TF';

      case 'GAB':
        return 'GA';

      case 'GMB':
        return 'GM';

      case 'GEO':
        return 'GE';

      case 'DEU':
        return 'DE';

      case 'GHA':
        return 'GH';

      case 'GIB':
        return 'GI';

      case 'GRC':
        return 'GR';

      case 'GRL':
        return 'GL';

      case 'GRD':
        return 'GD';

      case 'GLP':
        return 'GP';

      case 'GUM':
        return 'GU';

      case 'GTM':
        return 'GT';

      case 'GGY':
        return 'GG';

      case 'GIN':
        return 'GN';

      case 'GNB':
        return 'GW';

      case 'GUY':
        return 'GY';

      case 'HTI':
        return 'HT';

      case 'HMD':
        return 'HM';

      case 'VAT':
        return 'VA';

      case 'HND':
        return 'HN';

      case 'HKG':
        return 'HK';

      case 'HUN':
        return 'HU';

      case 'ISL':
        return 'IS';

      case 'IND':
        return 'IN';

      case 'IDN':
        return 'ID';

      case 'IRN':
        return 'IR';

      case 'IRQ':
        return 'IQ';

      case 'IRL':
        return 'IE';

      case 'IMN':
        return 'IM';

      case 'ISR':
        return 'IL';

      case 'ITA':
        return 'IT';

      case 'JAM':
        return 'JM';

      case 'JPN':
        return 'JP';

      case 'JEY':
        return 'JE';

      case 'JOR':
        return 'JO';

      case 'KAZ':
        return 'KZ';

      case 'KEN':
        return 'KE';

      case 'KIR':
        return 'KI';

      case 'PRK':
        return 'KP';

      case 'KOR':
        return 'KR';

      case 'KWT':
        return 'KW';

      case 'KGZ':
        return 'KG';

      case 'LAO':
        return 'LA';

      case 'LVA':
        return 'LV';

      case 'LBN':
        return 'LB';

      case 'LSO':
        return 'LS';

      case 'LBR':
        return 'LR';

      case 'LBY':
        return 'LY';

      case 'LIE':
        return 'LI';

      case 'LTU':
        return 'LT';

      case 'LUX':
        return 'LU';

      case 'MAC':
        return 'MO';

      case 'MKD':
        return 'MK';

      case 'MDG':
        return 'MG';

      case 'MWI':
        return 'MW';

      case 'MYS':
        return 'MY';

      case 'MDV':
        return 'MV';

      case 'MLI':
        return 'ML';

      case 'MLT':
        return 'MT';

      case 'MHL':
        return 'MH';

      case 'MTQ':
        return 'MQ';

      case 'MRT':
        return 'MR';

      case 'MUS':
        return 'MU';

      case 'MYT':
        return 'YT';

      case 'MEX':
        return 'MX';

      case 'FSM':
        return 'FM';

      case 'MDA':
        return 'MD';

      case 'MCO':
        return 'MC';

      case 'MNG':
        return 'MN';

      case 'MNE':
        return 'ME';

      case 'MSR':
        return 'MS';

      case 'MAR':
        return 'MA';

      case 'MOZ':
        return 'MZ';

      case 'MMR':
        return 'MM';

      case 'NAM':
        return 'NA';

      case 'NRU':
        return 'NR';

      case 'NPL':
        return 'NP';

      case 'NLD':
        return 'NL';

      case 'NCL':
        return 'NC';

      case 'NZL':
        return 'NZ';

      case 'NIC':
        return 'NI';

      case 'NER':
        return 'NE';

      case 'NGA':
        return 'NG';

      case 'NIU':
        return 'NU';

      case 'NFK':
        return 'NF';

      case 'MNP':
        return 'MP';

      case 'NOR':
        return 'NO';

      case 'OMN':
        return 'OM';

      case 'PAK':
        return 'PK';

      case 'PLW':
        return 'PW';

      case 'PSE':
        return 'PS';

      case 'PAN':
        return 'PA';

      case 'PNG':
        return 'PG';

      case 'PRY':
        return 'PY';

      case 'PER':
        return 'PE';

      case 'PHL':
        return 'PH';

      case 'PCN':
        return 'PN';

      case 'POL':
        return 'PL';

      case 'PRT':
        return 'PT';

      case 'PRI':
        return 'PR';

      case 'QAT':
        return 'QA';

      case 'REU':
        return 'RE';

      case 'ROU':
        return 'RO';

      case 'RUS':
        return 'RU';

      case 'RWA':
        return 'RW';

      case 'BLM':
        return 'BL';

      case 'SHN':
        return 'SH';

      case 'KNA':
        return 'KN';

      case 'LCA':
        return 'LC';

      case 'MAF':
        return 'MF';

      case 'SPM':
        return 'PM';

      case 'VCT':
        return 'VC';

      case 'WSM':
        return 'WS';

      case 'SMR':
        return 'SM';

      case 'STP':
        return 'ST';

      case 'SAU':
        return 'SA';

      case 'SEN':
        return 'SN';

      case 'SRB':
        return 'RS';

      case 'SYC':
        return 'SC';

      case 'SLE':
        return 'SL';

      case 'SGP':
        return 'SG';

      case 'SXM':
        return 'SX';

      case 'SVK':
        return 'SK';

      case 'SVN':
        return 'SI';

      case 'SLB':
        return 'SB';

      case 'SOM':
        return 'SO';

      case 'ZAF':
        return 'ZA';

      case 'SGS':
        return 'GS';

      case 'SSD':
        return 'SS';

      case 'ESP':
        return 'ES';

      case 'LKA':
        return 'LK';

      case 'SDN':
        return 'SD';

      case 'SUR':
        return 'SR';

      case 'SJM':
        return 'SJ';

      case 'SWE':
        return 'SE';

      case 'CHE':
        return 'CH';

      case 'SYR':
        return 'SY';

      case 'TWN':
        return 'TW';

      case 'TJK':
        return 'TJ';

      case 'TZA':
        return 'TZ';

      case 'THA':
        return 'TH';

      case 'TLS':
        return 'TL';

      case 'TGO':
        return 'TG';

      case 'TKL':
        return 'TK';

      case 'TON':
        return 'TO';

      case 'TTO':
        return 'TT';

      case 'TUN':
        return 'TN';

      case 'TUR':
        return 'TR';

      case 'TKM':
        return 'TM';

      case 'TCA':
        return 'TC';

      case 'TUV':
        return 'TV';

      case 'UGA':
        return 'UG';

      case 'UKR':
        return 'UA';

      case 'ARE':
        return 'AE';

      case 'GBR':
        return 'GB';

      case 'UMI':
        return 'UM';

      case 'USA':
        return 'US';

      case 'URY':
        return 'UY';

      case 'UZB':
        return 'UZ';

      case 'VUT':
        return 'VU';

      case 'VEN':
        return 'VE';

      case 'VNM':
        return 'VN';

      case 'VGB':
        return 'VG';

      case 'VIR':
        return 'VI';

      case 'WLF':
        return 'WF';

      case 'ESH':
        return 'EH';

      case 'YEM':
        return 'YE';

      case 'ZMB':
        return 'ZM';

      case 'ZWE':
        return 'ZW';

      default:
        return key;
    }
  }

  String fromIso3166ToIso4017() {
    switch (isoCode.toUpperCase()) {
      case 'AD':
        return 'EUR';
      case 'AE':
        return 'AED';
      case 'AF':
        return 'AFN';
      case 'AG':
        return 'XCD';
      case 'AI':
        return 'XCD';
      case 'AL':
        return 'ALL';
      case 'AM':
        return 'AMD';
      case 'AO':
        return 'AOA';
      case 'AR':
        return 'ARS';
      case 'AS':
        return 'USD';
      case 'AT':
        return 'EUR';
      case 'AU':
        return 'AUD';
      case 'AW':
        return 'AWG';
      case 'AX':
        return 'EUR';
      case 'AZ':
        return 'AZN';
      case 'BA':
        return 'BAM';
      case 'BB':
        return 'BBD';
      case 'BD':
        return 'BDT';
      case 'BE':
        return 'EUR';
      case 'BF':
        return 'XOF';
      case 'BG':
        return 'BGN';
      case 'BH':
        return 'BHD';
      case 'BI':
        return 'BIF';
      case 'BJ':
        return 'XOF';
      case 'BL':
        return 'EUR';
      case 'BM':
        return 'BMD';
      case 'BN':
        return 'BND';
      case 'BO':
        return 'BOB';
      case 'BQ':
        return 'USD';
      case 'BR':
        return 'BRL';
      case 'BS':
        return 'BSD';
      case 'BT':
        return 'INR';
      case 'BV':
        return 'NOK';
      case 'BW':
        return 'BWP';
      case 'BY':
        return 'BYN';
      case 'BZ':
        return 'BZD';
      case 'CA':
        return 'CAD';
      case 'CC':
        return 'AUD';
      case 'CD':
        return 'CDF';
      case 'CF':
        return 'XAF';
      case 'CG':
        return 'XAF';
      case 'CH':
        return 'CHF';
      case 'CI':
        return 'XOF';
      case 'CK':
        return 'NZD';
      case 'CL':
        return 'CLP';
      case 'CM':
        return 'XAF';
      case 'CN':
        return 'CNY';
      case 'CO':
        return 'COP';
      case 'CR':
        return 'CRC';
      case 'CU':
        return 'CUP';
      case 'CV':
        return 'CVE';
      case 'CW':
        return 'ANG';
      case 'CX':
        return 'AUD';
      case 'CY':
        return 'EUR';
      case 'CZ':
        return 'CZK';
      case 'DE':
        return 'EUR';
      case 'DJ':
        return 'DJF';
      case 'DK':
        return 'DKK';
      case 'DM':
        return 'XCD';
      case 'DO':
        return 'DOP';
      case 'DZ':
        return 'DZD';
      case 'EC':
        return 'USD';
      case 'EE':
        return 'EUR';
      case 'EG':
        return 'EGP';
      case 'EH':
        return 'MAD';
      case 'ER':
        return 'ERN';
      case 'ES':
        return 'EUR';
      case 'ET':
        return 'ETB';
      case 'FI':
        return 'EUR';
      case 'FJ':
        return 'FJD';
      case 'FK':
        return 'FKP';
      case 'FM':
        return 'USD';
      case 'FO':
        return 'DKK';
      case 'FR':
        return 'EUR';
      case 'GA':
        return 'XAF';
      case 'GB':
        return 'GBP';
      case 'GD':
        return 'XCD';
      case 'GE':
        return 'GEL';
      case 'GF':
        return 'EUR';
      case 'GG':
        return 'GGP';
      case 'GH':
        return 'GHS';
      case 'GI':
        return 'GIP';
      case 'GL':
        return 'DKK';
      case 'GM':
        return 'GMD';
      case 'GN':
        return 'GNF';
      case 'GP':
        return 'EUR';
      case 'GQ':
        return 'XAF';
      case 'GR':
        return 'EUR';
      case 'GS':
        return 'GBP';
      case 'GT':
        return 'GTQ';
      case 'GU':
        return 'USD';
      case 'GW':
        return 'XOF';
      case 'GY':
        return 'GYD';
      case 'HK':
        return 'HKD';
      case 'HM':
        return 'AUD';
      case 'HN':
        return 'HNL';
      case 'HR':
        return 'HRK';
      case 'HT':
        return 'HTG';
      case 'HU':
        return 'HUF';
      case 'ID':
        return 'IDR';
      case 'IE':
        return 'EUR';
      case 'IL':
        return 'ILS';
      case 'IM':
        return 'GBP';
      case 'IN':
        return 'INR';
      case 'IO':
        return 'USD';
      case 'IQ':
        return 'IQD';
      case 'IR':
        return 'IRR';
      case 'IS':
        return 'ISK';
      case 'IT':
        return 'EUR';
      case 'JE':
        return 'GBP';
      case 'JM':
        return 'JMD';
      case 'JO':
        return 'JOD';
      case 'JP':
        return 'JPY';
      case 'KE':
        return 'KES';
      case 'KG':
        return 'KGS';
      case 'KH':
        return 'KHR';
      case 'KI':
        return 'AUD';
      case 'KM':
        return 'KMF';
      case 'KN':
        return 'XCD';
      case 'KP':
        return 'KPW';
      case 'KR':
        return 'KRW';
      case 'KW':
        return 'KWD';
      case 'KY':
        return 'KYD';
      case 'KZ':
        return 'KZT';
      case 'LA':
        return 'LAK';
      case 'LB':
        return 'LBP';
      case 'LC':
        return 'XCD';
      case 'LI':
        return 'CHF';
      case 'LK':
        return 'LKR';
      case 'LR':
        return 'LRD';
      case 'LS':
        return 'LSL';
      case 'LT':
        return 'EUR';
      case 'LU':
        return 'EUR';
      case 'LV':
        return 'EUR';
      case 'LY':
        return 'LYD';
      case 'MA':
        return 'MAD';
      case 'MC':
        return 'EUR';
      case 'MD':
        return 'MDL';
      case 'ME':
        return 'EUR';
      case 'MF':
        return 'EUR';
      case 'MG':
        return 'MGA';
      case 'MH':
        return 'USD';
      case 'MK':
        return 'MKD';
      case 'ML':
        return 'XOF';
      case 'MM':
        return 'MMK';
      case 'MN':
        return 'MNT';
      case 'MO':
        return 'MOP';
      case 'MP':
        return 'USD';
      case 'MQ':
        return 'EUR';
      case 'MR':
        return 'MRO';
      case 'MS':
        return 'XCD';
      case 'MT':
        return 'EUR';
      case 'MU':
        return 'MUR';
      case 'MV':
        return 'MVR';
      case 'MW':
        return 'MWK';
      case 'MX':
        return 'MXN';
      case 'MY':
        return 'MYR';
      case 'MZ':
        return 'MZN';
      case 'NA':
        return 'NAD';
      case 'NC':
        return 'XPF';
      case 'NE':
        return 'XOF';
      case 'NF':
        return 'AUD';
      case 'NG':
        return 'NGN';
      case 'NI':
        return 'NIO';
      case 'NL':
        return 'EUR';
      case 'NO':
        return 'NOK';
      case 'NP':
        return 'NPR';
      case 'NR':
        return 'AUD';
      case 'NU':
        return 'NZD';
      case 'NZ':
        return 'NZD';
      case 'OM':
        return 'OMR';
      case 'PA':
        return 'PAB';
      case 'PE':
        return 'PEN';
      case 'PF':
        return 'XPF';
      case 'PG':
        return 'PGK';
      case 'PH':
        return 'PHP';
      case 'PK':
        return 'PKR';
      case 'PL':
        return 'PLN';
      case 'PM':
        return 'EUR';
      case 'PN':
        return 'NZD';
      case 'PR':
        return 'USD';
      case 'PS':
        return 'JOD';
      case 'PT':
        return 'EUR';
      case 'PW':
        return 'USD';
      case 'PY':
        return 'PYG';
      case 'QA':
        return 'QAR';
      case 'RE':
        return 'EUR';
      case 'RO':
        return 'RON';
      case 'RS':
        return 'RSD';
      case 'RU':
        return 'RUB';
      case 'RW':
        return 'RWF';
      case 'SA':
        return 'SAR';
      case 'SB':
        return 'SBD';
      case 'SC':
        return 'SCR';
      case 'SD':
        return 'SDG';
      case 'SE':
        return 'SEK';
      case 'SG':
        return 'SGD';
      case 'SH':
        return 'SHP';
      case 'SI':
        return 'EUR';
      case 'SJ':
        return 'NOK';
      case 'SK':
        return 'EUR';
      case 'SL':
        return 'SLL';
      case 'SM':
        return 'EUR';
      case 'SN':
        return 'XOF';
      case 'SO':
        return 'SOS';
      case 'SR':
        return 'SRD';
      case 'SS':
        return 'SSP';
      case 'ST':
        return 'STD';
      case 'SV':
        return 'USD';
      case 'SX':
        return 'ANG';
      case 'SY':
        return 'SYP';
      case 'SZ':
        return 'SZL';
      case 'TC':
        return 'USD';
      case 'TD':
        return 'XAF';
      case 'TF':
        return 'EUR';
      case 'TG':
        return 'XOF';
      case 'TH':
        return 'THB';
      case 'TJ':
        return 'TJS';
      case 'TK':
        return 'NZD';
      case 'TL':
        return 'USD';
      case 'TM':
        return 'TMT';
      case 'TN':
        return 'TND';
      case 'TO':
        return 'TOP';
      case 'TR':
        return 'TRY';
      case 'TT':
        return 'TTD';
      case 'TV':
        return 'AUD';
      case 'TW':
        return 'TWD';
      case 'TZ':
        return 'TZS';
      case 'UA':
        return 'UAH';
      case 'UG':
        return 'UGX';
      case 'UM':
        return 'USD';
      case 'US':
        return 'USD';
      case 'UY':
        return 'UYU';
      case 'UZ':
        return 'UZS';
      case 'VA':
        return 'EUR';
      case 'VC':
        return 'XCD';
      case 'VE':
        return 'VEF';
      case 'VG':
        return 'USD';
      case 'VI':
        return 'USD';
      case 'VN':
        return 'VND';
      case 'VU':
        return 'VUV';
      case 'WF':
        return 'XPF';
      case 'WS':
        return 'EUR';
      case 'YE':
        return 'YER';
      case 'YT':
        return 'EUR';
      case 'ZA':
        return 'ZAR';
      case 'ZM':
        return 'ZMW';
      case 'ZW':
        return 'USD';

      default:
        return 'USD';
    }
  }
}
