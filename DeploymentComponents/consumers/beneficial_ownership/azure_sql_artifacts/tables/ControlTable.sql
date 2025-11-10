IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ControlTable]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ControlTable] (
	[id] [int] IDENTITY(1,1) NOT NULL,
    [source_id] [int] NULL,
	[raw_filename] [nvarchar](255) NULL,
	[raw_folderpath] [nvarchar](1000) NULL,
	[processed_to_raw_datetime_utc] [datetime2](7) NULL,
    [processed] INT NULL,
    [processed_datetime_utc] [datetime2](7) NULL
    PRIMARY KEY CLUSTERED ([Id] ASC)
);
END
GO
