# LatLong2UTM Converter
Konversi nilai longitude latitude ke UTM pada SQl Server
hasil konversi dari code C#: https://github.com/owaremx/LatLngUTMConverter

untuk pemanggilan fungsi dapat dilakukan seperti berikut ini:
SELECT Easting, Northing, ZoneNumber, ZoneLetter
FROM dbo.ufn_ConvertLatLongToUTM(117.25220795522252, -0.68165135452675907, 'WGS 84')
