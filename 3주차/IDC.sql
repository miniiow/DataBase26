// 20260903 데이터베이스 3주차
// SQL문형 익히기 - 1
// 조건조회 : SELECT FROM WHERE

// 1월 3일에 주문한 주문마스터 정보 표시 + 정렬 적용
SELECT *
  FROM A_OUT_M
 WHERE OUTBOUND_DATE = '2023-01-03'
 ORDER BY BRAND_CD, ORDER_NM;;

// 1월 4일에 김민기가 주문한 주문마스터 정보를 표시
SELECT *
  FROM A_OUT_M
 WHERE OUTBOUND_DATE = '2023-01-04'
   AND ORDER_NM LIKE '김민기';

// A상품을 주문한 주문 디테일 정보를 표시
SELECT *
  FROM A_OUT_D
 WHERE ITEM_CD = 'A';

// C상품을 3개 이상 주문한 주문디테일 정보를 표시
SELECT *
  FROM A_OUT_D
 WHERE ITEM_CD = 'C'
   AND ORDER_QTY >= 3;

// 1001 브랜드가 보유하고 있는 상품마스터 정보 표시
SELECT *
  FROM A_ITEM
 WHERE BRAND_CD = '1001';
 
 
// IN
// 1월 3일 또는 1월 4일에 주문한 주문의 [브랜드], [인보이스], [주문자명]을 표시
SELECT BRAND_CD, INVOICE_NO, ORDER_NM
  FROM A_OUT_M
 WHERE OUTBOUND_DATE = '2023-01-03'
    OR OUTBOUND_DATE = '2023-01-04';
    
SELECT BRAND_CD, INVOICE_NO, ORDER_NM
  FROM A_OUT_M
 WHERE OUTBOUND_DATE IN ('2023-01-03', '2023-01-04');
    
// 1001 브랜드에서 A상품 또는 B상품 또는 C상품을 3개 이상 주문한 주문의 [브랜드], [인보이스], [상품코드], [주문수량]을 표시
SELECT BRAND_CD, INVOICE_NO, ITEM_CD, ORDER_QTY
  FROM A_OUT_D
 WHERE BRAND_CD = '1001'
   AND ((ITEM_CD = 'A') OR (ITEM_CD = 'B') OR (ITEM_CD = 'C'))
   AND ORDER_QTY >= 3;


// BETWEEN
// 1월1일에서 1월4일 사이의 주문중에 윤현수 또는 김민기라는 사람이 주문한 주문의 브랜드, 인보이스, 충고일자, 주문자를 표시
SELECT BRAND_CD, INVOICE_NO, OUTBOUND_DATE, ORDER_NM
  FROM A_OUT_M
 WHERE OUTBOUND_DATE BETWEEN '2023-01-01' AND '2023-01-04'
   AND ORDER_NM IN('윤현수', '김민기');

// 인보이스 #01번부터 #05번 사이의 주문 중에 A상품 또는 B상품 또는 C상품을 3개 이상 주문한 주문의 브랜드, 인보이스, 상품코드, 주문수량을 표시
SELECT BRAND_CD, INVOICE_NO, ITEM_CD, ORDER_QTY
  FROM A_OUT_D
 WHERE INVOICE_NO BETWEEN '#01' AND '#05'
   AND ITEM_CD IN ('A', 'B', 'C')
   AND ORDER_QTY >= 3;
   

// LIKE
// 인보이스 #01부터 #05번 사이의 주문중에 전씨 또는 권씨 성을 가진 사람이 주문한 주문의 브랜드, 인보이스, 출고일자, 주문자를 표시
SELECT BRAND_CD, INVOICE_NO, OUTBOUND_DATE, ORDER_NM
  FROM A_OUT_M
 WHERE INVOICE_NO BETWEEN '#01' AND '#05'
   AND (ORDER_NM LIKE '전%' OR ORDER_NM LIKE '권%');

SELECT BRAND_CD, INVOICE_NO, OUTBOUND_DATE, ORDER_NM
  FROM A_OUT_M
 WHERE INVOICE_NO BETWEEN '#01' AND '#05'
   AND SUBSTR(ORDER_NM, 1, 1) IN('전', '권');

// 인보이스가 #0으로 시작하고 주문수량이 3이상인 주문의 브랜드, 인보이스, 상품코드, 주문수량을 표시
SELECT BRAND_CD, INVOICE_NO, ITEM_CD, ORDER_QTY
  FROM A_OUT_D
 WHERE INVOICE_NO LIKE '#0%'
   AND ORDER_QTY >= 3;
   
   
// ORDER BY
// 주문수량이 많은 것부터 먼저 표시
SELECT BRAND_CD, INVOICE_NO, ITEM_CD, ORDER_QTY
  FROM A_OUT_D
 WHERE INVOICE_NO LIKE '#0%'
   AND ORDER_QTY >= 3
 ORDER BY ORDER_QTY DESC;

// 주문수량이 많은 순으로, 같다면 상품코드를 오름차순으로 정렬
SELECT BRAND_CD, INVOICE_NO, ITEM_CD, ORDER_QTY
  FROM A_OUT_D
 WHERE INVOICE_NO LIKE '#0%'
   AND ORDER_QTY >= 3
 ORDER BY ORDER_QTY DESC, ITEM_CD ASC;
 
// 위의 결과를 기준으로 TOP3 까지만 표시
SELECT *
  FROM (
        SELECT BRAND_CD, INVOICE_NO, ITEM_CD, ORDER_QTY
          FROM A_OUT_D
         WHERE INVOICE_NO LIKE '#0%'
           AND ORDER_QTY >= 3
         ORDER BY ORDER_QTY DESC, ITEM_CD ASC
       )
 WHERE ROWNUM <= 2;
 
 
 // 집계함수
-- 1월 3일부터 1월 4일 사이에 브랜드 구분없이 총 몇개의 인보이스를 출고시켰는가
SELECT COUNT(*)
  FROM A_OUT_M
 WHERE OUTBOUND_DATE BETWEEN '2023-01-03' AND '2023-01-04';

--SELECT COUNT(*)
--  FROM A_OUT_D
-- WHERE ITEM_CD = 'A';

-- 1001 브랜드는 총 몇개의 주문수량을 출고시켰는가
SELECT SUM(ORDER_QTY)
  FROM A_OUT_D
 WHERE BRAND_CD = '1001';