/* Copyright (c) Microsoft Corporation.
 Licensed under the MIT license. */

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ControlTable]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ControlTable](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SourceObjectSettings] [nvarchar](max) NULL,
	[SourceConnectionSettingsName] [varchar](max) NULL,
	[CopySourceSettings] [nvarchar](max) NULL,
	[SinkObjectSettings] [nvarchar](max) NULL,
	[SinkConnectionSettingsName] [varchar](max) NULL,
	[CopySinkSettings] [nvarchar](max) NULL,
	[CopyActivitySettings] [nvarchar](max) NULL,
	[TopLevelPipelineName] [varchar](max) NULL,
	[TriggerName] [nvarchar](max) NULL,
	[DataLoadingBehaviorSettings] [nvarchar](max) NULL,
	[TaskId] [int] NULL,
	[CopyEnabled] [bit] NULL,
	[DataContract] [nvarchar](max) NULL,
	[PurviewScanEnabled]  BIT NULL,	
	[ValidFrom] [datetime2](7) GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
	[ValidTo] [datetime2](7) GENERATED ALWAYS AS ROW END HIDDEN NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([ValidFrom], [ValidTo])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON (HISTORY_TABLE = [dbo].[ControlTableHistory])
)

IF NOT EXISTS (SELECT * FROM sys.default_constraints WHERE name = 'DF_ControlTable_PurviewScanEnabled' AND parent_object_id = OBJECT_ID('[dbo].[ControlTable]'))
BEGIN
ALTER TABLE [dbo].[ControlTable] ADD  CONSTRAINT [DF_ControlTable_PurviewScanEnabled]  DEFAULT ((1)) FOR [PurviewScanEnabled]
END

IF NOT EXISTS (SELECT * FROM sys.default_constraints WHERE name = 'DF_ControlTable_ValidFrom' AND parent_object_id = OBJECT_ID('[dbo].[ControlTable]'))
BEGIN
ALTER TABLE [dbo].[ControlTable] ADD  CONSTRAINT [DF_ControlTable_ValidFrom]  DEFAULT (sysutcdatetime()) FOR [ValidFrom]
END

IF NOT EXISTS (SELECT * FROM sys.default_constraints WHERE name = 'DF_ControlTable_ValidTo' AND parent_object_id = OBJECT_ID('[dbo].[ControlTable]'))
BEGIN
ALTER TABLE [dbo].[ControlTable] ADD  CONSTRAINT [DF_ControlTable_ValidTo]  DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59.9999999')) FOR [ValidTo]
END
END
GO

DECLARE @controlTableRecords INTEGER 

SET @controlTableRecords = (SELECT COUNT(*) FROM [dbo].[ControlTable])

IF @controlTableRecords = 0
BEGIN
INSERT INTO [dbo].[ControlTable]
VALUES (
'{ "fileName": "%.zip", "folderPath": "%/%", "container": "landing" }'
,''
,''
,'{ "fileName": null, "folderPath": null, "container": "landing" }'
,''
,''
,''
,'PL_2_Process_Landed_Files_Step2'
,'TR_blobCreatedEvent'
,'{ "dataLoadingBehavior": "Unzip_Zip_Folder" }'
,0
,1
,''
,''
)
END
