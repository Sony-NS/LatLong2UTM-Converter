
/****** Object:  UserDefinedFunction [dbo].[ufn_ConvertLatLongToUTM]    Script Date: 7/19/2023 8:43:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sony NS
-- Create date: 19-07-2023
-- Description:	convert Long Lat to UTM
-- =============================================
CREATE FUNCTION dbo.[ufn_ConvertLatLongToUTM](@Longitude float, @Latitude float, @datumName nvarchar(100))
RETURNS @UTMResult TABLE (
  Easting float,
  UTMEasting float,
  Northing float,
  UTMNorthing float,
  ZoneNumber int,
  ZoneLetter nvarchar(50)
)
AS
BEGIN 
  DECLARE @acc float, @eccSquared float, @zoneNumber int, @longTemp float, 
    @latRad float, @longRad float
	 
  -- Set Ellipsoid
  SELECT @acc = a,
	     @eccSquared = eccSquared
  FROM dbo.ufn_SetEllipsoid(@datumName) 
   
  IF (@acc IS NULL AND @eccSquared IS NULL)
     RETURN

  SET @longTemp = @Longitude
  SET @latRad = dbo.ufn_ToRadians(@Latitude)
  SET @longRad = dbo.ufn_toRadians(@longTemp)

  IF (@longTemp >= 8 AND @longTemp <= 13 AND @Latitude > 54.5 AND @Latitude < 58)
  BEGIN
    SET @zoneNumber = 32;
  END ELSE 
  IF (@Latitude >= 56.0 AND @Latitude < 64.0 AND @longTemp >= 3.0 AND @longTemp < 12.0)
  BEGIN
    SET @zoneNumber = 32;
  END ELSE
  BEGIN
    SET @zoneNumber = CAST((((@longTemp + 180) / 6) + 1) AS int)

    IF (@Latitude >= 72.0 AND @Latitude < 84.0)
    BEGIN
      IF (@longTemp >= 0.0 AND @longTemp < 9.0)
      BEGIN
        SET @zoneNumber = 31
      END ELSE
	  IF (@longTemp >= 9.0 AND @longTemp < 21.0)
      BEGIN
        SET @zoneNumber = 33
      END ELSE 
	  IF (@longTemp >= 21.0 AND @longTemp < 33.0)
      BEGIN
        SET @zoneNumber = 35
      END ELSE 
	  IF (@longTemp >= 33.0 AND @longTemp < 42.0)
      BEGIN
        SET @zoneNumber = 37
      END
    END
  END

  DECLARE @longOrigin float, @longOriginRad float, @UTMZone nvarchar(5), @eccPrimeSquared float,
    @N float, @T float, @C float, @A float, @M float, @UTMEasting float, @UTMNorthing float

  SET @longOrigin = (@zoneNumber - 1) * 6 - 180 + 3 --+3 puts origin in middle of zone
  SET @longOriginRad = dbo.ufn_ToRadians(@longOrigin)

  SET @UTMZone = dbo.ufn_GetUtmLetterDesignator(@Latitude)

  SET @eccPrimeSquared = (@eccSquared) / (1 - @eccSquared)

  SET @N = @acc / Sqrt(1 - @eccSquared * Sin(@latRad) * Sin(@latRad))
  SET @T = Tan(@latRad) * Tan(@latRad)
  SET @C = @eccPrimeSquared * Cos(@latRad) * Cos(@latRad)
  SET @A = Cos(@latRad) * (@longRad - @longOriginRad)

  SET @M = @acc * ((1 - @eccSquared / 4 - 3 * @eccSquared * @eccSquared / 64 - 5 * @eccSquared * @eccSquared * @eccSquared / 256) * @latRad
                    - (3 * @eccSquared / 8 + 3 * @eccSquared * @eccSquared / 32 + 45 * @eccSquared * @eccSquared * @eccSquared / 1024) * Sin(2 * @latRad)
                    + (15 * @eccSquared * @eccSquared / 256 + 45 * @eccSquared * @eccSquared * @eccSquared / 1024) * Sin(4 * @latRad)
                    - (35 * @eccSquared * @eccSquared * @eccSquared / 3072) * Sin(6 * @latRad));

  SET @UTMEasting = 0.9996 * @N * (@A + (1 - @T + @C) * @A * @A * @A / 6
                    + (5 - 18 * @T + @T * @T + 72 * @C - 58 * @eccPrimeSquared) * @A * @A * @A * @A * @A / 120)
                    + 500000.0;

  SET @UTMNorthing = 0.9996 * (@M + @N * Tan(@latRad) * (@A * @A / 2 + (5 - @T + 9 * @C + 4 * @C * @C) * @A * @A * @A * @A / 24
                    + (61 - 58 * @T + @T * @T + 600 * @C - 330 * @eccPrimeSquared) * @A * @A * @A * @A * @A * @A / 720));

            if (@Latitude < 0)
                SET @UTMNorthing += 10000000.0;

  INSERT INTO @UTMResult ( 
    Easting, 
	Northing,
	UTMEasting,
	UTMNorthing, 
	ZoneNumber,
	ZoneLetter
  ) 
  VALUES(
    @UTMEasting,
	@UTMNorthing,
	@UTMEasting,
	@UTMNorthing,
	@zoneNumber,
	@UTMZone
  )
  RETURN
END

GO
