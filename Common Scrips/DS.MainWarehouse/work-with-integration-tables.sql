EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Stage.Branches'
EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Stage.Coefficients'
EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Stage.Contracts'
EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Stage.Covers'
EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Stage.Faces'
EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Stage.FranchiseParameters'
EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Stage.Franchises'
EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Stage.InsuranceObjects'
EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Stage.PaymentPeriods'
EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Stage.PlanedPayments'
EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Stage.PlanedToRealPayments'
EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Stage.ProductCancelActs'
EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Stage.ProductCancels'
EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Stage.Products'
EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Stage.ProductToProductPermissions'
EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Stage.Programs'
EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Stage.ProgramToParameterValues'
EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Stage.RealPayments'
EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Stage.Signers'



/* ==================================================================================== */
-- LOADING GUIDELINE 
-- Sample code for loading HUB, SATELLITE, LINK Tables  
-- HUB : 

 

INSERT INTO customer_hub (cust#,load_dts,record_src) 
SELECT source.customer#, @load_dts, @record_src 
FROM source_customer  AS source  
WHERE  
NOT EXISTS  
(SELECT * FROM customer_hub AS hub WHERE hub.customer#=source.customer#) 

-- LINK : 

 

INSERT INTO  custcontact_link(cust_id,contact_id,load_dts, record_src) 
SELECT source.customer#, @load_dts, @record_src 
FROM source_table  AS source  
INNER JOIN contact_hub AS contact ON  contact. contact#= source.contact# 
INNER JOIN customer_hub AS cust ON cust. customer#= source.customer# 
WHERE 
  NOT EXISTS (
    SELECT * FROM custcontact_link AS link
    WHERE link. contact_id= contact.id 
      and 	link.cust_id= cust.id
      ) 

-- SATELLITE : 

 

INSERT INTO customer_sat (hub_id,load_dts, name,record_src) 
SELECT hub.id, @load_dts, source.cust_name, @record_src 
FROM source_customer  AS source
INNER JOIN customer_hub AS hub ON cust.customer#= source.customer#
INNER JOIN customer_sat AS sat ON sat.id= hub.id# AND sat “Is most recent” AND sat.name <> source.name 




--
-- Создать таблицу [Hub].[RealPayments]
--
CREATE TABLE Hub.RealPayments (
  HubRealPaymentId bigint IDENTITY,
  RealPaymentGid uniqueidentifier NOT NULL,
  SourceRecordId int NOT NULL,
  LoadDateTime datetime2 NOT NULL,
  CONSTRAINT PK_RealPayments_HubRealPaymentId PRIMARY KEY CLUSTERED (HubRealPaymentId)
)
