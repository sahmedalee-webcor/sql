
use database scdataanalytics_prod;
CREATE OR REPLACE TABLE DWH.FCT_COSTINGSHEET_HEADER_GVA AS (
SELECT
    TRACKING_HASH                                       AS TRACKING_HASH,
    CAST(NULL AS NUMBER(38,0))                          AS BC_COSTINGSHEET_HEADER_SK,
    COSTING_SHEET_NO                                    AS BC_COSTINGSHEET_NUMBER,
    CAST(NULL AS VARCHAR(20))                           AS BC_REQUEST_NUMBER,
    PR_NUMBER                                           AS BC_CUSTOMER_PR_NUMBER,

    CASE 
        WHEN LOWER(TRANSPORT_TYPE) LIKE '%bulk%' THEN 'BULK' 
        WHEN LOWER(TRANSPORT_TYPE) LIKE '%air%'  THEN 'AIR' 
        WHEN TRANSPORT_TYPE IS NULL OR TRANSPORT_TYPE = '' THEN NULL
        ELSE 'OCEAN' 
    END                                                 AS MODE_OF_SHIPMENT,

    CAST(
        IFF(
            "DATE" = '0001-01-01 00:00:00.000', STARTDATETIME, "DATE") 
            AS DATE
        )                                               AS COSTINGSHEET_DATE,
    TRANSPORT_TYPE                                      AS CONTAINER_DETAIL,
    CAST(NO_OF_CONTAINERS AS NUMBER(38,0))              AS NUMBER_OF_CONTAINERS,

    CASE
        WHEN TRANSPORT_TYPE ILIKE '%DV%'
          OR TRANSPORT_TYPE ILIKE '%RF%'
          OR TRANSPORT_TYPE ILIKE '%RE%'
          OR TRANSPORT_TYPE ILIKE '%FC%'
          OR TRANSPORT_TYPE ILIKE '%HC%'
        THEN
            CASE
                WHEN TRANSPORT_TYPE LIKE '%20%' AND TRANSPORT_TYPE LIKE '%40%' THEN '20''/40'''
                WHEN TRANSPORT_TYPE LIKE '%20%' THEN '20'''
                WHEN TRANSPORT_TYPE LIKE '%40%' THEN '40'''
            END
    END                                                 AS CONTAINER_TYPE,

    CAST(NULL AS NUMBER(38,0))                          AS NUMBER_OF_CONTAINERS2,
    CAST(NULL AS VARCHAR(30))                           AS CONTAINER_TYPE2,
    'SA'                                                AS SHIPMENT_COUNTRY_CODE,
    SUPPLIER_FREIGHT                                    AS FREIGHT_PROVIDER,
    CURRENCY_SALE                                       AS PI_CURRENCY,
    IFF(LOADING_NAME = NULL, LOAD_PORT, LOADING_NAME)   AS PORT_OF_LOADING,
    LOADING_NAME                                        AS PORT_LOADINGNAME,
    COUNTRY_OF_ORIGIN                                   AS ORIGIN_COUNTRY_CODE,
    ORIGIN                                              AS ORIGIN_COUNTRY_DESCRIPTION,
    CAST(PORT_OF_LOADING AS BOOLEAN)                    AS SHIPPED_FLAG,
    CAST(IFF(PORT_OF_LOADING = TRUE, ETD, NULL) AS DATE) 
                                                        AS SHIPPED_DATE,
    CUSTOMER_CODE                                       AS BC_CUSTOMER_ID,
    CUSTOMER_NAME                                       AS CUSTOMER_NAME,
    'Switzerland'                                       AS SHIPMENT_COUNTRY_DESCRIPTION,
    DISCHARGE_PORT_NAME                                 AS PORT_OF_DISCHARGE,
    DISCHARGE_PORT_NAME                                 AS PORT_DISCHARGENAME,

    CASE
        WHEN SHIPPING_YEAR = 0
        OR SHIPPING_MONTH = 0
        THEN '0001-01-01'
        ELSE DATE_FROM_PARTS(SHIPPING_YEAR, SHIPPING_MONTH, 1)
    END                                                 AS ORDER_MONTH,
    CASE
        WHEN SHIPPING_YEAR = 0
        OR SHIPPING_MONTH = 0
        THEN '0001-01-01'
        ELSE DATE_FROM_PARTS(SHIPPING_YEAR, SHIPPING_MONTH, 1)
    END                                                 AS DATE_OF_SHIPMENT,
    CASE
        WHEN SHIPPING_YEAR = 0
        OR SHIPPING_MONTH = 0
        THEN '0001-01-01'
        ELSE DATE_FROM_PARTS(SHIPPING_YEAR, SHIPPING_MONTH, 1)
    END                                                 AS MONTH_OF_SHIPMENT,

    CAST(IFF(PORT_OF_DISCHARGE = TRUE, ETA, NULL) AS DATE) 
                                                        AS RECEIVED_DATE,
    CATEGORY_MANAGER                                    AS CATEGORY_MANAGER,
    SHIPPING_LINE                                       AS SHIPPING_LINE,

    CAST(NULL AS VARCHAR(100))                          AS DESCRIPTION,
    CURRENCY_SALE                                       AS SELLING_CURRENCY,
    CAST(NULL AS NUMBER(38,6))                          AS BANK_CHARGES_VENDOR,
    CAST(TOTAL_INTERESTS_LCY AS NUMBER(38,6))           AS ADDITIONAL_BANK_CHARGES,
    CAST(TOTAL_CNCA_COST_LCY AS NUMBER(38,6))           AS OTHER_CHARGES,
    CURRENCY_PURCHASE_FREIGHT                           AS FREIGHT_CURRENCY,
    CAST(TOTAL_FREIGHT_COST_LCY AS NUMBER(38,6))        AS FREIGHT_COST,
    CAST(NULL AS NUMBER(38,6))                          AS FREIGHT_COST2,
    CAST(NULL AS BOOLEAN)                               AS INCLUDE_CNCACHARGES,
    CAST(NULL AS NUMBER(38,6))                          AS SHIPPING_COST,
    CAST(NULL AS NUMBER(38,6))                          AS FREIGHT_ADJUSTMENT,
    CAST(NULL AS NUMBER(38,6))                          AS ADDITIONAL_FREIGHT_CHARGES,

    SUPPLIER_FOB_PAYMENT_TERM                           AS PAYMENT_TERMS_CODE_VENDOR,
    CAST(NULL AS NUMBER(38,6))                          AS PETRAMAR_CHARGES,
    CAST(PROFIT_MARGIN_PERCENT AS NUMBER(38,6))         AS CS_MARGIN,
    APPROVAL_STATUS                                     AS BC_COSTINGSHEET_STATUS,
    CAST(NULL AS BOOLEAN)                               AS BC_COSTINGSHEET_COMPLETEDFLAG,
    COSTING_SHEET_STATUS                                AS CS_STAGE,
    SUPPLIER_FOB                                        AS VENDOR_CODE,
    SUPPLIER_FOB_NAME                                   AS VENDOR_NAME,
    FORWARD_CONTRACT                                    AS FORWARD_CONTRACT_NUMBER,

    CAST(NULL AS VARCHAR(30))                           AS WDMCC_BANKNAME_VENDOR,
    CUSTOMER_PAYMENT_TERMS_CODE                         AS PAYMENT_TERMS_CODE_CUSTOMER,
    CUSTOMER_PAYMENT_TERM                               AS PAYMENT_TERMS_DESC_CUSTOMER,
    CAST(NULL AS VARCHAR(30))                           AS WDMCC_BANKNAME_CUSTOMER,
    CAST(NULL AS NUMBER(38,6))                          AS BANK_CHARGES_CUSTOMER,
    CAST(NULL AS BOOLEAN)                               AS RECEIVED,

    CAST(NULL AS VARCHAR(50))                           AS PRODUCT_DESCRIPTION_CODE,
    CAST(NULL AS VARCHAR(150))                          AS PRODUCT_DESCRIPTION,

    CAST(TOTAL_PROD_PURCH_COST_LCY AS NUMBER(38,6))     AS TOTAL_SUPPINVORIGCURR_AMNT,
    CAST(TOTAL_PROD_PURCH_COST_LCY AS NUMBER(38,6))     AS TOTAL_SUPPINVBASECURR_AMNT,

    CAST(NULL AS VARCHAR(20))                           AS MARGIN_TYPE,
    CAST(NULL AS VARCHAR(5))                            AS COSTINGSHEET_VERSION,
    CAST(NULL AS VARCHAR(70))                           AS OTHER_CHARGES_DESCRIPTION,

    CAST('1900-01-01 00:00:00' AS TIMESTAMP_NTZ(9))                      AS BC_CS_SYSTEM_CREATED_DATE,
    CAST('1900-01-01 00:00:00' AS TIMESTAMP_NTZ(9))                      AS BC_CS_SYSTEM_MODIFIED_DATE,

    SOURCE,
    STARTDATETIME,
    ENDDATETIME,
    CURRENT_FLAG,
    BATCH_ID,
    EXECUTION_TIME,

    CAST(TOTAL_INSURANCE_FEES_LCY AS NUMBER(32,6))      AS CS_INSURANCE_COST,
    CAST(DELIVERY_COSTS_LCY AS NUMBER(32,6))            AS CS_COURIER_CHARGES,

    SYSTEM_CREATED_BY                                   AS BC_CS_SYSTEM_CREATED_BY,
    SYSTEM_MODIFIED_BY                                  AS BC_CS_SYSTEM_MODIFIED_BY,

    CASE
        WHEN TRANSPORT_TYPE LIKE '%RF%' OR TRANSPORT_TYPE LIKE '%RE%' THEN 'REEF'
        WHEN TRANSPORT_TYPE LIKE '%DV%' OR TRANSPORT_TYPE LIKE '%HC%' THEN 'DRY'
    END                                                 AS EQUIPMENT_TYPE,

    CAST(NULL AS VARCHAR(100))                          AS EQUIPMENT_TYPE_2,
    CAST(FALSE AS BOOLEAN)                              AS DELETED_FLAG
FROM DWH.FCT_COSTINGSHEET_HEADER_GENEVA
WHERE CURRENT_FLAG = 1
  AND COSTING_SHEET_NO NOT LIKE 'T%'
);


CREATE OR REPLACE TABLE DWH.FCT_COSTINGSHEET_LINE_GVA AS (
SELECT
    L.TRACKING_HASH                                     AS TRACKING_HASH,
    CAST(NULL AS NUMBER)                                AS BC_COSTINGSHEET_LINE_SK,
    L.COSTING_SHEET_NUMBER                              AS BC_COSTINGSHEET_NUMBER,
    L.COSTING_SHEET_LINE_NUMBER                         AS BC_COSTINGSHEET_LINENUMBER,
    L.COSTING_SHEET_LINE_ITEM_NUMBER                    AS BC_COSTINGSHEET_ITEM_NUMBER,
    L.COSTING_SHEET_LINE_REFERENCE_NUMBER               AS BC_COSTINGSHEET_ITEM_REFERENCE_NUMBER,
    L.COSTING_SHEET_LINE_ITEM_DESCRIPTION               AS BC_COSTINGSHEET_ITEM_DESCRIPTION,
    L.COSTING_SHEET_LINE_UNIT_OF_MEASURE                AS BC_COSTINGSHEET_SALES_UOM,
    L.COSTING_SHEET_LINE_PR_UOM                         AS BC_COSTINGSHEET_PURCHASE_UOM,
    L.COSTING_SHEET_LINE_ACTUAL_QUANTITY                AS BC_COSTINGSHEET_ITEM_QUANTITY,
    L.COSTING_SHEET_LINE_PO_REQUIRED                    AS PO_REQUIRED_FLAG,
    L.COSTING_SHEET_LINE_PO_REQUIRED_VENDOR             AS PO_REQUIRED_VENDORNO,
    H.CURRENCY_PURCHASE_CARGO                           AS PURCHASE_CURRENCY,
    L.COSTING_SHEET_LINE_TOTAL_VALUE_PURCH_CURR         AS TOTAL_FOB_COST,
    L.COSTING_SHEET_LINE_TOTAL_VALUE_PURCH_CURR         AS TOTAL_FOB_COST_LCY,
    (
        L.COSTING_SHEET_LINE_CIF_UNIT_SALE_CURR - 
        H.TOTAL_EXPENSES_PER_UNIT_PURCH_CURR
    )*L.COSTING_SHEET_LINE_ACTUAL_QUANTITY              AS TOTAL_FOB_PRICE,
    DIV0(
        L.COSTING_SHEET_LINE_TOTAL_VALUE_PURCH_CURR,
        L.COSTING_SHEET_LINE_ACTUAL_QUANTITY
    )                                                   AS FOB_COST_UNIT,
    DIV0(
        L.COSTING_SHEET_LINE_TOTAL_VALUE_PURCH_CURR,
        L.COSTING_SHEET_LINE_ACTUAL_QUANTITY
    )                                                   AS FOB_COST_UNIT_LCY,
    CAST(NULL AS NUMBER)                                AS EFFECTIVE_FOB_UNIT_LCY,
    (
        1-DIV0(H.PROFIT_MARGIN_PERCENT,100)
    )*L.COSTING_SHEET_LINE_CIF_UNIT_SALE_CURR           AS CIF_COST_UNIT,
    L.COSTING_SHEET_LINE_CIF_UNIT_SALE_CURR             AS CIF_PRICE_UNIT,
    H.PROFIT_MARGIN_PERCENT                             AS MARGIN_PERCENT,
    CAST(NULL AS VARCHAR(50))                           AS WEIGHTED_MARGIN_PERCENT,
    CAST(NULL AS VARCHAR(50))                           AS STUFFING_PERCENT,
    CAST(NULL AS VARCHAR(50))                           AS FX_RATE,
    CAST(NULL AS VARCHAR(50))                           AS PROCESS_FLAG,
    L.COSTING_SHEET_LINE_PO_NO                          AS PO_NUMBER,
    CAST(NULL AS VARCHAR(50))                           AS PQ_NUMBER,
    L.COSTING_SHEET_LINE_SO_NO                          AS SO_NUMBER,
    (
        L.COSTING_SHEET_LINE_CIF_UNIT_SALE_CURR-
        H.TOTAL_EXPENSES_PER_UNIT_PURCH_CURR
    )                                                   AS FOB_PRICE_UNIT,
    L.COSTING_SHEET_LINE_SYSTEMCREATEDAT                AS BC_CSLN_SYSTEM_CREATED_DATE,
    L.COSTING_SHEET_LINE_SYSTEMMODIFIEDAT               AS BC_CSLN_SYSTEM_ITEMMODIFIED_DATE,
    L.SOURCE,
    L.STARTDATETIME,
    L.ENDDATETIME,
    L.CURRENT_FLAG,
    L.BATCH_ID,
    L.EXECUTION_TIME,
    CAST(FALSE AS BOOLEAN)                              AS DELETED_FLAG
FROM DWH.FCT_COSTINGSHEET_LINE_GENEVA L
LEFT JOIN DWH.FCT_COSTINGSHEET_HEADER_GENEVA H
    ON L.COSTING_SHEET_NUMBER = H.COSTING_SHEET_NO
    AND H.CURRENT_FLAG = 1
WHERE L.CURRENT_FLAG = 1
  AND L.COSTING_SHEET_NUMBER NOT LIKE 'T%'
);


CREATE OR REPLACE TABLE DWH.FCT_VESSEL_TRACKING_GVA AS (
SELECT 
    TRACKING_HASH                                       AS TRACKING_HASH,
    CAST(NULL AS NUMBER(38,0))                          AS BC_VESSELTRACKING_SK,
    COSTING_SHEET_NO                                    AS VESSEL_TRACKING_NUMBER,
    CAST(NULL AS VARCHAR(20))                           AS BC_REQUESTNO,
    CUSTOMER_PR                                         AS BC_CUSTOMER_PR_NUMBER,
    COSTING_SHEET_NO                                    AS BC_COSTINGSHEET_NUMBER,
    LOADING_NAME                                        AS PORT_LOADINGNAME,
    DISCHARGE_PORT_NAME                                 AS PORT_DISCHARGENAME,
    'SA'                                                AS DESTINATION_COUNTRY_CODE,    
    CASE
        WHEN SHIPPING_YEAR = 0
        OR SHIPPING_MONTH = 0
        THEN '0001-01-01'
        ELSE DATE_FROM_PARTS(SHIPPING_YEAR, SHIPPING_MONTH, 1)
    END                                                 AS ORDER_DATE,
    COUNTRY_OF_ORIGIN                                   AS LOADING_COUNTRY_CODE,
    DISCHARGE_PORT_NAME                                 AS PORT_OF_DISCHARGE,
    'Switzerland'                                       AS DESTINATION_COUNTRY_NAME,   
    CASE
        WHEN SHIPPING_YEAR = 0
        OR SHIPPING_MONTH = 0
        THEN '0001-01-01'
        ELSE DATE_FROM_PARTS(SHIPPING_YEAR, SHIPPING_MONTH, 1)
    END                                                 AS DATE_OF_SHIPMENT,
    CAST(NO_OF_CONTAINERS AS NUMBER(38,0))              AS NO_OF_CONTAINERS,       
    CASE
        WHEN SHIPPING_YEAR = 0
        OR SHIPPING_MONTH = 0
        THEN '0001-01-01'
        ELSE DATE_FROM_PARTS(SHIPPING_YEAR, SHIPPING_MONTH, 1)
    END                                                 AS SUPPLIER_ETD,
    CAST(ETD AS DATE)                                   AS ACTUAL_ETD,
    CAST(ETA AS DATE)                                   AS ACTUAL_ETA,
    CAST(REQUESTED_ETA AS DATE)                         AS REQUESTED_ETA,
    CAST(NULL AS DATE)                                  AS PROMISED_ETA,
    VESSEL_NAME_1ST_TS                                  AS BOOKING_REFERENCE_NUMBER,
    SHIPPING_LINE                                       AS SHIPPING_LINE,
    CAST(ETA_1ST_TIMESTAMP AS DATE)                     AS CARGO_READY_DATE,
    CAST(NULL AS VARCHAR(20))                           AS BANK_AWB_NUMBER,
    BANK                                                AS BANK_REFERENCE_NUMBER,
    CAST(NULL AS VARCHAR(20))                           AS FINAL_SHIPMENT_STATUS,
    APPROVAL_STATUS                                     AS REQUEST_STATUS,
    CAST(NULL AS NUMBER(38,0))                          AS NO_OF_PO,
    SUPPLIER_FREIGHT                                    AS FREIGHT_CUSTOMER,

    CASE 
        WHEN LOWER(TRANSPORT_TYPE) LIKE '%bulk%' THEN 'BULK' 
        WHEN LOWER(TRANSPORT_TYPE) LIKE '%air%'  THEN 'AIR' 
        WHEN TRANSPORT_TYPE IS NULL OR TRANSPORT_TYPE = '' THEN NULL
        ELSE 'OCEAN' 
    END                                                 AS MODE_OF_SHIPMENT,

    CAST(ETA_2ND_TIMESTAMP AS DATE)                     AS BL_DATE,
    CAST(NULL AS VARCHAR(20))                           AS CNC_TRK_NUMBER,
    CAST(NULL AS DATE)                                  AS SHIPMENT_PREALERT_DATE,
    CAST(CUSTOMER_DOC_SENT AS DATE)                     AS CUSTOMER_DOC_SENT_DATE,
    TRACKING_AWB_NUMBER                                 AS TRACKING_AWB_NUMBER,
    CAST(NULL AS DATE)                                  AS CUSTOMER_DOC_RCV_DATE,
    CAST(NULL AS DATE)                                  AS CUSTOMER_CLEAR_DATE,
    CAST(IFF(PORT_OF_DISCHARGE = TRUE, ETA, NULL) AS DATE)
                                                        AS GRN_DATE,
    CAST(NULL AS DATE)                                  AS DC_DELIVERY_DATE,
    CAST(NULL AS VARCHAR(250))                          AS VENDOR_INV_NUMBER,
    CAST(NULL AS VARCHAR(30))                           AS SHIPMENT_AWB_NUMBER,
    INCOTERMS_PURCHASE                                  AS SUPPLIER_INCOTERMS,
    CAST(NULL AS VARCHAR(20))                           AS BC_SALESORDER_NUMBER,
    CAST(NULL AS VARCHAR(20))                           AS BC_PO_NUMBER,
    CAST(NULL AS VARCHAR(20))                           AS BC_PROFORMA_NUMBER,
    CAST(TOTAL_OPERATION_LCY AS NUMBER(38,6))           AS BC_SALESORDER_AMOUNT,
    CAST(NULL AS DATE)                                  AS BC_SALESORDER_DATE,
    VESSEL_NAME_3RD_TS                                  AS DULICENSE_NUMBER,
    CAST(DU_RECEIVE_DATE AS DATE)                       AS DU_RECEIVE_DATE,
    CAST(ETA_3RD_TIMESTAMP AS DATE)                     AS DU_EXPIRY_DATE,
    CAST(NULL AS VARCHAR(10))                           AS DU_DATE_CALCULATION,
    CAST(NULL AS VARCHAR(50))                           AS BC_CUSTOMER_PO_NUMBER,
    VESSEL_NAME_2ND_TS                                  AS BL_NUMBER,
    VESSEL_NAME                                         AS VESSEL_NAME,
    PORT_OF_LOADING                                     AS REQUEST_FOR_INSPECTION_FLAG,
    CAST(NULL AS VARCHAR(30))                           AS INSPECTION_REFERENCE_NUMBER,
    CAST(NULL AS VARCHAR(100))                          AS INSPECTION_STATUS,
    VENDOR_LC                                           AS VENDOR_LC_NUMBER,
    CUSTOMER_LC                                         AS CUSTOMER_LC_NUMBER,
    CURRENCY_PURCHASE_FREIGHT                           AS FREIGHT_CURRENCY,
    INCOTERMS_SALE                                      AS CUSTOMER_INCOTERMS,
    CUSTOMER_PAYMENT_TERMS_CODE                         AS PAYMENT_TERMS_CODE_CUSTOMER,
    CUSTOMER_PAYMENT_TERM                               AS PAYMENT_DESCRIPTION,
    CAST(NULL AS VARCHAR(20))                           AS LC_TRANS_REFERENCE_NUMBER,
    CAST(NULL AS NUMBER(38,6))                          AS LC_AMOUNT,
    CAST(NULL AS DATE)                                  AS LC_EXPIRY_DATE,
    CAST(NULL AS VARCHAR(5))                            AS LC_CURRENCY,
    CAST(NULL AS VARCHAR(10))                           AS LC_TYPE,
    CAST(NULL AS VARCHAR(100))                          AS LC_TERM,
    CAST(NULL AS VARCHAR(20))                           AS LC_STATUS,
    CAST(NULL AS DATE)                                  AS NEGOTIATION_DATE,
    CAST(NULL AS VARCHAR(50))                           AS LC_CONFIRMATION,
    CAST(NULL AS VARCHAR(50))                           AS LC_DOCUMENT_STATUS,
    CAST(NULL AS DATE)                                  AS VENDOR_DOC_SENT_DATE,
    CAST(TOTAL_FREIGHT_COST_LCY AS NUMBER(38,6))        AS FREIGHT_COST,
    CAST(NULL AS DATE)                                  AS DRAFTAPDATE,
    CAST(NULL AS DATE)                                  AS VGM_SUB_DATE,
    CAST(NULL AS DATE)                                  AS SI_SUB_DATE,
    CAST(TOTAL_OPERATION_LCY AS NUMBER(38,6))           AS SALESORDER_AMOUNT_LCY,
    CAST(NULL AS VARCHAR(20))                           AS SALESPERSON,
    CAST(NULL AS VARCHAR(100))                          AS VESSELTRACKING_COMMENT1,
    CAST(NULL AS VARCHAR(100))                          AS VESSELTRACKING_COMMENT2,
    CAST(NULL AS VARCHAR(100))                          AS VESSELTRACKING_COMMENT3,
    CAST(NULL AS VARCHAR(100))                          AS VESSELTRACKING_COMMENT4,
    CAST(NULL AS VARCHAR(5))                            AS VESSELTRACKING_VERSION,
    CAST(NULL AS VARCHAR(100))                          AS PRODUCT_DESCRIPTION_CODE,
    CAST(NULL AS VARCHAR(150))                          AS PRODUCT_DESCRIPTION,
    CAST(NULL AS VARCHAR(30))                           AS VESSELTRACKING_BANKNAME,
    CAST(NULL AS VARCHAR(100))                          AS REPORT_LINE_COMMENT,
    CAST(NULL AS VARCHAR(20))                           AS SO_ARCHIVE_NUMBER,
    CAST(NULL AS VARCHAR(20))                           AS PO_ARCHIVE_NUMBER,
    CAST(NULL AS VARCHAR(20))                           AS SO_INV_NUMBER,
    CAST(NULL AS VARCHAR(20))                           AS PO_INV_NUMBER,
    SUPPLIER_FOB                                        AS VENDOR_CODE,
    SUPPLIER_FOB_NAME                                   AS VENDOR_NAME,
    CAST(NULL AS VARCHAR(16777216))                     AS VESSELTRACKING_NOTES,
    CAST('1900-01-01 00:00:00' AS TIMESTAMP_NTZ(9))                      AS VT_SYSTEM_CREATED_DATE,
    CAST('1900-01-01 00:00:00' AS TIMESTAMP_NTZ(9))                      AS VT_SYSTEM_MODIFIED_DATE,
    SOURCE,
    STARTDATETIME,
    ENDDATETIME,
    CURRENT_FLAG,
    BATCH_ID,
    EXECUTION_TIME,
    CAST('1900-01-01 00:00:00' AS TIMESTAMP_NTZ(9))     AS BOOKING_DATE,
    CAST(NULL AS VARCHAR(16777216))                     AS CLEANSED_BL_AWB_NUMBER,
    CAST(FALSE AS BOOLEAN)                              AS DELETED_FLAG,
    PORT_OF_DISCHARGE                                   AS DISCHARGED_AT_POD
FROM DWH.FCT_COSTINGSHEET_HEADER_GENEVA
WHERE CURRENT_FLAG = 1
  AND COSTING_SHEET_NO NOT LIKE 'T%'
);




CREATE OR REPLACE TABLE DWH.FCT_PRINPUT_HEADER_GVA AS(
SELECT 
    CAST(TRACKING_HASH AS NUMBER(38,0))                 AS TRACKING_HASH,
    CAST(NULL AS NUMBER(38,0))                          AS BC_PRINPUT_HEADER_SK,
    REQUEST_NUMBER                                      AS BC_REQUESTNO,
    CAST(PR_CREATION_DATE AS DATE)                      AS BC_PR_DATE,
    CUSTOMER_NUMBER                                     AS CUSTOMER_NUMBER,
    CUSTOMER_NAME                                       AS CUSTOMER_NAME,
    CUSTOMER_PR_NUMBER                                  AS BC_CUSTOMER_PR_NUMBER,
    CAST(SUBMISSION_DATE AS DATE)                       AS ORDER_DATE,
    CAST(DOCUMENT_DATE AS DATE)                         AS BC_PRINPUT_DATE,
    CAST(NULL AS VARCHAR(200))                          AS NIF_NUMBER,
    CITY                                                AS CITY,
    COUNTRY                                             AS COUNTRY,
    CAST(NULL AS VARCHAR(10))                           AS STATUS,
    PR_STATUS                                           AS PR_STATUS,
    PR_DESCRIPTION                                      AS PR_DESCRIPTION,
    CAST(NULL AS VARCHAR(50))                           AS COUNTRY_DESCRIPTION,
    CAST(NULL AS VARCHAR(30))                           AS CATEGORY_MANAGER,
    CAST(NULL AS VARCHAR(10))                           AS CLOSED_FLAG,
    DATE_TRUNC('MONTH', SUBMISSION_DATE)                AS ORDER_MONTH,
    ADDRESS                                             AS ADDRESS,
    CAST(NULL AS VARCHAR(70))                           AS ADDRESS2,
    CAST(SYSTEM_CREATED_AT AS TIMESTAMP_TZ(9))          AS PR_CREATED_DATE,
    CAST(SYSTEM_MODIFIED_AT AS TIMESTAMP_TZ(9))         AS PR_MODIFIED_DATE,
    SOURCE,
    CURRENT_FLAG,
    STARTDATETIME,
    ENDDATETIME,
    BATCH_ID,
    CAST(EXECUTION_TIME AS VARCHAR(70))                 AS EXECUTION_TIME,
    PR_CREATED_BY                                       AS PR_CREATED_BY,
    CAST(PR_CREATED_BY AS VARCHAR(200))                 AS PR_MODIFIED_BY,
    CAST(FALSE AS BOOLEAN)                              AS DELETED_FLAG
FROM DWH.FCT_PRINPUT_HEADER_GENEVA
WHERE CURRENT_FLAG = 1
);

SELECT * FROM DWH.FCT_PRINPUT_LINE_GENEVA;

Create or replace TABLE DWH.FCT_PRINPUT_LINE_GVA AS (
SELECT
    CAST(L.TRACKING_HASH AS NUMBER(38,0))        AS TRACKING_HASH,
    CAST(NULL AS NUMBER(38,0))                   AS BC_PRINPUT_LINE_SK,
    CAST(H.CUSTOMER_PR_NUMBER AS VARCHAR(50))    AS BC_CUSTOMER_PR_NUMBER,
    L.REQUEST_NUMBER                             AS BC_REQUESTNO,
    L.ITEM_NUMBER                                AS ITEM_NUMBER,
    L.ITEM_REFERENCE                             AS ITEM_REFERENCE_NUMBER,
    CAST(L.LINE_NUMBER AS NUMBER(38,0))          AS LINE_NUMBER,
    L.DESCRIPTION                                AS ITEM_DESCRIPTION,
    L.ITEM_CATEGORY                              AS ITEM_CATEGORY,
    L.UOM                                        AS UNIT_OF_MEASURE,
    CAST(L.QUANTITY AS NUMBER(38,6))             AS QUANTITY,
    CAST(L.QUANTITY_TO_CONVERT AS NUMBER(38,6))  AS QTYTOCONVERT,
    CAST(NULL AS NUMBER(38,6))                   AS CS_QUANTITY,
    CAST(NULL AS BOOLEAN)                        AS PROCESS_FLAG,
    L.SOURCE,
    L.CURRENT_FLAG,
    L.STARTDATETIME,
    L.ENDDATETIME,
    L.BATCH_ID,
    L.EXECUTION_TIME,
    CAST(H.PR_CREATION_DATE AS DATE)                           AS BC_PR_DATE,
    CAST(FALSE AS BOOLEAN)                       AS DELETED_FLAG
FROM DWH.FCT_PRINPUT_LINE_GENEVA L
LEFT JOIN DWH.FCT_PRINPUT_HEADER_GENEVA H
    ON L.REQUEST_NUMBER = H.REQUEST_NUMBER
   AND H.CURRENT_FLAG = 1
WHERE L.CURRENT_FLAG = 1
);
