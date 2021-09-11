CREATE TABLE [Dimension].[Dates] (
  [DateKey] [int] NOT NULL,
  [Date] [date] NOT NULL,
  [DayOfYear] [smallint] NOT NULL,
  [WeekOfMonth] [tinyint] NOT NULL,
  [WeekOfYear] [tinyint] NOT NULL,
  [Month] [tinyint] NOT NULL,
  [MonthName] [varchar](10) NOT NULL,
  [Quarter] [tinyint] NOT NULL,
  [Year] [int] NOT NULL,
  [MMYYYY] [char](6) NOT NULL,
  [FirstDayOfMonth] [date] NOT NULL,
  [LastDayOfMonth] [date] NOT NULL,
  [FirstDayOfQuarter] [date] NOT NULL,
  [LastDayOfQuarter] [date] NOT NULL,
  [FirstDayOfYear] [date] NOT NULL,
  [LastDayOfYear] [date] NOT NULL,
  [FirstDayOfNextMonth] [date] NOT NULL,
  [FirstDayOfNextYear] [date] NOT NULL,
  [MonthNameUkr] [varchar](20) NULL,
  CONSTRAINT [PK_Dates_DateKey] PRIMARY KEY CLUSTERED ([DateKey])
)
ON [PRIMARY]
GO