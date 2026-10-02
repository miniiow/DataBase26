-- 데이터베이스 7주차

-- 낱개가 있다면 1박스로 싸서 BOX_CNT_TOT로 만들기
SELECT ITEM_CD, QTY_IN_BOX, SUM(ORDER_QTY)
  FROM LO_OUT_D
 WHERE INVOICE_NO BETWEEN '346724706262' AND '346724706762'
 GROUP BY ITEM_CD, QTY_IN_BOX
 ORDER BY SUM(ORDER_QTY) DESC;

SELECT ROWNUM AS RNK
      ,ITEM_CD
      ,QTY_IN_BOX
      ,ORDER_QTY
      ,TRUNC(ORDER_QTY / QTY_IN_BOX) AS BOX_CNT
      ,MOD(ORDER_QTY, QTY_IN_BOX) AS PCS_CNT
      ,CEIL(ORDER_QTY / QTY_IN_BOX) AS BOX_CNT_TOT
  FROM (-- 1) 상품코드/박스입수별 출고수량의 합계 구하기
        SELECT ITEM_CD, QTY_IN_BOX, SUM(ORDER_QTY) AS ORDER_QTY
          FROM LO_OUT_D 
         WHERE INVOICE_NO BETWEEN '346724706262' AND '346724706762'
         GROUP BY ITEM_CD, QTY_IN_BOX
         ORDER BY ORDER_QTY DESC
       )
 WHERE ROWNUM <= 5;


--결과 : (null)
SELECT NULL AS VAL
  FROM DUAL
 WHERE 1=1;
 
-- 결과 : NULLAS > 레코드가 0행임 == 공집합이다
-- 조건에 만족하는 레코드가 없기때문에 SELECT절에 어떤걸 넣어도 아무것도 뜨지 않음
SELECT NULL AS VAL
  FROM DUAL
 WHERE 1=2;


-- 공집합인데 집계함수를 사용하면 레코드가 뜨게 된다
-- GROUP BY절 없이 집계함수를 사용하게 되면 무조건 레코드가 한건이 뜨게 된다
SELECT MAX(NULL)
  FROM DUAL
 WHERE 1 = 2;
 
SELECT MAX(1), SUM(12112)
  FROM DUAL
 WHERE 1 = 2;

SELECT NVL(MAX(NULL), 'HELLO') AS VAL
  FROM DUAL
 WHERE 1 = 2;
 
-- 1001브랜드의 주문내역을 표시하되 출고일자에 해당하는 요일 컬럼을 추가하여 표시
SELECT OUTBOUND_DATE
      ,TO_CHAR(OUTBOUND_DATE, 'DY') AS DY
      ,INVOICE_NO
      ,ORDER_NM
  FROM A_OUT_M
 WHERE BRAND_CD = '1001';

-- 위의 내용에 인보이스 번호가 짝수인지 홀수인지에 대한 컬럼을 추가하여 표시
-- 인보이스 번호에 따라 짝수 홀수 판별하기
SELECT MOD(LTRIM(INVOICE_NO, '#'), 2)
      ,DECODE(MOD(LTRIM(INVOICE_NO, '#'), 2), 0, '짝수', '홀수')
  FROM A_OUT_M;
  
SELECT INVOICE_NO
      ,LTRIM(INVOICE_NO, '#')
      ,MOD(LTRIM(INVOICE_NO, '#'), 2)
      ,CASE WHEN MOD(LTRIM(INVOICE_NO, '#'), 2) = 0 '짝수'
            ELSE '홀수'
       END AS EVENODD
  FROM A_OUT_M;

SELECT OUTBOUND_DATE
      ,TO_CHAR(OUTBOUND_DATE, 'DY') AS DY
      ,INVOICE_NO
      ,DECODE(MOD(LTRIM(INVOICE_NO, '#'), 2), 0, '짝수', '홀수') AS EVENODD
      ,ORDER_NM
  FROM A_OUT_M
 WHERE BRAND_CD = '1001';
 

 
 
 