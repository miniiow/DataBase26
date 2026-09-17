-- 브랜드 별로 몇 개씩의 인보이스를 처리했는지 가르쳐줘
SELECT BRAND_CD, COUNT(*)
  FROM A_OUT_D
 GROUP BY BRAND_CD;
 
SELECT BRAND_CD, COUNT(*)
  FROM A_OUT_M
 GROUP BY BRAND_CD;

-- 브랜드&출고일자 별로 몇 개씩의 인보이스를 처리했는가
SELECT BRAND_CD, OUTBOUND_DATE, COUNT(*)
  FROM A_OUT_M
 GROUP BY BRAND_CD, OUTBOUND_DATE
 ORDER BY BRAND_CD, COUNT(*) DESC;

-- 브랜드 별로 몇 개씩의 주문수량을 출고시켰는가
SELECT BRAND_CD, SUM(ORDER_QTY)
  FROM A_OUT_D
 GROUP BY BRAND_CD
 ORDER BY SUM(ORDER_QTY) DESC;
 
-- 브랜드&상품 별로 몇 개씩의 주문수량을 출고시켰는가
SELECT BRAND_CD, ITEM_CD, SUM(ORDER_QTY)
  FROM A_OUT_D
 GROUP BY BRAND_CD, ITEM_CD
 ORDER BY BRAND_CD, SUM(ORDER_QTY) DESC;

-- 브랜드 별로 주문수량 중에서 가장 많이 주문한 수량과 가장 적게 주문한 수량은 몇 개인가
SELECT BRAND_CD, MAX(ORDER_QTY), MIN(ORDER_QTY)
  FROM A_OUT_D
 GROUP BY BRAND_CD
 ORDER BY BRAND_CD;
 
 
-- LO_OUT_M, LO_OUT_D 테이블 레코드 건수 확인
SELECT COUNT(*)
  FROM LO_OUT_M;

SELECT COUNT(*)
  FROM LO_OUT_D;
  

SELECT INVOICE_NO, OUTBOUND_DATE, OUT_TYPE_DIV, OUT_BOX_DIV, OUT_BOX_NM
  FROM LO_OUT_M
 WHERE OUTBOUND_DATE BETWEEN '2019/09/01' AND '2019/09/02'
   AND OUT_TYPE_DIV  IN ('M15', 'M22')
   AND OUT_BOX_DIV   LIKE 'F%'
   AND ORDER_PLACE = '52685'
 ORDER BY OUTBOUND_DATE, INVOICE_NO;

SELECT TO_CHAR(OUTBOUND_DATE, 'YYYY-MM'), COUNT(*)
  FROM LO_OUT_M
  GROUP BY TO_CHAR(OUTBOUND_DATE, 'YYYY-MM')
  ORDER BY TO_CHAR(OUTBOUND_DATE, 'YYYY-MM');


SELECT OUTBOUND_DATE
      ,COUNT(*)                    AS TOT_CNT
      ,COUNT(DISTINCT OUT_BOX_DIV) AS OUT_BOX_CNT
      ,MIN  (OUT_BOX_DIV)          AS OUT_BOX_MIN
      ,MAX  (OUT_BOX_DIV)          AS OUT_BOX_MAX
  FROM LO_OUT_M
 WHERE OUTBOUND_DATE BETWEEN '2019/09/01' AND '2019/09/02'
   AND OUT_TYPE_DIV  IN ('M15', 'M22')
   AND OUT_BOX_DIV   LIKE 'F%'
   AND ORDER_PLACE = '52685'
 GROUP BY OUTBOUND_DATE
 ORDER BY OUTBOUND_DATE;
 

-- 출고일자가 1월 2일인 인보이스에 대한 주문 디테일 정보 표시
SELECT *
  FROM A_OUT_D
 WHERE (BRAND_CD,INVOICE_NO) IN (
                                 SELECT BRAND_CD, INVOICE_NO
                                   FROM A_OUT_M
                                  WHERE OUTBOUND_DATE = '2023-01-03'
                                );

-- 1001 브랜드이고 출고유형이 M1로 시작하는 인보이스에 대한 주문디테일 정보 표시
SELECT *
  FROM A_OUT_D
 WHERE (BRAND_CD, INVOICE_NO) IN (
                                  SELECT BRAND_CD, INVOICE_NO
                                    FROM A_OUT_M
                                   WHERE BRAND_CD = '1001'
                                     AND OUT_TYPE_DIV LIKE 'M1%'
                                 );

-- 브랜드&인보이스 별로 총 주문수량이 3 이상인 인보이스의 주문마스터 정보 표시
SELECT *
  FROM A_OUT_M
 WHERE (BRAND_CD, INVOICE_NO) IN (-- 총 주문수량이 3건 이상인 인보이스 구하기
                                    FROM A_OUT_D
                                   GROUP BY BRAND_CD, INVOICE_NO
                                  SELECT BRAND_CD, INVOICE_NO
                                   HAVING SUM(ORDER_QTY) >= 3
                                 );


-- 복습하기
-- A_OUT_D에서 브랜드+인보이스별 총 주문수량을 구하세요, 단 총 주문수량이 3이상인 인보이스만 출력하세요
SELECT BRAND_CD, INVOICE_NO, ORDER_QTY
  FROM A_OUT_D
 WHERE ORDER_QTY >= 3
 GROUP BY BRAND_CD, INVOICE_NO, ORDER_QTY;
 
-- 문제 1. A_OUT_M에서 BRAND_CD가 1001이고, 출고일자가 2023-01-03인 주문의 모든 정보를 조회하세요
SELECT *
  FROM A_OUT_M
 WHERE BRAND_CD = '1001'
   AND OUTBOUND_DATE = '2023-01-03';
   
-- 문제 2. A_OUT_M에서 출고유형이 M1로 시작하는 모든 주문을 조회하세요 결과는 OUTBOUND_DATE가 빠른 순서대로 정렬
SELECT *
  FROM A_OUT_M
 WHERE OUT_TYPE_DIV LIKE 'M1%'
 ORDER BY OUTBOUND_DATE ASC;
 
-- 문제 3.A_OUT_M에서 출고일자가 2023-01-03부터 2023-01-05 사이이고, 출고 유형이 M11또는 M22인 주문을 조회
SELECT *
  FROM A_OUT_M
 WHERE OUTBOUND_DATE BETWEEN '2023-01-03' AND '2023-01-05';
   
SELECT *
  FROM A_OUT_M
 WHERE OUTBOUND_DATE BETWEEN '2023-01-03' AND '2023-01-05'
   AND OUT_TYPE_DIV IN ('M11', 'M22');
 
-- 문제 4. A_OUT_D의 모든 데이터를 ORDER_QTY가 큰 것부터 정렬하세요 주문수량이 같다면 INVOICE_NO가 작은 것부터 정렬하세요
SELECT *
  FROM A_OUT_D
 ORDER BY ORDER_QTY DESC, INVOICE_NO;
 
-- 문제 5. A_OUT_D에서 브랜드별 총 주문수량을 구하세요. 결과 컬럼의 별명은 TOTAL_QTY로 지정하세요
SELECT BRAND_CD, COUNT(*) AS TOTAL_QTY
  FROM A_OUT_D
 GROUP BY BRAND_CD;
 
 SELECT BRAND_CD, COUNT(ORDER_QTY) AS TOTAL_QTY
  FROM A_OUT_D
 GROUP BY BRAND_CD;
 
-- 문제 6. A_OUT_D에서 브랜드별로 주문한 상품의 종류가 몇 종류인지 구하세요. 같은 ITEM_CD는 한 번만 세어야 합니다. 결과 컬럼명은 ITEM_CNT로 하세요.
SELECT BRAND_CD, COUNT(DISTINCT ITEM_CD) AS ITEM_CNT
  FROM A_OUT_D
 GROUP BY BRAND_CD;
 
-- 문제 7. A_OUT_D에서 브랜드 + 인보이스별 총 주문수량을 구하세요. 단, 총 주문수량이 3 이상인 인보이스만 출력하세요.
SELECT BRAND_CD, INVOICE_NO, COUNT(*)
  FROM A_OUT_D
 GROUP BY BRAND_CD, INVOICE_NO
HAVING COUNT(*) >= 3;

SELECT BRAND_CD, INVOICE_NO, SUM(ORDER_QTY)
  FROM A_OUT_D
 GROUP BY BRAND_CD, INVOICE_NO
HAVING SUM(ORDER_QTY) >= 3;

-- 문제 8. A_OUT_D에서 브랜드별로 다음 네 가지를 출력하세요.
SELECT BRAND_CD
      ,COUNT(*) AS TOT_CNT
      ,COUNT(DISTINCT INVOICE_NO) AS ITEM_CNT
      ,MIN(ORDER_QTY) AS MIN_QTY
      ,MAX(ORDER_QTY) AS MAX_QTY
  FROM A_OUT_D
 GROUP BY BRAND_CD
 ORDER BY BRAND_CD;
 
SELECT BRAND_CD
      ,COUNT(ITEM_CD) AS TOT_CNT
      ,COUNT(DISTINCT INVOICE_NO) AS ITEM_CNT
      ,MIN(ORDER_QTY) AS MIN_QTY
      ,MAX(ORDER_QTY) AS MAX_QTY
  FROM A_OUT_D
 GROUP BY BRAND_CD
 ORDER BY BRAND_CD;
 
-- 문제 9. A_OUT_M에서 출고일자가 2023-01-04인 인보이스를 찾아서, 그 인보이스들의 주문 상세 정보(A_OUT_D)를 조회하세요. IN 서브쿼리를 사용하세요.
SELECT *
  FROM A_OUT_D
 WHERE (BRAND_CD, INVOICE_NO) IN (
                                   SELECT BRAND_CD, INVOICE_NO
                                     FROM A_OUT_M
                                    WHERE OUTBOUND_DATE = '2023-01-04'
                                 );

-- 문제 10. A_OUT_D에서 총 주문수량이 4 이상인 브랜드+인보이스를 찾고, 그 인보이스에 해당하는 주문 마스터 정보(A_OUT_M)를 조회하세요.
SELECT *
  FROM A_OUT_M
 WHERE (BRAND_CD, INVOICE_NO) = (
                                 SELECT BRAND_CD, INVOICE_NO
                                   FROM A_OUT_D
                                  WHERE ORDER_QTY >= 4
                                );
                                
SELECT *
  FROM A_OUT_M
 WHERE (BRAND_CD, INVOICE_NO) IN (
                                 SELECT BRAND_CD, INVOICE_NO
                                   FROM A_OUT_D
                                  GROUP BY BRAND_CD, INVOICE_NO
                                 HAVING SUM(ORDER_QTY) >= 4
                                );

-- 문제 11. A_OUT_M의 주문 중에서 A_OUT_D에 주문 상세 데이터가 하나라도 존재하는 주문만 조회하세요. 이번에는 IN을 쓰지 말고 EXISTS를 사용하세요.
SELECT *
  FROM A_OUT_M
 WHERE EXISTS (
               SELECT 1
                 FROM A_OUT_D
              );
              
SELECT *
  FROM A_OUT_M M1
 WHERE EXISTS (
               SELECT 1
                 FROM A_OUT_D S1
                WHERE S1.INVOICE_NO = M1.INVOICE_NO
                  AND S1.BRAND_CD = M1.BRAND_CD
              );

-- 문제 12. ⭐ A_OUT_D의 각 주문 상세 행을 출력하면서, 전체 주문 상세 중 가장 큰 ORDER_QTY도 MAX_QTY라는 컬럼으로 함께 표시하세요. 반드시 스칼라 서브쿼리를 사용하세요.
SELECT *,(SELECT MAX(ORDER_QTY)AS MAX_QTY FROM A_OUT_D)
  FROM A_OUT_D;

SELECT BRAND_CD, INVOICE_NO, LINE_NO, ITEM_CD, ORDER_QTY
      ,(
        SELECT MAX(ORDER_QTY)
          FROM A_OUT_D
       ) AS MAX_QTY
  FROM A_OUT_D;


SELECT M1.*, (SELECT MAX(S1.ORDER_QTY) FROM A_OUT_D S1) AS MAX_QTY
FROM A_OUT_D M1;