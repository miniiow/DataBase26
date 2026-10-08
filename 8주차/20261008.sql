-- 브랜드별로 몇 개씩의 인보이스를 처리했는가
SELECT BRAND_CD
      ,COUNT(*)
  FROM A_OUT_M
 GROUP BY BRAND_CD;

-- 브랜드 & 요일별로 몇 개씩의 인보이스를 처리했는가
SELECT BRAND_CD
      ,TO_CHAR(OUTBOUND_DATE, 'DY') AS DY
--      ,TO_CHAR(OUTBOUND_DATE, 'D') AS DY
      ,COUNT(*) AS INV_CNT
  FROM A_OUT_M
 GROUP BY BRAND_CD
         ,TO_CHAR(OUTBOUND_DATE, 'D')
         ,TO_CHAR(OUTBOUND_DATE, 'DY')
 ORDER BY BRAND_CD
         ,TO_CHAR(OUTBOUND_DATE, 'D')
;
-- GROUP BY를 사용한 경우에는 ORDER BY에는 GROUP BY절에 표현이 된것만 인식할 수 있다.
-- GROUP BY절에 표현된것을 SELECT절에 무조건 넣어야 하는것이 아니다
SELECT COUNT(*)
  FROM A_OUT_M
 GROUP BY BRAND_CD
;

-- 브랜드 & 인보이스 번호의 홀/짝별로 주문수량의 합계
SELECT BRAND_CD
      ,CASE WHEN MOD(LTRIM(INVOICE_NO, '#'), 2) = 0 THEN '짝수' ELSE '홀수' END AS EVENODD
      ,SUM(ORDER_QTY) AS SUM_QTY 
      ,COUNT(DISTINCT INVOICE_NO) AS INV_CNT --주문수
  FROM A_OUT_D
 GROUP BY BRAND_CD, CASE WHEN MOD(LTRIM(INVOICE_NO, '#'), 2) = 0 THEN '짝수' ELSE '홀수' END
 ORDER BY BRAND_CD
         ,EVENODD DESC
;


-- 08. 내장함수 일반: 요일을 표시하는 내장함수 사용하기
SELECT INVOICE_NO
      ,OUTBOUND_DATE
      ,TO_CHAR(OUTBOUND_DATE, 'DAY') AS DAYY
      ,OUTBOUND_NO
  FROM LO_OUT_M
 WHERE INVOICE_NO IN('346724706214', '346724793596', '346724869970')
 ORDER BY OUTBOUND_DATE
         ,INVOICE_NO
;

SELECT NVL(SUM(ORDER_QTY), 'Empty..') AS ORDER_QTY
  FROM LO_OUT_D
 WHERE INVOICE_NO = '346724706215'
;

-- 조건에 맞지 않는 데이터가 있을때 'NULL'대신 'Empty..'로 출력하시오
-- 함수의 결과로 나오는 데이터타입은 모든 경우에 대해서 같아야 한다
SELECT NVL(TO_CHAR(SUM(ORDER_QTY)), 'Empty..') AS ORDER_QTY
  FROM (
        SELECT *
          FROM LO_OUT_D
         WHERE INVOICE_NO = '346724706215'
       )
;


SELECT CASE SUBSTR(OUT_TYPE_DIV, 1, 2)
            WHEN 'M1' THEN '상온'
            WHEN 'M2' THEN '냉장'
            ELSE '기타'
       END AS TEMP
      ,COUNT(*)
  FROM LO_OUT_M
 GROUP BY CASE SUBSTR(OUT_TYPE_DIV, 1, 2)
            WHEN 'M1' THEN '상온'
            WHEN 'M2' THEN '냉장'
            ELSE '기타'
       END
;

SELECT CASE WHEN ORDER_QTY = 0              THEN '없음'
            WHEN ORDER_QTY BETWEEN 1 AND 10 THEN '소량'
            WHEN ORDER_QTY <= 99            THEN '보통'
            WHEN ITEM_WEIGHT = 1566         THEN '스페셜'
            ELSE '대량'
       END AS AMOUNT
      ,COUNT(DISTINCT ITEM_CD) AS ITEM_CNT
  FROM LO_OUT_D
 GROUP BY CASE WHEN ORDER_QTY = 0           THEN '없음'
            WHEN ORDER_QTY BETWEEN 1 AND 10 THEN '소량'
            WHEN ORDER_QTY <= 99            THEN '보통'
            WHEN ITEM_WEIGHT = 1566         THEN '스페셜'
            ELSE '대량'
       END
;


SELECT CASE TO_CHAR(OUTBOUND_DATE, 'MM') WHEN '01' THEN SET_QTY END AS M01
      ,CASE TO_CHAR(OUTBOUND_DATE, 'MM') WHEN '02' THEN SET_QTY END AS M02
      ,CASE TO_CHAR(OUTBOUND_DATE, 'MM') WHEN '03' THEN SET_QTY END AS M03
      ,CASE TO_CHAR(OUTBOUND_DATE, 'MM') WHEN '04' THEN SET_QTY END AS M04
      ,CASE TO_CHAR(OUTBOUND_DATE, 'MM') WHEN '05' THEN SET_QTY END AS M05
      ,CASE TO_CHAR(OUTBOUND_DATE, 'MM') WHEN '06' THEN SET_QTY END AS M06
      ,CASE TO_CHAR(OUTBOUND_DATE, 'MM') WHEN '07' THEN SET_QTY END AS M07
      ,CASE TO_CHAR(OUTBOUND_DATE, 'MM') WHEN '08' THEN SET_QTY END AS M08
      ,CASE TO_CHAR(OUTBOUND_DATE, 'MM') WHEN '09' THEN SET_QTY END AS M09
      ,CASE TO_CHAR(OUTBOUND_DATE, 'MM') WHEN '10' THEN SET_QTY END AS M10
      ,CASE TO_CHAR(OUTBOUND_DATE, 'MM') WHEN '11' THEN SET_QTY END AS M11
      ,CASE TO_CHAR(OUTBOUND_DATE, 'MM') WHEN '12' THEN SET_QTY END AS M12
  FROM LO_OUT_M
 WHERE OUTBOUND_DATE BETWEEN TO_DATE('20190101', 'YYYY-MM-DD') AND TO_DATE('20191231', 'YYYY-MM-DD')
;


SELECT SUM(CASE TO_CHAR(OUTBOUND_DATE, 'MM') WHEN '01' THEN SET_QTY END) AS M01
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE, 'MM') WHEN '02' THEN SET_QTY END) AS M02
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE, 'MM') WHEN '03' THEN SET_QTY END) AS M03
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE, 'MM') WHEN '04' THEN SET_QTY END) AS M04
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE, 'MM') WHEN '05' THEN SET_QTY END) AS M05
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE, 'MM') WHEN '06' THEN SET_QTY END) AS M06
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE, 'MM') WHEN '07' THEN SET_QTY END) AS M07
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE, 'MM') WHEN '08' THEN SET_QTY END) AS M08
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE, 'MM') WHEN '09' THEN SET_QTY END) AS M09
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE, 'MM') WHEN '10' THEN SET_QTY END) AS M10
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE, 'MM') WHEN '11' THEN SET_QTY END) AS M11
      ,SUM(CASE TO_CHAR(OUTBOUND_DATE, 'MM') WHEN '12' THEN SET_QTY END) AS M12
  FROM LO_OUT_M
 WHERE OUTBOUND_DATE BETWEEN TO_DATE('20190101', 'YYYY-MM-DD') AND TO_DATE('20191231', 'YYYY-MM-DD')
;


-- 출고유형이 M1로 시작하면 상온, M2로 시작하면 저온이라고 표시
SELECT OUTBOUND_DATE
      ,TO_CHAR(OUTBOUND_DATE, 'DY') AS DY
      ,INVOICE_NO
      ,CASE WHEN MOD(LTRIM(INVOICE_NO, '#'), 2) = 0 THEN '짝수' ELSE '홀수' END AS EVENODD
      ,ORDER_NM
      ,CASE SUBSTR(OUT_TYPE_DIV, 1, 2)
            WHEN 'M1' THEN '상온'
            WHEN 'M2' THEN '저온'
       END AS TEMP
  FROM A_OUT_M
;

-- 주문수량이 1~2이면 하, 3~4이면 중, 5이상이면 상으로 표시
SELECT BRAND_CD
      ,INVOICE_NO
      ,LINE_NO
      ,ITEM_CD
      ,ORDER_QTY
      ,CASE WHEN ORDER_QTY BETWEEN '1' AND '2' THEN '하'
            WHEN ORDER_QTY BETWEEN '3' AND '4' THEN '중'
            WHEN ORDER_QTY >= 5                THEN '상'
       END AS GRADE
  FROM A_OUT_D
;

-- 브랜드, 상온/저온 별로 몇 개의 인보이스를 처리했는가
SELECT BRAND_CD
      ,CASE SUBSTR(OUT_TYPE_DIV, 1, 2)
         WHEN 'M1' THEN '상온'
         WHEN 'M2' THEN '저온'
       END AS TEMP
      ,COUNT(*) AS CNT
  FROM A_OUT_M
 GROUP BY BRAND_CD
         ,CASE SUBSTR(OUT_TYPE_DIV, 1, 2)
            WHEN 'M1' THEN '상온'
            WHEN 'M2' THEN '저온'
          END
;

-- 브랜드 & 상/중/하(인보이스 단위의 합계)별로 몇 개의 인보이스를 처리했는가
SELECT BRAND_CD
      ,CASE WHEN ORDER_QTY BETWEEN '1' AND '2' THEN '하'
               WHEN ORDER_QTY BETWEEN '3' AND '4' THEN '중'
               WHEN ORDER_QTY >= 5                THEN '상'
       END AS TEMP
      ,COUNT(*) AS CNT
  FROM A_OUT_D
 GROUP BY BRAND_CD
         ,CASE WHEN ORDER_QTY BETWEEN '1' AND '2' THEN '하'
               WHEN ORDER_QTY BETWEEN '3' AND '4' THEN '중'
               WHEN ORDER_QTY >= 5                THEN '상'
          END
;


SELECT BRAND_CD, INVOICE_NO
      ,SUM(ORDER_QTY) AS SUM_QTY
      ,CASE WHEN SUM(ORDER_QTY) BETWEEN '1' AND '2' THEN '하'
            WHEN SUM(ORDER_QTY) BETWEEN '3' AND '4' THEN '중'
            WHEN SUM(ORDER_QTY) >= 5                THEN '상'
       END AS TEMP
  FROM A_OUT_D
 GROUP BY BRAND_CD
         ,INVOICE_NO
;

SELECT BRAND_CD
      ,CASE WHEN SUM_QTY BETWEEN 1 AND 2 THEN '하'
            WHEN SUM_QTY BETWEEN 3 AND 4 THEN '중'
            ELSE '상'
       END AS GRADE
      ,COUNT(*) AS INV_CNT
  FROM (--1) 브랜드, 인보이스 단위로 주문수량 집계
        SELECT BRAND_CD, INVOICE_NO
              ,SUM(ORDER_QTY) AS SUM_QTY
          FROM A_OUT_D
         GROUP BY BRAND_CD
                 ,INVOICE_NO
       )
 GROUP BY BRAND_CD
         ,CASE WHEN SUM_QTY BETWEEN 1 AND 2 THEN '하'
               WHEN SUM_QTY BETWEEN 3 AND 4 THEN '중'
               ELSE '상'
          END
;


-- 1, 2위는 그대로 살리고 그 이하는 etc로 바꿔서 그룹핑 한다
-- 1단계
SELECT ITEM_CD
      ,SUM(ORDER_QTY) AS SUM_QTY
  FROM A_OUT_D
 GROUP BY ITEM_CD
 ORDER BY SUM_QTY DESC
;

--2단계
SELECT ROWNUM, ITEM_CD, SUM_QTY
      ,CASE WHEN ROWNUM <= 2 THEN ITEM_CD ELSE 'etc' END AS NEW_ITEM
      ,SUM(SUM_QTY)
  FROM (
         SELECT ITEM_CD
               ,SUM(ORDER_QTY) AS SUM_QTY
           FROM A_OUT_D
          GROUP BY ITEM_CD
          ORDER BY SUM_QTY DESC
       )
;
-- 최종
SELECT CASE WHEN ROWNUM <= 2 THEN ITEM_CD ELSE 'etc' END AS NEW_ITEM
      ,SUM(SUM_QTY) AS ORDER_QTY
  FROM (
         SELECT ITEM_CD
               ,SUM(ORDER_QTY) AS SUM_QTY
           FROM A_OUT_D
          GROUP BY ITEM_CD
          ORDER BY SUM_QTY DESC
       )
 GROUP BY CASE WHEN ROWNUM <= 2 THEN ITEM_CD ELSE 'etc' END
;

-- 숙제
-- 1001브랜드의 주문내역을 표시하되, C상품을 가장 먼저 표시하고, 나머지 상품은 상품코드 순으로 나열
-- 동일한 상품에 대해서는 주문수량이 많은 것부터 나열
SELECT BRAND_CD, INVOICE_NO, LINE_NO, ITEM_CD, ORDER_QTY
      ,CASE WHEN ORDER_QTY BETWEEN '1' AND '2' THEN '하'
            WHEN ORDER_QTY BETWEEN '3' AND '4' THEN '중'
            WHEN ORDER_QTY >= 5                THEN '상'
       END AS GRADE
  FROM A_OUT_D
 WHERE BRAND_CD = '1001'
 ORDER BY CASE WHEN ITEM_CD = 'C' THEN TO_CHAR(1)
               ELSE ITEM_CD
          END 
         ,ITEM_CD
         ,ORDER_QTY DESC
;





