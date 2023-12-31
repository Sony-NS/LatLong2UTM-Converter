 
/****** Object:  UserDefinedFunction [dbo].[ufn_ToRadians]    Script Date: 7/18/2023 1:03:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sony NS
-- Create date: 18-07-2023
-- Description:	convert to Radians
-- =============================================
CREATE FUNCTION [dbo].[ufn_ToRadians](@grad float) 
RETURNS float
AS
BEGIN
  DECLARE @pi float = 3.1415926535897931;
  RETURN @grad * @pi / 180;  
END
