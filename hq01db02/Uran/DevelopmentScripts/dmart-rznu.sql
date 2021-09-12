use Oberon;

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [id]
      ,[claim_id]
      ,[claim_no]
      ,[act_id]
      ,[act_no]
      ,[oa_dataaktaraschet]
      ,[oa_dataakta]
      ,[ext_pkd]
      ,[polis_id]
      ,[prg_id]
      ,[obj_id]
      ,[BranchCode]
      ,[CodeProgramType]
      ,[T1_VIDN]
      ,[T1_komplektidN]
      ,[T1_SerDog]
      ,[T1_NomerDog]
      ,[T1_dataDog]
      ,[T1_dataDogBeg]
      ,[T1_dataDogEnd]
      ,[T1_SumStrah]
      ,[T1_FRANSH]
      ,[T1_StrahName]
      ,[T1_StrahINN]
      ,[T1_StrahTip]
      ,[T1_objname]
      ,[T1_objcomm]
      ,[T1_objGod]
      ,[T1_objVIN]
      ,[T1_RISK]
      ,[T1_dataVidmovy]
      ,[T1_dataZayavy]
      ,[T1_dataPovidStrah]
      ,[T1_dataPovidPoterp]
      ,[T1_dataVypadka]
      ,[T1_countDays]
      ,[oa_dataVymogy]
      ,[T1_dataZayavyPoterp]
      ,[T1_firstZayava]
      ,[T1_Perelik]
      ,[T1_SumZbytka]
      ,[T1_SumZbytkaFull]
      ,[Sum_Zbytka_akt]
      ,[reserv_limit]
      ,[T1_SumVregul]
      ,[T1_SumReservAll]
      ,[TIP]
      ,[flag_PV]
      ,[SDTIP]
      ,[T1_Can_OutRegres]
      ,[osnova]
      ,[ReservDate]
      ,[VehicleTypeGid]
      ,[zonegid]
      ,[Franchise]
      ,[b_m]
      ,[BranchGID]
      ,[BeginingDate]
      ,[T1_ProcVregul]
      ,[n_ord_ic]
  FROM [Dmart].[dbo].[rznu]