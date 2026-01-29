-- =========================================================================
-- Table: DWH.FCT_PRINPUT_LINE_GVA
-- =========================================================================
-- Description: 
--    Captures the specific line-item details for each Purchase Requisition, 
--    including item numbers, quantities, and descriptions.
-- Usage: 
--    Joined with the Header table to provide granular visibility into 
--    requested products and procurement demand planning.
-- =========================================================================

Create or replace TABLE DWH.FCT_PRINPUT_LINE_GVA AS (
 
SELECT
	TRACKING_HASH AS TRACKING_HASH,
	CAST(NULL AS NUMBER(38,0)) AS BC_PRINPUT_LINE_SK,
	CAST(NULL AS VARCHAR(50)) AS BC_CUSTOMER_PR_NUMBER,
	REQUEST_NUMBER AS BC_REQUESTNO,
	ITEM_NUMBER AS ITEM_NUMBER,
	ITEM_REFERENCE AS ITEM_REFERENCE_NUMBER,
	LINE_NUMBER AS LINE_NUMBER,
	DESCRIPTION AS ITEM_DESCRIPTION,
	ITEM_CATEGORY AS ITEM_CATEGORY,
	UOM AS UNIT_OF_MEASURE,
	QUANTITY AS QUANTITY,
	QUANTITY_TO_CONVERT AS QTYTOCONVERT,
	CAST(NULL AS NUMBER(38,6)) AS CS_QUANTITY,
	CAST(NULL AS VARCHAR(50)) AS PROCESS_FLAG,
	SOURCE,
	CURRENT_FLAG,
	STARTDATETIME,
	ENDDATETIME,
	BATCH_ID,
	EXECUTION_TIME,
	CAST(NULL AS DATE) AS BC_PR_DATE,
	CAST(NULL AS VARCHAR(50)) AS DELETED_FLAG
 
FROM DWH.FCT_PRINPUT_LINE_GENEVA
);
 
-- =========================================================================
-- Table: DWH.FCT_PRINPUT_HEADER_GVA
-- =========================================================================
-- Description: 
--    Stores header-level information for Purchase Requisitions (PR) originating 
--    from the Geneva system. This includes requestor details, dates, and 
--    overall PR status.
-- Usage: 
--    Used as the primary source for PR volume analysis and high-level 
--    procurement tracking dashboards.
-- =========================================================================

create or replace TABLE DWH.FCT_PRINPUT_HEADER_GVA AS (
 
SELECT 
	TRACKING_HASH AS TRACKING_HASH,
	CAST(NULL AS NUMBER(38,0)) AS BC_PRINPUT_HEADER_SK,
	REQUEST_NUMBER AS BC_REQUESTNO,
	CAST(NULL AS DATE) AS BC_PR_DATE,
	CUSTOMER_NUMBER AS CUSTOMER_NUMBER,
	CUSTOMER_NAME AS CUSTOMER_NAME,
	CUSTOMER_PR_NUMBER AS BC_CUSTOMER_PR_NUMBER,
	CAST(NULL AS DATE) AS ORDER_DATE,
	PR_CREATION_DATE AS BC_PRINPUT_DATE,
	CAST(NULL AS VARCHAR(200)) AS NIF_NUMBER,
	CITY AS CITY,
	COUNTRY AS COUNTRY,
	CAST(NULL AS VARCHAR(50)) AS STATUS,
	PR_STATUS AS PR_STATUS,
	PR_DESCRIPTION AS PR_DESCRIPTION,
	CAST(NULL AS VARCHAR(50)) AS COUNTRY_DESCRIPTION,
	CAST(NULL AS VARCHAR(50)) AS CATEGORY_MANAGER,
	CAST(NULL AS VARCHAR(50)) AS CLOSED_FLAG,
	CAST(NULL AS DATE) AS ORDER_MONTH,
	ADDRESS AS ADDRESS,
	CAST(NULL AS VARCHAR(50)) AS ADDRESS2,
	PR_CREATION_DATE AS PR_CREATED_DATE,
	CAST(NULL AS TIMESTAMP_NTZ(9)) AS PR_MODIFIED_DATE,
	SOURCE,
	CURRENT_FLAG,
	STARTDATETIME,
	ENDDATETIME,
	BATCH_ID,
	EXECUTION_TIME,
	PR_CREATED_BY AS PR_CREATED_BY,
	CAST(NULL AS VARCHAR(200)) AS PR_MODIFIED_BY,
	CAST(NULL AS VARCHAR(50)) AS DELETED_FLAG
FROM DWH.FCT_PRINPUT_HEADER_GENEVA
);

-- =========================================================================
-- Table: DWH.FCT_COSTINGSHEET_HEADER_GVA
-- =========================================================================
-- Description: 
--    Consolidates header-level financial and logistical data for Costing Sheets.
--    This table maps key fields like Freight Provider, Port of Loading/Discharge, 
--    and Total Freight Costs from the raw Geneva format.
-- Usage: 
--    Essential for Shipment Profitability Reporting and Logistics Cost Analysis.
-- =========================================================================

CREATE OR REPLACE TABLE DWH.FCT_COSTINGSHEET_HEADER_GVA AS (
SELECT
    TRACKING_HASH                                    AS TRACKING_HASH,
    CAST(NULL AS VARCHAR(50))                        AS BC_COSTINGSHEET_HEADER_SK,
    COSTING_SHEET_NO                                 AS BC_COSTINGSHEET_NUMBER,
    CAST(NULL AS VARCHAR(50))                        AS BC_REQUEST_NUMBER,
    PR_NUMBER                                        AS BC_CUSTOMER_PR_NUMBER,
    TRANSPORT_TYPE                                   AS MODE_OF_SHIPMENT,
    "DATE"                                           AS COSTINGSHEET_DATE,
    CAST(NULL AS VARCHAR(50))                        AS CONTAINER_DETAIL,
    NO_OF_CONTAINERS                                 AS NUMBER_OF_CONTAINERS,
    CAST(NULL AS VARCHAR(50))                        AS CONTAINER_TYPE,
    CAST(NULL AS VARCHAR(50))                        AS NUMBER_OF_CONTAINERS2,
    CAST(NULL AS VARCHAR(50))                        AS CONTAINER_TYPE2,
    CAST(NULL AS VARCHAR(50))                        AS SHIPMENT_COUNTRY_CODE,
    SUPPLIER_FREIGHT                                 AS FREIGHT_PROVIDER,
    CAST(NULL AS VARCHAR(50))                        AS PI_CURRENCY,
    PORT_OF_LOADING                                  AS PORT_OF_LOADING,
    LOADING_NAME                                     AS PORT_LOADINGNAME,
    COUNTRY_OF_ORIGIN                                AS ORIGIN_COUNTRY_CODE,
    ORIGIN                                           AS ORIGIN_COUNTRY_DESCRIPTION,
    CAST(NULL AS VARCHAR(50))                        AS SHIPPED_FLAG,
    CAST(NULL AS DATE)                               AS SHIPPED_DATE,
    CUSTOMER_CODE                                    AS BC_CUSTOMER_ID,
    CUSTOMER_NAME                                    AS CUSTOMER_NAME,
    CAST(NULL AS VARCHAR(50))                        AS SHIPMENT_COUNTRY_DESCRIPTION,
    DISCHARGE_PORT                                   AS PORT_OF_DISCHARGE,
    DISCHARGE_PORT_NAME                              AS PORT_DISCHARGENAME,
    CAST(NULL AS DATE)                               AS ORDER_MONTH,
    CAST(NULL AS DATE)                               AS DATE_OF_SHIPMENT,
    CAST(NULL AS DATE)                               AS MONTH_OF_SHIPMENT,
    CAST(NULL AS DATE)                               AS RECEIVED_DATE,
    CATEGORY_MANAGER                                 AS CATEGORY_MANAGER,
    SHIPPING_LINE                                    AS SHIPPING_LINE,
    CAST(NULL AS VARCHAR(50))                        AS DESCRIPTION,
    CAST(NULL AS VARCHAR(50))                        AS SELLING_CURRENCY,
    CAST(NULL AS VARCHAR(50))                        AS BANK_CHARGES_VENDOR,
    CAST(NULL AS VARCHAR(50))                        AS ADDITIONAL_BANK_CHARGES,
    CAST(NULL AS VARCHAR(50))                        AS OTHER_CHARGES,
    CURRENCY_PURCHASE_FREIGHT                        AS FREIGHT_CURRENCY,
    TOTAL_FREIGHT_COST_FREIGHT_CURR                  AS FREIGHT_COST,
    TOTAL_FREIGHT_COST_LCY                           AS FREIGHT_COST2,
    CAST(NULL AS VARCHAR(50))                        AS INCLUDE_CNCACHARGES,
    CAST(NULL AS VARCHAR(50))                        AS SHIPPING_COST,
    CAST(NULL AS VARCHAR(50))                        AS FREIGHT_ADJUSTMENT,
    CAST(NULL AS VARCHAR(50))                        AS ADDITIONAL_FREIGHT_CHARGES,
    CAST(NULL AS VARCHAR(50))                        AS PAYMENT_TERMS_CODE_VENDOR,
    CAST(NULL AS VARCHAR(50))                        AS PETRAMAR_CHARGES,
    PROFIT_MARGIN_AMOUNT_LCY                         AS CS_MARGIN,
    APPROVAL_STATUS                                  AS BC_COSTINGSHEET_STATUS,
    CAST(NULL AS VARCHAR(50))                        AS BC_COSTINGSHEET_COMPLETEDFLAG,
    COSTING_SHEET_STATUS                             AS CS_STAGE,
    SUPPLIER_FOB                                     AS VENDOR_CODE,
    SUPPLIER_FOB_NAME                                AS VENDOR_NAME,
    FORWARD_CONTRACT                                 AS FORWARD_CONTRACT_NUMBER,
    CAST(NULL AS VARCHAR(50))                        AS WDMCC_BANKNAME_VENDOR,
    CAST(NULL AS VARCHAR(50))                        AS PAYMENT_TERMS_CODE_CUSTOMER,
    CAST(NULL AS VARCHAR(50))                        AS PAYMENT_TERMS_DESC_CUSTOMER,
    CAST(NULL AS VARCHAR(50))                        AS WDMCC_BANKNAME_CUSTOMER,
    CAST(NULL AS VARCHAR(50))                        AS BANK_CHARGES_CUSTOMER,
    CAST(NULL AS VARCHAR(50))                        AS RECEIVED,
    CAST(NULL AS VARCHAR(50))                        AS PRODUCT_DESCRIPTION_CODE,
    CAST(NULL AS VARCHAR(50))                        AS PRODUCT_DESCRIPTION,
    CAST(NULL AS VARCHAR(50))                        AS TOTAL_SUPPINVORIGCURR_AMNT,
    CAST(NULL AS VARCHAR(50))                        AS TOTAL_SUPPINVBASECURR_AMNT,
    CAST(NULL AS VARCHAR(50))                        AS MARGIN_TYPE,
    CAST(NULL AS VARCHAR(50))                        AS COSTINGSHEET_VERSION,
    CAST(NULL AS VARCHAR(50))                        AS OTHER_CHARGES_DESCRIPTION,
    CAST(NULL AS TIMESTAMP_NTZ(9))                   AS BC_CS_SYSTEM_CREATED_DATE,
    CAST(NULL AS TIMESTAMP_NTZ(9))                   AS BC_CS_SYSTEM_MODIFIED_DATE,
    SOURCE,
    STARTDATETIME,
    ENDDATETIME,
    CURRENT_FLAG,
    BATCH_ID,
    EXECUTION_TIME,
    CAST(NULL AS VARCHAR(50))                        AS CS_INSURANCE_COST,
    CAST(NULL AS VARCHAR(50))                        AS CS_COURIER_CHARGES,
    CAST(NULL AS VARCHAR(50))                        AS BC_CS_SYSTEM_CREATED_BY,
    CAST(NULL AS VARCHAR(50))                        AS BC_CS_SYSTEM_MODIFIED_BY,
    CAST(NULL AS VARCHAR(50))                        AS EQUIPMENT_TYPE,
    CAST(NULL AS VARCHAR(50))                        AS EQUIPMENT_TYPE_2,
    CAST(NULL AS VARCHAR(50))                        AS DELETED_FLAG
FROM DWH.FCT_COSTINGSHEET_HEADER_GENEVA
);

-- =========================================================================
-- Table: FCT_COSTINGSHEET_LINE_GVA
-- =========================================================================
-- Description: 
--    Stores the detailed breakdown of costs for every item within a Costing Sheet.
--    It calculates and standardizes critical metrics like FOB Cost, CIF Price, 
--    and Margins at the SKU level.
-- Usage: 
--    Used by finance and sales teams to validate unit economics and track 
--    margins per product line.
-- =========================================================================

CREATE OR REPLACE TABLE DWH.FCT_COSTINGSHEET_LINE_GVA AS (
SELECT
    TRACKING_HASH                                    AS TRACKING_HASH,
    CAST(NULL AS VARCHAR(50))                        AS BC_COSTINGSHEET_LINE_SK,
    COSTING_SHEET_NUMBER                             AS BC_COSTINGSHEET_NUMBER,
    COSTING_SHEET_LINE_NUMBER                        AS BC_COSTINGSHEET_LINENUMBER,
    COSTING_SHEET_LINE_ITEM_NUMBER                   AS BC_COSTINGSHEET_ITEM_NUMBER,
    COSTING_SHEET_LINE_REFERENCE_NUMBER              AS BC_COSTINGSHEET_ITEM_REFERENCE_NUMBER,
    COSTING_SHEET_LINE_ITEM_DESCRIPTION              AS BC_COSTINGSHEET_ITEM_DESCRIPTION,
    COSTING_SHEET_LINE_UNIT_OF_MEASURE               AS BC_COSTINGSHEET_SALES_UOM,
    COSTING_SHEET_LINE_UNIT_OF_MEASURE               AS BC_COSTINGSHEET_PURCHASE_UOM,
    CAST(NULL AS VARCHAR(50))                        AS BC_COSTINGSHEET_ITEM_QUANTITY,
    COSTING_SHEET_LINE_PO_REQUIRED                   AS PO_REQUIRED_FLAG,
    COSTING_SHEET_LINE_PO_REQUIRED_VENDOR            AS PO_REQUIRED_VENDORNO,
    COSTING_SHEET_LINE_TOTAL_VALUE_PURCH_CURR        AS PURCHASE_CURRENCY,
    CAST(NULL AS VARCHAR(50))                        AS TOTAL_FOB_COST,
    CAST(NULL AS VARCHAR(50))                        AS TOTAL_FOB_COST_LCY,
    CAST(NULL AS VARCHAR(50))                        AS TOTAL_FOB_PRICE,
    CAST(NULL AS VARCHAR(50))                        AS FOB_COST_UNIT,
    CAST(NULL AS VARCHAR(50))                        AS FOB_COST_UNIT_LCY,
    CAST(NULL AS VARCHAR(50))                        AS EFFECTIVE_FOB_UNIT_LCY,
    COSTING_SHEET_LINE_CIF_UNIT_SALE_CURR            AS CIF_COST_UNIT,
    COSTING_SHEET_LINE_CIF_UNIT_SALE_CURR            AS CIF_PRICE_UNIT,
    CAST(NULL AS VARCHAR(50))                        AS MARGIN_PERCENT,
    CAST(NULL AS VARCHAR(50))                        AS WEIGHTED_MARGIN_PERCENT,
    CAST(NULL AS VARCHAR(50))                        AS STUFFING_PERCENT,
    CAST(NULL AS VARCHAR(50))                        AS FX_RATE,
    CAST(NULL AS VARCHAR(50))                        AS PROCESS_FLAG,
    COSTING_SHEET_LINE_SO_NO                         AS PO_NUMBER,
    CAST(NULL AS VARCHAR(50))                        AS PQ_NUMBER,
    COSTING_SHEET_LINE_PO_NO                         AS SO_NUMBER,
    CAST(NULL AS VARCHAR(50))                        AS FOB_PRICE_UNIT,
    CAST(NULL AS TIMESTAMP_NTZ(9))                   AS BC_CSLN_SYSTEM_CREATED_DATE,
    CAST(NULL AS TIMESTAMP_NTZ(9))                   AS BC_CSLN_SYSTEM_ITEMMODIFIED_DATE,
    SOURCE,
    STARTDATETIME,
    ENDDATETIME,
    CURRENT_FLAG,
    BATCH_ID,
    EXECUTION_TIME,
    CAST(NULL AS VARCHAR(50))                        AS DELETED_FLAG
FROM DWH.FCT_COSTINGSHEET_LINE_GENEVA
);

-- =========================================================================
-- Table: FCT_VESSEL_TRACKING_GVA
-- =========================================================================
-- Description: 
--    Tracks the physical movement of shipments associated with Costing Sheets.
--    It standardizes logistics timestamps (ETD, ETA, Cargo Ready Date) and 
--    vessel details (Vessel Name, BL Number) into a clean schema.
-- Usage: 
--    Used for Logistics Performance reporting, tracking shipment delays, and 
--    monitoring carrier KPIs.
-- =========================================================================

CREATE OR REPLACE TABLE DWH.FCT_VESSEL_TRACKING_GVA AS (
SELECT 
    TRACKING_HASH                                    AS TRACKING_HASH,
    CAST(NULL AS VARCHAR(50))                        AS BC_VESSELTRACKING_SK,
    CAST(NULL AS VARCHAR(50))                        AS VESSEL_TRACKING_NUMBER,
    CAST(NULL AS VARCHAR(50))                        AS BC_REQUESTNO,
    CUSTOMER_PR                                      AS BC_CUSTOMER_PR_NUMBER,
    COSTING_SHEET_NO                                 AS BC_COSTINGSHEET_NUMBER,
    CAST(NULL AS VARCHAR(50))                        AS PORT_LOADINGNAME,
    CAST(NULL AS VARCHAR(50))                        AS PORT_DISCHARGENAME,
    CAST(NULL AS VARCHAR(50))                        AS DESTINATION_COUNTRY_CODE,
    CAST(NULL AS DATE)                               AS ORDER_DATE,
    CAST(NULL AS VARCHAR(50))                        AS LOADING_COUNTRY_CODE,
    DISCHARGE_PORT                                   AS PORT_OF_DISCHARGE,
    CAST(NULL AS VARCHAR(50))                        AS DESTINATION_COUNTRY_NAME,
    CAST(NULL AS VARCHAR(50))                        AS DATE_OF_SHIPMENT,
    NO_OF_CONTAINERS                                 AS NO_OF_CONTAINERS,
    CAST(NULL AS DATE)                               AS SUPPLIER_ETD,
    ETD                                              AS ACTUAL_ETD,
    ETA                                              AS ACTUAL_ETA,
    REQUESTED_ETA                                    AS REQUESTED_ETA,
    CAST(NULL AS DATE)                               AS PROMISED_ETA,
    CAST(NULL AS VARCHAR(50))                        AS BOOKING_REFERENCE_NUMBER,
    SHIPPING_LINE                                    AS SHIPPING_LINE,
    ETA_1ST_TIMESTAMP                                AS CARGO_READY_DATE,
    CAST(NULL AS VARCHAR(50))                        AS BANK_AWB_NUMBER,
    CAST(NULL AS VARCHAR(50))                        AS BANK_REFERENCE_NUMBER,
    CAST(NULL AS VARCHAR(50))                        AS FINAL_SHIPMENT_STATUS,
    CAST(NULL AS VARCHAR(50))                        AS REQUEST_STATUS,
    CAST(NULL AS VARCHAR(50))                        AS NO_OF_PO,
    CAST(NULL AS VARCHAR(50))                        AS FREIGHT_CUSTOMER,
    CAST(NULL AS VARCHAR(50))                        AS MODE_OF_SHIPMENT,
    ETA_2ND_TIMESTAMP                                AS BL_DATE,
    CAST(NULL AS VARCHAR(50))                        AS CNC_TRK_NUMBER,
    CAST(NULL AS DATE)                               AS SHIPMENT_PREALERT_DATE,
    CUSTOMER_DOC_SENT                                AS CUSTOMER_DOC_SENT_DATE,
    TRACKING_AWB_NUMBER                              AS TRACKING_AWB_NUMBER,
    CAST(NULL AS DATE)                               AS CUSTOMER_DOC_RCV_DATE,
    CAST(NULL AS DATE)                               AS CUSTOMER_CLEAR_DATE,
    CAST(NULL AS DATE)                               AS GRN_DATE,
    CAST(NULL AS DATE)                               AS DC_DELIVERY_DATE,
    CAST(NULL AS VARCHAR(50))                        AS VENDOR_INV_NUMBER,
    CAST(NULL AS VARCHAR(50))                        AS SHIPMENT_AWB_NUMBER,
    CAST(NULL AS VARCHAR(50))                        AS SUPPLIER_INCOTERMS,
    CAST(NULL AS VARCHAR(50))                        AS BC_SALESORDER_NUMBER,
    CAST(NULL AS VARCHAR(50))                        AS BC_PO_NUMBER,
    CAST(NULL AS VARCHAR(50))                        AS BC_PROFORMA_NUMBER,
    CAST(NULL AS VARCHAR(50))                        AS BC_SALESORDER_AMOUNT,
    CAST(NULL AS DATE)                               AS BC_SALESORDER_DATE,
    CAST(NULL AS VARCHAR(50))                        AS DULICENSE_NUMBER,
    DU_RECEIVE_DATE                                  AS DU_RECEIVE_DATE,
    CAST(NULL AS DATE)                               AS DU_EXPIRY_DATE,
    CAST(NULL AS VARCHAR(50))                        AS DU_DATE_CALCULATION,
    CAST(NULL AS VARCHAR(50))                        AS BC_CUSTOMER_PO_NUMBER,
    VESSEL_NAME_2ND_TS                               AS BL_NUMBER,
    VESSEL_NAME                                      AS VESSEL_NAME,
    CAST(NULL AS VARCHAR(50))                        AS REQUEST_FOR_INSPECTION_FLAG,
    CAST(NULL AS VARCHAR(50))                        AS INSPECTION_REFERENCE_NUMBER,
    CAST(NULL AS VARCHAR(50))                        AS INSPECTION_STATUS,
    VENDOR_LC                                        AS VENDOR_LC_NUMBER,
    CUSTOMER_LC                                      AS CUSTOMER_LC_NUMBER,
    CURRENCY_PURCHASE_FREIGHT                        AS FREIGHT_CURRENCY,
    CAST(NULL AS VARCHAR(50))                        AS CUSTOMER_INCOTERMS,
    CAST(NULL AS VARCHAR(50))                        AS PAYMENT_TERMS_CODE_CUSTOMER,
    CAST(NULL AS VARCHAR(50))                        AS PAYMENT_DESCRIPTION,
    CAST(NULL AS VARCHAR(50))                        AS LC_TRANS_REFERENCE_NUMBER,
    CAST(NULL AS VARCHAR(50))                        AS LC_AMOUNT,
    CAST(NULL AS DATE)                               AS LC_EXPIRY_DATE,
    CAST(NULL AS VARCHAR(50))                        AS LC_CURRENCY,
    CAST(NULL AS VARCHAR(50))                        AS LC_TYPE,
    CAST(NULL AS VARCHAR(50))                        AS LC_TERM,
    CAST(NULL AS VARCHAR(50))                        AS LC_STATUS,
    CAST(NULL AS DATE)                               AS NEGOTIATION_DATE,
    CAST(NULL AS VARCHAR(50))                        AS LC_CONFIRMATION,
    CAST(NULL AS VARCHAR(50))                        AS LC_DOCUMENT_STATUS,
    CAST(NULL AS DATE)                               AS VENDOR_DOC_SENT_DATE,
    TOTAL_FREIGHT_COST_LCY                           AS FREIGHT_COST,
    CAST(NULL AS VARCHAR(50))                        AS DRAFTAPDATE,
    CAST(NULL AS DATE)                               AS VGM_SUB_DATE,
    CAST(NULL AS DATE)                               AS SI_SUB_DATE,
    CAST(NULL AS VARCHAR(50))                        AS SALESORDER_AMOUNT_LCY,
    CAST(NULL AS VARCHAR(50))                        AS SALESPERSON,
    CAST(NULL AS VARCHAR(50))                        AS VESSELTRACKING_COMMENT1,
    CAST(NULL AS VARCHAR(50))                        AS VESSELTRACKING_COMMENT2,
    CAST(NULL AS VARCHAR(50))                        AS VESSELTRACKING_COMMENT3,
    CAST(NULL AS VARCHAR(50))                        AS VESSELTRACKING_COMMENT4,
    CAST(NULL AS VARCHAR(50))                        AS VESSELTRACKING_VERSION,
    CAST(NULL AS VARCHAR(50))                        AS PRODUCT_DESCRIPTION_CODE,
    CAST(NULL AS VARCHAR(50))                        AS PRODUCT_DESCRIPTION,
    CAST(NULL AS VARCHAR(50))                        AS VESSELTRACKING_BANKNAME,
    CAST(NULL AS VARCHAR(50))                        AS REPORT_LINE_COMMENT,
    CAST(NULL AS VARCHAR(50))                        AS SO_ARCHIVE_NUMBER,
    CAST(NULL AS VARCHAR(50))                        AS PO_ARCHIVE_NUMBER,
    CAST(NULL AS VARCHAR(50))                        AS SO_INV_NUMBER,
    CAST(NULL AS VARCHAR(50))                        AS PO_INV_NUMBER,
    CAST(NULL AS VARCHAR(50))                        AS VENDOR_CODE,
    CAST(NULL AS VARCHAR(50))                        AS VENDOR_NAME,
    CAST(NULL AS VARCHAR(50))                        AS VESSELTRACKING_NOTES,
    CAST(NULL AS TIMESTAMP_NTZ(9))                   AS VT_SYSTEM_CREATED_DATE,
    CAST(NULL AS TIMESTAMP_NTZ(9))                   AS VT_SYSTEM_MODIFIED_DATE,
    SOURCE,
    STARTDATETIME,
    ENDDATETIME,
    CURRENT_FLAG,
    BATCH_ID,
    EXECUTION_TIME,
    CAST(NULL AS DATE)                               AS BOOKING_DATE,
    CAST(NULL AS VARCHAR(50))                        AS CLEANSED_BL_AWB_NUMBER,
    CAST(NULL AS VARCHAR(50))                        AS DELETED_FLAG,
    CAST(NULL AS VARCHAR(50))                        AS DISCHARGED_AT_POD
FROM DWH.FCT_COSTINGSHEET_HEADER_GENEVA
);
