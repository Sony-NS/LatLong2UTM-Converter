 
/****** Object:  UserDefinedFunction [dbo].[ufn_SetEllipsoid]    Script Date: 7/19/2023 8:26:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sony NS
-- Create date: 19-07-2023
-- Description:	Set Ellipsoid
-- =============================================
CREATE FUNCTION [dbo].[ufn_SetEllipsoid](@datumName nvarchar(100)) 
RETURNS @tmpTable TABLE (
  a float,
  eccSquared float
)
AS
BEGIN
  DECLARE @a float, @eccSquared float
  
  IF (@datumName = 'Airy') 
  BEGIN
	SET @a = 6377563
	SET @eccSquared = 0.00667054
  END ELSE
  IF (@datumName = 'Australian National')
  BEGIN
    SET @a = 6378160;
    SET @eccSquared = 0.006694542
  END ELSE
  IF (@datumName = 'Bessel 1841')
  BEGIN
    SET @a = 6377397;
    SET @eccSquared = 0.006674372
  END ELSE
  IF (@datumName = 'Bessel 1841 Nambia')
  BEGIN
    SET @a = 6377484;
    SET @eccSquared = 0.006674372
  END ELSE
  IF (@datumName = 'Clarke 1866')
  BEGIN
    SET @a = 6378206;
    SET @eccSquared = 0.006768658
  END ELSE
  IF (@datumName = 'Clarke 1880')
  BEGIN
    SET @a = 6378249;
    SET @eccSquared = 0.006803511
  END ELSE
  IF (@datumName = 'Everest')
  BEGIN
    SET @a = 6377276;
    SET @eccSquared = 0.006637847
  END ELSE
  IF (@datumName = 'Fischer 1960 Mercury')
  BEGIN
    SET @a = 6378166;
    SET @eccSquared = 0.006693422
  END ELSE
  IF (@datumName = 'Fischer 1968')
  BEGIN
    SET @a = 6378150;
    SET @eccSquared = 0.006693422
  END ELSE
  IF (@datumName = 'GRS 1967')
  BEGIN
    SET @a = 6378160;
    SET @eccSquared = 0.006694605
  END ELSE
  IF (@datumName = 'GRS 1980')
  BEGIN
    SET @a = 6378137;
    SET @eccSquared = 0.00669438
  END ELSE
  IF (@datumName = 'Helmert 1906')
  BEGIN
    SET @a = 6378200;
    SET @eccSquared = 0.006693422
  END ELSE
  IF (@datumName = 'Hough')
  BEGIN
    SET @a = 6378270;
    SET @eccSquared = 0.00672267
  END ELSE
  IF (@datumName = 'International')
  BEGIN
    SET @a = 6378388;
    SET @eccSquared = 0.00672267
  END ELSE
  IF (@datumName = 'Krassovsky')
  BEGIN
    SET @a = 6378245;
    SET @eccSquared = 0.006693422
  END ELSE
  IF (@datumName = 'Modified Airy')
  BEGIN
    SET @a = 6377340;
    SET @eccSquared = 0.00667054
  END ELSE
  IF (@datumName = 'Modified Everest')
  BEGIN
    SET @a = 6377304;
    SET @eccSquared = 0.006637847
  END ELSE
  IF (@datumName = 'Modified Fischer 1960')
  BEGIN
    SET @a = 6378155;
    SET @eccSquared = 0.006693422
  END ELSE
  IF (@datumName = 'South American 1969')
  BEGIN
    SET @a = 6378160;
    SET @eccSquared = 0.006694542
  END ELSE
  IF (@datumName = 'WGS 60')
  BEGIN
    SET @a = 6378165;
    SET @eccSquared = 0.006693422
  END ELSE
  IF (@datumName = 'WGS 66')
  BEGIN
    SET @a = 6378145;
    SET @eccSquared = 0.006694542
  END ELSE
  IF (@datumName = 'WGS 72')
  BEGIN
    SET @a = 6378135;
    SET @eccSquared = 0.006694318
  END ELSE
  IF (@datumName = 'ED50')
  BEGIN
    SET @a = 6378388;
    SET @eccSquared = 0.00672267
  END ELSE -- International Ellipsoid
  IF (@datumName = 'WGS 84' OR
      @datumName = 'EUREF89' OR -- Max deviation from WGS 84 is 40 cm/km see http://ocq.dk/euref89 (in danish)
      @datumName = 'ETRS89') -- Same as EUREF89 
  BEGIN
    SET @a = 6378137;
    SET @eccSquared = 0.00669438
  END
  
  INSERT INTO @tmpTable (
    a,
	eccSquared
  )
  VALUES(
    @a,
	@eccSquared
  )

  RETURN
END

GO
