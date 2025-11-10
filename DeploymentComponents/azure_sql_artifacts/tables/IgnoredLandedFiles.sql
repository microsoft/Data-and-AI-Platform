/* Copyright (c) Microsoft Corporation.
 Licensed under the MIT license. */


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IgnoredLandedFiles]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IgnoredLandedFiles](
	[filename] [nvarchar](255) NULL,
	[folderpath] [nvarchar](255) NULL,
	[condition] [nvarchar](255) NULL,
	[reason] [nvarchar](1000) NULL
) ON [PRIMARY]
END
GO