USE [NHS_Patient_Flow_BI]
GO

/****** Object:  Table [dw].[DimProvider]    Script Date: 28/10/2026 23:29:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dw].[DimProvider](
	[ProviderKey] [int] IDENTITY(1,1) NOT NULL,
	[ProviderOrgCode] [varchar](50) NOT NULL,
	[ProviderOrgName] [nvarchar](500) NULL,
	[ProviderParentOrgCode] [varchar](50) NULL,
	[ProviderParentName] [nvarchar](500) NULL,
	[CreatedAt] [datetime2](0) NOT NULL,
	[UpdatedAt] [datetime2](0) NULL,
PRIMARY KEY CLUSTERED 
(
	[ProviderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ProviderOrgCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dw].[DimProvider] ADD  DEFAULT (sysutcdatetime()) FOR [CreatedAt]
GO


