 
/****** Object:  UserDefinedFunction [dbo].[ufn_GetUtmLetterDesignator]    Script Date: 7/18/2023 1:06:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sony NS
-- Create date: 18-07-2023
-- Description:	UtmLetterDesignator
-- =============================================
CREATE FUNCTION [dbo].[ufn_GetUtmLetterDesignator](@Latitude float) 
RETURNS nvarchar(5)
AS
BEGIN
  DECLARE @result nvarchar(5)
  
  IF ((84 >= @Latitude) AND (@Latitude >= 72))
     SET @result = 'X'
  ELSE IF ((72 > @Latitude) AND (@Latitude >= 64))
     SET @result = 'W'
  ELSE IF ((64 > @Latitude) AND (@Latitude >= 56))
     SET @result = 'V'
  ELSE IF ((56 > @Latitude) AND (@Latitude >= 48))
     SET @result = 'U'
  ELSE IF ((48 > @Latitude) AND (@Latitude >= 40))
     SET @result = 'T'
  ELSE IF ((40 > @Latitude) AND (@Latitude >= 32))
     SET @result = 'S'
  ELSE IF ((32 > @Latitude) AND (@Latitude >= 24))
     SET @result = 'R'
  ELSE IF ((24 > @Latitude) AND (@Latitude >= 16))
     SET @result = 'Q'
  ELSE IF ((16 > @Latitude) AND (@Latitude >= 8))
     SET @result = 'P'
  ELSE IF ((8 > @Latitude) AND (@Latitude >= 0))
     SET @result = 'N'
  ELSE IF ((0 > @Latitude) AND (@Latitude >= -8))
     SET @result = 'M'
  ELSE IF ((-8 > @Latitude) AND (@Latitude >= -16))
     SET @result = 'L'
  ELSE IF ((-16 > @Latitude) AND (@Latitude >= -24))
     SET @result = 'K'
  ELSE IF ((-24 > @Latitude) AND (@Latitude >= -32))
     SET @result = 'J'
  ELSE IF ((-32 > @Latitude) AND (@Latitude >= -40))
     SET @result = 'H'
  ELSE IF ((-40 > @Latitude) AND (@Latitude >= -48))
     SET @result = 'G'
  ELSE IF ((-48 > @Latitude) AND (@Latitude >= -56))
     SET @result = 'F'
  ELSE IF ((-56 > @Latitude) AND (@Latitude >= -64))
     SET @result = 'E'
  ELSE IF ((-64 > @Latitude) AND (@Latitude >= -72))
     SET @result = 'D'
  ELSE IF ((-72 > @Latitude) AND (@Latitude >= -80))
     SET @result = 'C'
  ELSE
     SET @result = 'Z'
  
  RETURN @result
END

GO
