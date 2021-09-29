MERGE [dbo].[OsagoPolises] AS [target]
USING(
	
SELECT
    P.ProductId
	, HASHBYTES('SHA2_256', P.PolisNumber) AS HashValue
	, IIF(ISNUMERIC(P.PolisNumber)=1, NULL, LEFT(P.PolisNumber, 2)) AS sagr
    , IIF(ISNUMERIC(P.PolisNumber)=1, P.PolisNumber, SUBSTRING(P.PolisNumber, 4, 7)) AS nagr
    , SAT.RegulatorIdCompl AS [compl]
    , bD.Date AS [d_beg]
    , eD.Date AS [d_end]
    , P.Duration AS [c_term]
    , rD.Date AS [d_distr]
    , PA.IsActive1 AS [is_active1]
    , PA.IsActive2 AS [is_active2]
    , PA.IsActive3 AS [is_active3]
    , PA.IsActive4 AS [is_active4]
    , PA.IsActive5 AS [is_active5]
    , PA.IsActive6 AS [is_active6]
    , PA.IsActive7 AS [is_active7]
    , PA.IsActive8 AS [is_active8]
    , PA.IsActive9 AS [is_active9]
    , PA.IsActive10 AS [is_active10]
    , PA.IsActive11 AS [is_active11]
    , PA.IsActive12 AS [is_active12]
	, COALESCE(Pv.[Value], 0) AS [c_privileg]
	, COALESCE(D.[Value], 0) AS [c_discount]
	, case
        when Z.Value = '1' then '1'
        when Z.Value = '2' then IIF(P.RegisteredDate < 20190921 or P.BasePolisRegisteredDate < 20190921, '6', OS.RegulatorDZone)
        when Z.Value = '2' then IIF(P.RegisteredDate < 20190921 or P.BasePolisRegisteredDate < 20190921, '6', OS.RegulatorDZone)
        when Z.Value = '3' then IIF(P.RegisteredDate < 20190921 or P.BasePolisRegisteredDate < 20190921, '2', '3')
        when Z.Value = '4' then IIF(P.RegisteredDate < 20190921 or P.BasePolisRegisteredDate < 20190921, '3', '4')
        when Z.Value = '5' then IIF(P.RegisteredDate < 20190921 or P.BasePolisRegisteredDate < 20190921, '4', '5')
        when Z.Value = '6' then IIF(P.RegisteredDate < 20190921 or P.BasePolisRegisteredDate < 20190921, '5', '7')
        when Z.Value = '7' then IIF(P.RegisteredDate < 20190921 or P.BasePolisRegisteredDate < 20190921, '7', '')
    end as [zone]
	, IIF(P.RegisteredDate < 20190921 or P.BasePolisRegisteredDate < 20190921, Bm.Class, NULL) AS [b_m]
	, P.C1Value AS K1
	, P.C2Value AS K2
	, P.C3Value AS K3
	, P.C4Value AS K4
	, P.C5Value AS K5
	, P.C6Value AS K6
	, P.C7Value AS K7
	, IIF(P.RegisteredDate < 20190921 or P.BasePolisRegisteredDate < 20190921, NULL, P.C8Value) AS K8 --  null if reg date < 2109
	, P.HealthCover AS [limit_life]
	, P.EstateCover AS [limit_prop]
	, P.Franchise AS [franchise]
	, P.PValue AS [payment]
	, P.RValue AS [paym_bal]
	, B.BranchCode AS [note]
	, CAST(NULL AS DATE) AS [d_abort]
	, CAST(NULL AS DECIMAL(18,2)) AS [retpayment]
	, IIF(ISNUMERIC(P.BasePolisNumber)=1, NULL, LEFT(P.BasePolisNumber, 2)) AS [chng_sagr]
	, IIF(ISNUMERIC(P.BasePolisNumber)=1, P.BasePolisNumber, SUBSTRING(P.BasePolisNumber, 4, 7)) AS [chng_nagr]
	, F.IsResident AS [resident]
	, F.PersonTypeID AS [status_prs]
	, F.FaceIDN AS [numb_ins]
	, CAST(F.Firstname AS NVARCHAR(99)) AS [f_name]
	, CAST(F.Secondname AS NVARCHAR(99)) AS [s_name]
	, F.LastName AS [p_name]
	, F.Birthdate AS [birth_date]
	, '' AS [doc_name]
	, F.PassportSeria AS [doc_series]
	, F.PassportNumber AS [doc_no]
	, F.Gender AS [person_s]
	, cast(IIF(P.RegisteredDate < 20190921 or P.BasePolisRegisteredDate < 20190921, 
				IIF(Z.Value = '7', '3345', ISNULL(RS.RegulatorDCity, '3797')), 
				IIF(Z.Value = '6', '3345', ISNULL(OS.RegulatorDCity, '3797'))) as nvarchar(50)) AS [c_city]
	, IIF(P.RegisteredDate < 20190921 or P.BasePolisRegisteredDate < 20190921, RS.SettlementName, OS.SettlementName) AS [city_name]
	, F.ser_ins AS [ser_ins]
	, F.num_ins AS [num_ins]
	, F.DriverFrom AS [exprn_ins]
	, V.TechDocModel AS [auto] --todo: in Vehicle model
	, V.RegistrationNumber AS [reg_no]
	, V.BodyNumber AS [vin]
	, VT.RegulatorCTypeId AS [c_type]
	, CAST(V.ManufacturerRegulatorID AS NVARCHAR(50)) AS [c_mark]
	, V.Manufacturer AS [mark_txt]
	, CAST(V.ModelRegulatorID AS NVARCHAR(50)) AS [c_model]
	, V.Model AS [model_txt]
	, V.ProducedDate AS [prod_year]
	, P.SphereUse AS [sphere_use]
	, P.NeedTo AS [need_to]
	, P.DateNextTo AS [date_next_to]
	, ET.RegulatorId AS [c_exp]
	, COUNT(P.ProductId) OVER(PARTITION BY P.PolisNumber) AS [ErrorFlag]
	, P.LastModifiedDate AS [LastModifiedDate]

FROM DmartTest.Osago.Products AS P
    LEFT JOIN DmartTest.Osago.SupplementaryAgreementTypes AS SAT ON SAT.SupplementaryAgreementTypeId = P.SupplementaryAgreementTypeId
    LEFT JOIN DmartTest.Dimension.Dates AS bD ON bD.DateKey = P.BeginingDate
    LEFT JOIN DmartTest.Dimension.Dates AS rD ON rD.DateKey = P.RegisteredDate
    LEFT JOIN DmartTest.Dimension.Dates AS eD ON eD.DateKey = P.EndingDate
    INNER JOIN DmartTest.Dimension.ProgramTypes AS PT ON PT.ProgramTypeId = P.ProgramTypeId
    INNER JOIN DmartTest.Dimension.Branches AS B ON P.WhBranchId = B.BranchWhId
    INNER JOIN DmartTest.Osago.Faces AS F ON F.FaceId = P.InsuredFaceId
    INNER JOIN DmartTest.Osago.Vehicles AS V ON V.VehicleId = P.VehicleId
    LEFT JOIN DmartTest.Osago.ParameterActivities AS PA ON PA.ProductId = P.ProductId
    LEFT JOIN DmartTest.Osago.Zones AS Z ON Z.ZoneId = P.ZoneId
    LEFT JOIN DmartTest.Osago.BonusMaluses AS BM ON BM.BonusMalusId = P.BonusMalusId
    LEFT JOIN DmartTest.Osago.Discounts AS D ON D.DiscountId = P.DiscountId
    LEFT JOIN DmartTest.Osago.ExperienceTypes AS ET ON ET.ExperienceTypeId = P.ExperienceTypeId
    LEFT JOIN DmartTest.Osago.Privilegies AS Pv ON Pv.PrivilegId = P.PrivilegId
    LEFT JOIN DmartTest.Osago.VehicleTypes AS VT ON VT.VehicleTypeId = P.VehicleTypeId
    LEFT JOIN DmartTest.Dimension.Settlements AS OS ON OS.SettlementWhId = V.OwnerRegisteredSettlementWhId AND OS.[Current] = 1
    LEFT JOIN DmartTest.Dimension.Settlements AS RS ON RS.SettlementWhId = V.VehiclesRegisteredSettlementWhId AND RS.[Current] = 1
WHERE P.Deleted = 0
	AND NOT (P.PolisNumber like '%/%' AND SAT.RegulatorIdCompl = 4)
	AND ISNUMERIC(P.PolisNumber)!=1
	AND eD.Date >= DATEADD(MM, -2, GETDATE())
	AND P.LocalLoadTime >= (SELECT MAX([LoadedDate]) FROM Dmart.dbo.OsagoPolises)

) AS [source]
ON ([source].HashValue = [target].HashValue)
WHEN MATCHED AND (
		([target].[ProductId] <> [source].[ProductId]) OR
		([target].[compl] <> [source].[compl]) OR
		([target].[d_beg] <> [source].[d_beg]) OR
		([target].[d_end] <> [source].[d_end]) OR
		([target].[c_term] <> [source].[c_term]) OR
		([target].[d_distr] <> [source].[d_distr]) OR
		([target].[is_active1] <> [source].[is_active1]) OR
		([target].[is_active2] <> [source].[is_active2]) OR
		([target].[is_active3] <> [source].[is_active3]) OR
		([target].[is_active4] <> [source].[is_active4]) OR
		([target].[is_active5] <> [source].[is_active5]) OR
		([target].[is_active6] <> [source].[is_active6]) OR
		([target].[is_active7] <> [source].[is_active7]) OR
		([target].[is_active8] <> [source].[is_active8]) OR
		([target].[is_active9] <> [source].[is_active9]) OR
		([target].[is_active10] <> [source].[is_active10]) OR
		([target].[is_active11] <> [source].[is_active11]) OR
		([target].[is_active12] <> [source].[is_active12]) OR
		([target].[c_privileg] <> [source].[c_privileg]) OR
		([target].[c_discount] <> [source].[c_discount]) OR
		([target].[zone] <> [source].[zone]) OR
		([target].[b_m] <> [source].[b_m]) OR
		([target].[K1] <> [source].[K1]) OR
		([target].[K2] <> [source].[K2]) OR
		([target].[K3] <> [source].[K3]) OR
		([target].[K4] <> [source].[K4]) OR
		([target].[K5] <> [source].[K5]) OR
		([target].[K6] <> [source].[K6]) OR
		([target].[K7] <> [source].[K7]) OR
		([target].[K8] <> [source].[K8]) OR
		([target].[limit_life] <> [source].[limit_life]) OR
		([target].[limit_prop] <> [source].[limit_prop]) OR
		([target].[franchise] <> [source].[franchise]) OR
		([target].[payment] <> [source].[payment]) OR
		([target].[note] <> [source].[note]) OR
		([target].[d_abort] <> [source].[d_abort]) OR
		([target].[retpayment] <> [source].[retpayment]) OR
		([target].[chng_sagr] <> [source].[chng_sagr]) OR
		([target].[chng_nagr] <> [source].[chng_nagr]) OR
		([target].[resident] <> [source].[resident]) OR
		([target].[status_prs] <> [source].[status_prs]) OR
		([target].[numb_ins] <> [source].[numb_ins]) OR
		([target].[f_name] <> [source].[f_name]) OR
		([target].[s_name] <> [source].[s_name]) OR
		([target].[p_name] <> [source].[p_name]) OR
		([target].[birth_date] <> [source].[birth_date]) OR
		([target].[doc_name] <> [source].[doc_name]) OR
		([target].[doc_series] <> [source].[doc_series]) OR
		([target].[doc_no] <> [source].[doc_no]) OR
		([target].[person_s] <> [source].[person_s]) OR
		([target].[c_city] <> [source].[c_city]) OR
		([target].[city_name] <> [source].[city_name]) OR
		([target].[ser_ins] <> [source].[ser_ins]) OR
		([target].[num_ins] <> [source].[num_ins]) OR
		([target].[exprn_ins] <> [source].[exprn_ins]) OR
		([target].[auto] <> [source].[auto]) OR
		([target].[reg_no] <> [source].[reg_no]) OR
		([target].[vin] <> [source].[vin]) OR
		([target].[c_type] <> [source].[c_type]) OR
		([target].[c_mark] <> [source].[c_mark]) OR
		([target].[mark_txt] <> [source].[mark_txt]) OR
		([target].[c_model] <> [source].[c_model]) OR
		([target].[model_txt] <> [source].[model_txt]) OR
		([target].[prod_year] <> [source].[prod_year]) OR
		([target].[sphere_use] <> [source].[sphere_use]) OR
		([target].[need_to] <> [source].[need_to]) OR
		([target].[date_next_to] <> [source].[date_next_to]) OR
		([target].[c_exp] <> [source].[c_exp])

)
THEN UPDATE
SET
		[target].[ProductId] = [source].[ProductId],
		[target].[sagr] = [source].[sagr],
		[target].[nagr] = [source].[nagr],
		[target].[compl] = [source].[compl],
		[target].[d_beg] = [source].[d_beg],
		[target].[d_end] = [source].[d_end],
		[target].[c_term] = [source].[c_term],
		[target].[d_distr] = [source].[d_distr],
		[target].[is_active1] = [source].[is_active1],
		[target].[is_active2] = [source].[is_active2],
		[target].[is_active3] = [source].[is_active3],
		[target].[is_active4] = [source].[is_active4],
		[target].[is_active5] = [source].[is_active5],
		[target].[is_active6] = [source].[is_active6],
		[target].[is_active7] = [source].[is_active7],
		[target].[is_active8] = [source].[is_active8],
		[target].[is_active9] = [source].[is_active9],
		[target].[is_active10] = [source].[is_active10],
		[target].[is_active11] = [source].[is_active11],
		[target].[is_active12] = [source].[is_active12],
		[target].[c_privileg] = [source].[c_privileg],
		[target].[c_discount] = [source].[c_discount],
		[target].[zone] = [source].[zone],
		[target].[b_m] = [source].[b_m],
		[target].[K1] = [source].[K1],
		[target].[K2] = [source].[K2],
		[target].[K3] = [source].[K3],
		[target].[K4] = [source].[K4],
		[target].[K5] = [source].[K5],
		[target].[K6] = [source].[K6],
		[target].[K7] = [source].[K7],
		[target].[K8] = [source].[K8],
		[target].[limit_life] = [source].[limit_life],
		[target].[limit_prop] = [source].[limit_prop],
		[target].[franchise] = [source].[franchise],
		[target].[payment] = [source].[payment],
		[target].[paym_bal] = [source].[paym_bal],
		[target].[note] = [source].[note],
		[target].[d_abort] = [source].[d_abort],
		[target].[retpayment] = [source].[retpayment],
		[target].[chng_sagr] = [source].[chng_sagr],
		[target].[chng_nagr] = [source].[chng_nagr],
		[target].[resident] = [source].[resident],
		[target].[status_prs] = [source].[status_prs],
		[target].[numb_ins] = [source].[numb_ins],
		[target].[f_name] = [source].[f_name],
		[target].[s_name] = [source].[s_name],
		[target].[p_name] = [source].[p_name],
		[target].[birth_date] = [source].[birth_date],
		[target].[doc_name] = [source].[doc_name],
		[target].[doc_series] = [source].[doc_series],
		[target].[doc_no] = [source].[doc_no],
		[target].[person_s] = [source].[person_s],
		[target].[c_city] = [source].[c_city],
		[target].[city_name] = [source].[city_name],
		[target].[ser_ins] = [source].[ser_ins],
		[target].[num_ins] = [source].[num_ins],
		[target].[exprn_ins] = [source].[exprn_ins],
		[target].[auto] = [source].[auto],
		[target].[reg_no] = [source].[reg_no],
		[target].[vin] = [source].[vin],
		[target].[c_type] = [source].[c_type],
		[target].[c_mark] = [source].[c_mark],
		[target].[mark_txt] = [source].[mark_txt],
		[target].[c_model] = [source].[c_model],
		[target].[model_txt] = [source].[model_txt],
		[target].[prod_year] = [source].[prod_year],
		[target].[sphere_use] = [source].[sphere_use],
		[target].[need_to] = [source].[need_to],
		[target].[date_next_to] = [source].[date_next_to],
		[target].[c_exp] = [source].[c_exp],
		[target].[ErrorFlag] = [source].[ErrorFlag],
		[target].[LastModifiedDate] = [source].[LastModifiedDate],
		[target].[IsChanged] = coalesce([target].[IsUpLoaded], 0) | coalesce([target].[IsChanged], 0),
		[target].LoadedDate = current_timestamp,
		[target].[IsUpLoaded] = NULL,
		[target].[UploadedError] = NULL
WHEN NOT MATCHED BY TARGET
THEN INSERT
([ProductId]
           ,[HashValue]
           ,[sagr]
           ,[nagr]
           ,[compl]
           ,[d_beg]
           ,[d_end]
           ,[c_term]
           ,[d_distr]
           ,[is_active1]
           ,[is_active2]
           ,[is_active3]
           ,[is_active4]
           ,[is_active5]
           ,[is_active6]
           ,[is_active7]
           ,[is_active8]
           ,[is_active9]
           ,[is_active10]
           ,[is_active11]
           ,[is_active12]
           ,[c_privileg]
           ,[c_discount]
           ,[zone]
           ,[b_m]
           ,[K1]
           ,[K2]
           ,[K3]
           ,[K4]
           ,[K5]
           ,[K6]
           ,[K7]
           ,[K8]
           ,[limit_life]
           ,[limit_prop]
           ,[franchise]
           ,[payment]
           ,[paym_bal]
           ,[note]
           ,[d_abort]
           ,[retpayment]
           ,[chng_sagr]
           ,[chng_nagr]
           ,[resident]
           ,[status_prs]
           ,[numb_ins]
           ,[f_name]
           ,[s_name]
           ,[p_name]
           ,[birth_date]
           ,[doc_name]
           ,[doc_series]
           ,[doc_no]
           ,[person_s]
           ,[c_city]
           ,[city_name]
           ,[ser_ins]
           ,[num_ins]
           ,[exprn_ins]
           ,[auto]
           ,[reg_no]
           ,[vin]
           ,[c_type]
           ,[c_mark]
           ,[mark_txt]
           ,[c_model]
           ,[model_txt]
           ,[prod_year]
           ,[sphere_use]
           ,[need_to]
           ,[date_next_to]
           ,[c_exp]
           ,[ErrorFlag]
           ,[LastModifiedDate]
           ,[LoadedDate]
           ,[IsUpLoaded]
           ,[UploadedError]
           ,[IsChanged])
VALUES
(
 [source].ProductId
,[source].[HashValue]
,[source].[sagr]
,[source].[nagr]
,[source].[compl]
,[source].[d_beg]
,[source].[d_end]
,[source].[c_term]
,[source].[d_distr]
,[source].[is_active1]
,[source].[is_active2]
,[source].[is_active3]
,[source].[is_active4]
,[source].[is_active5]
,[source].[is_active6]
,[source].[is_active7]
,[source].[is_active8]
,[source].[is_active9]
,[source].[is_active10]
,[source].[is_active11]
,[source].[is_active12]
,[source].[c_privileg]
,[source].[c_discount]
,[source].[zone]
,[source].[b_m]
,[source].[K1]
,[source].[K2]
,[source].[K3]
,[source].[K4]
,[source].[K5]
,[source].[K6]
,[source].[K7]
,[source].[K8]
,[source].[limit_life]
,[source].[limit_prop]
,[source].[franchise]
,[source].[payment]
,[source].[paym_bal]
,[source].[note]
,[source].[d_abort]
,[source].[retpayment]
,[source].[chng_sagr]
,[source].[chng_nagr]
,[source].[resident]
,[source].[status_prs]
,[source].[numb_ins]
,[source].[f_name]
,[source].[s_name]
,[source].[p_name]
,[source].[birth_date]
,[source].[doc_name]
,[source].[doc_series]
,[source].[doc_no]
,[source].[person_s]
,[source].[c_city]
,[source].[city_name]
,[source].[ser_ins]
,[source].[num_ins]
,[source].[exprn_ins]
,[source].[auto]
,[source].[reg_no]
,[source].[vin]
,[source].[c_type]
,[source].[c_mark]
,[source].[mark_txt]
,[source].[c_model]
,[source].[model_txt]
,[source].[prod_year]
,[source].[sphere_use]
,[source].[need_to]
,[source].[date_next_to]
,[source].[c_exp]
,[source].[ErrorFlag]
,[source].[LastModifiedDate]
,current_timestamp
,NULL
,NULL
,0
);

