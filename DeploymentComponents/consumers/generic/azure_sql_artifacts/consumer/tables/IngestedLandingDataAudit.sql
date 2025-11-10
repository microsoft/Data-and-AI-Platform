SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IngestedLandingDataAudit]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IngestedLandingDataAudit](
	[id] [int] NULL,
	[source_filename] [nvarchar](255) NULL,
	[source_folderpath] [nvarchar](1000) NULL,
	[source_file_md5_hash] [nvarchar](1000) NULL,
	[destination_filename] [nvarchar](255) NULL,
	[destination_folderpath] [nvarchar](1000) NULL,
	[ingestion_status] [nvarchar](100) NULL,
	[pipeline_trigger] [nvarchar](255) NULL,
	[event_start_datetime_utc] [datetime2](7) NULL,
	[event_end_datetime_utc] [datetime2](7) NULL,
	[control_table_record_id] int,
	[pipeline_id] [nvarchar](255) NULL
) ON [PRIMARY]
END
GO
