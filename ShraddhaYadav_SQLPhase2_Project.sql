-- UK Air Quality Monitoring Sites (500 rows) - SQL Phase 2 Project
-- Author: Shraddha Yadav
-- This script creates the table, inserts all 500 rows, creates views, and includes all 75 queries.
SET NOCOUNT ON;
GO
-- Table for the 500-row UK Air Sites dataset
-- Main table used by all 75 queries.

-- Drop dependent views first so the script can be re-run safely.
IF OBJECT_ID('dbo.vw_zone_summary_500', 'V') IS NOT NULL DROP VIEW dbo.vw_zone_summary_500;
IF OBJECT_ID('dbo.vw_environment_summary_500', 'V') IS NOT NULL DROP VIEW dbo.vw_environment_summary_500;
IF OBJECT_ID('dbo.vw_site_lifecycle_500', 'V') IS NOT NULL DROP VIEW dbo.vw_site_lifecycle_500;
IF OBJECT_ID('dbo.vw_identifier_quality_500', 'V') IS NOT NULL DROP VIEW dbo.vw_identifier_quality_500;
GO

IF OBJECT_ID('dbo.ShraddhaYadav_UK_AIR_Sites_500', 'U') IS NOT NULL
    DROP TABLE dbo.ShraddhaYadav_UK_AIR_Sites_500;
GO

CREATE TABLE dbo.ShraddhaYadav_UK_AIR_Sites_500 (
    id INT NOT NULL PRIMARY KEY,
    uk_air_id NVARCHAR(20) NOT NULL,
    eu_site_id NVARCHAR(30) NOT NULL,
    emep_site_id NVARCHAR(30) NOT NULL,
    site_name NVARCHAR(100) NOT NULL,
    environment_type NVARCHAR(50) NOT NULL,
    zone NVARCHAR(80) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    latitude DECIMAL(9,6) NOT NULL,
    longitude DECIMAL(9,6) NOT NULL,
    northing DECIMAL(12,2) NOT NULL,
    easting DECIMAL(12,2) NOT NULL,
    altitude_m DECIMAL(10,2) NOT NULL,
    networks NVARCHAR(MAX) NOT NULL,
    site_description NVARCHAR(MAX) NOT NULL
);
GO

CREATE INDEX IX_UK_AIR_Sites_500_Zone ON dbo.ShraddhaYadav_UK_AIR_Sites_500(zone);
CREATE INDEX IX_UK_AIR_Sites_500_Environment ON dbo.ShraddhaYadav_UK_AIR_Sites_500(environment_type);
CREATE INDEX IX_UK_AIR_Sites_500_Dates ON dbo.ShraddhaYadav_UK_AIR_Sites_500(start_date, end_date);
GO

-- Insert all 500 rows.
-- Data is inserted with INSERT statements so the types stay correct.

INSERT INTO dbo.ShraddhaYadav_UK_AIR_Sites_500 (
    id, uk_air_id, eu_site_id, emep_site_id, site_name, environment_type, zone,
    start_date, end_date, latitude, longitude, northing, easting, altitude_m,
    networks, site_description
)
VALUES
    (1, N'UKA15910', N'Not Available', N'Not Available', N'SH15 SH20 SH25 Verran Road', N'Urban Traffic', N'South East', '2003-03-01', '2003-10-01', 51.322247, -0.743709, 158876.00, 487639.00, 71.02, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (2, N'UKA15956', N'Not Available', N'Not Available', N'SH15 SH22 SH25 Air Quality Machine Bisley', N'Urban Traffic', N'South East', '2003-08-01', '2005-06-01', 51.320938, -0.630890, 158871.00, 495503.00, 49.90, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (3, N'UKA13340', N'Not Available', N'Not Available', N'ABERDARE 1N', N'Urban Traffic', N'South Wales', '1992-12-29', '2000-11-28', 51.712306, -3.447338, 202500.00, 300100.00, 135.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (4, N'UKA13341', N'Not Available', N'Not Available', N'ABERDARE 2N', N'Urban Traffic', N'South Wales', '1992-12-29', '1997-12-30', 51.712431, -3.437210, 202500.00, 300800.00, 120.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (5, N'UKA00399', N'GB0729A', N'Not Available', N'Aberdeen', N'Urban Background', N'North East Scotland', '1999-09-18', '2021-09-20', 57.157360, -2.094278, 807391.98, 394395.80, 20.00, N'Automatic Urban and Rural Monitoring Network (AURN)', N'The monitoring station is within a self-contained air conditioned housing located in an open area of ground within a housing development. The city centre is approximately 1 kilometre from the site and Aberdeen beach is around 500m away. The nearest main road the A956 is 70m away.'),
    (6, N'UKA13343', N'Not Available', N'Not Available', N'ABERDEEN 2N', N'Urban Traffic', N'North East Scotland', '1992-12-29', '2000-11-28', 57.135927, -2.110659, 805000.00, 393400.00, 80.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (7, N'UKA00513', N'GB0923A', N'Not Available', N'Aberdeen Union Street Roadside', N'Urban Traffic', N'North East Scotland', '2008-01-01', '2024-12-31', 57.144555, -2.106472, 805967.60, 393655.92, 26.00, N'Automatic Urban and Rural Monitoring Network (AURN); UK Urban NO2 Network', N'The monitoring station is within a small self-contained housing located on the north side of the A9013 Union Street near the junction with Bon Accord Street. This location is within a busy commercial area. The monitoring station is located approximately 3 metres from the kerb.'),
    (8, N'UKA15197', N'Not Available', N'Not Available', N'ABERGAVENNY 1N', N'Urban Traffic', N'South Wales', '1999-12-31', '2003-12-30', 51.822032, -3.015570, 214200.00, 330100.00, 57.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (9, N'UKA15198', N'Not Available', N'Not Available', N'ABERGAVENNY 2N', N'Urban Traffic', N'South Wales', '1999-12-31', '2000-11-28', 51.821596, -3.064891, 214200.00, 326700.00, 80.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (10, N'UKA15199', N'Not Available', N'Not Available', N'ABERGAVENNY 3N', N'Urban Traffic', N'South Wales', '1999-12-31', '2001-12-04', 51.812156, -3.013897, 213100.00, 330200.00, 60.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (11, N'UKA13347', N'Not Available', N'Not Available', N'ABERYSTWYTH 2N', N'Urban Traffic', N'South Wales', '1992-12-29', '2000-11-28', 52.414968, -4.080466, 281700.00, 258600.00, 5.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (12, N'UKA14829', N'Not Available', N'Not Available', N'ABERYSTWYTH 4N', N'Urban Traffic', N'South Wales', '1996-12-31', '1997-12-30', 52.413940, -4.087770, 281600.00, 258100.00, 5.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (13, N'UKA14669', N'Not Available', N'Not Available', N'ABINGDON 2N', N'Urban Traffic', N'South East', '1994-12-31', '2000-11-28', 51.671364, -1.279817, 197200.00, 449900.00, 54.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (14, N'UKA13351', N'Not Available', N'Not Available', N'ACCRINGTON 2N', N'Urban Traffic', N'North West & Merseyside', '1992-12-29', '2000-11-28', 53.754943, -2.385186, 428800.00, 374700.00, 120.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (15, N'UKA00136', N'Not Available', N'Not Available', N'Achanarras', N'Rural Background', N'Highland', '1986-05-27', '2005-12-28', 58.474600, -3.457928, 954963.06, 315067.38, 98.00, N'UKEAP: Precip-Net; UKEAP: Rural NO2', N'Not Available'),
    (16, N'UKA13353', N'Not Available', N'Not Available', N'ADDLESTONE 2N', N'Urban Traffic', N'South East', '1992-12-29', '2000-11-28', 51.369844, -0.491559, 164500.00, 505100.00, 16.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (17, N'UKA13354', N'Not Available', N'Not Available', N'AIRDRIE 1N', N'Urban Traffic', N'Central Scotland', '1992-12-29', '2010-01-06', 55.867640, -3.981532, 665600.00, 276100.00, 132.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (18, N'UKA14526', N'Not Available', N'Not Available', N'ALLOA 2N', N'Urban Traffic', N'Central Scotland', '1993-12-31', '1994-11-29', 56.116023, -3.781957, 692900.00, 289300.00, 20.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (19, N'UKA14528', N'Not Available', N'Not Available', N'ALLOA 5N', N'Urban Traffic', N'Central Scotland', '1993-12-31', '1994-11-29', 56.111463, -3.786571, 692400.00, 289000.00, 5.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (20, N'UKA13358', N'Not Available', N'Not Available', N'ALLOA 7N', N'Urban Traffic', N'Central Scotland', '1992-12-29', '2000-11-28', 56.116898, -3.783606, 693000.00, 289200.00, 20.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (21, N'UKA13359', N'Not Available', N'Not Available', N'ALLOA 8N', N'Urban Traffic', N'Central Scotland', '1992-12-29', '1994-11-29', 56.111483, -3.781721, 692400.00, 289300.00, 10.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (22, N'UKA13361', N'Not Available', N'Not Available', N'ALNWICK 2N', N'Urban Traffic', N'North East', '1992-12-29', '1994-11-29', 55.406051, -1.693605, 612500.00, 419500.00, 65.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (23, N'UKA13362', N'Not Available', N'Not Available', N'ALNWICK 3N', N'Urban Traffic', N'North East', '1992-12-29', '2008-01-30', 55.411473, -1.706198, 613100.00, 418700.00, 70.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (24, N'UKA14758', N'Not Available', N'Not Available', N'ALNWICK 6N', N'Urban Traffic', N'North East', '1995-12-31', '2000-11-28', 55.413263, -1.703026, 613300.00, 418900.00, 55.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (25, N'UKA00088', N'Not Available', N'Not Available', N'Altnaheglish Reservoir', N'Rural Background', N'Northern Ireland', '1986-01-07', '1990-01-31', 54.888879, -6.898548, 565900.00, 86000.00, 244.00, N'UKEAP: Precip-Net', N'Not Available'),
    (26, N'UKA14529', N'Not Available', N'Not Available', N'ALTON 2N', N'Urban Traffic', N'South East', '1993-12-31', '1994-11-29', 51.147593, -0.977762, 139200.00, 471600.00, 110.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (27, N'UKA14530', N'Not Available', N'Not Available', N'ALTON 4N', N'Urban Traffic', N'South East', '1993-12-31', '1994-11-29', 51.149354, -0.973434, 139400.00, 471900.00, 120.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (28, N'UKA14531', N'Not Available', N'Not Available', N'ALTON 5N', N'Urban Traffic', N'South East', '1993-12-31', '2004-06-02', 51.004248, -0.936732, 123300.00, 474700.00, 50.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (29, N'UKA14532', N'Not Available', N'Not Available', N'ALTON 6N', N'Urban Traffic', N'South East', '1993-12-31', '2000-11-28', 51.006085, -0.940966, 123500.00, 474400.00, 50.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (30, N'UKA13365', N'Not Available', N'Not Available', N'AMMANFORD 1N', N'Urban Traffic', N'South Wales', '1992-12-29', '2000-11-28', 51.792526, -3.987882, 212300.00, 263000.00, 38.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (31, N'UKA13366', N'Not Available', N'Not Available', N'AMMANFORD 2N', N'Urban Traffic', N'South Wales', '1992-12-29', '2000-11-28', 51.791579, -3.990740, 212200.00, 262800.00, 38.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (32, N'UKA13367', N'Not Available', N'Not Available', N'AMMANFORD 3N', N'Urban Traffic', N'South Wales', '1992-12-29', '2000-11-28', 51.791726, -3.982046, 212200.00, 263400.00, 38.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (33, N'UKA13368', N'Not Available', N'Not Available', N'AMMANFORD 4N', N'Urban Traffic', N'South Wales', '1992-12-29', '2000-11-28', 51.789781, -3.990661, 212000.00, 262800.00, 34.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (34, N'UKA15811', N'GB0779A', N'Not Available', N'ANTRIM 1', N'Suburban', N'Northern Ireland', '2002-04-02', '2005-03-08', 54.858244, -6.112023, 559245.00, 136200.00, 48.00, N'Black Smoke & SO2', N'Not Available'),
    (35, N'UKA00305', N'GB0403A', N'Not Available', N'Appleacre1', N'Rural Background', N'North West & Merseyside', '1996-11-15', '2004-01-27', 54.580000, -2.516666, 520655.45, 366702.34, 125.00, N'UKEAP: Precip-Net', N'Not Available'),
    (36, N'UKA14831', N'Not Available', N'Not Available', N'ARMAGH 2N', N'Urban Traffic', N'Northern Ireland', '1996-12-31', '2000-11-28', 54.359812, -6.625731, 505900.00, 99600.00, 40.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (37, N'UKA13370', N'Not Available', N'Not Available', N'ARNOLD 2N', N'Urban Traffic', N'East Midlands', '1992-12-29', '2000-11-28', 52.996505, -1.138777, 344700.00, 457900.00, 65.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (38, N'UKA14836', N'Not Available', N'Not Available', N'ASHFIELD 6N', N'Urban Traffic', N'East Midlands', '1996-12-31', '2000-11-28', 53.035601, -1.202125, 349000.00, 453600.00, 85.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (39, N'UKA13371', N'Not Available', N'Not Available', N'ASHFORD 3N', N'Urban Traffic', N'South East', '1992-12-29', '2002-12-31', 51.149050, 0.876787, 142800.00, 601300.00, 49.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (40, N'UKA13372', N'Not Available', N'Not Available', N'ASHFORD 4N', N'Urban Traffic', N'South East', '1992-12-29', '2003-12-31', 51.148187, 0.875304, 142700.00, 601200.00, 45.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (41, N'UKA14727', N'Not Available', N'Not Available', N'ASHFORD 7N', N'Urban Traffic', N'South East', '1995-03-31', '2008-07-02', 51.148398, 0.866736, 142700.00, 600600.00, 52.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (42, N'UKA13375', N'Not Available', N'Not Available', N'ASHTON UNDER LYNE 8N', N'Urban Traffic', N'Greater Manchester Urban Area', '1992-12-29', '2000-11-28', 53.489474, -2.093404, 399200.00, 393900.00, 119.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (43, N'UKA00289', N'GB0116R', N'GB0116R', N'Aston Rowant', N'Rural Background', N'South East', '1996-09-16', '2016-11-21', 51.672557, -0.949898, 197609.06, 472712.76, 156.00, N'UKEAP: National Ammonia Monitoring Network', N'Not Available'),
    (44, N'UKA00126', N'Not Available', N'Not Available', N'Avonmouth 1', N'Urban Traffic', N'Bristol Urban Area', '1986-04-01', '1987-01-27', 51.497998, -2.691420, 177900.00, 352100.00, 2.00, N'Heavy Metals', N'Not Available'),
    (45, N'UKA00127', N'Not Available', N'Not Available', N'Avonmouth 2', N'Urban Traffic', N'Bristol Urban Area', '1986-04-01', '1987-01-27', 51.505390, -2.656953, 178700.00, 354500.00, 10.00, N'Heavy Metals', N'Not Available'),
    (46, N'UKA13377', N'Not Available', N'Not Available', N'AYLESBURY 6N', N'Urban Traffic', N'South East', '1992-12-29', '2000-11-28', 51.812284, -0.807580, 213300.00, 482300.00, 80.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (47, N'UKA13378', N'Not Available', N'Not Available', N'AYLESBURY 7N', N'Urban Traffic', N'South East', '1992-12-29', '2010-01-06', 51.813169, -0.806106, 213400.00, 482400.00, 80.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (48, N'UKA14760', N'Not Available', N'Not Available', N'AYR 2N', N'Urban Traffic', N'Central Scotland', '1995-12-31', '2000-11-28', 55.464493, -4.627247, 622100.00, 234000.00, 10.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (49, N'UKA13380', N'Not Available', N'Not Available', N'BAGSHOT 1N', N'Urban Traffic', N'South East', '1992-12-29', '2010-01-06', 51.344339, -0.753250, 163500.00, 491100.00, 65.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (50, N'UKA13381', N'Not Available', N'Not Available', N'BAGSHOT 2N', N'Urban Traffic', N'South East', '1992-12-29', '2001-12-04', 51.361473, -0.692924, 163300.00, 491100.00, 65.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (51, N'UKA15380', N'Not Available', N'Not Available', N'BALLOCH 1N', N'Urban Traffic', N'Central Scotland', '2001-01-02', '2005-01-06', 55.899645, -4.579811, 670400.00, 238800.00, 13.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (52, N'UKA16244', N'GB0873A', N'Not Available', N'BALLYCASTLE 1', N'Roadside', N'Northern Ireland', '2005-01-01', '2005-12-31', 55.200504, -6.251545, 597832.00, 129569.00, 35.00, N'Black Smoke & SO2', N'Not Available'),
    (53, N'UKA00949', N'GB1391R', N'Not Available', N'Ballylinney Church', N'Rural Background', N'Northern Ireland', '2022-04-01', '2024-09-03', 54.740000, -5.990000, 545644.44, 143277.34, 112.00, N'UKEAP: National Ammonia Monitoring Network', N'Please note that the location of this site is only reported to 2 decimal places for latitudes and longitude. The location data has a precision of approximately 1 km for latitude and 600 m for longitude.'),
    (54, N'UKA14840', N'Not Available', N'Not Available', N'BALLYMENA 3N', N'Urban Traffic', N'Northern Ireland', '1996-12-31', '2000-11-28', 54.341812, -6.458957, 503200.00, 110300.00, 50.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (55, N'UKA15001', N'Not Available', N'Not Available', N'BALLYMONEY 2N', N'Urban Traffic', N'Northern Ireland', '1998-12-29', '2001-12-04', 55.080636, -6.500166, 585500.00, 112900.00, 40.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (56, N'UKA15294', N'GB0753A', N'Not Available', N'BALLYMONEY 4', N'Suburban', N'Northern Ireland', '2000-04-04', '2005-12-31', 55.071265, -6.508362, 584492.00, 112310.00, 49.00, N'Black Smoke & SO2', N'Not Available'),
    (57, N'UKA15383', N'Not Available', N'Not Available', N'BALLYNAHINCH 8N', N'Urban Traffic', N'Northern Ireland', '2001-01-02', '2001-12-04', 54.400217, -5.897480, 352216.00, 336592.00, 0.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (58, N'UKA00067', N'Not Available', N'Not Available', N'Balquhidder', N'Rural Background', N'North East Scotland', '1984-09-02', '2000-01-01', 56.354722, -4.393888, 720616.60, 252179.66, 137.00, N'UKEAP: Precip-Net; UKEAP: Precip-Net; UKEAP: Rural NO2', N'Not Available'),
    (59, N'UKA00239', N'GB0390A', N'Not Available', N'Balquhidder 2', N'Rural Background', N'North East Scotland', '1994-08-08', '2025-01-09', 56.356229, -4.356985, 720705.54, 254465.15, 130.00, N'UKEAP: Precip-Net; UKEAP: Rural NO2', N'Not Available'),
    (60, N'UKA00142', N'Not Available', N'Not Available', N'Baltasound', N'Rural Background', N'Highland', '1986-08-19', '1989-01-03', 60.759380, -0.884296, 1209000.00, 460900.00, 25.00, N'UKEAP: Precip-Net', N'Not Available'),
    (61, N'UKA13384', N'Not Available', N'Not Available', N'BANBURY 2N', N'Urban Traffic', N'South East', '1992-12-29', '1999-11-30', 52.057429, -1.339261, 240100.00, 445400.00, 117.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (62, N'UKA13385', N'Not Available', N'Not Available', N'BANBURY 5N', N'Urban Traffic', N'South East', '1992-12-29', '1999-11-30', 52.056595, -1.350941, 240000.00, 444600.00, 127.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (63, N'UKA15200', N'Not Available', N'Not Available', N'BANBURY 7N', N'Urban Traffic', N'South East', '1999-12-31', '2000-11-28', 52.058337, -1.340706, 240200.00, 445300.00, 117.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (64, N'UKA00455', N'GB0091R', N'GB0091R', N'Banchory', N'Rural Background', N'North East Scotland', '2003-02-07', '2014-01-06', 57.076625, -2.534892, 798527.71, 367671.42, 130.00, N'Heavy Metals', N'Not Available'),
    (65, N'UKA15707', N'GB0768A', N'Not Available', N'BANGOR (CO DOWN) 5', N'Suburban', N'Northern Ireland', '2001-04-03', '2005-12-31', 54.654950, -5.682324, 535103.00, 162575.00, 34.00, N'Black Smoke & SO2', N'Not Available'),
    (66, N'UKA16542', N'Not Available', N'Not Available', N'BANGOR NI 14N', N'Urban Traffic', N'Northern Ireland', '2005-02-01', '2008-04-02', 54.642537, -5.832190, 379313.00, 340000.00, 12.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (67, N'UKA16386', N'Not Available', N'Not Available', N'BANGOR NI 15N', N'Urban Traffic', N'Northern Ireland', '2005-01-02', '2008-08-31', 54.641894, -5.838421, 379229.00, 339600.00, 11.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (68, N'UKA13387', N'Not Available', N'Not Available', N'BANGOR NI 1N', N'Urban Traffic', N'Northern Ireland', '1992-12-29', '2000-11-28', 54.677490, -5.649837, 537500.00, 164800.00, 18.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (69, N'UKA13388', N'Not Available', N'Not Available', N'BANGOR NI 2N', N'Urban Traffic', N'Northern Ireland', '1992-12-29', '2000-11-28', 54.676547, -5.651304, 537400.00, 164700.00, 16.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (70, N'UKA13389', N'Not Available', N'Not Available', N'BANGOR NI 4N', N'Urban Traffic', N'Northern Ireland', '1992-12-29', '2006-01-31', 54.679085, -5.626702, 537600.00, 166300.00, 35.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (71, N'UKA13390', N'Not Available', N'Not Available', N'BANGOR NI 5N', N'Urban Traffic', N'Northern Ireland', '1992-12-29', '2000-11-28', 54.673768, -5.683640, 537200.00, 162600.00, 33.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (72, N'UKA15384', N'Not Available', N'Not Available', N'BANGOR NI 6N', N'Urban Traffic', N'Northern Ireland', '2001-01-02', '2008-04-02', 54.658851, -5.671431, 535500.00, 163300.00, 16.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (73, N'UKA15385', N'Not Available', N'Not Available', N'BANGOR NI 7N', N'Urban Traffic', N'Northern Ireland', '2001-01-02', '2008-08-31', 54.662579, -5.667114, 535900.00, 163600.00, 14.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (74, N'UKA15386', N'Not Available', N'Not Available', N'BANGOR NI 8N', N'Urban Traffic', N'Northern Ireland', '2001-01-02', '2008-08-31', 54.659655, -5.704079, 535700.00, 161200.00, 59.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (75, N'UKA00114', N'GB1563A', N'Not Available', N'Bannisdale', N'Rural Background', N'North West & Merseyside', '1986-01-21', '2021-12-13', 54.431308, -2.748991, 504245.70, 351509.72, 265.00, N'UKEAP: Precip-Net; UKEAP: Rural NO2', N'Not Available'),
    (76, N'UKA00936', N'GB1378R', N'Not Available', N'Bannisdale Beck', N'Rural Background', N'North West & Merseyside', '2021-12-14', '2025-01-03', 54.409225, -2.724522, 501771.95, 353071.81, 277.00, N'UKEAP: Precip-Net; UKEAP: Rural NO2', N'Not Available'),
    (77, N'UKA00069', N'GB0007R', N'GB0007R', N'Barcombe Mills', N'Rural Background', N'South East', '1985-01-01', '2016-10-04', 50.919130, 0.048579, 115294.75, 544092.05, 10.00, N'UKEAP: Acid Gases & Aerosol Network; UKEAP: Historic Aerosol measurements; UKEAP: National Ammonia Monitoring Network; UKEAP: Precip-Net; UKEAP: Precip-Net; UKEAP: Rural NO2', N'Not Available'),
    (78, N'UKA13392', N'Not Available', N'Not Available', N'BARKING 2N', N'Urban Traffic', N'Greater London Urban Area', '1992-12-29', '2001-12-04', 51.534541, 0.086300, 183800.00, 544800.00, 5.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (79, N'UKA13393', N'Not Available', N'Not Available', N'BARKING 3N', N'Urban Traffic', N'Greater London Urban Area', '1992-12-29', '2000-11-28', 51.540780, 0.089470, 184500.00, 545000.00, 8.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (80, N'UKA13397', N'Not Available', N'Not Available', N'BARNET 6N', N'Urban Traffic', N'Greater London Urban Area', '1992-12-29', '2000-11-28', 51.601466, -0.268747, 190600.00, 520000.00, 54.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (81, N'UKA00186', N'GB0543A', N'Not Available', N'Barnsley', N'Urban Background', N'Yorkshire & Humberside', '1991-03-14', '1994-03-21', 53.580045, -1.475865, 409400.00, 434800.00, 90.00, N'Automatic Urban and Rural Monitoring Network (AURN)', N'Municipal building on edge of a coal mining town.'),
    (82, N'UKA00236', N'GB0600A', N'Not Available', N'Barnsley 12', N'Urban Background', N'Yorkshire & Humberside', '1994-03-21', '2012-07-17', 53.555930, -1.485153, 406712.58, 434204.47, 120.00, N'Automatic Urban and Rural Monitoring Network (AURN)', N'The monitoring station is within an existing four-storey office block in a suburban area of Barnsley. The manifold inlet is approximately 13 metres above ground level and approximately 25 metres distance from the nearest minor road. A busy inner ring-road (A635) is approximately 100 metres from the monitoring station. The traffic flow along Church Road (A635) is approximately 8 500 vehicles per day. The surrounding area is suburban with no light industry in the immediate area.'),
    (83, N'UKA14843', N'Not Available', N'Not Available', N'BARNSLEY 2N', N'Urban Traffic', N'Yorkshire & Humberside', '1996-12-31', '1999-11-30', 53.547669, -1.471738, 405800.00, 435100.00, 100.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (84, N'UKA14763', N'Not Available', N'Not Available', N'BARNSLEY 3N', N'Urban Traffic', N'Yorkshire & Humberside', '1995-12-31', '1999-11-30', 53.547669, -1.471738, 405800.00, 435100.00, 102.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (85, N'UKA13399', N'Not Available', N'Not Available', N'BARROW-IN-FURNESS 1N', N'Urban Traffic', N'North West & Merseyside', '1992-12-29', '2006-01-03', 54.111499, -3.228270, 469100.00, 319800.00, 42.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (86, N'UKA13400', N'Not Available', N'Not Available', N'BARROW-IN-FURNESS 2N', N'Urban Traffic', N'North West & Merseyside', '1992-12-29', '2000-11-28', 54.123288, -3.217908, 470400.00, 320500.00, 28.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (87, N'UKA13401', N'Not Available', N'Not Available', N'BARROW-IN-FURNESS 3N', N'Urban Traffic', N'North West & Merseyside', '1992-12-29', '2006-01-03', 54.112644, -3.203828, 469200.00, 321400.00, 9.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (88, N'UKA15389', N'Not Available', N'Not Available', N'BARROW-IN-FURNESS 5N', N'Urban Traffic', N'North West & Merseyside', '2001-01-02', '2006-01-03', 54.114241, -3.223762, 469400.00, 320100.00, 30.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (89, N'UKA13404', N'Not Available', N'Not Available', N'BARRY 2N', N'Urban Traffic', N'South Wales', '1992-12-29', '2000-11-28', 51.406779, -3.275200, 168300.00, 311400.00, 51.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (90, N'UKA13405', N'Not Available', N'Not Available', N'BARRY 5N', N'Urban Traffic', N'South Wales', '1992-12-29', '1999-11-30', 51.411289, -3.273888, 168800.00, 311500.00, 80.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (91, N'UKA13410', N'Not Available', N'Not Available', N'BASINGSTOKE 5N', N'Urban Traffic', N'South East', '1992-12-29', '2000-11-28', 51.253850, -1.105807, 150900.00, 462500.00, 96.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (92, N'UKA00061', N'GB0303A', N'Not Available', N'Bath 6', N'Suburban', N'South West', '1981-03-31', '2012-03-09', 51.388985, -2.354879, 165609.04, 375402.97, 20.00, N'Black Carbon; Black Smoke & SO2', N'Not Available'),
    (93, N'UKA00306', N'GB0647A', N'Not Available', N'Bath Roadside', N'Urban Traffic', N'South West', '1996-11-18', '2019-06-11', 51.391127, -2.354155, 165847.02, 375454.50, 27.00, N'Automatic Urban and Rural Monitoring Network (AURN); Non-Automatic Hydrocarbon Network', N'The monitoring station is located in the basement of a property adjacent to the A4 trunk road which runs from Bristol to Reading. This is a busy two lane two-way road which is subject to frequent congestion. The monitoring station is located approximately 150 metres from a set of traffic lights. The majority of the buildings surrounding the site are three to four storeys creating street canyons within the immediate vicinity.'),
    (94, N'UKA13411', N'Not Available', N'Not Available', N'BATHGATE 2N', N'Urban Traffic', N'Central Scotland', '1992-12-29', '2000-11-28', 55.900490, -3.642499, 668700.00, 297400.00, 145.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (95, N'UKA00464', N'GB0855A', N'Not Available', N'Beacon Hill', N'Rural Background', N'East Midlands', '2003-11-13', '2014-03-13', 52.721994, -1.232292, 314092.24, 451949.73, 186.00, N'Heavy Metals', N'Not Available'),
    (96, N'UKA14535', N'Not Available', N'Not Available', N'BEARSDEN 2N', N'Urban Traffic', N'Central Scotland', '1993-12-31', '2000-11-28', 55.919835, -4.336302, 672100.00, 254100.00, 57.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (97, N'UKA00120', N'Not Available', N'Not Available', N'Beddgelert', N'Rural Background', N'North Wales', '1986-01-28', '1996-07-25', 53.043611, -4.154166, 351763.96, 255681.22, 358.00, N'UKEAP: Precip-Net; UKEAP: Rural NO2', N'Not Available'),
    (98, N'UKA13415', N'Not Available', N'Not Available', N'BEDFORD 6N', N'Urban Traffic', N'Eastern', '1992-12-29', '1998-12-29', 52.139897, -0.449608, 250200.00, 506200.00, 26.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (99, N'UKA13416', N'Not Available', N'Not Available', N'BEDFORD 7N', N'Urban Traffic', N'Eastern', '1992-12-29', '1995-11-28', 52.150489, -0.434623, 251400.00, 507200.00, 34.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (100, N'UKA00097', N'Not Available', N'Not Available', N'Beinn Eighe', N'Rural Background', N'Highland', '1986-01-14', '1989-01-09', 57.612795, -5.308057, 862909.51, 202497.25, 22.00, N'UKEAP: Precip-Net', N'Not Available'),
    (101, N'UKA13419', N'Not Available', N'Not Available', N'BELFAST 2N', N'Urban Traffic', N'Belfast Metropolitan Urban Area', '1992-12-29', '2000-11-28', 54.612735, -5.908989, 531200.00, 147700.00, 4.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (102, N'UKA00371', N'GB0696A', N'Not Available', N'Belfast Clara St', N'Suburban Background', N'Belfast Metropolitan Urban Area', '1998-06-01', '2007-09-30', 54.591256, -5.895460, 528763.15, 148440.54, 20.00, N'Automatic Urban and Rural Monitoring Network (AURN); PAH Andersen', N'The monitoring station is within an existing building located in the City Councils Depot in Clara Street. The building is located approximately 10 metres from the nearest road which is generally quiet and free flowing. The manifold inlet is approximately at 3 metres height. The surrounding area is open and comprises predominantly residential dwellings with a number of small business outlets.'),
    (103, N'UKA00175', N'GB0514A', N'Not Available', N'Belfast East', N'Urban Background', N'Belfast Metropolitan Urban Area', '1989-09-06', '2007-09-30', 54.596530, -5.901667, 529371.83, 148072.35, 20.00, N'Automatic Urban and Rural Monitoring Network (AURN)', N'The monitoring station is within an existing building at the Templemore Avenue Swimming Centre approximately 3 metres from a quiet residential road. The manifold inlet is approximately 3 metres above ground level. The surrounding area is predominantly residential and open.'),
    (104, N'UKA00228', N'GB0798A', N'Not Available', N'Belfast South', N'Urban Background', N'Belfast Metropolitan Urban Area', '1993-08-01', '2000-12-31', 54.599180, -5.912416, 529705.12, 147394.81, 12.00, N'Automatic Hydrocarbon Network', N'Situated 10m to the rear of a row of terraced houses in College Gardens. 100m west of a major road.'),
    (105, N'UKA00398', N'Not Available', N'Not Available', N'Benniguinea', N'Rural Background', N'Scottish Borders', '1999-08-13', '2004-01-04', 55.068639, -4.241006, 577203.29, 256997.34, 190.00, N'UKEAP: Precip-Net', N'Not Available'),
    (106, N'UKA00205', N'GB0380A', N'Not Available', N'Bentra', N'Rural Background', N'Northern Ireland', '1991-11-12', '2004-01-14', 54.757222, -5.735000, 546655.02, 159784.76, 115.00, N'UKEAP: Precip-Net', N'Not Available'),
    (107, N'UKA13422', N'Not Available', N'Not Available', N'BEXHILL 2N', N'Urban Traffic', N'South East', '1992-12-29', '2000-11-28', 50.844550, 0.465909, 107900.00, 573700.00, 8.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (108, N'UKA13429', N'Not Available', N'Not Available', N'BIDEFORD 7N', N'Urban Traffic', N'South West', '1992-12-29', '2000-11-28', 51.017747, -4.215479, 126600.00, 244700.00, 40.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (109, N'UKA13431', N'Not Available', N'Not Available', N'BIGGLESWADE 2N', N'Urban Traffic', N'Eastern', '1992-12-29', '2000-11-28', 52.086882, -0.258781, 244600.00, 519400.00, 30.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (110, N'UKA00153', N'GB0421A', N'Not Available', N'Billingham', N'Urban Industrial', N'Teesside Urban Area', '1987-01-01', '2024-06-19', 54.605370, -1.275039, 523597.01, 446927.61, 10.00, N'Automatic Urban and Rural Monitoring Network (AURN)', N'The monitoring station is within an existing building within the grounds of a council depot. The nearest road is a minor road within the industrial area and is approximately 80 metres from the monitoring station. The surrounding area is generally open and comprises both light industrial and business units with nearby residential dwellings. A larger industrial area is located approximately 700 metres to the south.'),
    (111, N'UKA13434', N'Not Available', N'Not Available', N'BILSTON 1N', N'Urban Traffic', N'West Midlands Urban Area', '1992-12-29', '2007-12-31', 52.566304, -2.075197, 296500.00, 395000.00, 141.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (112, N'UKA13435', N'Not Available', N'Not Available', N'BILSTON 2N', N'Urban Traffic', N'West Midlands Urban Area', '1992-12-29', '2000-11-28', 52.562704, -2.081091, 296100.00, 394600.00, 142.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (113, N'UKA13436', N'Not Available', N'Not Available', N'BILSTON 3N', N'Urban Traffic', N'West Midlands Urban Area', '1992-12-29', '2007-12-31', 52.566309, -2.066345, 296500.00, 395600.00, 137.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (114, N'UKA13437', N'Not Available', N'Not Available', N'BILSTON 4N', N'Urban Traffic', N'West Midlands Urban Area', '1992-12-29', '2007-12-31', 52.572587, -2.089963, 297200.00, 394000.00, 135.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (115, N'UKA00176', N'GB0515A', N'Not Available', N'Bircotes', N'Urban Background', N'East Midlands', '1989-09-14', '1991-03-11', 53.422855, -1.054946, 392200.00, 462900.00, 30.00, N'Automatic Urban and Rural Monitoring Network (AURN)', N'A residential area - 1 km north of a colliery and 2 km west of the A1(M).'),
    (116, N'UKA00098', N'Not Available', N'Not Available', N'Birds Hill', N'Rural Background', N'South West', '1986-01-14', '1989-01-03', 51.118184, -3.350106, 136300.00, 305600.00, 300.00, N'UKEAP: Precip-Net', N'Not Available'),
    (117, N'UKA15007', N'Not Available', N'Not Available', N'BIRKENHEAD 1N', N'Urban Traffic', N'Birkenhead Urban Area', '1998-12-29', '2007-10-01', 53.398776, -3.030170, 389600.00, 331600.00, 10.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (118, N'UKA13438', N'Not Available', N'Not Available', N'BIRKENHEAD 2N', N'Urban Traffic', N'Birkenhead Urban Area', '1992-12-29', '2000-11-28', 53.386168, -3.032873, 388200.00, 331400.00, 30.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (119, N'UKA13442', N'Not Available', N'Not Available', N'BIRMINGHAM 535N', N'Urban Traffic', N'West Midlands Urban Area', '1992-12-29', '2000-11-28', 52.436825, -1.892575, 282100.00, 407400.00, 150.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (120, N'UKA00559', N'GB1013A', N'Not Available', N'Birmingham Acocks Green', N'Urban Background', N'West Midlands Urban Area', '2011-03-18', '2021-10-01', 52.437165, -1.829999, 282146.00, 411653.98, 134.00, N'Automatic Urban and Rural Monitoring Network (AURN); Non-Automatic Hydrocarbon Network', N'The monitoring station is within a self-contained air-conditioned housing located within the grounds of an annex to a large school. The monitoring station is approximately 70 metres from the nearest road (other than car park access road) Shirley Road.'),
    (121, N'UKA00214', N'GB0569A', N'Not Available', N'Birmingham Centre', N'Urban Background', N'West Midlands Urban Area', '1992-03-18', '2009-01-14', 52.479724, -1.908078, 286870.45, 406340.03, 163.00, N'Automatic Urban and Rural Monitoring Network (AURN); Automatic Urban and Rural Monitoring Network (AURN); Non-Automatic Hydrocarbon Network', N'The monitoring station is within a self-contained air conditioned housing located within a pedestrianised area of the city centre. The nearest road is approximately 10 metres distance and is used for access to the adjacent car park. The nearest heavily trafficked urban road is approximately 60 metres from the station. The manifold inlet is 3.5 metres above ground level. The surrounding area is generally open and comprises urban retail and business outlets. Trees occur within 2 metres distance of'),
    (122, N'UKA00229', N'GB0595A', N'Not Available', N'Birmingham East', N'Urban Background', N'West Midlands Urban Area', '1993-08-04', '2004-10-01', 52.497630, -1.831498, 288871.58, 411536.41, 100.00, N'Automatic Hydrocarbon Network; Automatic Urban and Rural Monitoring Network (AURN); PAH Andersen', N'Within playground of a Junior and Infant School in a residential area.'),
    (123, N'UKA00547', N'GB1001A', N'Not Available', N'Birmingham Roadside 2', N'Urban Traffic', N'West Midlands Urban Area', '2009-07-22', '2010-08-19', 52.459009, -1.871564, 284569.99, 408824.01, 130.00, N'Non-Automatic Hydrocarbon Network', N'Not Available'),
    (124, N'UKA00479', N'GB0851A', N'Not Available', N'Birmingham Tyburn', N'Urban Background', N'West Midlands Urban Area', '2004-08-16', '2017-06-06', 52.511722, -1.830583, 290439.26, 411594.86, 93.00, N'Automatic Urban and Rural Monitoring Network (AURN); Black Carbon; Non-Automatic Hydrocarbon Network; PAH Andersen; PAH Digitel (solid phase); Particle Concentrations and Numbers Network', N'The monitoring station is within a self-contained air-conditioned housing located within the car park of council owned offices. The nearest road (other than car park access road) is approximately 60 metres north of the station the A38 Tyburn Road . The site is located approximately 600 metres to the north of the M6 motorway.'),
    (125, N'UKA00543', N'GB0960A', N'Not Available', N'Birmingham Tyburn Roadside', N'Urban Traffic', N'West Midlands Urban Area', '2009-02-11', '2016-09-07', 52.512194, -1.830861, 290491.72, 411575.87, 93.00, N'Automatic Urban and Rural Monitoring Network (AURN); Black Carbon; Non-Automatic Hydrocarbon Network', N'The monitoring station is within a self-contained air-conditioned housing located on the south side of the A38 in Tyburn outside council owned offices. The site is located approximately 700 metres to the north of the M6 motorway.'),
    (126, N'UKA14845', N'Not Available', N'Not Available', N'BISHOP AUCKLAND 2N', N'Urban Traffic', N'North East', '1996-12-31', '2000-11-28', 54.661053, -1.675979, 529600.00, 421000.00, 100.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (127, N'UKA14846', N'Not Available', N'Not Available', N'BISHOP AUCKLAND 3N', N'Urban Traffic', N'North East', '1996-12-31', '2006-01-31', 54.652978, -1.680693, 528700.00, 420700.00, 100.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (128, N'UKA13445', N'Not Available', N'Not Available', N'BISHOPBRIGGS 7N', N'Urban Traffic', N'Central Scotland', '1992-12-29', '2000-11-28', 55.915768, -4.216030, 671400.00, 261600.00, 66.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (129, N'UKA13447', N'Not Available', N'Not Available', N'BISLEY 1N', N'Urban Traffic', N'South East', '1992-12-29', '2010-11-29', 51.343266, -0.606995, 159400.00, 494600.00, 40.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (130, N'UKA14539', N'Not Available', N'Not Available', N'BLABY 2N', N'Urban Traffic', N'East Midlands', '1993-12-31', '2000-11-28', 52.604817, -1.176011, 301100.00, 455900.00, 62.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (131, N'UKA15099', N'Not Available', N'Not Available', N'BLACKBURN 1N', N'Urban Traffic', N'North West & Merseyside', '1998-12-31', '2005-05-31', 53.745579, -2.488209, 427800.00, 367900.00, 100.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (132, N'UKA15008', N'Not Available', N'Not Available', N'BLACKBURN 2N', N'Urban Traffic', N'North West & Merseyside', '1998-12-29', '2000-11-28', 53.745573, -2.489725, 427800.00, 367800.00, 100.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (133, N'UKA14765', N'Not Available', N'Not Available', N'BLACKBURN 3N', N'Urban Traffic', N'North West & Merseyside', '1995-12-31', '2005-02-01', 53.745573, -2.489725, 427800.00, 367800.00, 100.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (134, N'UKA15402', N'Not Available', N'Not Available', N'BLACKBURN 5N', N'Urban Traffic', N'North West & Merseyside', '2001-01-02', '2002-12-31', 53.747548, -2.444257, 428000.00, 370800.00, 140.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (135, N'UKA00545', N'GB0961A', N'Not Available', N'Blackburn Darwen Roadside', N'Urban Traffic', N'North West & Merseyside', '2009-06-15', '2014-03-17', 53.715504, -2.483815, 424451.95, 368167.00, 139.00, N'Automatic Urban and Rural Monitoring Network (AURN)', N'The monitoring station is within a self-contained air-conditioned housing within the grounds of Darwen Vale College. The surrounding area a generally open with residential dwellings. The nearest road A666 Blackburn Road is approximately 10 metres to the east of the station with the M65 approximately 60 metres to the north.'),
    (136, N'UKA00412', N'GB0727A', N'Not Available', N'Blackpool', N'Urban Background', N'Blackpool Urban Area', '2000-08-08', '2004-11-11', 53.790460, -3.029283, 433174.40, 332289.25, 6.00, N'Automatic Urban and Rural Monitoring Network (AURN)', N'Grounds of public library in a residential area. Main road approximately 30m and a minor road 3m from monitoring site.'),
    (137, N'UKA13448', N'Not Available', N'Not Available', N'BLACKPOOL 1N', N'Urban Traffic', N'Blackpool Urban Area', '1992-12-29', '2009-12-31', 53.812233, -3.032691, 435600.00, 332100.00, 8.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (138, N'UKA13449', N'Not Available', N'Not Available', N'BLACKPOOL 2N', N'Urban Traffic', N'Blackpool Urban Area', '1992-12-29', '2000-11-28', 53.822964, -3.039031, 436800.00, 331700.00, 15.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (139, N'UKA13450', N'Not Available', N'Not Available', N'BLACKPOOL 3N', N'Urban Traffic', N'Blackpool Urban Area', '1992-12-29', '2009-12-31', 53.822209, -3.022302, 436700.00, 332800.00, 23.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (140, N'UKA13451', N'Not Available', N'Not Available', N'BLACKPOOL 4N', N'Urban Traffic', N'Blackpool Urban Area', '1992-12-29', '2009-12-31', 53.807818, -3.023471, 435100.00, 332700.00, 8.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (141, N'UKA15403', N'Not Available', N'Not Available', N'BLACKPOOL 5N', N'Urban Traffic', N'Blackpool Urban Area', '2001-01-02', '2009-12-31', 53.790244, -2.857585, 433000.00, 343600.00, 20.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (142, N'UKA13453', N'Not Available', N'Not Available', N'BLACKWOOD 2N', N'Urban Traffic', N'South Wales', '1992-12-29', '2000-11-28', 51.661248, -3.189802, 196500.00, 317800.00, 235.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (143, N'UKA13454', N'Not Available', N'Not Available', N'BLYTH 1N', N'Urban Traffic', N'North East', '1992-12-29', '1998-12-29', 55.129627, -1.520074, 581800.00, 430700.00, 7.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (144, N'UKA13455', N'Not Available', N'Not Available', N'BLYTH 4N', N'Urban Traffic', N'North East', '1992-12-29', '2006-01-31', 55.123325, -1.517014, 581100.00, 430900.00, 21.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (145, N'UKA13456', N'Not Available', N'Not Available', N'BLYTH 5N', N'Urban Traffic', N'North East', '1992-12-29', '1998-12-29', 55.123325, -1.517014, 581100.00, 430900.00, 21.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (146, N'UKA13460', N'Not Available', N'Not Available', N'BOLSOVER 1N', N'Urban Traffic', N'East Midlands', '1992-12-29', '2000-11-28', 53.229424, -1.289907, 370500.00, 447500.00, 160.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (147, N'UKA13461', N'Not Available', N'Not Available', N'BOLSOVER 2N', N'Urban Traffic', N'East Midlands', '1992-12-29', '2000-11-28', 53.229433, -1.291405, 370500.00, 447400.00, 160.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (148, N'UKA15406', N'Not Available', N'Not Available', N'BOLSOVER 6N', N'Urban Traffic', N'East Midlands', '2001-01-02', '2002-12-31', 53.201961, -1.211016, 367500.00, 452800.00, 85.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (149, N'UKA16006', N'Not Available', N'Not Available', N'BOLSOVER 7N', N'Urban Traffic', N'East Midlands', '2003-12-03', '2005-01-05', 53.202273, -1.216115, 367531.00, 452459.00, 95.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (150, N'UKA00326', N'GB0654A', N'Not Available', N'Bolton', N'Urban Background', N'Greater Manchester Urban Area', '1997-02-03', '2008-06-30', 53.572320, -2.439583, 408502.87, 370987.69, 103.00, N'Automatic Urban and Rural Monitoring Network (AURN)', N'The monitoring station is within an existing college building within the grounds of the Bolton Institute. The site is bounded by three busy roads with traffic flows of 18 000 - 23 000 vehicles per day. The nearest of the three roads is approximately 170 metres from the monitoring station. The manifold inlet is approximately 9 metres above ground level. The surrounding area is built-up and urban.'),
    (151, N'UKA13465', N'Not Available', N'Not Available', N'BOLTON 2N', N'Urban Traffic', N'Greater Manchester Urban Area', '1992-12-29', '1995-11-28', 53.601079, -2.433651, 411700.00, 371400.00, 118.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (152, N'UKA13466', N'Not Available', N'Not Available', N'BOLTON 3N', N'Urban Traffic', N'Greater Manchester Urban Area', '1992-12-29', '1997-12-30', 53.601966, -2.436683, 411800.00, 371200.00, 123.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (153, N'UKA14673', N'Not Available', N'Not Available', N'BOLTON 7N', N'Urban Traffic', N'Greater Manchester Urban Area', '1994-12-31', '2000-11-28', 53.601073, -2.435162, 411700.00, 371300.00, 119.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (154, N'UKA14675', N'Not Available', N'Not Available', N'BOREHAMWOOD 2N', N'Urban Traffic', N'Eastern', '1994-12-31', '2000-11-28', 51.658234, -0.276705, 196900.00, 519300.00, 90.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (155, N'UKA13471', N'Not Available', N'Not Available', N'BOSTON 2N', N'Urban Traffic', N'East Midlands', '1992-12-29', '2000-11-28', 52.975957, -0.020689, 343900.00, 533000.00, 3.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (156, N'UKA00055', N'GB0032R', N'GB0032R', N'Bottesford', N'Rural Background', N'East Midlands', '1977-10-01', '2016-10-17', 52.930280, -0.814722, 337643.41, 479770.54, 32.00, N'Automatic Urban and Rural Monitoring Network (AURN); UKEAP: Precip-Net; UKEAP: Rural NO2', N'The monitoring station is within a self-contained air-conditioned housing in a rural setting surrounded by farm land. The nearest main road is the A52 Nottingham to Grantham road which lies at a distance of approximately 400 metres north of the station. The manifold inlet is approximately 5 metres from the nearest rural road. The surrounding area is open.'),
    (157, N'UKA00099', N'Not Available', N'Not Available', N'Bowood House', N'Rural Background', N'South West', '1986-01-14', '1989-01-03', 51.428085, -2.068992, 169900.00, 395300.00, 85.00, N'UKEAP: Precip-Net', N'Not Available'),
    (158, N'UKA13475', N'Not Available', N'Not Available', N'BRACKNELL 2N', N'Urban Traffic', N'Reading/Wokingham Urban Area', '1992-12-29', '2000-11-28', 51.402522, -0.746385, 167800.00, 487300.00, 85.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (159, N'UKA13477', N'Not Available', N'Not Available', N'BRACKNELL 4N', N'Urban Traffic', N'Reading/Wokingham Urban Area', '1992-12-29', '2002-12-31', 51.441253, -0.752519, 172100.00, 486800.00, 60.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (160, N'UKA13479', N'Not Available', N'Not Available', N'BRADFORD 2N', N'Urban Traffic', N'Yorkshire & Humberside', '1992-12-29', '2000-11-28', 53.794845, -1.747964, 433200.00, 416700.00, 125.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (161, N'UKA00001', N'GB0105A', N'Not Available', N'Bradford 6', N'Urban Centre', N'West Yorkshire Urban Area', '1961-04-04', '2009-12-31', 53.792474, -1.753003, 432935.02, 416368.99, 100.00, N'Black Carbon; Black Smoke & SO2', N'Not Available'),
    (162, N'UKA00364', N'GB0689A', N'Not Available', N'Bradford Centre', N'Urban Background', N'West Yorkshire Urban Area', '1997-11-28', '2007-12-31', 53.793390, -1.748694, 433037.92, 416652.49, 102.00, N'Automatic Urban and Rural Monitoring Network (AURN); Black Carbon', N'The monitoring station is within a self-contained air-conditioned housing located adjacent to a busy 2-4 lane road in the city centre. The manifold inlet is approx at 3.5 metres height and approximately 10 metres from the kerbside. The surrounding area is built up and comprises urban retail and business premises.'),
    (163, N'UKA13483', N'Not Available', N'Not Available', N'BRAINTREE 2N', N'Urban Traffic', N'Eastern', '1992-12-29', '2000-11-28', 51.876987, 0.551067, 222900.00, 575700.00, 30.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (164, N'UKA13484', N'Not Available', N'Not Available', N'BRAINTREE 3N', N'Urban Traffic', N'Eastern', '1992-12-29', '2000-11-28', 51.878341, 0.571486, 223100.00, 577100.00, 70.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (165, N'UKA14478', N'Not Available', N'Not Available', N'BRECON 4N', N'Urban Traffic', N'South Wales', '1992-12-31', '2005-05-03', 51.943294, -3.380564, 228100.00, 305200.00, 140.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (166, N'UKA13486', N'Not Available', N'Not Available', N'BRENT 41N', N'Urban Traffic', N'Greater London Urban Area', '1992-12-29', '2010-06-29', 51.543365, -0.292585, 184100.00, 518500.00, 38.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (167, N'UKA13487', N'Not Available', N'Not Available', N'BRENT 43N', N'Urban Traffic', N'Greater London Urban Area', '1992-12-29', '2000-11-28', 51.537847, -0.284140, 183500.00, 519100.00, 24.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (168, N'UKA13488', N'Not Available', N'Not Available', N'BRENT 51N', N'Urban Traffic', N'Greater London Urban Area', '1992-12-29', '2000-11-28', 51.585075, -0.254936, 188800.00, 521000.00, 67.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (169, N'UKA13489', N'Not Available', N'Not Available', N'BRENT 54N', N'Urban Traffic', N'Greater London Urban Area', '1992-12-29', '2000-11-28', 51.553188, -0.287890, 185200.00, 518800.00, 47.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (170, N'UKA00460', N'GB0774A', N'Not Available', N'Brentford Roadside', N'Urban Traffic', N'Greater London Urban Area', '2003-06-20', '2007-09-30', 51.489448, -0.310121, 178075.85, 517422.48, 15.00, N'Automatic Urban and Rural Monitoring Network (AURN)', N'The site is adjacent to the A4 and an elevated section of the M4 with total traffic flows of around 130 000 vehicles per day over 10 lanes.'),
    (171, N'UKA13490', N'Not Available', N'Not Available', N'BRIDGEND 1N', N'Urban Traffic', N'South Wales', '1992-12-29', '2000-11-28', 51.418424, -3.574659, 170000.00, 290600.00, 20.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (172, N'UKA13491', N'Not Available', N'Not Available', N'BRIDGEND 2N', N'Urban Traffic', N'South Wales', '1992-12-29', '2000-11-28', 51.504691, -3.579073, 179600.00, 290500.00, 19.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (173, N'UKA14479', N'Not Available', N'Not Available', N'BRIDGEND 3N', N'Urban Traffic', N'South Wales', '1992-12-31', '2006-01-31', 51.505375, -3.594947, 179700.00, 289400.00, 30.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (174, N'UKA13492', N'Not Available', N'Not Available', N'BRIDGEND 4N', N'Urban Traffic', N'South Wales', '1992-12-29', '2009-07-29', 51.510729, -3.598016, 180300.00, 289200.00, 61.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (175, N'UKA13494', N'Not Available', N'Not Available', N'BRIDGNORTH 2N', N'Urban Traffic', N'West Midlands', '1992-12-29', '2000-11-28', 52.535915, -2.420127, 293200.00, 371600.00, 70.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (176, N'UKA13498', N'Not Available', N'Not Available', N'BRIDGWATER 2N', N'Urban Traffic', N'South West', '1992-12-29', '2000-11-28', 51.124399, -3.000191, 136600.00, 330100.00, 10.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (177, N'UKA13502', N'Not Available', N'Not Available', N'BRIDLINGTON 2N', N'Urban Traffic', N'Yorkshire & Humberside', '1992-12-29', '2000-11-28', 54.080700, -0.184040, 466500.00, 518900.00, 12.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (178, N'UKA13503', N'Not Available', N'Not Available', N'BRIDLINGTON 3N', N'Urban Traffic', N'Yorkshire & Humberside', '1992-12-29', '2008-12-05', 54.090834, -0.200418, 467600.00, 517800.00, 12.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (179, N'UKA13504', N'Not Available', N'Not Available', N'BRIDLINGTON 4N', N'Urban Traffic', N'Yorkshire & Humberside', '1992-12-29', '2008-12-05', 54.083920, -0.219063, 466800.00, 516600.00, 22.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (180, N'UKA13505', N'Not Available', N'Not Available', N'BRIGG 1N', N'Urban Traffic', N'Yorkshire & Humberside', '1992-12-29', '2006-01-03', 53.550979, -0.489078, 407100.00, 500200.00, 7.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (181, N'UKA13506', N'Not Available', N'Not Available', N'BRIGG 2N', N'Urban Traffic', N'Yorkshire & Humberside', '1992-12-29', '2000-11-28', 53.550979, -0.489078, 407100.00, 500200.00, 7.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (182, N'UKA13507', N'Not Available', N'Not Available', N'BRIGG 3N', N'Urban Traffic', N'Yorkshire & Humberside', '1992-12-29', '2006-01-03', 53.550080, -0.489110, 407000.00, 500200.00, 7.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (183, N'UKA15421', N'Not Available', N'Not Available', N'BRIGG 5N', N'Urban Traffic', N'Yorkshire & Humberside', '2001-01-02', '2005-12-31', 53.552718, -0.484488, 407300.00, 500500.00, 10.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (184, N'UKA13509', N'Not Available', N'Not Available', N'BRIGHTON 3N', N'Urban Traffic', N'Brighton/Worthing/Littlehampton', '1992-12-29', '2000-11-28', 50.833317, -0.141109, 105400.00, 531000.00, 19.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (185, N'UKA00367', N'GB0693A', N'Not Available', N'Brighton Roadside', N'Urban Traffic', N'Brighton/Worthing/Littlehampton', '1998-02-10', '2010-12-31', 50.823540, -0.137281, 104319.64, 531296.95, 10.00, N'Automatic Urban and Rural Monitoring Network (AURN)', N'The monitoring station is within an existing building located close to the Royal Pavilion near the busy A23 road junction of Marlborough Place and Church street Brighton. Traffic flow is approximately 23 000 vehicles per day. The site is located approximately 3 metres from the kerbside of the A23 which is generally free flowing. The manifold inlet is approximately 4 metres above ground level. The surrounding area is generally open and comprises public gardens with a few mature trees within 5-10 '),
    (186, N'UKA00458', N'GB0845A', N'Not Available', N'Brighton Roadside PM10', N'Urban Traffic', N'Brighton/Worthing/Littlehampton', '2003-02-28', '2008-05-29', 50.823500, -0.136924, 104315.83, 531322.21, 10.00, N'Automatic Urban and Rural Monitoring Network (AURN)', N'Not Available'),
    (187, N'UKA13513', N'Not Available', N'Not Available', N'BRISTOL 2N', N'Urban Traffic', N'Bristol Urban Area', '1992-12-29', '2000-11-28', 51.444654, -2.579819, 171900.00, 359800.00, 38.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (188, N'UKA00465', N'GB0878A', N'Not Available', N'Bristol Avonmouth', N'Urban Industrial', N'Bristol Urban Area', '2004-01-01', '2011-01-05', 51.500406, -2.703803, 178175.95, 351243.01, 10.00, N'Heavy Metals', N'Not Available'),
    (189, N'UKA00221', N'GB0585A', N'Not Available', N'Bristol Centre', N'Urban Background', N'Bristol Urban Area', '1993-01-04', '2005-09-15', 51.457180, -2.585622, 173296.30, 359407.87, 15.00, N'Automatic Urban and Rural Monitoring Network (AURN)', N'Pedestrianised walkway (Lower Castle Street to Bond Street) 43 m from major road.'),
    (190, N'UKA00237', N'GB0801A', N'Not Available', N'Bristol East', N'Urban Background', N'Bristol Urban Area', '1994-05-01', '2000-12-31', 51.453650, -2.578496, 172899.78, 359899.87, 30.00, N'Automatic Hydrocarbon Network', N'Not Available'),
    (191, N'UKA00466', N'GB0789A', N'Not Available', N'Bristol Hallen', N'Urban Industrial', N'South West', '2004-01-01', '2011-01-05', 51.514741, -2.658629, 179741.03, 354393.02, 8.00, N'Heavy Metals', N'Not Available'),
    (192, N'UKA00262', N'GB0639A', N'Not Available', N'Bristol Old Market', N'Urban Traffic', N'Bristol Urban Area', '1996-07-01', '2012-10-03', 51.456030, -2.583519, 173167.24, 359552.96, 17.00, N'Automatic Urban and Rural Monitoring Network (AURN); Non-Automatic Hydrocarbon Network', N'The monitoring station is located within a self contained air conditioned unit adjacent to a building. The surrounding area is urban in nature comprising of retail and business premises. The nearest road the A4044 Temple Way Underpass is approximately 10 metres from the instrument to the kerbside. The traffic flow along the A4044 is approximately 34 500 vehicles per day The sample inlet is approximately 2.5 metres above ground level.'),
    (193, N'UKA00084', N'Not Available', N'Not Available', N'Britannia 1', N'Urban Traffic', N'Greater London Urban Area', '1985-10-29', '1986-04-22', 51.448231, 0.324153, 174700.00, 561600.00, 18.00, N'Heavy Metals', N'Not Available'),
    (194, N'UKA00085', N'Not Available', N'Not Available', N'Britannia 2', N'Urban Traffic', N'Greater London Urban Area', '1985-10-29', '1986-04-22', 51.450085, 0.321368, 174900.00, 561400.00, 4.00, N'Heavy Metals', N'Not Available'),
    (195, N'UKA13516', N'Not Available', N'Not Available', N'BRIXHAM 2N', N'Urban Traffic', N'South West', '1992-12-29', '1994-11-29', 50.396554, -3.526474, 56300.00, 291600.00, 50.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (196, N'UKA00124', N'Not Available', N'Not Available', N'Broadford', N'Rural Background', N'Highland', '1986-02-25', '1989-01-03', 57.237356, -5.892781, 823008.77, 165196.32, 12.00, N'UKEAP: Precip-Net', N'Not Available'),
    (197, N'UKA13517', N'Not Available', N'Not Available', N'BROADLAND 1N NO LONGER USED.', N'Urban Traffic', N'Eastern', '1992-12-29', '2009-01-07', 52.656774, 1.276519, 311600.00, 621700.00, 30.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (198, N'UKA13519', N'Not Available', N'Not Available', N'BROADLAND 3N NO LONGER IN USE', N'Urban Traffic', N'Eastern', '1992-12-29', '2004-01-01', 52.665619, 1.314164, 312700.00, 624200.00, 20.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (199, N'UKA00204', N'GB0371A', N'Not Available', N'Brockhill 1', N'Rural Background', N'West Midlands', '1991-08-16', '2002-01-04', 52.327222, -1.996944, 269903.13, 400305.23, 138.00, N'UKEAP: Precip-Net', N'Not Available'),
    (200, N'UKA13521', N'Not Available', N'Not Available', N'BROMLEY 2N', N'Urban Traffic', N'Greater London Urban Area', '1992-12-29', '2000-11-28', 51.403558, 0.017070, 169100.00, 540400.00, 62.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (201, N'UKA13522', N'Not Available', N'Not Available', N'BROMLEY 3N', N'Urban Traffic', N'Greater London Urban Area', '1992-12-29', '2000-11-28', 51.402610, 0.019904, 169000.00, 540600.00, 60.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (202, N'UKA13523', N'Not Available', N'Not Available', N'BROMLEY 4N', N'Urban Traffic', N'Greater London Urban Area', '1992-12-29', '2000-11-28', 51.411867, -0.048713, 169900.00, 535800.00, 32.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (203, N'UKA13524', N'Not Available', N'Not Available', N'BROMLEY 5N', N'Urban Traffic', N'Greater London Urban Area', '1992-12-29', '2000-11-28', 51.405405, 0.014276, 169300.00, 540200.00, 66.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (204, N'UKA00345', N'GB0675A', N'Not Available', N'Bromley Roadside', N'Urban Traffic', N'Greater London Urban Area', '1997-05-02', '1998-07-06', 51.407100, 0.020128, 169499.67, 540601.80, 50.00, N'Automatic Urban and Rural Monitoring Network (AURN)', N'A kerbside site in Tweedy Road.'),
    (205, N'UKA13526', N'Not Available', N'Not Available', N'BROMSGROVE 2N', N'Urban Traffic', N'West Midlands', '1992-12-29', '2000-11-28', 52.340664, -2.058667, 271400.00, 396100.00, 97.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (206, N'UKA00073', N'GB0416A', N'Not Available', N'Brookside 1', N'Urban Traffic', N'West Midlands Urban Area', '1985-06-04', '1996-05-28', 52.571715, -2.041270, 297100.00, 397300.00, 129.00, N'Heavy Metals', N'Not Available'),
    (207, N'UKA00467', N'GB0417A', N'Not Available', N'Brookside 2', N'Suburban Industrial', N'West Midlands Urban Area', '2004-01-01', '2007-12-31', 52.582222, -2.041394, 298268.80, 397292.28, 128.00, N'Heavy Metals', N'Not Available'),
    (208, N'UKA00089', N'Not Available', N'Not Available', N'Brooms Barn', N'Rural Background', N'Eastern', '1986-01-07', '1989-01-03', 52.260628, 0.567174, 265600.00, 575300.00, 75.00, N'UKEAP: Precip-Net', N'Not Available'),
    (209, N'UKA13530', N'Not Available', N'Not Available', N'BROXTOWE 2N', N'Urban Traffic', N'East Midlands', '1992-12-29', '2000-11-28', 53.016437, -1.299370, 346800.00, 447100.00, 100.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (210, N'UKA13532', N'Not Available', N'Not Available', N'BROXTOWE 4N', N'Urban Traffic', N'East Midlands', '1992-12-29', '2000-11-28', 52.926941, -1.218999, 336900.00, 452600.00, 33.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (211, N'UKA13535', N'Not Available', N'Not Available', N'BRYNMAWR 3N', N'Urban Traffic', N'South Wales', '1992-12-29', '2000-11-28', 51.799029, -3.168773, 211800.00, 319500.00, 330.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (212, N'UKA00310', N'GB0047R', N'GB0047R', N'Bure Marshes', N'Rural Background', N'Eastern', '1996-12-01', '2017-02-01', 52.692369, 1.452620, 316114.11, 633416.75, 5.00, N'UKEAP: National Ammonia Monitoring Network', N'Not Available'),
    (213, N'UKA00189', N'GB0339A', N'Not Available', N'Burham 1', N'Rural Background', N'South East', '1991-08-13', '1993-06-21', 51.329882, 0.481815, 161900.00, 573000.00, 48.00, N'UKEAP: Precip-Net', N'Not Available'),
    (214, N'UKA13537', N'Not Available', N'Not Available', N'BURNLEY 2N', N'Urban Traffic', N'North West & Merseyside', '1992-12-29', '2000-11-28', 53.786774, -2.242807, 432300.00, 384100.00, 115.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (215, N'UKA16231', N'Not Available', N'Not Available', N'BURTON 23N', N'Urban Traffic', N'West Midlands', '2004-11-03', '2008-12-03', 52.808438, -1.642067, 323492.00, 424225.00, 50.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (216, N'UKA13541', N'Not Available', N'Not Available', N'BURTON 2N', N'Urban Traffic', N'West Midlands', '1992-12-29', '1998-12-29', 52.803993, -1.635058, 323000.00, 424700.00, 50.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (217, N'UKA13542', N'Not Available', N'Not Available', N'BURTON 3N', N'Urban Traffic', N'West Midlands', '1992-12-29', '2006-08-01', 52.808383, -1.602385, 323500.00, 426900.00, 81.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (218, N'UKA16757', N'Not Available', N'Not Available', N'BURTON 46N', N'Urban Traffic', N'West Midlands', '2005-11-29', '2009-06-03', 52.820714, -1.641061, 324858.00, 424286.00, 50.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (219, N'UKA14848', N'Not Available', N'Not Available', N'BURTON 5N', N'Urban Traffic', N'West Midlands', '1996-12-31', '2000-11-28', 52.803085, -1.632099, 322900.00, 424900.00, 50.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (220, N'UKA00322', N'GB0652A', N'Not Available', N'Bury Roadside', N'Urban Traffic', N'Greater Manchester Urban Area', '1997-01-20', '2013-09-10', 53.539110, -2.289611, 404757.20, 380903.97, 50.00, N'Automatic Urban and Rural Monitoring Network (AURN); Non-Automatic Hydrocarbon Network', N'The monitoring station is located within a self-contained air conditioned housing located on the embankment of Junction 17 16 metres away from the M60 motorway which has an annual average traffic flow of 162 000 vehicles. Within 21 metres distance of the site is a 3-lane roundabout The motorway and roundabout are subject to frequent congestion during peak traffic flow periods. The manifold inlet is approximately 3 metres above ground level. The surrounding area is generally open.'),
    (221, N'UKA13544', N'Not Available', N'Not Available', N'BURY ST EDMUNDS 1N', N'Urban Traffic', N'Eastern', '1992-12-29', '2001-12-04', 52.256489, 0.712008, 265500.00, 585200.00, 32.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (222, N'UKA13545', N'Not Available', N'Not Available', N'BURY ST EDMUNDS 2N', N'Urban Traffic', N'Eastern', '1992-12-29', '2000-11-28', 52.258319, 0.710654, 265700.00, 585100.00, 32.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (223, N'UKA13546', N'Not Available', N'Not Available', N'BURY ST EDMUNDS 5N', N'Urban Traffic', N'Eastern', '1992-12-29', '1996-12-31', 52.238100, 0.690379, 263400.00, 583800.00, 56.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (224, N'UKA14849', N'Not Available', N'Not Available', N'BURY ST EDMUNDS 6N', N'Urban Traffic', N'Eastern', '1996-12-31', '1999-11-30', 52.432343, 0.441796, 284400.00, 566100.00, 42.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (225, N'UKA15812', N'GB0780A', N'Not Available', N'BUSHMILLS 1', N'Suburban', N'Northern Ireland', '2002-04-02', '2004-12-31', 55.206178, -6.523736, 599553.00, 112303.00, 15.00, N'Black Smoke & SO2', N'Not Available'),
    (226, N'UKA15962', N'GB0844A', N'Not Available', N'BUSHMILLS 2', N'Suburban', N'Northern Ireland', '2003-09-02', '2005-12-31', 55.203198, -6.522400, 599216.00, 112366.00, 18.00, N'Black Smoke & SO2', N'Not Available'),
    (227, N'UKA13548', N'Not Available', N'Not Available', N'BUXTON DERBYSHIRE 2N', N'Urban Traffic', N'East Midlands', '1992-12-29', '2000-11-28', 53.259367, -1.907020, 373600.00, 406300.00, 296.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (228, N'UKA00242', N'GB0391A', N'Not Available', N'Bylchau', N'Rural Background', N'North Wales', '1995-01-05', '2004-01-05', 53.100000, -3.550277, 356990.13, 296298.61, 390.00, N'UKEAP: Precip-Net', N'Not Available'),
    (229, N'UKA00190', N'GB0340A', N'Not Available', N'Caenby 1', N'Rural Background', N'East Midlands', '1991-08-13', '2004-01-28', 53.394444, -0.506388, 389662.43, 499418.05, 22.00, N'UKEAP: Precip-Net', N'Not Available'),
    (230, N'UKA13551', N'Not Available', N'Not Available', N'CAERPHILLY 6N', N'Urban Traffic', N'South Wales', '1992-12-29', '2000-11-28', 51.572796, -3.222122, 186700.00, 315400.00, 99.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (231, N'UKA13552', N'Not Available', N'Not Available', N'CAERPHILLY 7N', N'Urban Traffic', N'South Wales', '1992-12-29', '2010-01-19', 51.586325, -3.218155, 188200.00, 315700.00, 77.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (232, N'UKA15434', N'Not Available', N'Not Available', N'CAERPHILLY 8N', N'Urban Traffic', N'South Wales', '2001-01-02', '2010-01-19', 51.571928, -3.219213, 186600.00, 315600.00, 0.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (233, N'UKA00216', N'GB0388A', N'Not Available', N'Cam Forest', N'Rural Background', N'Northern Ireland', '1992-04-22', '2001-11-22', 55.014489, -6.585103, 578500.00, 107000.00, 250.00, N'UKEAP: Precip-Net', N'Not Available'),
    (234, N'UKA00191', N'GB0341A', N'Not Available', N'Camborne 1', N'Rural Background', N'South West', '1991-08-13', '2004-01-24', 50.216944, -5.325277, 40507.97, 162874.48, 90.00, N'UKEAP: Precip-Net', N'Not Available'),
    (235, N'UKA13565', N'Not Available', N'Not Available', N'Cambridge 17N', N'Urban Traffic', N'Eastern', '1992-12-29', '2007-04-04', 52.205918, 0.117960, 258524.00, 544824.00, 5.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (236, N'UKA13567', N'Not Available', N'Not Available', N'Cambridge 19N', N'Urban Traffic', N'Eastern', '1992-12-29', '2007-04-04', 52.201254, 0.129767, 258029.00, 545646.00, 10.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (237, N'UKA13577', N'Not Available', N'Not Available', N'CAMBRIDGE 2N', N'Urban Traffic', N'Eastern', '1992-12-29', '2000-11-28', 52.208933, 0.138243, 258900.00, 546200.00, 10.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (238, N'UKA13578', N'Not Available', N'Not Available', N'Cambridge 6N', N'Urban Traffic', N'Eastern', '1992-12-29', '2007-04-04', 52.199369, 0.127102, 257814.00, 545470.00, 10.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (239, N'UKA13579', N'Not Available', N'Not Available', N'Cambridge 8N', N'Urban Traffic', N'Eastern', '1992-12-29', '2007-04-04', 52.221922, 0.135529, 260339.00, 545972.00, 10.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (240, N'UKA13585', N'Not Available', N'Not Available', N'CAMDEN 5N', N'Urban Traffic', N'Greater London Urban Area', '1992-12-29', '2000-11-28', 51.553492, -0.188349, 185400.00, 525700.00, 75.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (241, N'UKA00202', N'GB0361A', N'Not Available', N'Camphill 1', N'Rural Background', N'Central Scotland', '1991-08-15', '2004-01-07', 55.753939, -4.751928, 654604.98, 227396.96, 181.00, N'UKEAP: Precip-Net', N'Not Available'),
    (242, N'UKA00424', N'GB0737A', N'Not Available', N'Canterbury', N'Urban Background', N'South East', '2001-01-02', '2024-11-04', 51.273990, 1.098061, 157319.12, 616186.92, 35.00, N'Automatic Urban and Rural Monitoring Network (AURN)', N'The monitoring station is located within a self contained housing located at the western edge of a large Technology School in a suburb of Canterbury. The surrounding area is open with residential dwellings and a railway line. The nearest road is a minor road approximately 20 metres away. Thie site is approximately 1.5 kilometres form the centre of Canterbury.'),
    (243, N'UKA13589', N'Not Available', N'Not Available', N'CANTERBURY 4N', N'Urban Traffic', N'South East', '1992-12-29', '2001-07-03', 51.280401, 1.087207, 158000.00, 615400.00, 10.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (244, N'UKA13590', N'Not Available', N'Not Available', N'CANTERBURY 5N', N'Urban Traffic', N'South East', '1992-12-29', '2006-01-03', 51.289795, 1.072058, 159000.00, 614300.00, 24.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (245, N'UKA13591', N'Not Available', N'Not Available', N'CANTERBURY 6N', N'Urban Traffic', N'South East', '1992-12-29', '2006-01-03', 51.270562, 1.085113, 156900.00, 615300.00, 34.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (246, N'UKA00002', N'GB0146A', N'Not Available', N'Cardiff 12', N'Suburban', N'Cardiff Urban Area', '1961-04-04', '2014-06-09', 51.489078, -3.164169, 177323.96, 319268.02, 15.00, N'Black Carbon; Black Smoke & SO2', N'Not Available'),
    (247, N'UKA14679', N'Not Available', N'Not Available', N'CARDIFF 2N', N'Urban Traffic', N'South Wales', '1994-12-31', '2000-11-28', 51.476094, -3.182097, 175900.00, 318000.00, 9.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (248, N'UKA14681', N'Not Available', N'Not Available', N'CARDIFF 4N', N'Urban Traffic', N'South Wales', '1994-12-31', '2000-11-28', 51.463639, -3.168819, 174500.00, 318900.00, 8.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (249, N'UKA00232', N'GB0787A', N'Not Available', N'Cardiff East', N'Urban Background', N'Cardiff Urban Area', '1994-01-01', '2002-09-05', 51.488870, -3.163711, 177300.32, 319299.45, 20.00, N'Automatic Hydrocarbon Network', N'Situated off Croft Street in the Roath District of Cardiff.'),
    (250, N'UKA00013', N'GB0899A', N'Not Available', N'Cardiff Kerbside', N'Urban Traffic', N'Cardiff Urban Area', '1973-07-28', '1976-11-23', 51.482431, -3.177940, 176600.00, 318300.00, 22.00, N'Automatic Urban and Rural Monitoring Network (AURN)', N'Kerbside of the busy Queen Street with 30 000 vehicles per day (until November 1975).'),
    (251, N'UKA00453', N'GB0369A', N'Not Available', N'Cardiff Llandaff', N'Urban Traffic', N'Cardiff Urban Area', '2004-01-01', '2013-12-31', 51.488197, -3.228471, 177298.95, 314802.02, 13.00, N'Heavy Metals', N'Not Available'),
    (252, N'UKA00468', N'GB0984A', N'Not Available', N'Cardiff Rumney', N'Urban Background', N'Cardiff Urban Area', '2008-01-01', '2013-12-31', 51.508779, -3.122754, 179470.03, 322177.01, 20.00, N'Heavy Metals', N'Not Available'),
    (253, N'UKA00188', N'GB0338A', N'Not Available', N'Cardington 2', N'Rural Background', N'Eastern', '1991-08-12', '2002-01-02', 52.102777, -0.420000, 246115.26, 508315.99, 30.00, N'UKEAP: Precip-Net', N'Not Available'),
    (254, N'UKA15013', N'Not Available', N'Not Available', N'CARLISLE 2N', N'Urban Traffic', N'North West & Merseyside', '1998-12-29', '2001-12-04', 54.917504, -2.946918, 558500.00, 339400.00, 27.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (255, N'UKA15014', N'Not Available', N'Not Available', N'CARLISLE 3N', N'Urban Traffic', N'North West & Merseyside', '1998-12-29', '2001-12-04', 54.897452, -2.982312, 556300.00, 337100.00, 33.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (256, N'UKA00526', N'GB0925A', N'Not Available', N'Carlisle Roadside', N'Urban Traffic', N'North West & Merseyside', '2008-02-14', '2021-06-30', 54.894834, -2.945307, 555975.97, 339469.19, 11.00, N'Automatic Urban and Rural Monitoring Network (AURN); Non-Automatic Hydrocarbon Network', N'The monitoring station is located within a self-contained air-conditioned housing on the south side of the A595 Castle Way. The surrounding area is open with residential dwellings and light industrial activities.'),
    (257, N'UKA13595', N'Not Available', N'Not Available', N'CARMARTHEN 2N', N'Urban Traffic', N'South Wales', '1992-12-29', '1998-12-29', 51.857673, -4.310248, 220200.00, 241000.00, 20.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (258, N'UKA13596', N'Not Available', N'Not Available', N'CARMARTHEN 3N', N'Urban Traffic', N'South Wales', '1992-12-29', '1998-12-29', 51.859555, -4.305988, 220400.00, 241300.00, 25.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (259, N'UKA13597', N'Not Available', N'Not Available', N'CARMARTHEN 4N', N'Urban Traffic', N'South Wales', '1992-12-29', '1998-12-29', 51.849030, -4.292381, 219200.00, 242200.00, 60.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (260, N'UKA00389', N'GB0173R', N'GB0173R', N'Carradale', N'Rural Background', N'Highland', '1999-03-08', '2022-05-10', 55.582519, -5.496231, 637646.55, 179744.15, 13.00, N'UKEAP: Acid Gases & Aerosol Network; UKEAP: National Ammonia Monitoring Network', N'Not Available'),
    (261, N'UKA00192', N'GB0342A', N'Not Available', N'Carrickfergus 2', N'Rural Background', N'Northern Ireland', '1991-08-13', '1991-11-11', 55.115969, -6.058474, 587700.00, 141300.00, 64.00, N'UKEAP: Precip-Net', N'Not Available'),
    (262, N'UKA15206', N'Not Available', N'Not Available', N'CARRICKFERGUS 2N', N'Urban Traffic', N'Belfast Metropolitan Urban Area', '1999-12-31', '2000-11-28', 55.115969, -6.058474, 587700.00, 141300.00, 12.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (263, N'UKA13598', N'Not Available', N'Not Available', N'CASTLEREAGH 2N', N'Urban Traffic', N'Northern Ireland', '1992-12-29', '2000-11-28', 54.583295, -5.873649, 527800.00, 149800.00, 25.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (264, N'UKA13601', N'Not Available', N'Not Available', N'CASTLEREAGH 6N', N'Urban Traffic', N'Northern Ireland', '1992-12-29', '2008-02-28', 54.587926, -5.869444, 528300.00, 150100.00, 23.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (265, N'UKA00143', N'Not Available', N'Not Available', N'CBS 1', N'Urban Traffic', N'North West & Merseyside', '1986-09-02', '1987-07-28', 53.505462, -2.955860, 401400.00, 336700.00, 5.00, N'Heavy Metals', N'Not Available'),
    (266, N'UKA00144', N'Not Available', N'Not Available', N'CBS 2', N'Urban Traffic', N'North West & Merseyside', '1986-09-02', '1987-07-28', 53.508158, -2.955920, 401700.00, 336700.00, 5.00, N'Heavy Metals', N'Not Available'),
    (267, N'UKA00009', N'GB0204A', N'Not Available', N'Central London', N'Urban Background', N'Greater London Urban Area', '1972-07-01', '1990-08-20', 51.494722, -0.138333, 178951.61, 529333.66, 20.00, N'Automatic Urban and Rural Monitoring Network (AURN); Heavy Metals', N'Situated facing a quiet street within a busy city centre located in Victoria.'),
    (268, N'UKA00514', N'GB0985A', N'Not Available', N'Chadwell St Mary', N'Urban Background', N'Eastern', '2008-01-01', '2023-10-11', 51.481960, 0.370213, 178553.01, 564678.89, 30.00, N'Heavy Metals', N'Not Available'),
    (269, N'UKA13603', N'Not Available', N'Not Available', N'CHELMSFORD 2N', N'Urban Traffic', N'Eastern', '1992-12-29', '2000-11-28', 51.723855, 0.478721, 205700.00, 571300.00, 28.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (270, N'UKA15210', N'Not Available', N'Not Available', N'CHEPSTOW 2N', N'Urban Traffic', N'South Wales', '1999-12-31', '2001-12-04', 51.631137, -2.680440, 192700.00, 353000.00, 62.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (271, N'UKA13607', N'Not Available', N'Not Available', N'CHESHUNT 2N', N'Urban Traffic', N'Eastern', '1992-12-29', '1999-11-30', 51.694007, -0.035155, 201300.00, 535900.00, 22.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (272, N'UKA15211', N'Not Available', N'Not Available', N'CHESHUNT 4N', N'Urban Traffic', N'Eastern', '1999-12-31', '2000-11-28', 51.696679, -0.033592, 201600.00, 536000.00, 22.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (273, N'UKA13609', N'Not Available', N'Not Available', N'CHESTER 2N', N'Urban Traffic', N'North West & Merseyside', '1992-12-29', '2000-11-28', 53.191432, -2.880010, 366400.00, 341300.00, 20.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (274, N'UKA00530', N'GB0929A', N'Not Available', N'Chesterfield', N'Urban Background', N'East Midlands', '2008-03-13', '2014-05-20', 53.230583, -1.433611, 370543.35, 437906.04, 86.00, N'Automatic Urban and Rural Monitoring Network (AURN); Urban Sulphate', N'The monitoring station is located within a self-contained air conditioned housing located adjacent to Queens Park Annex Pavilion. The nearest road Summerfield Road is approximately 100 metres to the South of the station and is a residential access road. The A619 is approximately 390 metres to the North. The immediate area is open with a combination of residenital and commercial properties surrounding the park.'),
    (275, N'UKA15285', N'Not Available', N'Not Available', N'CHICHESTER 10N', N'Urban Traffic', N'South East', '2000-03-02', '2006-06-27', 50.827850, -0.782412, 103852.00, 485851.00, 7.30, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (276, N'UKA15286', N'Not Available', N'Not Available', N'CHICHESTER 11N', N'Urban Traffic', N'South East', '2000-03-02', '2006-06-27', 50.826548, -0.761233, 103732.00, 487345.00, 12.42, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (277, N'UKA15287', N'Not Available', N'Not Available', N'CHICHESTER 12N', N'Urban Traffic', N'South East', '2000-03-02', '2008-07-30', 50.833382, -0.754378, 104500.00, 487815.00, 18.94, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (278, N'UKA15288', N'Not Available', N'Not Available', N'CHICHESTER 13N', N'Urban Traffic', N'South East', '2000-03-02', '2006-06-27', 50.838566, -0.755618, 105075.00, 487718.00, 15.50, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (279, N'UKA15990', N'Not Available', N'Not Available', N'CHICHESTER 18N', N'Urban Traffic', N'South East', '2003-11-04', '2008-10-01', 50.827772, -0.783593, 103842.00, 485768.00, 7.30, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (280, N'UKA13612', N'Not Available', N'Not Available', N'CHICHESTER 1N', N'Urban Traffic', N'South East', '1992-12-29', '2007-11-28', 50.840265, -0.778538, 105237.00, 486101.00, 13.40, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (281, N'UKA13613', N'Not Available', N'Not Available', N'CHICHESTER 2N', N'Urban Traffic', N'South East', '1992-12-29', '2000-11-28', 50.839033, -0.778585, 105100.00, 486100.00, 15.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (282, N'UKA15289', N'Not Available', N'Not Available', N'CHICHESTER 9N', N'Urban Traffic', N'South East', '2000-03-02', '2006-06-27', 50.834588, -0.802615, 104578.00, 484416.00, 4.90, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (283, N'UKA00031', N'GB0900A', N'Not Available', N'Chilworth', N'Suburban Background', N'South East', '1975-04-18', '1975-10-10', 50.962706, -1.424677, 118300.00, 440500.00, 93.00, N'Automatic Urban and Rural Monitoring Network (AURN)', N'Rural site in the new forest.'),
    (284, N'UKA13616', N'Not Available', N'Not Available', N'CHIPPENHAM 2N', N'Urban Traffic', N'South West', '1992-12-29', '2000-11-28', 51.464889, -2.138144, 174000.00, 390500.00, 69.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (285, N'UKA13620', N'Not Available', N'Not Available', N'CHORLEY 1N', N'Urban Traffic', N'Preston Urban Area', '1992-12-29', '2000-11-28', 53.652326, -2.632375, 417500.00, 358300.00, 268.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (286, N'UKA13622', N'Not Available', N'Not Available', N'CHORLEY 5N', N'Urban Traffic', N'Preston Urban Area', '1992-12-29', '2000-11-28', 53.639678, -2.644286, 416100.00, 357500.00, 266.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (287, N'UKA13624', N'Not Available', N'Not Available', N'CHRISTCHURCH 2N', N'Urban Traffic', N'South West', '1992-12-29', '2000-11-28', 50.739119, -1.788793, 93300.00, 415000.00, 6.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (288, N'UKA14545', N'Not Available', N'Not Available', N'CLYDEBANK 2N', N'Urban Traffic', N'Central Scotland', '1993-12-31', '2000-11-28', 55.902244, -4.407198, 670300.00, 249600.00, 8.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (289, N'UKA14546', N'Not Available', N'Not Available', N'CLYDEBANK 3N', N'Urban Traffic', N'Central Scotland', '1993-12-31', '2004-12-31', 55.898903, -4.394193, 669900.00, 250400.00, 7.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (290, N'UKA14547', N'Not Available', N'Not Available', N'CLYDEBANK 4N', N'Urban Traffic', N'Central Scotland', '1993-12-31', '2004-12-31', 55.927567, -4.399163, 673100.00, 250200.00, 76.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (291, N'UKA15449', N'Not Available', N'Not Available', N'CLYDEBANK 5N', N'Urban Traffic', N'Central Scotland', '2001-01-02', '2010-06-30', 55.908793, -4.396442, 671000.00, 250300.00, 0.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (292, N'UKA15450', N'Not Available', N'Not Available', N'COALVILLE 10N', N'Urban Traffic', N'East Midlands', '2001-01-02', '2006-01-03', 52.713762, -1.347156, 313100.00, 444200.00, 160.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (293, N'UKA13628', N'Not Available', N'Not Available', N'COALVILLE 1N', N'Urban Traffic', N'East Midlands', '1992-12-29', '2006-01-03', 52.723801, -1.375138, 314200.00, 442300.00, 150.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (294, N'UKA13629', N'Not Available', N'Not Available', N'COALVILLE 6N', N'Urban Traffic', N'East Midlands', '1992-12-29', '2006-01-03', 52.723714, -1.358852, 314200.00, 443400.00, 160.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (295, N'UKA13630', N'Not Available', N'Not Available', N'COALVILLE 7N', N'Urban Traffic', N'East Midlands', '1992-12-29', '1998-12-29', 52.718376, -1.369293, 313600.00, 442700.00, 160.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (296, N'UKA14548', N'Not Available', N'Not Available', N'COALVILLE 8N', N'Urban Traffic', N'East Midlands', '1993-12-31', '2000-11-28', 52.723801, -1.375138, 314200.00, 442300.00, 150.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (297, N'UKA15016', N'Not Available', N'Not Available', N'COALVILLE 9N', N'Urban Traffic', N'East Midlands', '1998-12-29', '2006-01-03', 52.727196, -1.338071, 314600.00, 444800.00, 160.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (298, N'UKA13632', N'Not Available', N'Not Available', N'COATBRIDGE 2N', N'Urban Traffic', N'Central Scotland', '1992-12-29', '2000-11-28', 55.851681, -4.020628, 663900.00, 273600.00, 81.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (299, N'UKA15451', N'Not Available', N'Not Available', N'COATBRIDGE 3N', N'Urban Traffic', N'Central Scotland', '2001-01-02', '2010-01-14', 55.851681, -4.020628, 663900.00, 273600.00, 87.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (300, N'UKA00459', N'GB0853A', N'Not Available', N'Cockley Beck', N'Rural Background', N'North West & Merseyside', '2003-04-02', '2014-01-16', 54.403489, -3.161372, 501513.34, 324707.91, 220.00, N'Heavy Metals', N'Not Available'),
    (301, N'UKA15452', N'Not Available', N'Not Available', N'CODSALL 15N', N'Urban Traffic', N'West Midlands', '2001-01-02', '2008-01-02', 52.760243, -2.104917, 318076.00, 393017.00, 80.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (302, N'UKA15686', N'Not Available', N'Not Available', N'CODSALL 16N', N'Urban Traffic', N'West Midlands', '2001-01-03', '2008-01-02', 52.634081, -2.052337, 304038.00, 396555.00, 175.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (303, N'UKA16393', N'Not Available', N'Not Available', N'CODSALL 23N', N'Urban Traffic', N'West Midlands', '2005-01-04', '2008-01-02', 52.676716, -2.088121, 308783.00, 394139.00, 105.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (304, N'UKA16395', N'Not Available', N'Not Available', N'CODSALL 26N', N'Urban Traffic', N'West Midlands', '2005-01-04', '2008-01-02', 52.680361, -2.051786, 309186.00, 396596.00, 115.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (305, N'UKA13633', N'Not Available', N'Not Available', N'CODSALL 2N', N'Urban Traffic', N'West Midlands', '1992-12-29', '2005-01-05', 52.670607, -2.020660, 308100.00, 398700.00, 123.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (306, N'UKA15930', N'Not Available', N'Not Available', N'CODSALL 30N', N'Urban Traffic', N'West Midlands', '2003-06-02', '2008-01-02', 52.692939, -2.130987, 310592.00, 391244.00, 100.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (307, N'UKA16397', N'Not Available', N'Not Available', N'CODSALL 31N', N'Urban Traffic', N'West Midlands', '2005-01-04', '2008-01-02', 52.723001, -2.102206, 313933.00, 393194.00, 90.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (308, N'UKA16399', N'Not Available', N'Not Available', N'CODSALL 33N', N'Urban Traffic', N'West Midlands', '2005-01-04', '2008-01-02', 52.690780, -2.115210, 310350.00, 392310.00, 105.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (309, N'UKA16401', N'Not Available', N'Not Available', N'CODSALL 35N', N'Urban Traffic', N'West Midlands', '2005-01-04', '2008-01-02', 52.688127, -2.095334, 310053.00, 393653.00, 105.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (310, N'UKA16402', N'Not Available', N'Not Available', N'CODSALL 36N', N'Urban Traffic', N'West Midlands', '2005-01-04', '2008-01-02', 52.693712, -2.130783, 310678.00, 391258.00, 100.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (311, N'UKA13634', N'Not Available', N'Not Available', N'CODSALL 3N', N'Urban Traffic', N'West Midlands', '1992-12-29', '1999-11-30', 52.664316, -2.013264, 307400.00, 399200.00, 130.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (312, N'UKA13635', N'Not Available', N'Not Available', N'CODSALL 4N', N'Urban Traffic', N'West Midlands', '1992-12-29', '1999-11-30', 52.667013, -2.011787, 307700.00, 399300.00, 128.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (313, N'UKA13636', N'Not Available', N'Not Available', N'CODSALL 5N', N'Urban Traffic', N'West Midlands', '1992-12-29', '1997-12-30', 52.660719, -2.017699, 307000.00, 398900.00, 132.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (314, N'UKA15017', N'Not Available', N'Not Available', N'CODSALL 6N', N'Urban Traffic', N'West Midlands', '1998-12-29', '2008-01-02', 52.653910, -2.036943, 306243.00, 397598.00, 150.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (315, N'UKA15018', N'Not Available', N'Not Available', N'CODSALL 8N', N'Urban Traffic', N'West Midlands', '1998-12-29', '2005-01-05', 52.670608, -2.017703, 308100.00, 398900.00, 122.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (316, N'UKA15453', N'Not Available', N'Not Available', N'CODSALL 9N', N'Urban Traffic', N'West Midlands', '2001-01-02', '2005-01-05', 52.671506, -2.020661, 308200.00, 398700.00, 123.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (317, N'UKA00149', N'Not Available', N'Not Available', N'Cohen 1', N'Urban Traffic', N'Greater London Urban Area', '1986-09-30', '1987-09-22', 51.496545, 0.098972, 179600.00, 545800.00, 2.00, N'Heavy Metals', N'Not Available'),
    (318, N'UKA00150', N'Not Available', N'Not Available', N'Cohen 2', N'Urban Traffic', N'Greater London Urban Area', '1986-09-30', '1987-09-22', 51.495543, 0.104688, 179500.00, 546200.00, 2.00, N'Heavy Metals', N'Not Available'),
    (319, N'UKA00151', N'Not Available', N'Not Available', N'Cohen 3', N'Urban Traffic', N'Greater London Urban Area', '1986-09-30', '1987-09-22', 51.499984, 0.107775, 180000.00, 546400.00, 2.00, N'Heavy Metals', N'Not Available'),
    (320, N'UKA13638', N'Not Available', N'Not Available', N'COLCHESTER 6N', N'Urban Traffic', N'Eastern', '1992-12-29', '2000-11-28', 51.884111, 0.903158, 224600.00, 599900.00, 28.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (321, N'UKA15814', N'GB0778A', N'Not Available', N'COLERAINE 3', N'Suburban', N'Northern Ireland', '2002-04-02', '2005-12-31', 55.134905, -6.651795, 592167.00, 103633.00, 30.00, N'Black Smoke & SO2', N'Not Available'),
    (322, N'UKA13642', N'Not Available', N'Not Available', N'COLWYN BAY 2N', N'Urban Traffic', N'North Wales', '1992-12-29', '2000-11-28', 53.293640, -3.726807, 378800.00, 285000.00, 28.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (323, N'UKA13643', N'Not Available', N'Not Available', N'COLWYN BAY 3N', N'Urban Traffic', N'North Wales', '1992-12-29', '2000-11-28', 53.293727, -3.720809, 378800.00, 285400.00, 24.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (324, N'UKA00087', N'Not Available', N'Not Available', N'Compton', N'Rural Background', N'South East', '1985-12-29', '2007-01-08', 51.520993, -1.264186, 180487.01, 451149.22, 105.00, N'UKEAP: Precip-Net; UKEAP: Rural NO2', N'Not Available'),
    (325, N'UKA14549', N'Not Available', N'Not Available', N'CONGLETON 1N', N'Urban Traffic', N'North West & Merseyside', '1993-12-31', '2010-01-07', 53.164825, -2.215346, 363100.00, 385700.00, 98.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (326, N'UKA14682', N'Not Available', N'Not Available', N'CONGLETON 2N', N'Urban Traffic', N'North West & Merseyside', '1994-12-31', '1998-12-29', 53.165727, -2.213855, 363200.00, 385800.00, 83.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (327, N'UKA14550', N'Not Available', N'Not Available', N'CONGLETON 3N', N'Urban Traffic', N'North West & Merseyside', '1993-12-31', '2010-01-07', 53.166633, -2.209372, 363300.00, 386100.00, 83.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (328, N'UKA14551', N'Not Available', N'Not Available', N'CONGLETON 4N', N'Urban Traffic', N'North West & Merseyside', '1993-12-31', '2010-01-07', 53.176547, -2.194459, 364400.00, 387100.00, 83.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (329, N'UKA15019', N'Not Available', N'Not Available', N'CONGLETON 5N', N'Urban Traffic', N'North West & Merseyside', '1998-12-29', '2000-11-28', 53.164833, -2.210859, 363100.00, 386000.00, 100.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (330, N'UKA15455', N'Not Available', N'Not Available', N'CONGLETON 6N', N'Urban Traffic', N'North West & Merseyside', '2001-01-02', '2010-01-07', 53.164833, -2.210859, 363100.00, 386000.00, 80.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (331, N'UKA15815', N'GB0781A', N'Not Available', N'COOKSTOWN 1', N'Suburban', N'Northern Ireland', '2002-04-02', '2005-12-31', 54.667612, -6.802138, 540878.00, 90489.00, 76.00, N'Black Smoke & SO2', N'Not Available'),
    (332, N'UKA00145', N'Not Available', N'Not Available', N'Cornwall Works 1', N'Urban Traffic', N'Liverpool Urban Area', '1986-09-02', '1987-07-28', 53.450397, -2.734775, 395100.00, 351300.00, 27.00, N'Heavy Metals', N'Not Available'),
    (333, N'UKA00146', N'Not Available', N'Not Available', N'Cornwall Works 2', N'Urban Traffic', N'Liverpool Urban Area', '1986-09-02', '1987-07-28', 53.453992, -2.734837, 395500.00, 351300.00, 35.00, N'Heavy Metals', N'Not Available'),
    (334, N'UKA00197', N'GB0347A', N'Not Available', N'Corpach 1', N'Rural Background', N'Highland', '1991-08-14', '2004-01-07', 56.855149, -5.193407, 778292.16, 205387.82, 5.00, N'UKEAP: Precip-Net', N'Not Available'),
    (335, N'UKA00062', N'GB0362A', N'Not Available', N'Cottered', N'Urban Traffic', N'Eastern', '1983-03-15', '1996-05-28', 51.937510, -0.078360, 228300.00, 532200.00, 125.00, N'Heavy Metals', N'Not Available'),
    (336, N'UKA13651', N'Not Available', N'Not Available', N'COVENTRY 2N', N'Urban Traffic', N'Coventry/Bedworth', '1992-12-29', '2000-11-28', 52.503366, -1.530007, 289600.00, 432000.00, 85.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (337, N'UKA13653', N'Not Available', N'Not Available', N'COVENTRY 4N', N'Urban Traffic', N'Coventry/Bedworth', '1992-12-29', '1994-11-29', 52.407205, -1.538379, 278900.00, 431500.00, 95.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (338, N'UKA00327', N'GB0655A', N'Not Available', N'Coventry Centre', N'Urban Background', N'Coventry/Bedworth', '1997-02-18', '2000-12-31', 52.413450, -1.522133, 279601.83, 432600.60, 100.00, N'Automatic Urban and Rural Monitoring Network (AURN)', N'Top floor of a three storey Victorian Clock Tower.'),
    (339, N'UKA00427', N'GB0739A', N'Not Available', N'Coventry Memorial Park', N'Urban Background', N'Coventry/Bedworth', '2001-02-26', '2014-06-10', 52.394399, -1.519612, 277483.87, 432786.14, 95.00, N'Automatic Urban and Rural Monitoring Network (AURN); Non-Automatic Hydrocarbon Network', N'The monitoring station is located within an aviary building in Memorial Park in Earlsdon. The current location replaced Coventry Centre in February 2001. The closet road to the station is Kenilworth Road (A429) approximately 100 metres to the north. The surrounding area is open parkland with residential dwellings surrounding the park.'),
    (340, N'UKA00100', N'Not Available', N'Not Available', N'Cow Green Reservoir', N'Rural Background', N'North East', '1986-01-14', '2006-02-01', 54.663454, -2.284185, 529856.15, 381766.66, 510.00, N'UKEAP: Precip-Net; UKEAP: Rural NO2', N'Not Available'),
    (341, N'UKA00243', N'GB0392A', N'Not Available', N'Crai', N'Rural Background', N'South Wales', '1995-01-05', '2004-01-01', 51.835555, -3.683611, 216556.76, 284093.44, 280.00, N'UKEAP: Precip-Net', N'Not Available'),
    (342, N'UKA13654', N'Not Available', N'Not Available', N'CRAIGAVON 1N', N'Urban Traffic', N'Northern Ireland', '1992-12-29', '1993-11-30', 54.461556, -6.347056, 516057.00, 118391.00, 22.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (343, N'UKA13655', N'Not Available', N'Not Available', N'CRAIGAVON 2N', N'Urban Traffic', N'Northern Ireland', '1992-12-29', '1993-11-30', 54.473497, -6.345941, 517379.96, 118545.34, 33.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (344, N'UKA13656', N'Not Available', N'Not Available', N'CRAIGAVON 3N', N'Urban Traffic', N'Northern Ireland', '1992-12-29', '1993-11-30', 54.422405, -6.442183, 512090.09, 111955.32, 22.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (345, N'UKA13657', N'Not Available', N'Not Available', N'CRAIGAVON 4N', N'Urban Traffic', N'Northern Ireland', '1992-12-29', '1993-11-30', 54.834304, -6.544354, 558300.00, 108300.00, 50.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (346, N'UKA14938', N'Not Available', N'Not Available', N'CRAIGAVON 6N', N'Urban Traffic', N'Northern Ireland', '1997-12-30', '2000-11-28', 54.841958, -6.556128, 559200.00, 107600.00, 40.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (347, N'UKA13659', N'Not Available', N'Not Available', N'CRAWLEY 2N', N'Urban Traffic', N'South East', '1992-12-29', '2000-11-28', 51.126222, -0.180822, 137900.00, 527400.00, 70.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (348, N'UKA00193', N'GB0343A', N'Not Available', N'Cresselly 1', N'Rural Background', N'South Wales', '1991-08-13', '2004-01-13', 51.718611, -4.803055, 205929.28, 206473.49, 86.00, N'UKEAP: Precip-Net', N'Not Available'),
    (349, N'UKA16007', N'Not Available', N'Not Available', N'CRICKHOWELL 1N', N'Urban Traffic', N'South Wales', '2003-12-03', '2007-04-04', 51.858390, -3.136694, 218367.00, 321815.00, 87.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (350, N'UKA13662', N'Not Available', N'Not Available', N'CRICKHOWELL 2N', N'Urban Traffic', N'South Wales', '1992-12-29', '2000-11-28', 51.857786, -3.136897, 218300.00, 321800.00, 89.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (351, N'UKA13663', N'Not Available', N'Not Available', N'CRICKHOWELL 3N', N'Urban Traffic', N'South Wales', '1992-12-29', '2008-01-02', 51.862266, -3.138462, 218800.00, 321700.00, 84.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (352, N'UKA13664', N'Not Available', N'Not Available', N'CROESPENMAEN 3N', N'Urban Traffic', N'South Wales', '1992-12-29', '2010-01-19', 51.678574, -3.165668, 198400.00, 319500.00, 270.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (353, N'UKA13666', N'Not Available', N'Not Available', N'CROMER 2N', N'Urban Traffic', N'Eastern', '1992-12-29', '2000-11-28', 52.929522, 1.300074, 342000.00, 621900.00, 21.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (354, N'UKA14850', N'Not Available', N'Not Available', N'CROOK 1N', N'Urban Traffic', N'North East', '1996-12-31', '2005-12-31', 54.707950, -1.745445, 534800.00, 416500.00, 140.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (355, N'UKA13669', N'Not Available', N'Not Available', N'CROSBY 2N', N'Urban Traffic', N'North West & Merseyside', '1992-12-29', '2000-11-28', 53.479737, -3.023090, 398600.00, 332200.00, 11.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (356, N'UKA13672', N'Not Available', N'Not Available', N'CROWBOROUGH 2N', N'Urban Traffic', N'South East', '1992-12-29', '2000-11-28', 51.060923, 0.167690, 131300.00, 552000.00, 184.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (357, N'UKA13673', N'Not Available', N'Not Available', N'CROWBOROUGH 3N', N'Urban Traffic', N'South East', '1992-12-29', '1998-12-29', 51.054527, 0.173099, 130600.00, 552400.00, 185.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (358, N'UKA13674', N'Not Available', N'Not Available', N'CUPAR 2N', N'Urban Traffic', N'Central Scotland', '1992-12-29', '2000-11-28', 56.318769, -3.016895, 714500.00, 337200.00, 26.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (359, N'UKA00436', N'GB0744A', N'Not Available', N'Cwmbran', N'Urban Background', N'South Wales', '2001-07-20', '2020-08-07', 51.653800, -3.006953, 195481.48, 330435.61, 71.00, N'Automatic Urban and Rural Monitoring Network (AURN); Non-Automatic Hydrocarbon Network', N'The monitoring station is located within a self contained mobile unit within playing fields adjacent to school buildings. The nearest road the residential access road Turnpike Drive is approximately 200 metres to the east of the station. The surrounding area is urban / semi-rural environment with undulating topography of a valley basin.'),
    (360, N'UKA13676', N'Not Available', N'Not Available', N'CWMCARN 4N', N'Urban Traffic', N'South Wales', '1992-12-29', '2010-01-19', 51.634879, -3.128423, 193500.00, 322000.00, 113.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (361, N'UKA15803', N'Not Available', N'Not Available', N'DA28 Ivy Villas Greenhithe', N'Urban Traffic', N'Greater London Urban Area', '2002-02-26', '2009-12-02', 51.448845, 0.279164, 174670.00, 558472.00, 7.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (362, N'UKA15819', N'Not Available', N'Not Available', N'DA31 Taunton Rd (off London Rd)', N'Urban Traffic', N'Greater London Urban Area', '2002-04-30', '2009-12-02', 51.450120, 0.318707, 174898.00, 561215.00, 8.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (363, N'UKA16704', N'Not Available', N'Not Available', N'DA36 Burnham Road', N'Urban Traffic', N'Greater London Urban Area', '2005-08-01', '2011-01-05', 51.455843, 0.204789, 175290.00, 553281.00, 5.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (364, N'UKA16775', N'Not Available', N'Not Available', N'DA37 Watling Street', N'Urban Traffic', N'Greater London Urban Area', '2005-11-29', '2006-01-03', 51.438421, 0.253636, 173456.00, 556734.00, 52.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (365, N'UKA13680', N'Not Available', N'Not Available', N'DALKEITH 3N', N'Urban Traffic', N'Central Scotland', '1992-12-29', '2000-11-28', 55.892490, -3.061684, 667100.00, 333700.00, 40.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (366, N'UKA13684', N'Not Available', N'Not Available', N'DARLINGTON 6N', N'Urban Traffic', N'North East', '1992-12-29', '2000-11-28', 54.529456, -1.553405, 515000.00, 429000.00, 46.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (367, N'UKA15191', N'Not Available', N'Not Available', N'DARTFORD 2N', N'Urban Traffic', N'Greater London Urban Area', '1999-11-30', '2001-06-01', 51.437955, 0.251685, 173400.00, 556600.00, 55.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (368, N'UKA13685', N'Not Available', N'Not Available', N'DARTFORD 3N', N'Urban Traffic', N'Greater London Urban Area', '1992-12-29', '1999-11-30', 51.441659, 0.246111, 173800.00, 556200.00, 40.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (369, N'UKA13686', N'Not Available', N'Not Available', N'DARTFORD 4N', N'Urban Traffic', N'Greater London Urban Area', '1992-12-29', '1997-12-31', 51.448168, 0.234917, 174500.00, 555400.00, 29.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (370, N'UKA00516', N'GB0986A', N'Not Available', N'Dartford Bean', N'Urban Background', N'South East', '2008-01-01', '2013-12-31', 51.423874, 0.288708, 171914.00, 559221.92, 90.00, N'Heavy Metals', N'Not Available'),
    (371, N'UKA00331', N'GB0161R', N'GB0161R', N'Dennington', N'Rural Background', N'Eastern', '1997-03-03', '2016-10-25', 52.251793, 1.326389, 266726.19, 627146.73, 56.00, N'UKEAP: National Ammonia Monitoring Network', N'Not Available'),
    (372, N'UKA13688', N'Not Available', N'Not Available', N'DERBY 1N', N'Urban Traffic', N'East Midlands', '1992-12-29', '1999-11-30', 52.925577, -1.458513, 336600.00, 436500.00, 45.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (373, N'UKA13689', N'Not Available', N'Not Available', N'DERBY 2N', N'Urban Traffic', N'East Midlands', '1992-12-29', '2000-11-28', 52.926475, -1.458502, 336700.00, 436500.00, 45.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (374, N'UKA13690', N'Not Available', N'Not Available', N'DERBY 5N', N'Urban Traffic', N'East Midlands', '1992-12-29', '2003-12-30', 52.935416, -1.447975, 337700.00, 437200.00, 80.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (375, N'UKA13691', N'Not Available', N'Not Available', N'DERBY 6N', N'Urban Traffic', N'East Midlands', '1992-12-29', '2006-01-03', 52.905047, -1.491478, 334300.00, 434300.00, 81.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (376, N'UKA00343', N'GB0673A', N'Not Available', N'Derry', N'Urban Background', N'Northern Ireland', '1997-04-29', '2016-02-29', 55.001225, -7.329115, 580402.88, 59371.07, 32.00, N'Automatic Urban and Rural Monitoring Network (AURN)', N'The monitoring station is located within a self contained housing in the south east corner of Brooke Park approximately 1 kilometre from the city centre. The park is bounded on three sides by roadways that are periodically subject to congestion during peak traffic flow periods. The closest of these roads is Infirmary Road approximately 60 metres to the south-east of the station. There are mature trees within 10 metres distance.'),
    (377, N'UKA15463', N'Not Available', N'Not Available', N'DERRY 11N', N'Urban Traffic', N'Northern Ireland', '2001-01-02', '2004-11-30', 54.990950, -7.295993, 579100.00, 61400.00, 55.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (378, N'UKA13692', N'Not Available', N'Not Available', N'DERRY 1N', N'Urban Traffic', N'Northern Ireland', '1992-12-29', '2000-11-28', 54.110053, -7.312966, 481300.00, 52900.00, 11.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (379, N'UKA13693', N'Not Available', N'Not Available', N'DERRY 2N', N'Urban Traffic', N'Northern Ireland', '1992-12-29', '1994-11-29', 54.108243, -7.292824, 481000.00, 54200.00, 28.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (380, N'UKA13694', N'Not Available', N'Not Available', N'DERRY 5N', N'Urban Traffic', N'Northern Ireland', '1992-12-29', '2000-11-28', 55.001471, -7.281727, 580200.00, 62400.00, 30.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (381, N'UKA13695', N'Not Available', N'Not Available', N'DERRY 6N', N'Urban Traffic', N'Northern Ireland', '1992-12-29', '2000-11-28', 55.013670, -7.311524, 581700.00, 60600.00, 15.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (382, N'UKA14553', N'Not Available', N'Not Available', N'DERRY 7N', N'Urban Traffic', N'Northern Ireland', '1993-12-31', '2000-11-28', 55.008982, -7.295244, 581100.00, 61600.00, 26.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (383, N'UKA13698', N'Not Available', N'Not Available', N'DEVIZES 6N', N'Urban Traffic', N'South West', '1992-12-29', '2000-11-28', 51.353475, -1.994207, 161600.00, 400500.00, 131.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (384, N'UKA00115', N'Not Available', N'Not Available', N'Devoke Water', N'Rural Background', N'North West & Merseyside', '1986-01-21', '1989-01-03', 54.364318, -3.289672, 497300.00, 316300.00, 235.00, N'UKEAP: Precip-Net', N'Not Available'),
    (385, N'UKA14554', N'Not Available', N'Not Available', N'DINGWALL 10N', N'Urban Traffic', N'Highland', '1993-12-31', '1994-11-29', 57.593947, -4.437654, 858600.00, 254400.00, 25.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (386, N'UKA13700', N'Not Available', N'Not Available', N'DINGWALL 5N', N'Urban Traffic', N'Highland', '1992-12-29', '1993-11-30', 57.595871, -4.431088, 858800.00, 254800.00, 3.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (387, N'UKA13701', N'Not Available', N'Not Available', N'DINGWALL 6N', N'Urban Traffic', N'Highland', '1992-12-29', '1999-11-30', 57.595839, -4.432760, 858800.00, 254700.00, 5.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (388, N'UKA13702', N'Not Available', N'Not Available', N'DINGWALL 7N', N'Urban Traffic', N'Highland', '1992-12-29', '1994-11-29', 57.603179, -4.424880, 859600.00, 255200.00, 20.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (389, N'UKA13703', N'Not Available', N'Not Available', N'DINGWALL 8N', N'Urban Traffic', N'Highland', '1992-12-29', '1994-11-29', 57.594877, -4.436043, 858700.00, 254500.00, 15.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (390, N'UKA14556', N'Not Available', N'Not Available', N'DINGWALL 9N', N'Urban Traffic', N'Highland', '1993-12-31', '2004-02-28', 57.604044, -4.426612, 859700.00, 255100.00, 28.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (391, N'UKA13705', N'Not Available', N'Not Available', N'DONCASTER 2N', N'Urban Traffic', N'Yorkshire & Humberside', '1992-12-29', '1997-12-30', 53.524151, -1.137165, 403400.00, 457300.00, 10.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (392, N'UKA13706', N'Not Available', N'Not Available', N'DONCASTER 3N', N'Urban Traffic', N'Yorkshire & Humberside', '1992-12-29', '2001-12-04', 53.532018, -1.106831, 404300.00, 459300.00, 20.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (393, N'UKA14851', N'Not Available', N'Not Available', N'DONCASTER 5N', N'Urban Traffic', N'Yorkshire & Humberside', '1996-12-31', '2000-11-28', 53.523263, -1.138691, 403300.00, 457200.00, 10.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (394, N'UKA13709', N'Not Available', N'Not Available', N'DORKING 2N', N'Urban Traffic', N'South East', '1992-12-29', '1999-11-30', 51.235397, -0.325497, 149800.00, 517000.00, 55.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (395, N'UKA13712', N'Not Available', N'Not Available', N'DOUGLAS IOM 2N', N'Urban Traffic', N'Not Available', '1992-12-29', '2000-11-28', 54.148802, -4.481933, 475400.00, 238000.00, 12.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (396, N'UKA14480', N'Not Available', N'Not Available', N'DOVER 3N', N'Urban Traffic', N'South East', '1992-12-31', '2006-01-03', 51.124661, 1.289782, 141300.00, 630300.00, 33.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (397, N'UKA13716', N'Not Available', N'Not Available', N'DOVER 7N', N'Urban Traffic', N'South East', '1992-12-29', '2001-01-02', 51.129564, 1.307285, 141900.00, 631500.00, 10.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (398, N'UKA13717', N'Not Available', N'Not Available', N'DOWNPATRICK 2N', N'Urban Traffic', N'Northern Ireland', '1992-12-29', '2000-11-28', 54.344353, -5.692564, 500600.00, 160100.00, 1.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (399, N'UKA00283', N'Not Available', N'GB0122R', N'Drayton', N'Rural Background', N'West Midlands', '1996-09-04', '2011-09-28', 52.192291, -1.760705, 254921.53, 416454.63, 135.00, N'UKEAP: National Ammonia Monitoring Network; UKEAP: Precip-Net', N'Not Available'),
    (400, N'UKA00562', N'GB0123R', N'GB0123R', N'Drayton 2', N'Rural Background', N'West Midlands', '2011-08-31', '2014-05-15', 52.188745, -1.756915, 254527.98, 416715.03, 49.00, N'UKEAP: National Ammonia Monitoring Network', N'Not Available'),
    (401, N'UKA00608', N'GB1050A', N'Not Available', N'Drayton 3', N'Rural Background', N'West Midlands', '2014-09-11', '2019-06-19', 52.192355, -1.761523, 254928.47, 416398.69, 49.00, N'UKEAP: National Ammonia Monitoring Network', N'Not Available'),
    (402, N'UKA00101', N'Not Available', N'Not Available', N'Driby', N'Rural Background', N'East Midlands', '1986-01-14', '2008-04-14', 53.248263, 0.077523, 374374.14, 538715.12, 47.00, N'UKEAP: Precip-Net; UKEAP: Rural NO2', N'Not Available'),
    (403, N'UKA13718', N'Not Available', N'Not Available', N'DUDLEY 1N', N'Urban Traffic', N'West Midlands Urban Area', '1992-12-29', '1997-12-30', 52.457493, -2.116217, 284400.00, 392200.00, 100.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (404, N'UKA13719', N'Not Available', N'Not Available', N'DUDLEY 2N', N'Urban Traffic', N'West Midlands Urban Area', '1992-12-29', '2000-11-28', 52.521356, -2.073646, 291500.00, 395100.00, 151.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (405, N'UKA13720', N'Not Available', N'Not Available', N'DUDLEY 3N', N'Urban Traffic', N'West Midlands Urban Area', '1992-12-29', '2002-12-31', 52.474520, -2.161901, 286300.00, 389100.00, 71.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (406, N'UKA13721', N'Not Available', N'Not Available', N'DUDLEY 4N', N'Urban Traffic', N'West Midlands Urban Area', '1992-12-29', '1999-11-30', 52.449441, -2.066169, 283500.00, 395600.00, 152.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (407, N'UKA15472', N'Not Available', N'Not Available', N'DUDLEY 7N', N'Urban Traffic', N'West Midlands Urban Area', '2001-01-02', '2003-03-04', 52.481760, -2.122171, 287100.00, 391800.00, 150.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (408, N'UKA00539', N'GB0991A', N'Not Available', N'Dudley Centre', N'Urban Background', N'West Midlands Urban Area', '2008-10-29', '2012-01-19', 52.511459, -2.085417, 290399.91, 394300.00, 205.00, N'Black Carbon', N'Not Available'),
    (409, N'UKA13724', N'Not Available', N'Not Available', N'DUMBARTON 2N', N'Urban Traffic', N'Central Scotland', '1992-12-29', '1994-11-29', 55.942642, -4.589120, 675200.00, 238400.00, 10.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (410, N'UKA13725', N'Not Available', N'Not Available', N'DUMBARTON 6N', N'Urban Traffic', N'Central Scotland', '1992-12-29', '1995-11-28', 55.945238, -4.550853, 675400.00, 240800.00, 9.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (411, N'UKA13726', N'Not Available', N'Not Available', N'DUMBARTON 7N', N'Urban Traffic', N'Central Scotland', '1992-12-29', '2010-07-30', 55.944571, -4.582842, 675400.00, 238800.00, 30.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (412, N'UKA14683', N'Not Available', N'Not Available', N'DUMBARTON 8N', N'Urban Traffic', N'Central Scotland', '1994-12-31', '2000-11-28', 55.942413, -4.557073, 675100.00, 240400.00, 15.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (413, N'UKA14767', N'Not Available', N'Not Available', N'DUMBARTON 9N', N'Urban Traffic', N'Central Scotland', '1995-12-31', '2010-07-30', 55.944308, -4.552393, 675300.00, 240700.00, 30.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (414, N'UKA00368', N'GB0165R', N'GB0165R', N'Dumfries Grannoch', N'Rural Background', N'Scottish Borders', '1998-04-08', '2017-03-01', 54.966000, -4.271960, 565848.27, 254649.89, 145.00, N'UKEAP: National Ammonia Monitoring Network', N'Not Available'),
    (415, N'UKA13727', N'Not Available', N'Not Available', N'DUNDEE 1N', N'Urban Traffic', N'North East Scotland', '1992-12-29', '1996-12-31', 56.462000, -2.970410, 730400.00, 340300.00, 805.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (416, N'UKA13728', N'Not Available', N'Not Available', N'DUNDEE 2N', N'Urban Traffic', N'North East Scotland', '1992-12-29', '1995-11-28', 56.461114, -2.968765, 730300.00, 340400.00, 80.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (417, N'UKA13731', N'Not Available', N'Not Available', N'DUNFERMLINE 2N', N'Urban Traffic', N'Central Scotland', '1992-12-29', '2000-11-28', 56.078640, -3.482956, 688300.00, 307800.00, 104.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (418, N'UKA13734', N'Not Available', N'Not Available', N'DUNFERMLINE 7N', N'Urban Traffic', N'Central Scotland', '1992-12-29', '1998-12-29', 56.077877, -3.471679, 688200.00, 308500.00, 108.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (419, N'UKA14943', N'Not Available', N'Not Available', N'DUNGANNON 2N', N'Urban Traffic', N'Northern Ireland', '1997-12-30', '2000-11-28', 54.963844, -6.801354, 573800.00, 92800.00, 120.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (420, N'UKA15159', N'GB0706A', N'Not Available', N'DUNMURRY 3', N'Suburban', N'Belfast Metropolitan Urban Area', '1999-03-30', '2005-12-31', 54.539558, -6.013334, 523444.00, 140501.00, 45.00, N'Black Smoke & SO2', N'Not Available'),
    (421, N'UKA13735', N'Not Available', N'Not Available', N'DUNSTABLE 2N', N'Urban Traffic', N'Eastern', '1992-12-29', '2000-11-28', 51.886319, -0.517923, 221900.00, 502100.00, 145.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (422, N'UKA13740', N'Not Available', N'Not Available', N'DURHAM 2N', N'Urban Traffic', N'North East', '1992-12-29', '2000-11-28', 54.777570, -1.575552, 542600.00, 427400.00, 46.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (423, N'UKA13746', N'Not Available', N'Not Available', N'EALING 2N', N'Urban Traffic', N'Greater London Urban Area', '1992-12-29', '2000-11-28', 51.513037, -0.309572, 180700.00, 517400.00, 30.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (424, N'UKA00319', N'GB0119R', N'GB0119R', N'Easingwold', N'Rural Background', N'Yorkshire & Humberside', '1997-01-07', '2016-12-05', 54.101685, -1.180914, 467620.39, 453658.49, 30.00, N'UKEAP: National Ammonia Monitoring Network', N'Not Available'),
    (425, N'UKA00032', N'GB0901A', N'Not Available', N'East Kilbride', N'Suburban Background', N'Central Scotland', '1975-05-08', '1975-10-09', 55.754737, -4.171789, 653400.00, 263800.00, 197.00, N'Automatic Urban and Rural Monitoring Network (AURN)', N'Open area in new town.'),
    (426, N'UKA13750', N'Not Available', N'Not Available', N'EAST KILBRIDE 2N', N'Urban Traffic', N'Central Scotland', '1992-12-29', '2000-11-28', 55.761907, -4.175412, 654200.00, 263600.00, 170.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (427, N'UKA00102', N'GB0090R', N'GB0090R', N'East Ruston', N'Rural Background', N'Eastern', '1986-01-14', '1989-01-03', 52.797222, 1.479733, 327860.47, 634684.18, 2.00, N'UKEAP: Precip-Net', N'Not Available'),
    (428, N'UKA13754', N'Not Available', N'Not Available', N'EASTBOURNE 2N', N'Urban Traffic', N'South East', '1992-12-29', '2000-11-28', 50.770863, 0.286156, 99300.00, 561300.00, 4.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (429, N'UKA13757', N'Not Available', N'Not Available', N'EASTHAM WIRRAL 1N', N'Urban Traffic', N'Birkenhead Urban Area', '1992-12-29', '1993-11-30', 53.322960, -2.959282, 381100.00, 336200.00, 30.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (430, N'UKA14482', N'Not Available', N'Not Available', N'EASTLEIGH 1N', N'Urban Traffic', N'Southampton Urban Area', '1992-12-31', '2005-05-03', 50.973256, -1.377546, 119500.00, 443800.00, 15.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (431, N'UKA13758', N'Not Available', N'Not Available', N'EASTLEIGH 2N', N'Urban Traffic', N'Southampton Urban Area', '1992-12-29', '2000-11-28', 50.972311, -1.369013, 119400.00, 444400.00, 10.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (432, N'UKA13761', N'Not Available', N'Not Available', N'EDINBURGH 1N', N'Urban Traffic', N'Edinburgh Urban Area', '1992-12-29', '1996-12-31', 55.943355, -3.287238, 673000.00, 319700.00, 50.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (433, N'UKA13762', N'Not Available', N'Not Available', N'EDINBURGH 2N', N'Urban Traffic', N'Edinburgh Urban Area', '1992-12-29', '1996-12-31', 55.943372, -3.285637, 673000.00, 319800.00, 55.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (434, N'UKA00218', N'GB0581A', N'Not Available', N'Edinburgh Centre', N'Urban Background', N'Edinburgh Urban Area', '1992-10-04', '2003-10-13', 55.951970, -3.195775, 673861.23, 325427.92, 40.00, N'Automatic Urban and Rural Monitoring Network (AURN)', N'Urban parkland (East Princes Street Gardens) 35 m from major road.'),
    (435, N'UKA00227', N'GB0786A', N'Not Available', N'Edinburgh Med. Sch.', N'Urban Background', N'Edinburgh Urban Area', '1993-05-13', '2006-01-18', 55.944270, -3.191183, 672999.34, 325699.89, 30.00, N'Automatic Hydrocarbon Network; Non-Automatic Hydrocarbon Network; UKEAP: National Ammonia Monitoring Network', N'Not Available'),
    (436, N'UKA00074', N'Not Available', N'Not Available', N'Elkington 1', N'Urban Traffic', N'West Midlands Urban Area', '1985-06-04', '1985-11-26', 52.619367, -1.982232, 302400.00, 401300.00, 145.00, N'Heavy Metals', N'Not Available'),
    (437, N'UKA00075', N'Not Available', N'Not Available', N'Elkington 2', N'Urban Traffic', N'West Midlands', '1985-06-04', '1985-11-26', 52.622062, -1.974845, 302700.00, 401800.00, 136.00, N'Heavy Metals', N'Not Available'),
    (438, N'UKA00076', N'Not Available', N'Not Available', N'Elkington 3', N'Urban Traffic', N'West Midlands Urban Area', '1985-06-04', '1985-11-26', 52.615770, -1.979279, 302000.00, 401500.00, 148.00, N'Heavy Metals', N'Not Available'),
    (439, N'UKA13766', N'Not Available', N'Not Available', N'ELLESMERE PORT 2N', N'Urban Traffic', N'Birkenhead Urban Area', '1992-12-29', '2004-11-03', 53.277557, -2.902774, 376000.00, 339900.00, 29.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (440, N'UKA13767', N'Not Available', N'Not Available', N'ELLESMERE PORT 4N', N'Urban Traffic', N'Birkenhead Urban Area', '1992-12-29', '2006-01-31', 53.273165, -2.889186, 375500.00, 340800.00, 16.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (441, N'UKA13768', N'Not Available', N'Not Available', N'ELLESMERE PORT 5N', N'Urban Traffic', N'Birkenhead Urban Area', '1992-12-29', '2000-11-28', 53.295135, -2.954157, 378000.00, 336500.00, 35.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (442, N'UKA13769', N'Not Available', N'Not Available', N'ELLESMERE PORT 6N', N'Urban Traffic', N'Birkenhead Urban Area', '1992-12-29', '2006-01-31', 53.265747, -2.919018, 374700.00, 338800.00, 33.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (443, N'UKA00273', N'GB0117R', N'GB0117R', N'Ellon', N'Rural Background', N'North East Scotland', '1996-09-02', '2015-12-26', 57.363340, -2.089927, 830321.98, 394689.37, 11.00, N'UKEAP: National Ammonia Monitoring Network', N'Not Available'),
    (444, N'UKA00131', N'Not Available', N'Not Available', N'Elswick 1', N'Urban Traffic', N'Tyneside', '1986-04-29', '1996-03-26', 54.961959, -1.626712, 563100.00, 424000.00, 20.00, N'Heavy Metals', N'Not Available'),
    (445, N'UKA00132', N'Not Available', N'Not Available', N'Elswick 2', N'Urban Traffic', N'Tyneside', '1986-04-29', '1996-05-28', 54.966413, -1.614175, 563600.00, 424800.00, 25.00, N'Heavy Metals', N'Not Available'),
    (446, N'UKA00133', N'Not Available', N'Not Available', N'Elswick 3', N'Urban Traffic', N'Tyneside', '1986-04-29', '1990-02-20', 54.969129, -1.620397, 563900.00, 424400.00, 40.00, N'Heavy Metals', N'Not Available'),
    (447, N'UKA00164', N'Not Available', N'Not Available', N'Elswick 4', N'Urban Traffic', N'Tyneside', '1987-03-31', '1988-10-25', 54.966457, -1.628232, 563600.00, 423900.00, 42.00, N'Heavy Metals', N'Not Available'),
    (448, N'UKA00165', N'Not Available', N'Not Available', N'Elswick 5', N'Urban Traffic', N'Tyneside', '1987-03-31', '1988-10-25', 54.959249, -1.622052, 562800.00, 424300.00, 15.00, N'Heavy Metals', N'Not Available'),
    (449, N'UKA14685', N'Not Available', N'Not Available', N'ELY CAMBS 2N', N'Urban Traffic', N'Eastern', '1994-12-31', '2000-11-28', 52.396357, 0.261946, 280000.00, 554000.00, 21.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (450, N'UKA13771', N'Not Available', N'Not Available', N'ENFIELD 2N', N'Urban Traffic', N'Greater London Urban Area', '1992-12-29', '2000-11-28', 51.649807, -0.026948, 196400.00, 536600.00, 14.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (451, N'UKA15485', N'Not Available', N'Not Available', N'ENFIELD 5N', N'Urban Traffic', N'Greater London Urban Area', '2001-01-02', '2007-05-02', 51.345223, -0.097496, 162400.00, 532600.00, 22.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (452, N'UKA13775', N'Not Available', N'Not Available', N'EPPING 2N', N'Urban Traffic', N'Eastern', '1992-12-29', '2000-11-28', 51.702177, 0.115712, 202500.00, 546300.00, 110.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (453, N'UKA13779', N'Not Available', N'Not Available', N'EPSOM 2N', N'Urban Traffic', N'Greater London Urban Area', '1992-12-29', '2000-11-28', 51.333450, -0.265942, 160800.00, 520900.00, 50.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (454, N'UKA13781', N'Not Available', N'Not Available', N'EPSOM 4N', N'Urban Traffic', N'Greater London Urban Area', '1992-12-29', '1998-12-29', 51.358487, -0.256379, 163600.00, 521500.00, 60.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (455, N'UKA13783', N'Not Available', N'Not Available', N'ESHER 2N', N'Urban Traffic', N'South East', '1992-12-29', '2000-11-28', 51.370806, -0.362226, 164800.00, 514100.00, 30.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (456, N'UKA00194', N'GB0344A', N'Not Available', N'Etton 1', N'Rural Background', N'Yorkshire & Humberside', '1991-08-13', '2004-01-04', 53.884444, -0.508888, 444169.44, 498109.34, 24.00, N'UKEAP: Precip-Net', N'Not Available'),
    (457, N'UKA13786', N'Not Available', N'Not Available', N'EXETER 2N', N'Urban Traffic', N'South West', '1992-12-29', '2000-11-28', 50.721452, -3.508674, 92400.00, 293600.00, 56.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (458, N'UKA13790', N'Not Available', N'Not Available', N'EXMOUTH 2N', N'Urban Traffic', N'South West', '1992-12-29', '2000-11-28', 50.621937, -3.412182, 81200.00, 300200.00, 2.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (459, N'UKA00231', N'GB0389A', N'Not Available', N'Fairseat', N'Rural Background', N'South East', '1993-10-12', '2004-01-01', 51.320833, 0.328055, 160542.65, 562321.08, 210.00, N'UKEAP: Precip-Net', N'Not Available'),
    (460, N'UKA13794', N'Not Available', N'Not Available', N'FALKIRK 14N', N'Urban Traffic', N'Central Scotland', '1992-12-29', '2000-11-28', 55.998494, -3.768526, 679800.00, 289800.00, 30.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (461, N'UKA13796', N'Not Available', N'Not Available', N'FALKIRK 4N', N'Urban Traffic', N'Central Scotland', '1992-12-29', '2009-04-29', 55.998808, -3.771747, 679840.00, 289600.00, 30.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (462, N'UKA13800', N'Not Available', N'Not Available', N'FAREHAM 5N', N'Urban Traffic', N'Portsmouth Urban Area', '1992-12-29', '2000-11-28', 50.853396, -1.188778, 106300.00, 457200.00, 17.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (463, N'UKA13801', N'Not Available', N'Not Available', N'FAREHAM 6N', N'Urban Traffic', N'Portsmouth Urban Area', '1992-12-29', '1994-11-29', 50.848118, -1.205915, 105700.00, 456000.00, 14.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (464, N'UKA14557', N'Not Available', N'Not Available', N'FAREHAM 8N', N'Urban Traffic', N'Portsmouth Urban Area', '1993-12-31', '1995-11-28', 50.847248, -1.210191, 105600.00, 455700.00, 17.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (465, N'UKA14772', N'Not Available', N'Not Available', N'FAREHAM 9N', N'Urban Traffic', N'Portsmouth Urban Area', '1995-12-31', '1998-12-29', 50.848204, -1.218698, 105700.00, 455100.00, 33.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (466, N'UKA13803', N'Not Available', N'Not Available', N'FARNHAM 1N', N'Urban Traffic', N'South East', '1992-12-29', '1998-12-29', 51.217063, -0.811565, 147100.00, 483100.00, 69.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (467, N'UKA13804', N'Not Available', N'Not Available', N'FARNHAM 2N', N'Urban Traffic', N'South East', '1992-12-29', '2000-11-28', 51.216164, -0.811588, 147000.00, 483100.00, 69.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (468, N'UKA00177', N'GB0516A', N'Not Available', N'Featherstone', N'Urban Background', N'Yorkshire & Humberside', '1989-09-14', '1991-03-13', 53.670222, -1.352146, 419500.00, 442900.00, 50.00, N'Automatic Urban and Rural Monitoring Network (AURN)', N'A residential area - 1 km south of a colliery.'),
    (469, N'UKA13807', N'Not Available', N'Not Available', N'FELIXSTOWE 1N', N'Urban Traffic', N'Eastern', '1992-12-29', '2004-03-31', 51.967576, 1.349745, 235200.00, 630200.00, 20.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (470, N'UKA13808', N'Not Available', N'Not Available', N'FELIXSTOWE 2N', N'Urban Traffic', N'Eastern', '1992-12-29', '2000-11-28', 51.968474, 1.349812, 235300.00, 630200.00, 20.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (471, N'UKA13809', N'Not Available', N'Not Available', N'FELIXSTOWE 3N', N'Urban Traffic', N'Eastern', '1992-12-29', '2000-11-28', 51.964110, 1.345118, 234800.00, 629900.00, 22.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (472, N'UKA13810', N'Not Available', N'Not Available', N'FELIXSTOWE 4N', N'Urban Traffic', N'Eastern', '1992-12-29', '1996-12-31', 51.962964, 1.353769, 234700.00, 630500.00, 20.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (473, N'UKA14773', N'Not Available', N'Not Available', N'FELIXSTOWE 5N', N'Urban Traffic', N'Eastern', '1995-12-31', '2010-01-31', 51.969122, 1.358597, 235400.00, 630800.00, 19.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (474, N'UKA15490', N'Not Available', N'Not Available', N'FELIXSTOWE 6N', N'Urban Traffic', N'Eastern', '2001-01-02', '2002-12-31', 51.967576, 1.349745, 235200.00, 630200.00, 21.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (475, N'UKA15218', N'Not Available', N'Not Available', N'FELIXSTOWE 7N', N'Urban Traffic', N'Eastern', '1999-12-31', '2004-03-31', 51.964966, 1.346638, 234900.00, 630000.00, 21.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (476, N'UKA15750', N'Not Available', N'Not Available', N'FELIXSTOWE 9N', N'Urban Traffic', N'Eastern', '2002-01-01', '2004-03-31', 51.976743, 1.375189, 236300.00, 631900.00, 13.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (477, N'UKA13812', N'Not Available', N'Not Available', N'FISHGUARD 6N', N'Urban Traffic', N'South Wales', '1992-12-29', '2001-12-04', 51.991185, -4.972632, 236700.00, 196000.00, 67.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (478, N'UKA13814', N'Not Available', N'Not Available', N'FOLKESTONE 2N', N'Urban Traffic', N'South East', '1992-12-29', '1994-11-29', 51.093508, 1.180437, 137500.00, 622800.00, 51.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (479, N'UKA13815', N'Not Available', N'Not Available', N'FOLKESTONE 3N', N'Urban Traffic', N'South East', '1992-12-29', '2009-03-31', 51.078864, 1.156584, 135800.00, 621200.00, 53.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (480, N'UKA14498', N'Not Available', N'Not Available', N'FOLKESTONE 4N', N'Urban Traffic', N'South East', '1993-02-01', '2006-01-05', 51.080956, 1.078186, 135800.00, 615700.00, 40.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (481, N'UKA13816', N'Not Available', N'Not Available', N'FOLKESTONE 5N', N'Urban Traffic', N'South East', '1992-12-29', '2009-03-31', 51.087693, 1.195748, 136900.00, 623900.00, 48.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (482, N'UKA14688', N'Not Available', N'Not Available', N'FOLKESTONE 6N', N'Urban Traffic', N'South East', '1994-12-31', '2001-01-02', 51.093586, 1.177585, 137500.00, 622600.00, 51.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (483, N'UKA00502', N'GB0931A', N'Not Available', N'Folkestone Suburban', N'Suburban Background', N'South East', '2007-01-03', '2012-01-16', 51.087061, 1.159491, 136720.07, 621364.43, 35.00, N'Black Carbon', N'Not Available'),
    (484, N'UKA00438', N'Not Available', N'Not Available', N'Formoyle', N'Rural Background', N'Northern Ireland', '2001-12-06', '2004-01-22', 55.103243, -6.799130, 589284.18, 94008.29, 195.00, N'UKEAP: Precip-Net', N'Not Available'),
    (485, N'UKA00300', N'GB0396A', N'Not Available', N'Forsinain', N'Rural Background', N'Highland', '1996-10-29', '2004-01-25', 58.395971, -3.873323, 946810.84, 290599.42, 70.00, N'UKEAP: Precip-Net', N'Not Available'),
    (486, N'UKA00490', N'Not Available', N'Not Available', N'Forsinain 2', N'Rural Background', N'Highland', '2006-01-02', '2014-12-09', 58.411943, -3.875950, 948593.07, 290495.50, 70.00, N'UKEAP: Precip-Net; UKEAP: Rural NO2', N'Not Available'),
    (487, N'UKA00224', N'Not Available', N'Not Available', N'Forsinard', N'Rural Background', N'Highland', '1993-02-26', '2006-01-01', 58.356969, -3.898604, 942510.75, 288999.37, 153.00, N'UKEAP: Precip-Net; UKEAP: Rural NO2', N'Not Available'),
    (488, N'UKA00093', N'GB0301A', N'Not Available', N'Fort Augustus', N'Rural Background', N'Highland', '1986-01-12', '1989-01-03', 57.143704, -4.702226, 809108.21, 236597.78, 40.00, N'UKEAP: Precip-Net; UKEAP: Precip-Net', N'Not Available'),
    (489, N'UKA00090', N'Not Available', N'Not Available', N'Fourmile Burn', N'Rural Background', N'Northern Ireland', '1986-01-07', '1990-01-31', 54.754651, -6.078173, 547600.00, 137700.00, 110.00, N'UKEAP: Precip-Net', N'Not Available'),
    (490, N'UKA13818', N'Not Available', N'Not Available', N'FROME 2N', N'Urban Traffic', N'South West', '1992-12-29', '1995-11-28', 51.232541, -2.322206, 148200.00, 377600.00, 80.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (491, N'UKA14689', N'Not Available', N'Not Available', N'FROME 5N', N'Urban Traffic', N'South West', '1994-12-31', '2000-11-28', 51.230743, -2.322194, 148000.00, 377600.00, 90.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (492, N'UKA13820', N'Not Available', N'Not Available', N'GAINSBOROUGH 1N', N'Urban Traffic', N'East Midlands', '1992-12-29', '2000-11-28', 53.401411, -0.772650, 390100.00, 481700.00, 10.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (493, N'UKA13821', N'Not Available', N'Not Available', N'GAINSBOROUGH 2N', N'Urban Traffic', N'East Midlands', '1992-12-29', '2000-11-28', 53.399675, -0.778716, 389900.00, 481300.00, 5.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (494, N'UKA13822', N'Not Available', N'Not Available', N'GAINSBOROUGH 3N', N'Urban Traffic', N'East Midlands', '1992-12-29', '1995-11-28', 53.405796, -0.761993, 390600.00, 482400.00, 35.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (495, N'UKA13823', N'Not Available', N'Not Available', N'GAINSBOROUGH 4N', N'Urban Traffic', N'East Midlands', '1992-12-29', '2001-12-04', 53.404138, -0.775580, 390400.00, 481500.00, 5.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (496, N'UKA14690', N'Not Available', N'Not Available', N'GAINSBOROUGH 5N', N'Urban Traffic', N'East Midlands', '1994-12-31', '2001-12-04', 53.405036, -0.775554, 390500.00, 481500.00, 8.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (497, N'UKA15492', N'Not Available', N'Not Available', N'GAINSBOROUGH 6N', N'Urban Traffic', N'East Midlands', '2001-01-02', '2001-12-04', 53.393323, -0.772882, 389200.00, 481700.00, 6.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (498, N'UKA15493', N'Not Available', N'Not Available', N'GAINSBOROUGH 7N', N'Urban Traffic', N'East Midlands', '2001-01-02', '2001-12-04', 53.400528, -0.774179, 390000.00, 481600.00, 5.00, N'Defra NO2 Diffusion Tube', N'Not Available'),
    (499, N'UKA00363', N'GB0410A', N'Not Available', N'Garrary 1', N'Rural Background', N'Scottish Borders', '1997-11-07', '1999-08-06', 55.083692, -4.301392, 579003.35, 253197.25, 220.00, N'UKEAP: Precip-Net', N'Not Available'),
    (500, N'UKA13827', N'Not Available', N'Not Available', N'GATESHEAD 6N', N'Urban Traffic', N'Tyneside', '1992-12-29', '2000-11-28', 54.895299, -1.577434, 555700.00, 427200.00, 37.00, N'Defra NO2 Diffusion Tube', N'Not Available');
GO

-- Views used by the difficult queries.

IF OBJECT_ID('dbo.vw_zone_summary_500', 'V') IS NOT NULL DROP VIEW dbo.vw_zone_summary_500;
GO
CREATE VIEW dbo.vw_zone_summary_500 AS
SELECT
    zone,
    COUNT(*) AS total_sites,
    COUNT(DISTINCT environment_type) AS environment_type_count,
    ROUND(AVG(CAST(altitude_m AS FLOAT)), 2) AS avg_altitude_m,
    MIN(latitude) AS min_latitude,
    MAX(latitude) AS max_latitude,
    MIN(longitude) AS min_longitude,
    MAX(longitude) AS max_longitude,
    MIN(start_date) AS first_start_date,
    MAX(end_date) AS last_end_date,
    ROUND(AVG(CAST(DATEDIFF(DAY, start_date, end_date) AS FLOAT) / 365.25), 2) AS avg_operational_years
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
GROUP BY zone;
GO

IF OBJECT_ID('dbo.vw_environment_summary_500', 'V') IS NOT NULL DROP VIEW dbo.vw_environment_summary_500;
GO
CREATE VIEW dbo.vw_environment_summary_500 AS
SELECT
    environment_type,
    COUNT(*) AS total_sites,
    COUNT(DISTINCT zone) AS zones_covered,
    ROUND(AVG(CAST(altitude_m AS FLOAT)), 2) AS avg_altitude_m,
    MIN(start_date) AS earliest_start_date,
    MAX(end_date) AS latest_end_date,
    ROUND(AVG(CAST(DATEDIFF(DAY, start_date, end_date) AS FLOAT) / 365.25), 2) AS avg_operational_years
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
GROUP BY environment_type;
GO

IF OBJECT_ID('dbo.vw_site_lifecycle_500', 'V') IS NOT NULL DROP VIEW dbo.vw_site_lifecycle_500;
GO
CREATE VIEW dbo.vw_site_lifecycle_500 AS
SELECT
    id,
    uk_air_id,
    site_name,
    zone,
    environment_type,
    start_date,
    end_date,
    DATEDIFF(DAY, start_date, end_date) AS operational_days,
    ROUND(CAST(DATEDIFF(DAY, start_date, end_date) AS FLOAT) / 365.25, 2) AS operational_years,
    CASE
        WHEN DATEDIFF(DAY, start_date, end_date) >= 3650 THEN 'Long running site'
        WHEN DATEDIFF(DAY, start_date, end_date) >= 1095 THEN 'Medium running site'
        ELSE 'Short running site'
    END AS lifecycle_category
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500;
GO

IF OBJECT_ID('dbo.vw_identifier_quality_500', 'V') IS NOT NULL DROP VIEW dbo.vw_identifier_quality_500;
GO
CREATE VIEW dbo.vw_identifier_quality_500 AS
SELECT
    id,
    uk_air_id,
    site_name,
    zone,
    environment_type,
    eu_site_id,
    emep_site_id,
    networks,
    site_description,
    CASE WHEN eu_site_id <> N'Not Available' THEN 1 ELSE 0 END AS has_eu_site_id,
    CASE WHEN emep_site_id <> N'Not Available' THEN 1 ELSE 0 END AS has_emep_site_id,
    CASE WHEN site_description <> N'Not Available' THEN 1 ELSE 0 END AS has_site_description,
    CASE
        WHEN eu_site_id <> N'Not Available'
         AND emep_site_id <> N'Not Available'
         AND site_description <> N'Not Available' THEN 'Strong metadata'
        WHEN eu_site_id <> N'Not Available'
          OR emep_site_id <> N'Not Available'
          OR site_description <> N'Not Available' THEN 'Partial metadata'
        ELSE 'Weak metadata'
    END AS metadata_quality_band
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500;
GO

-- Queries for the UK Air Sites 500 project
-- Required table: dbo.ShraddhaYadav_UK_AIR_Sites_500
-- Run 03_CREATE_VIEWS_SQL_SERVER.sql first if the views are not already created.

-- Q01 | Geographic Coverage | Easy | Concept: Basic SELECT
-- Business Question: List the first 20 monitoring sites with their zone, latitude, and longitude.
SELECT TOP (20) id, uk_air_id, site_name, zone, latitude, longitude
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
ORDER BY id;
GO

-- Q02 | Geographic Coverage | Easy | Concept: Basic WHERE
-- Business Question: Which sites are located in the South East zone?
SELECT uk_air_id, site_name, zone
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
WHERE zone = N'South East'
ORDER BY site_name;
GO

-- Q03 | Geographic Coverage | Easy | Concept: DISTINCT / ORDER BY
-- Business Question: Which unique UK zones are present in the 500-row dataset?
SELECT DISTINCT zone
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
ORDER BY zone;
GO

-- Q04 | Geographic Coverage | Easy | Concept: Basic WHERE
-- Business Question: Which sites have valid latitude and longitude values?
SELECT TOP (25) uk_air_id, site_name, zone, latitude, longitude
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
WHERE latitude IS NOT NULL AND longitude IS NOT NULL
ORDER BY zone, site_name;
GO

-- Q05 | Geographic Coverage | Easy | Concept: Basic WHERE
-- Business Question: Which sites have altitude above 100 metres?
SELECT uk_air_id, site_name, zone, altitude_m
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
WHERE altitude_m > 100
ORDER BY altitude_m DESC;
GO

-- Q06 | Geographic Coverage | Medium | Concept: GROUP BY / Aggregation
-- Business Question: How many monitoring sites are there in each zone?
SELECT zone, COUNT(*) AS total_sites
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
GROUP BY zone
ORDER BY total_sites DESC, zone;
GO

-- Q07 | Geographic Coverage | Medium | Concept: GROUP BY / Aggregation
-- Business Question: What is the average altitude of monitoring sites in each zone?
SELECT zone, ROUND(AVG(CAST(altitude_m AS FLOAT)), 2) AS avg_altitude_m, COUNT(*) AS site_count
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
GROUP BY zone
ORDER BY avg_altitude_m DESC;
GO

-- Q08 | Geographic Coverage | Medium | Concept: GROUP BY / HAVING
-- Business Question: Which zones have at least 10 monitoring sites?
SELECT zone, COUNT(*) AS total_sites
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
GROUP BY zone
HAVING COUNT(*) >= 10
ORDER BY total_sites DESC, zone;
GO

-- Q09 | Geographic Coverage | Medium | Concept: GROUP BY / CASE
-- Business Question: How many mapped and unmapped sites exist in each zone?
SELECT zone,
       CASE WHEN latitude IS NOT NULL AND longitude IS NOT NULL THEN 'Coordinates Available' ELSE 'Coordinates Missing' END AS coordinate_status,
       COUNT(*) AS site_count
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
GROUP BY zone, CASE WHEN latitude IS NOT NULL AND longitude IS NOT NULL THEN 'Coordinates Available' ELSE 'Coordinates Missing' END
ORDER BY zone, coordinate_status;
GO

-- Q10 | Geographic Coverage | Medium | Concept: GROUP BY / Aggregation
-- Business Question: Which zone and environment type combinations have the most sites?
SELECT TOP (15) zone, environment_type, COUNT(*) AS total_sites
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
GROUP BY zone, environment_type
ORDER BY total_sites DESC, zone, environment_type;
GO

-- Q11 | Geographic Coverage | Difficult | Concept: Window Function
-- Business Question: Rank zones by total number of monitoring sites.
WITH zone_counts AS (
    SELECT zone, COUNT(*) AS total_sites
    FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
    GROUP BY zone
)
SELECT zone, total_sites, RANK() OVER (ORDER BY total_sites DESC) AS coverage_rank
FROM zone_counts
ORDER BY coverage_rank, zone;
GO

-- Q12 | Geographic Coverage | Difficult | Concept: Window Function
-- Business Question: Show each zone count and its percentage of all monitoring sites.
WITH zone_counts AS (
    SELECT zone, COUNT(*) AS total_sites
    FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
    GROUP BY zone
)
SELECT zone, total_sites,
       ROUND(100.0 * total_sites / SUM(total_sites) OVER (), 2) AS pct_of_all_sites
FROM zone_counts
ORDER BY total_sites DESC, zone;
GO

-- Q13 | Geographic Coverage | Difficult | Concept: CTE
-- Business Question: Use a CTE to identify zones with below-average site coverage.
WITH zone_counts AS (
    SELECT zone, COUNT(*) AS total_sites
    FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
    GROUP BY zone
), overall_avg AS (
    SELECT AVG(CAST(total_sites AS FLOAT)) AS avg_sites_per_zone
    FROM zone_counts
)
SELECT z.zone, z.total_sites, ROUND(o.avg_sites_per_zone, 2) AS average_zone_sites
FROM zone_counts z
CROSS JOIN overall_avg o
WHERE z.total_sites < o.avg_sites_per_zone
ORDER BY z.total_sites ASC, z.zone;
GO

-- Q14 | Geographic Coverage | Difficult | Concept: VIEW
-- Business Question: Use the zone summary view to review overall geographic coverage.
SELECT zone, total_sites, environment_type_count, avg_altitude_m, first_start_date, last_end_date, avg_operational_years
FROM dbo.vw_zone_summary_500
ORDER BY total_sites DESC, zone;
GO

-- Q15 | Geographic Coverage | Difficult | Concept: Window Function
-- Business Question: Find the northernmost monitoring site in each zone using row numbering.
WITH ranked_sites AS (
    SELECT zone, uk_air_id, site_name, latitude,
           ROW_NUMBER() OVER (PARTITION BY zone ORDER BY latitude DESC, site_name) AS rn
    FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
)
SELECT zone, uk_air_id, site_name, latitude
FROM ranked_sites
WHERE rn = 1
ORDER BY zone;
GO

-- Q16 | Environment Type and Site Character | Easy | Concept: Basic WHERE
-- Business Question: List sites classified as Urban Traffic.
SELECT TOP (30) uk_air_id, site_name, zone, environment_type
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
WHERE environment_type = N'Urban Traffic'
ORDER BY zone, site_name;
GO

-- Q17 | Environment Type and Site Character | Easy | Concept: Basic WHERE
-- Business Question: List sites classified as Rural Background.
SELECT uk_air_id, site_name, zone, environment_type
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
WHERE environment_type = N'Rural Background'
ORDER BY zone, site_name;
GO

-- Q18 | Environment Type and Site Character | Easy | Concept: DISTINCT / ORDER BY
-- Business Question: Show all distinct environment types in the dataset.
SELECT DISTINCT environment_type
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
ORDER BY environment_type;
GO

-- Q19 | Environment Type and Site Character | Easy | Concept: LIKE Filter
-- Business Question: Find site names containing the word London.
SELECT uk_air_id, site_name, zone, environment_type
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
WHERE site_name LIKE N'%London%'
ORDER BY site_name;
GO

-- Q20 | Environment Type and Site Character | Easy | Concept: LIKE Filter
-- Business Question: Which sites are classified as a background environment type?
SELECT uk_air_id, site_name, zone, environment_type
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
WHERE environment_type LIKE N'%Background%'
ORDER BY zone, site_name;
GO

-- Q21 | Environment Type and Site Character | Medium | Concept: GROUP BY / Aggregation
-- Business Question: How many sites exist for each environment type?
SELECT environment_type, COUNT(*) AS total_sites
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
GROUP BY environment_type
ORDER BY total_sites DESC, environment_type;
GO

-- Q22 | Environment Type and Site Character | Medium | Concept: GROUP BY / CASE
-- Business Question: How many traffic-related and non-traffic sites exist?
SELECT CASE WHEN environment_type LIKE N'%Traffic%' OR environment_type = N'Roadside' THEN 'Traffic / Roadside' ELSE 'Background / Other' END AS site_category,
       COUNT(*) AS total_sites
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
GROUP BY CASE WHEN environment_type LIKE N'%Traffic%' OR environment_type = N'Roadside' THEN 'Traffic / Roadside' ELSE 'Background / Other' END
ORDER BY total_sites DESC;
GO

-- Q23 | Environment Type and Site Character | Medium | Concept: GROUP BY / Aggregation
-- Business Question: What is the average altitude by environment type?
SELECT environment_type, ROUND(AVG(CAST(altitude_m AS FLOAT)), 2) AS avg_altitude_m, COUNT(*) AS site_count
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
GROUP BY environment_type
ORDER BY avg_altitude_m DESC;
GO

-- Q24 | Environment Type and Site Character | Medium | Concept: GROUP BY / HAVING
-- Business Question: Which environment types appear in more than one zone?
SELECT environment_type, COUNT(DISTINCT zone) AS zone_count
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
GROUP BY environment_type
HAVING COUNT(DISTINCT zone) > 1
ORDER BY zone_count DESC, environment_type;
GO

-- Q25 | Environment Type and Site Character | Medium | Concept: GROUP BY / Aggregation
-- Business Question: Which environment type and zone combinations have the highest average altitude?
SELECT TOP (15) environment_type, zone, ROUND(AVG(CAST(altitude_m AS FLOAT)), 2) AS avg_altitude_m, COUNT(*) AS site_count
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
GROUP BY environment_type, zone
ORDER BY avg_altitude_m DESC, site_count DESC;
GO

-- Q26 | Environment Type and Site Character | Difficult | Concept: Window Function
-- Business Question: Rank environment types by total site coverage.
WITH env_counts AS (
    SELECT environment_type, COUNT(*) AS total_sites
    FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
    GROUP BY environment_type
)
SELECT environment_type, total_sites, RANK() OVER (ORDER BY total_sites DESC) AS environment_rank
FROM env_counts
ORDER BY environment_rank, environment_type;
GO

-- Q27 | Environment Type and Site Character | Difficult | Concept: CTE
-- Business Question: Compare each environment type average altitude against the overall average altitude.
WITH env_altitude AS (
    SELECT environment_type, ROUND(AVG(CAST(altitude_m AS FLOAT)), 2) AS avg_altitude_m
    FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
    GROUP BY environment_type
), overall_altitude AS (
    SELECT ROUND(AVG(CAST(altitude_m AS FLOAT)), 2) AS overall_avg_altitude
    FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
)
SELECT e.environment_type, e.avg_altitude_m, o.overall_avg_altitude,
       CASE WHEN e.avg_altitude_m > o.overall_avg_altitude THEN 'Above overall average' ELSE 'At or below overall average' END AS altitude_comparison
FROM env_altitude e
CROSS JOIN overall_altitude o
ORDER BY e.avg_altitude_m DESC;
GO

-- Q28 | Environment Type and Site Character | Difficult | Concept: VIEW
-- Business Question: Use the environment summary view to compare environment types.
SELECT environment_type, total_sites, zones_covered, avg_altitude_m, avg_operational_years
FROM dbo.vw_environment_summary_500
ORDER BY total_sites DESC, environment_type;
GO

-- Q29 | Environment Type and Site Character | Difficult | Concept: Window Function
-- Business Question: Find the top zone for each environment type.
WITH env_zone_counts AS (
    SELECT environment_type, zone, COUNT(*) AS site_count
    FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
    GROUP BY environment_type, zone
), ranked AS (
    SELECT environment_type, zone, site_count,
           ROW_NUMBER() OVER (PARTITION BY environment_type ORDER BY site_count DESC, zone) AS rn
    FROM env_zone_counts
)
SELECT environment_type, zone, site_count
FROM ranked
WHERE rn = 1
ORDER BY environment_type;
GO

-- Q30 | Environment Type and Site Character | Difficult | Concept: Window Function
-- Business Question: Calculate the percentage of all sites represented by each environment type.
SELECT environment_type, COUNT(*) AS total_sites,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_all_sites
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
GROUP BY environment_type
ORDER BY total_sites DESC, environment_type;
GO

-- Q31 | Time and Monitoring Lifecycle | Easy | Concept: Basic WHERE
-- Business Question: Which sites started before 1980?
SELECT uk_air_id, site_name, zone, start_date
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
WHERE start_date < '1980-01-01'
ORDER BY start_date, site_name;
GO

-- Q32 | Time and Monitoring Lifecycle | Easy | Concept: Basic WHERE
-- Business Question: Which sites started in or after 2000?
SELECT uk_air_id, site_name, zone, start_date
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
WHERE start_date >= '2000-01-01'
ORDER BY start_date, site_name;
GO

-- Q33 | Time and Monitoring Lifecycle | Easy | Concept: Basic WHERE
-- Business Question: Which sites ended before 2000?
SELECT uk_air_id, site_name, zone, end_date
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
WHERE end_date < '2000-01-01'
ORDER BY end_date, site_name;
GO

-- Q34 | Time and Monitoring Lifecycle | Easy | Concept: ORDER BY
-- Business Question: Show the 20 earliest monitoring start dates.
SELECT TOP (20) uk_air_id, site_name, zone, start_date
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
ORDER BY start_date ASC, site_name;
GO

-- Q35 | Time and Monitoring Lifecycle | Easy | Concept: ORDER BY
-- Business Question: Show the 20 latest monitoring end dates.
SELECT TOP (20) uk_air_id, site_name, zone, end_date
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
ORDER BY end_date DESC, site_name;
GO

-- Q36 | Time and Monitoring Lifecycle | Medium | Concept: GROUP BY / Aggregation
-- Business Question: How many sites started in each year?
SELECT YEAR(start_date) AS start_year, COUNT(*) AS sites_started
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
GROUP BY YEAR(start_date)
ORDER BY start_year;
GO

-- Q37 | Time and Monitoring Lifecycle | Medium | Concept: GROUP BY / Aggregation
-- Business Question: How many sites ended in each year?
SELECT YEAR(end_date) AS end_year, COUNT(*) AS sites_ended
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
GROUP BY YEAR(end_date)
ORDER BY end_year;
GO

-- Q38 | Time and Monitoring Lifecycle | Medium | Concept: GROUP BY / Aggregation
-- Business Question: What are the earliest and latest start dates by zone?
SELECT zone, MIN(start_date) AS earliest_start_date, MAX(start_date) AS latest_start_date, COUNT(*) AS total_sites
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
GROUP BY zone
ORDER BY earliest_start_date, zone;
GO

-- Q39 | Time and Monitoring Lifecycle | Medium | Concept: GROUP BY / HAVING
-- Business Question: Which start years have at least 10 new monitoring sites?
SELECT YEAR(start_date) AS start_year, COUNT(*) AS sites_started
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
GROUP BY YEAR(start_date)
HAVING COUNT(*) >= 10
ORDER BY sites_started DESC, start_year;
GO

-- Q40 | Time and Monitoring Lifecycle | Medium | Concept: Date Calculation / Aggregation
-- Business Question: What is the average operational duration for sites in each zone?
SELECT zone, ROUND(AVG(CAST(DATEDIFF(DAY, start_date, end_date) AS FLOAT) / 365.25), 2) AS avg_years_operated, COUNT(*) AS site_count
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
GROUP BY zone
ORDER BY avg_years_operated DESC, zone;
GO

-- Q41 | Time and Monitoring Lifecycle | Difficult | Concept: CTE
-- Business Question: Use a CTE to classify site duration bands and count them by zone.
WITH duration_cte AS (
    SELECT zone,
           CASE
               WHEN DATEDIFF(DAY, start_date, end_date) >= 3650 THEN '10 years or more'
               WHEN DATEDIFF(DAY, start_date, end_date) >= 1095 THEN '3 to 9 years'
               ELSE 'Under 3 years'
           END AS duration_band
    FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
)
SELECT zone, duration_band, COUNT(*) AS site_count
FROM duration_cte
GROUP BY zone, duration_band
ORDER BY zone, duration_band;
GO

-- Q42 | Time and Monitoring Lifecycle | Difficult | Concept: Window Function
-- Business Question: Calculate year-over-year change in sites started.
WITH yearly AS (
    SELECT YEAR(start_date) AS start_year, COUNT(*) AS sites_started
    FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
    GROUP BY YEAR(start_date)
)
SELECT start_year, sites_started,
       LAG(sites_started) OVER (ORDER BY start_year) AS previous_year_sites,
       sites_started - LAG(sites_started) OVER (ORDER BY start_year) AS yoy_change
FROM yearly
ORDER BY start_year;
GO

-- Q43 | Time and Monitoring Lifecycle | Difficult | Concept: Window Function
-- Business Question: Calculate a running total of monitoring sites started over time.
WITH yearly AS (
    SELECT YEAR(start_date) AS start_year, COUNT(*) AS sites_started
    FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
    GROUP BY YEAR(start_date)
)
SELECT start_year, sites_started,
       SUM(sites_started) OVER (ORDER BY start_year ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total_sites
FROM yearly
ORDER BY start_year;
GO

-- Q44 | Time and Monitoring Lifecycle | Difficult | Concept: VIEW / Window Function
-- Business Question: Use the lifecycle view to list the longest-operating site in each zone.
WITH ranked AS (
    SELECT zone, uk_air_id, site_name, operational_years,
           ROW_NUMBER() OVER (PARTITION BY zone ORDER BY operational_days DESC, site_name) AS rn
    FROM dbo.vw_site_lifecycle_500
)
SELECT zone, uk_air_id, site_name, operational_years
FROM ranked
WHERE rn = 1
ORDER BY zone;
GO

-- Q45 | Time and Monitoring Lifecycle | Difficult | Concept: Window Function
-- Business Question: Rank the top 10 longest-operating monitoring sites.
SELECT TOP (10) uk_air_id, site_name, zone, start_date, end_date, operational_years,
       RANK() OVER (ORDER BY operational_days DESC) AS duration_rank
FROM dbo.vw_site_lifecycle_500
ORDER BY duration_rank, site_name;
GO

-- Q46 | Identifier, Network and Metadata Coverage | Easy | Concept: Basic WHERE
-- Business Question: Which sites have an EU site ID available?
SELECT uk_air_id, eu_site_id, site_name, zone
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
WHERE eu_site_id <> N'Not Available'
ORDER BY zone, site_name;
GO

-- Q47 | Identifier, Network and Metadata Coverage | Easy | Concept: Basic WHERE
-- Business Question: Which sites have an EMEP site ID available?
SELECT uk_air_id, emep_site_id, site_name, zone
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
WHERE emep_site_id <> N'Not Available'
ORDER BY zone, site_name;
GO

-- Q48 | Identifier, Network and Metadata Coverage | Easy | Concept: Basic WHERE
-- Business Question: Which sites have both EU and EMEP identifiers available?
SELECT uk_air_id, eu_site_id, emep_site_id, site_name, zone
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
WHERE eu_site_id <> N'Not Available' AND emep_site_id <> N'Not Available'
ORDER BY zone, site_name;
GO

-- Q49 | Identifier, Network and Metadata Coverage | Easy | Concept: LIKE Filter
-- Business Question: Which sites belong to networks containing the word Automatic?
SELECT uk_air_id, site_name, zone, networks
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
WHERE networks LIKE N'%Automatic%'
ORDER BY zone, site_name;
GO

-- Q50 | Identifier, Network and Metadata Coverage | Easy | Concept: Basic WHERE
-- Business Question: Which sites have a site description available?
SELECT TOP (30) uk_air_id, site_name, zone, LEFT(site_description, 120) AS description_preview
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
WHERE site_description <> N'Not Available'
ORDER BY site_name;
GO

-- Q51 | Identifier, Network and Metadata Coverage | Medium | Concept: GROUP BY / CASE
-- Business Question: How many records have EU and EMEP identifiers available?
SELECT
    CASE WHEN eu_site_id <> N'Not Available' THEN 'EU ID Available' ELSE 'EU ID Missing' END AS eu_id_status,
    CASE WHEN emep_site_id <> N'Not Available' THEN 'EMEP ID Available' ELSE 'EMEP ID Missing' END AS emep_id_status,
    COUNT(*) AS site_count
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
GROUP BY CASE WHEN eu_site_id <> N'Not Available' THEN 'EU ID Available' ELSE 'EU ID Missing' END,
         CASE WHEN emep_site_id <> N'Not Available' THEN 'EMEP ID Available' ELSE 'EMEP ID Missing' END
ORDER BY site_count DESC;
GO

-- Q52 | Identifier, Network and Metadata Coverage | Medium | Concept: GROUP BY / Aggregation
-- Business Question: What is the EU identifier availability by zone?
SELECT zone,
       SUM(CASE WHEN eu_site_id <> N'Not Available' THEN 1 ELSE 0 END) AS sites_with_eu_id,
       COUNT(*) AS total_sites,
       ROUND(100.0 * SUM(CASE WHEN eu_site_id <> N'Not Available' THEN 1 ELSE 0 END) / COUNT(*), 2) AS eu_id_pct
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
GROUP BY zone
ORDER BY eu_id_pct DESC, total_sites DESC;
GO

-- Q53 | Identifier, Network and Metadata Coverage | Medium | Concept: GROUP BY / Aggregation
-- Business Question: What is the EMEP identifier availability by environment type?
SELECT environment_type,
       SUM(CASE WHEN emep_site_id <> N'Not Available' THEN 1 ELSE 0 END) AS sites_with_emep_id,
       COUNT(*) AS total_sites,
       ROUND(100.0 * SUM(CASE WHEN emep_site_id <> N'Not Available' THEN 1 ELSE 0 END) / COUNT(*), 2) AS emep_id_pct
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
GROUP BY environment_type
ORDER BY emep_id_pct DESC, total_sites DESC;
GO

-- Q54 | Identifier, Network and Metadata Coverage | Medium | Concept: GROUP BY / Text Length
-- Business Question: What is the average available description length by environment type?
SELECT environment_type,
       ROUND(AVG(CAST(CASE WHEN site_description <> N'Not Available' THEN LEN(site_description) ELSE NULL END AS FLOAT)), 2) AS avg_description_length,
       SUM(CASE WHEN site_description <> N'Not Available' THEN 1 ELSE 0 END) AS descriptions_available
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
GROUP BY environment_type
ORDER BY avg_description_length DESC;
GO

-- Q55 | Identifier, Network and Metadata Coverage | Medium | Concept: GROUP BY / Aggregation
-- Business Question: Which network values appear most often?
SELECT TOP (15) networks, COUNT(*) AS site_count
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
GROUP BY networks
ORDER BY site_count DESC, networks;
GO

-- Q56 | Identifier, Network and Metadata Coverage | Difficult | Concept: CTE
-- Business Question: Use a CTE to identify weak metadata records by zone.
WITH metadata_flags AS (
    SELECT zone,
           CASE WHEN eu_site_id = N'Not Available' AND emep_site_id = N'Not Available' AND site_description = N'Not Available' THEN 1 ELSE 0 END AS weak_metadata_flag
    FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
)
SELECT zone, SUM(weak_metadata_flag) AS weak_metadata_sites, COUNT(*) AS total_sites,
       ROUND(100.0 * SUM(weak_metadata_flag) / COUNT(*), 2) AS weak_metadata_pct
FROM metadata_flags
GROUP BY zone
ORDER BY weak_metadata_pct DESC, total_sites DESC;
GO

-- Q57 | Identifier, Network and Metadata Coverage | Difficult | Concept: Window Function
-- Business Question: Rank zones by EU identifier coverage rate.
WITH zone_id_coverage AS (
    SELECT zone, COUNT(*) AS total_sites,
           SUM(CASE WHEN eu_site_id <> N'Not Available' THEN 1 ELSE 0 END) AS sites_with_eu_id
    FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
    GROUP BY zone
)
SELECT zone, total_sites, sites_with_eu_id,
       ROUND(100.0 * sites_with_eu_id / total_sites, 2) AS eu_id_pct,
       RANK() OVER (ORDER BY 100.0 * sites_with_eu_id / total_sites DESC, total_sites DESC) AS eu_id_rank
FROM zone_id_coverage
ORDER BY eu_id_rank, zone;
GO

-- Q58 | Identifier, Network and Metadata Coverage | Difficult | Concept: VIEW
-- Business Question: Use the identifier quality view to summarize metadata quality bands.
SELECT metadata_quality_band, COUNT(*) AS site_count
FROM dbo.vw_identifier_quality_500
GROUP BY metadata_quality_band
ORDER BY site_count DESC;
GO

-- Q59 | Identifier, Network and Metadata Coverage | Difficult | Concept: Window Function
-- Business Question: List the 10 longest site descriptions with row numbers.
WITH descriptions AS (
    SELECT uk_air_id, site_name, zone, LEN(site_description) AS description_length,
           ROW_NUMBER() OVER (ORDER BY LEN(site_description) DESC, site_name) AS description_rank
    FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
    WHERE site_description <> N'Not Available'
)
SELECT TOP (10) description_rank, uk_air_id, site_name, zone, description_length
FROM descriptions
ORDER BY description_rank;
GO

-- Q60 | Identifier, Network and Metadata Coverage | Difficult | Concept: Window Function
-- Business Question: Show each network count and its percentage share of the dataset.
WITH network_counts AS (
    SELECT networks, COUNT(*) AS site_count
    FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
    GROUP BY networks
)
SELECT networks, site_count,
       ROUND(100.0 * site_count / SUM(site_count) OVER (), 2) AS pct_of_all_sites
FROM network_counts
ORDER BY site_count DESC, networks;
GO

-- Q61 | Operational Prioritisation and Data Quality | Easy | Concept: Basic WHERE
-- Business Question: Which traffic or roadside sites have altitude above the dataset average?
SELECT uk_air_id, site_name, zone, environment_type, altitude_m
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
WHERE (environment_type LIKE N'%Traffic%' OR environment_type = N'Roadside')
  AND altitude_m > (SELECT AVG(CAST(altitude_m AS FLOAT)) FROM dbo.ShraddhaYadav_UK_AIR_Sites_500)
ORDER BY altitude_m DESC;
GO

-- Q62 | Operational Prioritisation and Data Quality | Easy | Concept: ORDER BY
-- Business Question: Which 20 sites are furthest west by longitude?
SELECT TOP (20) uk_air_id, site_name, zone, longitude
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
ORDER BY longitude ASC, site_name;
GO

-- Q63 | Operational Prioritisation and Data Quality | Easy | Concept: ORDER BY
-- Business Question: Which 20 sites are furthest north by latitude?
SELECT TOP (20) uk_air_id, site_name, zone, latitude
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
ORDER BY latitude DESC, site_name;
GO

-- Q64 | Operational Prioritisation and Data Quality | Easy | Concept: LIKE Filter
-- Business Question: Which records are part of Automatic monitoring networks?
SELECT uk_air_id, site_name, zone, networks
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
WHERE networks LIKE N'%Automatic%'
ORDER BY zone, site_name;
GO

-- Q65 | Operational Prioritisation and Data Quality | Easy | Concept: CASE Expression
-- Business Question: Classify sites into simple altitude bands.
SELECT TOP (50) uk_air_id, site_name, zone, altitude_m,
       CASE
           WHEN altitude_m >= 150 THEN 'High altitude'
           WHEN altitude_m >= 50 THEN 'Medium altitude'
           ELSE 'Low altitude'
       END AS altitude_band
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
ORDER BY altitude_m DESC;
GO

-- Q66 | Operational Prioritisation and Data Quality | Medium | Concept: GROUP BY / CASE
-- Business Question: How many sites fall into each metadata quality band?
SELECT metadata_quality_band, COUNT(*) AS site_count
FROM dbo.vw_identifier_quality_500
GROUP BY metadata_quality_band
ORDER BY site_count DESC;
GO

-- Q67 | Operational Prioritisation and Data Quality | Medium | Concept: GROUP BY / Aggregation
-- Business Question: Which zones have the highest average operational duration?
SELECT TOP (15) zone, ROUND(AVG(CAST(operational_days AS FLOAT) / 365.25), 2) AS avg_operational_years, COUNT(*) AS site_count
FROM dbo.vw_site_lifecycle_500
GROUP BY zone
ORDER BY avg_operational_years DESC, site_count DESC;
GO

-- Q68 | Operational Prioritisation and Data Quality | Medium | Concept: GROUP BY / CASE
-- Business Question: What percentage of sites in each zone are traffic or roadside sites?
SELECT zone,
       SUM(CASE WHEN environment_type LIKE N'%Traffic%' OR environment_type = N'Roadside' THEN 1 ELSE 0 END) AS traffic_or_roadside_sites,
       COUNT(*) AS total_sites,
       ROUND(100.0 * SUM(CASE WHEN environment_type LIKE N'%Traffic%' OR environment_type = N'Roadside' THEN 1 ELSE 0 END) / COUNT(*), 2) AS traffic_pct
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
GROUP BY zone
ORDER BY traffic_pct DESC, total_sites DESC;
GO

-- Q69 | Operational Prioritisation and Data Quality | Medium | Concept: GROUP BY / HAVING
-- Business Question: Which zones have more than 5 sites and an average altitude above 50 metres?
SELECT zone, COUNT(*) AS total_sites, ROUND(AVG(CAST(altitude_m AS FLOAT)), 2) AS avg_altitude_m
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
GROUP BY zone
HAVING COUNT(*) > 5 AND AVG(CAST(altitude_m AS FLOAT)) > 50
ORDER BY avg_altitude_m DESC, total_sites DESC;
GO

-- Q70 | Operational Prioritisation and Data Quality | Medium | Concept: GROUP BY / CASE
-- Business Question: Summarize description availability by zone.
SELECT zone,
       SUM(CASE WHEN site_description <> N'Not Available' THEN 1 ELSE 0 END) AS descriptions_available,
       COUNT(*) AS total_sites,
       ROUND(100.0 * SUM(CASE WHEN site_description <> N'Not Available' THEN 1 ELSE 0 END) / COUNT(*), 2) AS description_available_pct
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
GROUP BY zone
ORDER BY description_available_pct DESC, total_sites DESC;
GO

-- Q71 | Operational Prioritisation and Data Quality | Difficult | Concept: Window Function
-- Business Question: Place sites into altitude quartiles using NTILE.
SELECT uk_air_id, site_name, zone, environment_type, altitude_m,
       NTILE(4) OVER (ORDER BY altitude_m) AS altitude_quartile
FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
ORDER BY altitude_quartile, altitude_m;
GO

-- Q72 | Operational Prioritisation and Data Quality | Difficult | Concept: CTE
-- Business Question: Classify zones as high, medium, or low coverage compared with the dataset average.
WITH zone_counts AS (
    SELECT zone, COUNT(*) AS total_sites
    FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
    GROUP BY zone
), stats AS (
    SELECT AVG(CAST(total_sites AS FLOAT)) AS avg_zone_sites
    FROM zone_counts
)
SELECT z.zone, z.total_sites, ROUND(s.avg_zone_sites, 2) AS avg_zone_sites,
       CASE
           WHEN z.total_sites >= s.avg_zone_sites * 1.5 THEN 'High coverage zone'
           WHEN z.total_sites >= s.avg_zone_sites THEN 'Medium coverage zone'
           ELSE 'Low coverage zone'
       END AS coverage_category
FROM zone_counts z
CROSS JOIN stats s
ORDER BY z.total_sites DESC, z.zone;
GO

-- Q73 | Operational Prioritisation and Data Quality | Difficult | Concept: CTE / CASE
-- Business Question: Create a data readiness summary combining identifier and description status.
WITH readiness AS (
    SELECT
        CASE WHEN eu_site_id <> N'Not Available' OR emep_site_id <> N'Not Available' THEN 'Has external identifier' ELSE 'No external identifier' END AS identifier_status,
        CASE WHEN site_description <> N'Not Available' THEN 'Description available' ELSE 'Description missing' END AS description_status
    FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
)
SELECT identifier_status, description_status, COUNT(*) AS site_count
FROM readiness
GROUP BY identifier_status, description_status
ORDER BY identifier_status, description_status;
GO

-- Q74 | Operational Prioritisation and Data Quality | Difficult | Concept: Window Function
-- Business Question: Calculate a 3-year moving average of sites started by year.
WITH yearly AS (
    SELECT YEAR(start_date) AS start_year, COUNT(*) AS sites_started
    FROM dbo.ShraddhaYadav_UK_AIR_Sites_500
    GROUP BY YEAR(start_date)
)
SELECT start_year, sites_started,
       ROUND(AVG(CAST(sites_started AS FLOAT)) OVER (ORDER BY start_year ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS moving_avg_3_years
FROM yearly
ORDER BY start_year;
GO

-- Q75 | Operational Prioritisation and Data Quality | Difficult | Concept: CTE / Window Function
-- Business Question: Create a final prioritisation list for traffic or roadside sites with weak or partial metadata.
WITH candidate_sites AS (
    SELECT q.uk_air_id, q.site_name, q.zone, q.environment_type, q.metadata_quality_band,
           l.operational_years,
           CASE WHEN q.metadata_quality_band = 'Weak metadata' THEN 3
                WHEN q.metadata_quality_band = 'Partial metadata' THEN 2
                ELSE 1 END AS metadata_priority_score
    FROM dbo.vw_identifier_quality_500 q
    INNER JOIN dbo.vw_site_lifecycle_500 l ON q.id = l.id
    WHERE q.environment_type LIKE N'%Traffic%' OR q.environment_type = N'Roadside'
), ranked AS (
    SELECT *,
           RANK() OVER (ORDER BY metadata_priority_score DESC, operational_years DESC, site_name) AS priority_rank
    FROM candidate_sites
)
SELECT TOP (25) priority_rank, uk_air_id, site_name, zone, environment_type, metadata_quality_band, operational_years
FROM ranked
ORDER BY priority_rank, site_name;
GO
