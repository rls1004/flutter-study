List<String> stocks = [
  "Tesla Inc.",
  "Direxion daily tsla bull 2X shares",
  "Nike Inc.",
  "Amazon.com Inc.",
  "Palantir Technologies",
];

List<String> stocksTicker = ["TSLA", "TSLL", "Nike", "AMZN", "PLTR"];

List<String> stocksSumary = [
  "전기차 및 에너지 솔루션을 제공하는 혁신적인 기업으로, Elon Musk가 이끄는 세계적인 전기차 제조업체",
  "Tesla 주가의 일일 변동성을 2배로 추종하는 레버리지 ETF",
  "스포츠 의류 및 신발 제조업체로, 글로벌 브랜드로 유명한 운동용품 회사",
  "세계 최대 전자상거래 및 클라우드 컴퓨팅 기업으로, AWS를 포함한 다양한 기술 및 유통 사업을 운영",
  "빅데이터 분석 및 인공지능 기반 소프트웨어를 제공하는 기업으로, 정부 및 기업을 위한 데이터 솔루션을 개발",
];

List<String> stocksDetails = [
  "Tesla Inc.는 2003년에 설립되어 전기자동차, 에너지 저장 시스템, 태양광 패널 등을 설계 및 생산하는 혁신적인 기업입니다.\n\nCEO인 Elon Musk의 리더십 아래, 지속 가능한 에너지 솔루션을 제공하며, 전 세계적으로 친환경 자동차 및 에너지 분야의 선도 기업으로 자리매김하고 있습니다.",
  "Direxion이 운용하는 TSLL은 Tesla 주가의 일일 변동성을 2배로 추종하는 레버리지 ETF로, Tesla 주가가 1% 상승하면 TSLL은 2% 상승하고, 1% 하락하면 TSLL은 2% 하락합니다.\n\n이러한 구조로 인해 단기적인 고수익을 추구하는 투자자들에게 매력적이지만, 레버리지 효과로 인해 변동성이 크므로 장기 보유 시에는 주의가 필요합니다!",
  "Nike Inc.는 1964년에 설립되어 스포츠 의류, 신발, 장비 등을 제조하는 세계적인 브랜드로, 'Just Do It'이라는 슬로건 아래 다양한 스포츠 분야에서 활동하고 있습니다.\n\n혁신적인 제품과 마케팅 전략으로 글로벌 시장에서 높은 인지도를 유지하고 있으며, 지속 가능한 제품 개발과 사회 공헌 활동에도 적극적으로 참여하고 있습니다!",
  "Amazon.com Inc.는 1994년에 설립되어 온라인 소매, 클라우드 컴퓨팅(AWS), 디지털 스트리밍, 인공지능(AI) 등 다양한 사업 영역에서 혁신을 주도하는 글로벌 기술 기업입니다.\n\n압도적인 시장 지배력과 강력한 브랜드 인지도를 바탕으로 전자상거래와 클라우드 시장을 장악하고 있으며, AI 기술을 활용한 고객 경험 개선과 물류 혁신을 통해 지속적인 성장을 이어가고 있습니다!",
  "Palantir Technologies Inc.는 2003년에 설립되어 데이터 분석 및 인공지능 솔루션을 제공하는 미국의 소프트웨어 기업으로, 본사는 콜로라도주 덴버에 위치하고 있습니다.\n\n주요 플랫폼으로는 정부 기관을 위한 Palantir Gotham과 상업 고객을 위한 Palantir Foundry가 있으며, 복잡한 데이터 세트를 분석하여 인사이트를 도출하는 소프트웨어를 개발합니다!",
];

List<String> stocksPositive = [
  "시장 선도적 위치, 혁신적인 기술력, 글로벌 확장성",
  "레버리지 효과, 헤지 수단",
  "브랜드 가치, 글로벌 시장 점유율, 지속 가능성",
  "광범위한 사업, 글로벌 물류 네트워크, 기술 혁신",
  "독점적 데이터 분석 기술, 정부 및 대기업 고객층",
];
List<String> stocksNegative = [
  "높은 변동성, 경쟁 심화, 공급망 이슈",
  "높은 변동성, 장기 보유 부적합, 복리 위험",
  "원자재 가격 변동, 환율 리스크, 경쟁심화",
  "규제 리스크, 운영 비용 증가, 경쟁심화",
  "의존적인 고객 구조, 수익성 우려, 개인정보 논란",
];

List<List<(DateTime, double)>> pricesOfStock = [
  _priceHistoryTSLA,
  _priceHistoryTSLL,
  _priceHistoryNIKE,
  _priceHistoryAMZN,
  _priceHistoryPLTR,
];

List<(DateTime, double)> _priceHistoryTSLA = [
  (DateTime(2024, 10, 14), 220.7),
  (DateTime(0, 10, 21), 269.19),
  (DateTime(0, 10, 28), 248.98),
  (DateTime(0, 11, 4), 321.22),
  (DateTime(0, 11, 11), 320.72),
  (DateTime(0, 11, 18), 352.56),
  (DateTime(0, 11, 25), 345.16),
  (DateTime(0, 12, 2), 389.22),
  (DateTime(0, 12, 9), 436.23),
  (DateTime(0, 12, 16), 421.06),

  (DateTime(0, 12, 23), 431.66),
  (DateTime(0, 12, 30), 410.44),
  (DateTime(2025, 1, 6), 397.74),
  (DateTime(0, 1, 13), 426.5),
  (DateTime(0, 1, 21), 406.58),
  (DateTime(0, 1, 27), 404.6),
  (DateTime(0, 2, 3), 361.62),
  (DateTime(0, 2, 10), 355.84),
  (DateTime(0, 2, 18), 337.8),
  (DateTime(0, 2, 24), 292.98),
  (DateTime(0, 3, 3), 262.67),
];
List<(DateTime, double)> _priceHistoryTSLL = [
  (DateTime(2024, 10, 14), 9.4859),
  (DateTime(0, 10, 21), 13.6076),
  (DateTime(0, 10, 28), 11.6059),
  (DateTime(0, 11, 4), 18.7943),
  (DateTime(0, 11, 11), 18.4492),
  (DateTime(0, 11, 18), 22.1173),
  (DateTime(0, 11, 25), 21.0622),
  (DateTime(0, 12, 2), 26.6138),
  (DateTime(0, 12, 9), 33.1272),
  (DateTime(0, 12, 16), 30.3401),

  (DateTime(0, 12, 23), 31.6),
  (DateTime(0, 12, 30), 28.17),
  (DateTime(2025, 1, 6), 25.92),
  (DateTime(0, 1, 13), 29.91),
  (DateTime(0, 1, 21), 27.09),
  (DateTime(0, 1, 27), 26.7),
  (DateTime(0, 2, 3), 21.13),
  (DateTime(0, 2, 10), 20.23),
  (DateTime(0, 2, 18), 18.11),
  (DateTime(0, 2, 24), 13.45),
  (DateTime(0, 3, 3), 10.66),
];
List<(DateTime, double)> _priceHistoryNIKE = [
  (DateTime(2021, 2), 128.0725),
  (DateTime(0, 3), 126.2766),
  (DateTime(0, 4), 126.02),
  (DateTime(0, 5), 129.9306),
  (DateTime(0, 6), 147.0979),
  (DateTime(0, 7), 159.4949),
  (DateTime(0, 8), 157.1163),
  (DateTime(0, 9), 138.5091),
  (DateTime(0, 10), 159.5482),
  (DateTime(0, 11), 161.4080),

  (DateTime(0, 12), 159.2426),
  (DateTime(2022, 1), 141.4715),
  (DateTime(0, 2), 130.4649),
  (DateTime(0, 3), 128.8569),
  (DateTime(0, 4), 119.4148),
  (DateTime(0, 5), 113.8128),
  (DateTime(0, 6), 98.1109),
  (DateTime(0, 7), 110.3220),
  (DateTime(0, 8), 102.1909),
  (DateTime(0, 9), 80.0235),
  (DateTime(0, 10), 89.2274),
];
List<(DateTime, double)> _priceHistoryAMZN = [
  (DateTime(2024, 10, 28), 197.93),
  (DateTime(0, 11, 4), 208.18),
  (DateTime(0, 11, 11), 202.61),
  (DateTime(0, 11, 18), 197.12),
  (DateTime(0, 11, 25), 207.89),
  (DateTime(0, 12, 2), 227.03),
  (DateTime(0, 12, 9), 227.46),
  (DateTime(0, 12, 16), 224.92),
  (DateTime(0, 12, 23), 223.75),
  (DateTime(0, 12, 30), 224.19),

  (DateTime(2025, 1, 6), 218.94),
  (DateTime(0, 1, 13), 225.94),
  (DateTime(0, 1, 21), 234.85),
  (DateTime(0, 1, 27), 237.68),
  (DateTime(0, 2, 3), 229.15),
  (DateTime(0, 2, 10), 228.68),
  (DateTime(0, 2, 18), 216.58),
  (DateTime(0, 2, 24), 212.28),
  (DateTime(0, 3, 3), 199.25),
  (DateTime(0, 3, 10), 197.95),
  (DateTime(0, 3, 17), 194.47),
];
List<(DateTime, double)> _priceHistoryPLTR = [
  (DateTime(2025, 2, 4), 103.83),
  (DateTime(0, 2, 5), 101.36),
  (DateTime(0, 2, 6), 111.28),
  (DateTime(0, 2, 7), 100.85),
  (DateTime(0, 2, 10), 106.65),
  (DateTime(0, 2, 11), 112.62),
  (DateTime(0, 2, 12), 117.39),
  (DateTime(0, 2, 13), 117.91),
  (DateTime(0, 2, 14), 119.16),
  (DateTime(0, 2, 18), 124.62),

  (DateTime(0, 2, 19), 112.06),
  (DateTime(0, 2, 20), 106.27),
  (DateTime(0, 2, 21), 101.35),
  (DateTime(0, 2, 24), 90.68),
  (DateTime(0, 2, 25), 87.84),
  (DateTime(0, 2, 26), 89.31),
  (DateTime(0, 2, 27), 84.77),
  (DateTime(0, 2, 28), 84.92),
  (DateTime(0, 3, 3), 83.42),
  (DateTime(0, 3, 4), 84.4),
  (DateTime(0, 3, 5), 90.13),
];
