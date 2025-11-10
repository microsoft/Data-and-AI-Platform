/* Copyright (c) Microsoft Corporation.
 Licensed under the MIT license. */


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IngestionServiceAudit]') AND type in (N'U'))
BEGIN
CREATE TABLE dbo.IngestionServiceAudit (
    Id INT IDENTITY(1,1)
    ,LogDateTime DATETIME DEFAULT GETDATE()
    ,HttpRequest NVARCHAR(MAX)
    ,AuditMessage NVARCHAR(255)
    ,MetaDataInserted BIT
);
END
GO

