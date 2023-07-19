  
/****** Object:  UserDefinedFunction [dbo].[ufn_ToDegree]    Script Date: 7/18/2023 1:05:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sony NS
-- Create date: 18-07-2023
-- Description:	convert to degree
-- =============================================
CREATE FUNCTION dbo.ufn_ToDegree(@rad float) 
RETURNS float
AS
BEGIN
  DECLARE @pi float = 3.1415926535897931;
  RETURN @rad / @pi * 180;
END
GO

