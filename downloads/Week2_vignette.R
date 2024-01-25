


















## 1. Overview of Worked Example {-}

### a) Background on spatial packages in R

There has been a lot of development recently in R regarding object types for geospatial data. We are currently in a transition period, where some packages still expect the "old" object types (based e.g. on packages `raster` and `sp`), others expect the "new" object types (based e.g. on packages `terra` and `sf`), and some accept both. This vignette uses the newer packages `terra` and `sf`. The bonus vignette includes code for converting between `sf` and `sp`, and between `terra` and `raster`. 

Further resources: 

- **Intro GIS with R**: to learn about GIS functionality using R, https://bookdown.org/michael_bcalles/gis-crash-course-in-r/data.html#vector-data

- **R Tutorial**: For an introductory tutorial on spatial data analysis with R, which explains object types in more detail than this worked example, see: https://rpubs.com/jguelat/fdsfd 

- **Advanced**: For a thorough resource on spatial data analysis with R, see this excellent Gitbook: https://geocompr.robinlovelace.net/index.html.


### b) Goals {-} 

This worked example shows:

- How to import spatial coordinates and site attributes as spatially referenced data.  
- How to plot raster data in R and overlay sampling locations.
- How to calculate landscape metrics.
- How to extract landscape data at sampling locations and within a buffer around them.

Try modifying the code to import your own data!

### c) Data set {-}

This code builds on data and code from the `GeNetIt` package by Jeff Evans and Melanie Murphy. Landscape metrics will be calculated with the `landscapemetrics` package described in: Hesselbarth et al. (2019), Ecography 42: 1648-1657.

This code uses landscape data and spatial coordinates from 30 locations where Colombia spotted frogs (*Rana luteiventris*) were sampled for the full data set analyzed by Funk et al. (2005) and Murphy et al. (2010). Please see the separate introduction to the data set.

- `ralu.site`: `sf` object with UTM coordinates (zone 11) and 17 site variables for 31 sites. The data are included in the 'GeNetIt' package, for meta data type: ?ralu.site

We will extract values at sampling point locations and within a local neighborhood (buffer) from six raster maps (see Murphy et al. 2010 for definitions), which are included with the `GeNetIt` package as a SpatialPixelsDataFrame called 'rasters':

- cti:   Compound Topographic Index ("wetness")
- err27: Elevation Relief Ratio 
- ffp:   Frost Free Period
- gsp:   Growing Season Precipitation
- hli:   Heat Load Index
- nlcd:  USGS Landcover (categorical map)

### d) Required R packages {-}

Install some packages needed for this worked example.


```r
if(!requireNamespace("GeNetIt", quietly = TRUE)) remotes::install_github("jeffreyevans/GeNetIt")
```


```r
library(LandGenCourse)
library(here)
library(landscapemetrics)
library(dplyr)
library(sf)
library(terra)
library(GeNetIt)
library(tibble)
library(tmap)
library(RColorBrewer)
```

## 2. Import site data from .csv file {-}

### a) Import data into an `sf` object {-}

The site data are already in an `sf` object named `ralu.site` that comes with the package `GeNetIt`. Use `data(ralu.site)` to load it. This will create an object `ralu.site`. 


```r
data(ralu.site)
class(ralu.site)
```

```
## [1] "sf"         "data.frame"
```

To demonstrate how to create an `sf` object from two data frames (one with the coordinates and one with the attribute data), we'll extract these data frames from the `sf` object `ralu.site` and then recreate the `sf` object (we'll call it `Sites`) from the two data frames.

We can extract the coordinates with the function `st_coordinates`:


```r
Coordinates <- st_coordinates(ralu.site)
head(Coordinates)
```

```
##             X       Y
## [1,] 688816.6 5003207
## [2,] 688494.4 4999093
## [3,] 687938.4 5000223
## [4,] 689732.8 5002522
## [5,] 690104.0 4999355
## [6,] 688742.5 4997481
```

**Question**: What are the variable names for the spatial coordinates?

Similarly, we can drop the geometry (spatial information) from the `sf` object to reduce it to a data frame:


```r
Data <- st_drop_geometry(ralu.site)
class(Data)
```

```
## [1] "data.frame"
```

Now we can create an `sf` object again. Here, we: 

- combine the two data frames `Data` and `Coordinates` into a single data frame with function `data.frame`,
- use the function `st_as_sf` from the `sf` package to convert this data frame to an `sf` object,
- tell R that the variables with the coordinates are called "X" and "Y". 


```r
Sites <- data.frame(Data, Coordinates)
Sites.sf <- st_as_sf(Sites, coords=c("X", "Y"))
head(Sites.sf)
```

```
## Simple feature collection with 6 features and 17 fields
## Geometry type: POINT
## Dimension:     XY
## Bounding box:  xmin: 687938.4 ymin: 4997481 xmax: 690104 ymax: 5003207
## CRS:           NA
##         SiteName        Drainage      Basin Substrate
## 1   AirplaneLake ShipIslandCreek Sheepeater      Silt
## 2 BachelorMeadow     WilsonCreek    Skyhigh      Silt
## 3 BarkingFoxLake  WaterfallCreek    Terrace      Silt
## 4   BirdbillLake      ClearCreek   Birdbill      Sand
## 5        BobLake     WilsonCreek     Harbor      Silt
## 6      CacheLake     WilsonCreek    Skyhigh      Silt
##                               NWI AREA_m2 PERI_m Depth_m  TDS FISH ACB   AUC
## 1                      Lacustrine 62582.2 1142.8   21.64  2.5    1   0 0.411
## 2 Riverine_Intermittent_Streambed   225.0   60.0    0.40  0.0    0   0 0.000
## 3                      Lacustrine 12000.0  435.0    5.00 13.8    1   0 0.300
## 4                      Lacustrine 12358.6  572.3    3.93  6.4    1   0 0.283
## 5                      Palustrine  4600.0  321.4    2.00 14.3    0   0 0.000
## 6                      Palustrine  2268.8  192.0    1.86 10.9    0   0 0.000
##   AUCV  AUCC   AUF AWOOD  AUFV                 geometry
## 1    0 0.411 0.063 0.063 0.464 POINT (688816.6 5003207)
## 2    0 0.000 1.000 0.000 0.000 POINT (688494.4 4999093)
## 3    0 0.300 0.700 0.000 0.000 POINT (687938.4 5000223)
## 4    0 0.283 0.717 0.000 0.000 POINT (689732.8 5002522)
## 5    0 0.000 0.500 0.000 0.500   POINT (690104 4999355)
## 6    0 0.000 0.556 0.093 0.352 POINT (688742.5 4997481)
```

**Question**: Where and how are the spatial coordinates shown in the `sf` object `Sites.sf`?


To illustrate importing spatial data from Excel, here we export the combined data frame as a csv file, import it again as a data frame, then convert it to an `sf` object. First we create a folder `output` if it does not yet exist. 

Note: to run the code below, remove all the hashtags `#` at the beginning of the lines to un-comment them. This part assumes that you have writing permission on your computer. Alternatively, try setting up your R project folder on an external drive where you have writing permission.

The code below does the following:

- Line 1: Load package here that helps with file paths.
- Line 2: Check if folder output exists, and if not, create it.
- Line 3: Export the combined data frame as a .csv file.
- Line 4: Re-imports the .csv file as a `data.frame` object `Sites`.
- Line 5: Create `sf` object `Sites.sf` from df`.


```r
#require(here)
#if(!dir.exists(here("output"))) dir.create(here("output"))
#write.csv(data.frame(Data, Coordinates), file=here("output/ralu.site.csv"), quote=FALSE, row.names=FALSE)
#Sites <- read.csv(here("output/ralu.site.csv"), header=TRUE)
#Sites.sf <- st_as_sf(df, coords=c("X", "Y"))
```

The `sf` object `Sites.sf` contains 17 attribute variables and one variable `geometry` that contains the spatial information. Now R knows these are spatial data and knows how to handle them. 

### b) Add spatial reference data {-}

Before we can combine the sampling locations with other spatial datasets, such as raster data, we need to tell R where on Earth these locations are (georeferencing). This is done by specifying the "Coordinate Reference System" (CRS).

For a great explanation of projections, see:
https://michaelminn.net/tutorials/gis-projections/index.html

For more information on CRS, see: https://www.nceas.ucsb.edu/~frazier/RSpatialGuides/OverviewCoordinateReferenceSystems.pdf

We know that these coordinates are UTM zone 11 (Northern hemisphere) coordinates. We define it here by its EPSG code (32611). You can search for EPSG codes here: https://epsg.io/32611.

Here we call the function and the package simultaneously (this is good practice, as it helps keep track of where the functions in your code come from).


```r
st_crs(Sites.sf) <- 32611
```

**Question:** Print `Sites.sf` and check what CRS is listed in the header.

**Important**: the code above, using function `st_crs`,  only **declares** the existing projection, it does not change the coordinates to that projection! 

However, the `ralu.site` dataset uses a slightly different definition of the projection (the difference is in the `datum` argument `WGS84` vs. `NAD83`). Hence it may be safer to simply copy the crs information from ralu.site to Sites.sf. Again, this does not change the projection but declares that Sites.sf has the same projection as ralu.site. R even prints a warning to remind us of this:


```r
st_crs(Sites.sf) <- st_crs(ralu.site)
```

```
## Warning: st_crs<- : replacing crs does not reproject data; use st_transform for
## that
```


### c) Change projection {-}

In case we needed to **transform** the projection, e.g., from UTM zone 11 to longitude/latitude (EPSG code: 4326), we could create a new `sf` object `Sites.sf.longlat`. We use the function `st_transform` to change the projection from the projection of the old object `Sites.sf` to the "longlat" coordinate system, which we define by the argument `crs`.

With 

```r
Sites.sf.longlat <- st_transform(Sites.sf, crs = 4326)
head(Sites.sf.longlat)
```

```
## Simple feature collection with 6 features and 17 fields
## Geometry type: POINT
## Dimension:     XY
## Bounding box:  xmin: -114.61 ymin: 45.1056 xmax: -114.5828 ymax: 45.15708
## Geodetic CRS:  WGS 84
##         SiteName        Drainage      Basin Substrate
## 1   AirplaneLake ShipIslandCreek Sheepeater      Silt
## 2 BachelorMeadow     WilsonCreek    Skyhigh      Silt
## 3 BarkingFoxLake  WaterfallCreek    Terrace      Silt
## 4   BirdbillLake      ClearCreek   Birdbill      Sand
## 5        BobLake     WilsonCreek     Harbor      Silt
## 6      CacheLake     WilsonCreek    Skyhigh      Silt
##                               NWI AREA_m2 PERI_m Depth_m  TDS FISH ACB   AUC
## 1                      Lacustrine 62582.2 1142.8   21.64  2.5    1   0 0.411
## 2 Riverine_Intermittent_Streambed   225.0   60.0    0.40  0.0    0   0 0.000
## 3                      Lacustrine 12000.0  435.0    5.00 13.8    1   0 0.300
## 4                      Lacustrine 12358.6  572.3    3.93  6.4    1   0 0.283
## 5                      Palustrine  4600.0  321.4    2.00 14.3    0   0 0.000
## 6                      Palustrine  2268.8  192.0    1.86 10.9    0   0 0.000
##   AUCV  AUCC   AUF AWOOD  AUFV                   geometry
## 1    0 0.411 0.063 0.063 0.464 POINT (-114.5977 45.15708)
## 2    0 0.000 1.000 0.000 0.000 POINT (-114.6034 45.12016)
## 3    0 0.300 0.700 0.000 0.000   POINT (-114.61 45.13047)
## 4    0 0.283 0.717 0.000 0.000 POINT (-114.5864 45.15067)
## 5    0 0.000 0.500 0.000 0.500 POINT (-114.5828 45.12208)
## 6    0 0.000 0.556 0.093 0.352  POINT (-114.6008 45.1056)
```

**Question**: What has changed in the summary?

### d) Map sampling sites on world map {-}

Where on earth is this? You could enter the coordinates from the "longlat" projection in Google maps. Note that Google expects the Latitude (Y coordinate) first, then the Longitude (X coordinate). In the variable `geometry`, longitude (e.g., -114.5977 for the first data point) is listed before latitude (45.15708 for the first data point). Thus, to locate the first site in Google maps, you will need to enter `45.15708, -114.5977`. 

There is a much easier way to find out where on Earth the sampling points are located. And we don't even need to change the coordinates to longitude/latitude - R will do this for us internally.

- We load the R package `tmap` (which stands for "thematic maps")
- With `tmap_mode("view")`, we indicate that we want to create an interactive map.
- With `tm_shape(Sites.sf)` we select the data set (Sites.sf`) to be displayed. For now, we only plot the location, no attribute information. 
- With `tm_sf`, we specify how the points should be displayed (color, size).


```r
require(tmap)

tmap_mode("view")
```

```
## tmap mode set to interactive viewing
```

```r
tm_shape(Sites.sf) + tm_sf(col="red", size=1)
```

```{=html}
<div class="leaflet html-widget html-fill-item" id="htmlwidget-b0089f0219197435d7ad" style="width:672px;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-b0089f0219197435d7ad">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"createMapPane","args":["tmap401",401]},{"method":"addProviderTiles","args":["Esri.WorldGrayCanvas",null,"Esri.WorldGrayCanvas",{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"pane":"tilePane"}]},{"method":"addProviderTiles","args":["OpenStreetMap",null,"OpenStreetMap",{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"pane":"tilePane"}]},{"method":"addProviderTiles","args":["Esri.WorldTopoMap",null,"Esri.WorldTopoMap",{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"pane":"tilePane"}]},{"method":"addCircles","args":[[45.15707850945083,45.12016062430876,45.1304727987641,45.15066982354276,45.12208200955106,45.10559714362714,45.0982893066227,45.11162597727552,45.16810160930147,45.09975785083597,45.11407808030845,45.15469735448928,45.15545452687273,45.1637644385459,45.09441390148887,45.1165823853642,45.15207319555835,45.09016340391857,45.08848338859229,45.15092837107155,45.08316146635691,45.08356480981284,45.16692667954503,45.08533324650074,45.16529181498381,45.11965875884201,45.15632923267202,45.13562787813084,45.12274430524,45.07529212294912,45.12860201067411],[-114.5977396540216,-114.6033865250272,-114.6100248049217,-114.5863531992181,-114.5828399817001,-114.6008430385362,-114.5983541778665,-114.6031733879995,-114.5964858515769,-114.5990662195857,-114.599181207082,-114.585563173993,-114.5835998180092,-114.5798359744075,-114.6100936916924,-114.6065382479126,-114.5715719888294,-114.6045327001424,-114.6158701947446,-114.6222594992278,-114.6185682698232,-114.622073588037,-114.5761415003057,-114.6122166396044,-114.6216736368122,-114.6076631577064,-114.5829370604914,-114.6082003751046,-114.5837103287136,-114.6117283040945,-114.5904058421169],[171.9993370863407,171.9993370863407,171.9993370863407,171.9993370863407,171.9993370863407,171.9993370863407,171.9993370863407,171.9993370863407,171.9993370863407,171.9993370863407,171.9993370863407,171.9993370863407,171.9993370863407,171.9993370863407,171.9993370863407,171.9993370863407,171.9993370863407,171.9993370863407,171.9993370863407,171.9993370863407,171.9993370863407,171.9993370863407,171.9993370863407,171.9993370863407,171.9993370863407,171.9993370863407,171.9993370863407,171.9993370863407,171.9993370863407,171.9993370863407,171.9993370863407],["AirplaneLake","BachelorMeadow","BarkingFoxLake","BirdbillLake","BobLake","CacheLake","DoeLake","EggWhiteLake","ElenasLake","FawnLake","FrogPondLake","GentianLake","GentianPonds","GoldenLake","GreggsLake","InandOutLake","MeadowLake","MooseLake","Mt.WilsonLake","NopezLake","ParagonLake","ParagonWetland","PotholeLake","RamshornLake","ShipIslandLake","SkyhighLake","StockingCapLake","Terrace1Lake","TobiasLake","WalkaboutLake","WelcomeLake"],"Sites.sf",{"interactive":true,"className":"","pane":"tmap401","stroke":true,"color":"#666666","weight":1,"opacity":0.5,"fill":true,"fillColor":["#FF0000","#FF0000","#FF0000","#FF0000","#FF0000","#FF0000","#FF0000","#FF0000","#FF0000","#FF0000","#FF0000","#FF0000","#FF0000","#FF0000","#FF0000","#FF0000","#FF0000","#FF0000","#FF0000","#FF0000","#FF0000","#FF0000","#FF0000","#FF0000","#FF0000","#FF0000","#FF0000","#FF0000","#FF0000","#FF0000","#FF0000"],"fillOpacity":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},["<style> div.leaflet-popup-content {width:auto !important;overflow-y:auto; overflow-x:hidden;}<\/style><div style=\"max-height:25em;padding-right:15px;\"><table>\n\t\t\t   <thead><tr><th colspan=\"2\"><b>AirplaneLake<\/b><\/th><\/thead><\/tr><tr><td style=\"color: #888888;\"><nobr>SiteName<\/nobr><\/td><td align=\"right\"><nobr>AirplaneLake<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Drainage<\/nobr><\/td><td align=\"right\"><nobr>ShipIslandCreek<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Basin<\/nobr><\/td><td align=\"right\"><nobr>Sheepeater<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Substrate<\/nobr><\/td><td align=\"right\"><nobr>Silt<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>NWI<\/nobr><\/td><td align=\"right\"><nobr>Lacustrine<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AREA_m2<\/nobr><\/td><td align=\"right\"><nobr>62,582<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>PERI_m<\/nobr><\/td><td align=\"right\"><nobr>1,143<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Depth_m<\/nobr><\/td><td align=\"right\"><nobr>21.64<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>TDS<\/nobr><\/td><td align=\"right\"><nobr>2.5<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>FISH<\/nobr><\/td><td align=\"right\"><nobr>1<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>ACB<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUC<\/nobr><\/td><td align=\"right\"><nobr>0.411<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCC<\/nobr><\/td><td align=\"right\"><nobr>0.411<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUF<\/nobr><\/td><td align=\"right\"><nobr>0.063<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AWOOD<\/nobr><\/td><td align=\"right\"><nobr>0.063<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUFV<\/nobr><\/td><td align=\"right\"><nobr>0.464<\/nobr><\/td><\/tr><\/table><\/div>","<style> div.leaflet-popup-content {width:auto !important;overflow-y:auto; overflow-x:hidden;}<\/style><div style=\"max-height:25em;padding-right:15px;\"><table>\n\t\t\t   <thead><tr><th colspan=\"2\"><b>BachelorMeadow<\/b><\/th><\/thead><\/tr><tr><td style=\"color: #888888;\"><nobr>SiteName<\/nobr><\/td><td align=\"right\"><nobr>BachelorMeadow<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Drainage<\/nobr><\/td><td align=\"right\"><nobr>WilsonCreek<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Basin<\/nobr><\/td><td align=\"right\"><nobr>Skyhigh<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Substrate<\/nobr><\/td><td align=\"right\"><nobr>Silt<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>NWI<\/nobr><\/td><td align=\"right\"><nobr>Riverine_Intermittent_Streambed<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AREA_m2<\/nobr><\/td><td align=\"right\"><nobr>225<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>PERI_m<\/nobr><\/td><td align=\"right\"><nobr>60<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Depth_m<\/nobr><\/td><td align=\"right\"><nobr>0.40<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>TDS<\/nobr><\/td><td align=\"right\"><nobr>0.0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>FISH<\/nobr><\/td><td align=\"right\"><nobr>0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>ACB<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUC<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCC<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUF<\/nobr><\/td><td align=\"right\"><nobr>1.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AWOOD<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUFV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><\/table><\/div>","<style> div.leaflet-popup-content {width:auto !important;overflow-y:auto; overflow-x:hidden;}<\/style><div style=\"max-height:25em;padding-right:15px;\"><table>\n\t\t\t   <thead><tr><th colspan=\"2\"><b>BarkingFoxLake<\/b><\/th><\/thead><\/tr><tr><td style=\"color: #888888;\"><nobr>SiteName<\/nobr><\/td><td align=\"right\"><nobr>BarkingFoxLake<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Drainage<\/nobr><\/td><td align=\"right\"><nobr>WaterfallCreek<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Basin<\/nobr><\/td><td align=\"right\"><nobr>Terrace<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Substrate<\/nobr><\/td><td align=\"right\"><nobr>Silt<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>NWI<\/nobr><\/td><td align=\"right\"><nobr>Lacustrine<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AREA_m2<\/nobr><\/td><td align=\"right\"><nobr>12,000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>PERI_m<\/nobr><\/td><td align=\"right\"><nobr>435<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Depth_m<\/nobr><\/td><td align=\"right\"><nobr>5.00<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>TDS<\/nobr><\/td><td align=\"right\"><nobr>13.8<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>FISH<\/nobr><\/td><td align=\"right\"><nobr>1<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>ACB<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUC<\/nobr><\/td><td align=\"right\"><nobr>0.300<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCC<\/nobr><\/td><td align=\"right\"><nobr>0.300<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUF<\/nobr><\/td><td align=\"right\"><nobr>0.700<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AWOOD<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUFV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><\/table><\/div>","<style> div.leaflet-popup-content {width:auto !important;overflow-y:auto; overflow-x:hidden;}<\/style><div style=\"max-height:25em;padding-right:15px;\"><table>\n\t\t\t   <thead><tr><th colspan=\"2\"><b>BirdbillLake<\/b><\/th><\/thead><\/tr><tr><td style=\"color: #888888;\"><nobr>SiteName<\/nobr><\/td><td align=\"right\"><nobr>BirdbillLake<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Drainage<\/nobr><\/td><td align=\"right\"><nobr>ClearCreek<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Basin<\/nobr><\/td><td align=\"right\"><nobr>Birdbill<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Substrate<\/nobr><\/td><td align=\"right\"><nobr>Sand<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>NWI<\/nobr><\/td><td align=\"right\"><nobr>Lacustrine<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AREA_m2<\/nobr><\/td><td align=\"right\"><nobr>12,359<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>PERI_m<\/nobr><\/td><td align=\"right\"><nobr>572<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Depth_m<\/nobr><\/td><td align=\"right\"><nobr>3.93<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>TDS<\/nobr><\/td><td align=\"right\"><nobr>6.4<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>FISH<\/nobr><\/td><td align=\"right\"><nobr>1<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>ACB<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUC<\/nobr><\/td><td align=\"right\"><nobr>0.283<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCC<\/nobr><\/td><td align=\"right\"><nobr>0.283<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUF<\/nobr><\/td><td align=\"right\"><nobr>0.717<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AWOOD<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUFV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><\/table><\/div>","<style> div.leaflet-popup-content {width:auto !important;overflow-y:auto; overflow-x:hidden;}<\/style><div style=\"max-height:25em;padding-right:15px;\"><table>\n\t\t\t   <thead><tr><th colspan=\"2\"><b>BobLake<\/b><\/th><\/thead><\/tr><tr><td style=\"color: #888888;\"><nobr>SiteName<\/nobr><\/td><td align=\"right\"><nobr>BobLake<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Drainage<\/nobr><\/td><td align=\"right\"><nobr>WilsonCreek<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Basin<\/nobr><\/td><td align=\"right\"><nobr>Harbor<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Substrate<\/nobr><\/td><td align=\"right\"><nobr>Silt<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>NWI<\/nobr><\/td><td align=\"right\"><nobr>Palustrine<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AREA_m2<\/nobr><\/td><td align=\"right\"><nobr>4,600<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>PERI_m<\/nobr><\/td><td align=\"right\"><nobr>321<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Depth_m<\/nobr><\/td><td align=\"right\"><nobr>2.00<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>TDS<\/nobr><\/td><td align=\"right\"><nobr>14.3<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>FISH<\/nobr><\/td><td align=\"right\"><nobr>0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>ACB<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUC<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCC<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUF<\/nobr><\/td><td align=\"right\"><nobr>0.500<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AWOOD<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUFV<\/nobr><\/td><td align=\"right\"><nobr>0.500<\/nobr><\/td><\/tr><\/table><\/div>","<style> div.leaflet-popup-content {width:auto !important;overflow-y:auto; overflow-x:hidden;}<\/style><div style=\"max-height:25em;padding-right:15px;\"><table>\n\t\t\t   <thead><tr><th colspan=\"2\"><b>CacheLake<\/b><\/th><\/thead><\/tr><tr><td style=\"color: #888888;\"><nobr>SiteName<\/nobr><\/td><td align=\"right\"><nobr>CacheLake<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Drainage<\/nobr><\/td><td align=\"right\"><nobr>WilsonCreek<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Basin<\/nobr><\/td><td align=\"right\"><nobr>Skyhigh<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Substrate<\/nobr><\/td><td align=\"right\"><nobr>Silt<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>NWI<\/nobr><\/td><td align=\"right\"><nobr>Palustrine<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AREA_m2<\/nobr><\/td><td align=\"right\"><nobr>2,269<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>PERI_m<\/nobr><\/td><td align=\"right\"><nobr>192<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Depth_m<\/nobr><\/td><td align=\"right\"><nobr>1.86<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>TDS<\/nobr><\/td><td align=\"right\"><nobr>10.9<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>FISH<\/nobr><\/td><td align=\"right\"><nobr>0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>ACB<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUC<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCC<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUF<\/nobr><\/td><td align=\"right\"><nobr>0.556<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AWOOD<\/nobr><\/td><td align=\"right\"><nobr>0.093<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUFV<\/nobr><\/td><td align=\"right\"><nobr>0.352<\/nobr><\/td><\/tr><\/table><\/div>","<style> div.leaflet-popup-content {width:auto !important;overflow-y:auto; overflow-x:hidden;}<\/style><div style=\"max-height:25em;padding-right:15px;\"><table>\n\t\t\t   <thead><tr><th colspan=\"2\"><b>DoeLake<\/b><\/th><\/thead><\/tr><tr><td style=\"color: #888888;\"><nobr>SiteName<\/nobr><\/td><td align=\"right\"><nobr>DoeLake<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Drainage<\/nobr><\/td><td align=\"right\"><nobr>WilsonCreek<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Basin<\/nobr><\/td><td align=\"right\"><nobr>Skyhigh<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Substrate<\/nobr><\/td><td align=\"right\"><nobr>Silt<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>NWI<\/nobr><\/td><td align=\"right\"><nobr>Lacustrine<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AREA_m2<\/nobr><\/td><td align=\"right\"><nobr>13,035<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>PERI_m<\/nobr><\/td><td align=\"right\"><nobr>463<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Depth_m<\/nobr><\/td><td align=\"right\"><nobr>6.03<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>TDS<\/nobr><\/td><td align=\"right\"><nobr>10.0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>FISH<\/nobr><\/td><td align=\"right\"><nobr>1<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>ACB<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUC<\/nobr><\/td><td align=\"right\"><nobr>0.415<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCV<\/nobr><\/td><td align=\"right\"><nobr>0.171<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCC<\/nobr><\/td><td align=\"right\"><nobr>0.585<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUF<\/nobr><\/td><td align=\"right\"><nobr>0.341<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AWOOD<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUFV<\/nobr><\/td><td align=\"right\"><nobr>0.073<\/nobr><\/td><\/tr><\/table><\/div>","<style> div.leaflet-popup-content {width:auto !important;overflow-y:auto; overflow-x:hidden;}<\/style><div style=\"max-height:25em;padding-right:15px;\"><table>\n\t\t\t   <thead><tr><th colspan=\"2\"><b>EggWhiteLake<\/b><\/th><\/thead><\/tr><tr><td style=\"color: #888888;\"><nobr>SiteName<\/nobr><\/td><td align=\"right\"><nobr>EggWhiteLake<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Drainage<\/nobr><\/td><td align=\"right\"><nobr>WilsonCreek<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Basin<\/nobr><\/td><td align=\"right\"><nobr>Skyhigh<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Substrate<\/nobr><\/td><td align=\"right\"><nobr>Silt<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>NWI<\/nobr><\/td><td align=\"right\"><nobr>Palustrine<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AREA_m2<\/nobr><\/td><td align=\"right\"><nobr>4,544<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>PERI_m<\/nobr><\/td><td align=\"right\"><nobr>292<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Depth_m<\/nobr><\/td><td align=\"right\"><nobr>3.30<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>TDS<\/nobr><\/td><td align=\"right\"><nobr>2.4<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>FISH<\/nobr><\/td><td align=\"right\"><nobr>0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>ACB<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUC<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCV<\/nobr><\/td><td align=\"right\"><nobr>0.047<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCC<\/nobr><\/td><td align=\"right\"><nobr>0.047<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUF<\/nobr><\/td><td align=\"right\"><nobr>0.686<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AWOOD<\/nobr><\/td><td align=\"right\"><nobr>0.209<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUFV<\/nobr><\/td><td align=\"right\"><nobr>0.058<\/nobr><\/td><\/tr><\/table><\/div>","<style> div.leaflet-popup-content {width:auto !important;overflow-y:auto; overflow-x:hidden;}<\/style><div style=\"max-height:25em;padding-right:15px;\"><table>\n\t\t\t   <thead><tr><th colspan=\"2\"><b>ElenasLake<\/b><\/th><\/thead><\/tr><tr><td style=\"color: #888888;\"><nobr>SiteName<\/nobr><\/td><td align=\"right\"><nobr>ElenasLake<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Drainage<\/nobr><\/td><td align=\"right\"><nobr>ShipIslandCreek<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Basin<\/nobr><\/td><td align=\"right\"><nobr>Sheepeater<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Substrate<\/nobr><\/td><td align=\"right\"><nobr>Sand<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>NWI<\/nobr><\/td><td align=\"right\"><nobr>Palustrine<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AREA_m2<\/nobr><\/td><td align=\"right\"><nobr>0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>PERI_m<\/nobr><\/td><td align=\"right\"><nobr>0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Depth_m<\/nobr><\/td><td align=\"right\"><nobr>0.00<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>TDS<\/nobr><\/td><td align=\"right\"><nobr>0.0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>FISH<\/nobr><\/td><td align=\"right\"><nobr>0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>ACB<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUC<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCC<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUF<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AWOOD<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUFV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><\/table><\/div>","<style> div.leaflet-popup-content {width:auto !important;overflow-y:auto; overflow-x:hidden;}<\/style><div style=\"max-height:25em;padding-right:15px;\"><table>\n\t\t\t   <thead><tr><th colspan=\"2\"><b>FawnLake<\/b><\/th><\/thead><\/tr><tr><td style=\"color: #888888;\"><nobr>SiteName<\/nobr><\/td><td align=\"right\"><nobr>FawnLake<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Drainage<\/nobr><\/td><td align=\"right\"><nobr>WilsonCreek<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Basin<\/nobr><\/td><td align=\"right\"><nobr>Skyhigh<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Substrate<\/nobr><\/td><td align=\"right\"><nobr>Silt<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>NWI<\/nobr><\/td><td align=\"right\"><nobr>Palustrine<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AREA_m2<\/nobr><\/td><td align=\"right\"><nobr>3,866<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>PERI_m<\/nobr><\/td><td align=\"right\"><nobr>238<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Depth_m<\/nobr><\/td><td align=\"right\"><nobr>1.98<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>TDS<\/nobr><\/td><td align=\"right\"><nobr>3.6<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>FISH<\/nobr><\/td><td align=\"right\"><nobr>0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>ACB<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUC<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCC<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUF<\/nobr><\/td><td align=\"right\"><nobr>1.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AWOOD<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUFV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><\/table><\/div>","<style> div.leaflet-popup-content {width:auto !important;overflow-y:auto; overflow-x:hidden;}<\/style><div style=\"max-height:25em;padding-right:15px;\"><table>\n\t\t\t   <thead><tr><th colspan=\"2\"><b>FrogPondLake<\/b><\/th><\/thead><\/tr><tr><td style=\"color: #888888;\"><nobr>SiteName<\/nobr><\/td><td align=\"right\"><nobr>FrogPondLake<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Drainage<\/nobr><\/td><td align=\"right\"><nobr>WilsonCreek<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Basin<\/nobr><\/td><td align=\"right\"><nobr>Skyhigh<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Substrate<\/nobr><\/td><td align=\"right\"><nobr>Silt<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>NWI<\/nobr><\/td><td align=\"right\"><nobr>Palustrine<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AREA_m2<\/nobr><\/td><td align=\"right\"><nobr>2,094<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>PERI_m<\/nobr><\/td><td align=\"right\"><nobr>171<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Depth_m<\/nobr><\/td><td align=\"right\"><nobr>3.07<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>TDS<\/nobr><\/td><td align=\"right\"><nobr>9.0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>FISH<\/nobr><\/td><td align=\"right\"><nobr>0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>ACB<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUC<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCC<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUF<\/nobr><\/td><td align=\"right\"><nobr>0.500<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AWOOD<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUFV<\/nobr><\/td><td align=\"right\"><nobr>0.500<\/nobr><\/td><\/tr><\/table><\/div>","<style> div.leaflet-popup-content {width:auto !important;overflow-y:auto; overflow-x:hidden;}<\/style><div style=\"max-height:25em;padding-right:15px;\"><table>\n\t\t\t   <thead><tr><th colspan=\"2\"><b>GentianLake<\/b><\/th><\/thead><\/tr><tr><td style=\"color: #888888;\"><nobr>SiteName<\/nobr><\/td><td align=\"right\"><nobr>GentianLake<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Drainage<\/nobr><\/td><td align=\"right\"><nobr>ClearCreek<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Basin<\/nobr><\/td><td align=\"right\"><nobr>Birdbill<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Substrate<\/nobr><\/td><td align=\"right\"><nobr>Sand<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>NWI<\/nobr><\/td><td align=\"right\"><nobr>Lacustrine<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AREA_m2<\/nobr><\/td><td align=\"right\"><nobr>26,276<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>PERI_m<\/nobr><\/td><td align=\"right\"><nobr>1,046<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Depth_m<\/nobr><\/td><td align=\"right\"><nobr>3.57<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>TDS<\/nobr><\/td><td align=\"right\"><nobr>3.3<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>FISH<\/nobr><\/td><td align=\"right\"><nobr>1<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>ACB<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUC<\/nobr><\/td><td align=\"right\"><nobr>0.597<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCC<\/nobr><\/td><td align=\"right\"><nobr>0.597<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUF<\/nobr><\/td><td align=\"right\"><nobr>0.260<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AWOOD<\/nobr><\/td><td align=\"right\"><nobr>0.143<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUFV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><\/table><\/div>","<style> div.leaflet-popup-content {width:auto !important;overflow-y:auto; overflow-x:hidden;}<\/style><div style=\"max-height:25em;padding-right:15px;\"><table>\n\t\t\t   <thead><tr><th colspan=\"2\"><b>GentianPonds<\/b><\/th><\/thead><\/tr><tr><td style=\"color: #888888;\"><nobr>SiteName<\/nobr><\/td><td align=\"right\"><nobr>GentianPonds<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Drainage<\/nobr><\/td><td align=\"right\"><nobr>ClearCreek<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Basin<\/nobr><\/td><td align=\"right\"><nobr>Birdbill<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Substrate<\/nobr><\/td><td align=\"right\"><nobr>Silt<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>NWI<\/nobr><\/td><td align=\"right\"><nobr>Palustrine<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AREA_m2<\/nobr><\/td><td align=\"right\"><nobr>225<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>PERI_m<\/nobr><\/td><td align=\"right\"><nobr>60<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Depth_m<\/nobr><\/td><td align=\"right\"><nobr>2.00<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>TDS<\/nobr><\/td><td align=\"right\"><nobr>6.7<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>FISH<\/nobr><\/td><td align=\"right\"><nobr>0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>ACB<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUC<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCC<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUF<\/nobr><\/td><td align=\"right\"><nobr>1.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AWOOD<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUFV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><\/table><\/div>","<style> div.leaflet-popup-content {width:auto !important;overflow-y:auto; overflow-x:hidden;}<\/style><div style=\"max-height:25em;padding-right:15px;\"><table>\n\t\t\t   <thead><tr><th colspan=\"2\"><b>GoldenLake<\/b><\/th><\/thead><\/tr><tr><td style=\"color: #888888;\"><nobr>SiteName<\/nobr><\/td><td align=\"right\"><nobr>GoldenLake<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Drainage<\/nobr><\/td><td align=\"right\"><nobr>ClearCreek<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Basin<\/nobr><\/td><td align=\"right\"><nobr>Glacier<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Substrate<\/nobr><\/td><td align=\"right\"><nobr>Silt<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>NWI<\/nobr><\/td><td align=\"right\"><nobr>Lacustrine<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AREA_m2<\/nobr><\/td><td align=\"right\"><nobr>3,526<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>PERI_m<\/nobr><\/td><td align=\"right\"><nobr>264<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Depth_m<\/nobr><\/td><td align=\"right\"><nobr>2.00<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>TDS<\/nobr><\/td><td align=\"right\"><nobr>0.0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>FISH<\/nobr><\/td><td align=\"right\"><nobr>1<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>ACB<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUC<\/nobr><\/td><td align=\"right\"><nobr>0.111<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCC<\/nobr><\/td><td align=\"right\"><nobr>0.111<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUF<\/nobr><\/td><td align=\"right\"><nobr>0.889<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AWOOD<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUFV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><\/table><\/div>","<style> div.leaflet-popup-content {width:auto !important;overflow-y:auto; overflow-x:hidden;}<\/style><div style=\"max-height:25em;padding-right:15px;\"><table>\n\t\t\t   <thead><tr><th colspan=\"2\"><b>GreggsLake<\/b><\/th><\/thead><\/tr><tr><td style=\"color: #888888;\"><nobr>SiteName<\/nobr><\/td><td align=\"right\"><nobr>GreggsLake<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Drainage<\/nobr><\/td><td align=\"right\"><nobr>WilsonCreek<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Basin<\/nobr><\/td><td align=\"right\"><nobr>TipTop<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Substrate<\/nobr><\/td><td align=\"right\"><nobr>Cobble<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>NWI<\/nobr><\/td><td align=\"right\"><nobr>Palustrine<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AREA_m2<\/nobr><\/td><td align=\"right\"><nobr>6,556<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>PERI_m<\/nobr><\/td><td align=\"right\"><nobr>305<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Depth_m<\/nobr><\/td><td align=\"right\"><nobr>4.70<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>TDS<\/nobr><\/td><td align=\"right\"><nobr>0.0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>FISH<\/nobr><\/td><td align=\"right\"><nobr>0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>ACB<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUC<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCV<\/nobr><\/td><td align=\"right\"><nobr>0.351<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCC<\/nobr><\/td><td align=\"right\"><nobr>0.351<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUF<\/nobr><\/td><td align=\"right\"><nobr>0.455<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AWOOD<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUFV<\/nobr><\/td><td align=\"right\"><nobr>0.195<\/nobr><\/td><\/tr><\/table><\/div>","<style> div.leaflet-popup-content {width:auto !important;overflow-y:auto; overflow-x:hidden;}<\/style><div style=\"max-height:25em;padding-right:15px;\"><table>\n\t\t\t   <thead><tr><th colspan=\"2\"><b>InandOutLake<\/b><\/th><\/thead><\/tr><tr><td style=\"color: #888888;\"><nobr>SiteName<\/nobr><\/td><td align=\"right\"><nobr>InandOutLake<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Drainage<\/nobr><\/td><td align=\"right\"><nobr>WilsonCreek<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Basin<\/nobr><\/td><td align=\"right\"><nobr>Skyhigh<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Substrate<\/nobr><\/td><td align=\"right\"><nobr>Sand<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>NWI<\/nobr><\/td><td align=\"right\"><nobr>Lacustrine<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AREA_m2<\/nobr><\/td><td align=\"right\"><nobr>13,043<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>PERI_m<\/nobr><\/td><td align=\"right\"><nobr>438<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Depth_m<\/nobr><\/td><td align=\"right\"><nobr>8.00<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>TDS<\/nobr><\/td><td align=\"right\"><nobr>5.2<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>FISH<\/nobr><\/td><td align=\"right\"><nobr>0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>ACB<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUC<\/nobr><\/td><td align=\"right\"><nobr>0.279<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCV<\/nobr><\/td><td align=\"right\"><nobr>0.403<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCC<\/nobr><\/td><td align=\"right\"><nobr>0.682<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUF<\/nobr><\/td><td align=\"right\"><nobr>0.287<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AWOOD<\/nobr><\/td><td align=\"right\"><nobr>0.031<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUFV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><\/table><\/div>","<style> div.leaflet-popup-content {width:auto !important;overflow-y:auto; overflow-x:hidden;}<\/style><div style=\"max-height:25em;padding-right:15px;\"><table>\n\t\t\t   <thead><tr><th colspan=\"2\"><b>MeadowLake<\/b><\/th><\/thead><\/tr><tr><td style=\"color: #888888;\"><nobr>SiteName<\/nobr><\/td><td align=\"right\"><nobr>MeadowLake<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Drainage<\/nobr><\/td><td align=\"right\"><nobr>ClearCreek<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Basin<\/nobr><\/td><td align=\"right\"><nobr>Birdbill<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Substrate<\/nobr><\/td><td align=\"right\"><nobr>Silt<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>NWI<\/nobr><\/td><td align=\"right\"><nobr>Palustrine<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AREA_m2<\/nobr><\/td><td align=\"right\"><nobr>12,000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>PERI_m<\/nobr><\/td><td align=\"right\"><nobr>460<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Depth_m<\/nobr><\/td><td align=\"right\"><nobr>3.00<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>TDS<\/nobr><\/td><td align=\"right\"><nobr>10.0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>FISH<\/nobr><\/td><td align=\"right\"><nobr>1<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>ACB<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUC<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCC<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUF<\/nobr><\/td><td align=\"right\"><nobr>0.045<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AWOOD<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUFV<\/nobr><\/td><td align=\"right\"><nobr>0.955<\/nobr><\/td><\/tr><\/table><\/div>","<style> div.leaflet-popup-content {width:auto !important;overflow-y:auto; overflow-x:hidden;}<\/style><div style=\"max-height:25em;padding-right:15px;\"><table>\n\t\t\t   <thead><tr><th colspan=\"2\"><b>MooseLake<\/b><\/th><\/thead><\/tr><tr><td style=\"color: #888888;\"><nobr>SiteName<\/nobr><\/td><td align=\"right\"><nobr>MooseLake<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Drainage<\/nobr><\/td><td align=\"right\"><nobr>WilsonCreek<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Basin<\/nobr><\/td><td align=\"right\"><nobr>TipTop<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Substrate<\/nobr><\/td><td align=\"right\"><nobr>Silt<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>NWI<\/nobr><\/td><td align=\"right\"><nobr>Palustrine<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AREA_m2<\/nobr><\/td><td align=\"right\"><nobr>3,445<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>PERI_m<\/nobr><\/td><td align=\"right\"><nobr>220<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Depth_m<\/nobr><\/td><td align=\"right\"><nobr>2.00<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>TDS<\/nobr><\/td><td align=\"right\"><nobr>0.0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>FISH<\/nobr><\/td><td align=\"right\"><nobr>0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>ACB<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUC<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCV<\/nobr><\/td><td align=\"right\"><nobr>0.067<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCC<\/nobr><\/td><td align=\"right\"><nobr>0.067<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUF<\/nobr><\/td><td align=\"right\"><nobr>0.437<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AWOOD<\/nobr><\/td><td align=\"right\"><nobr>0.042<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUFV<\/nobr><\/td><td align=\"right\"><nobr>0.454<\/nobr><\/td><\/tr><\/table><\/div>","<style> div.leaflet-popup-content {width:auto !important;overflow-y:auto; overflow-x:hidden;}<\/style><div style=\"max-height:25em;padding-right:15px;\"><table>\n\t\t\t   <thead><tr><th colspan=\"2\"><b>Mt.WilsonLake<\/b><\/th><\/thead><\/tr><tr><td style=\"color: #888888;\"><nobr>SiteName<\/nobr><\/td><td align=\"right\"><nobr>Mt.WilsonLake<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Drainage<\/nobr><\/td><td align=\"right\"><nobr>WilsonCreek<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Basin<\/nobr><\/td><td align=\"right\"><nobr>TipTop<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Substrate<\/nobr><\/td><td align=\"right\"><nobr>Silt<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>NWI<\/nobr><\/td><td align=\"right\"><nobr>Palustrine<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AREA_m2<\/nobr><\/td><td align=\"right\"><nobr>6,089<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>PERI_m<\/nobr><\/td><td align=\"right\"><nobr>300<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Depth_m<\/nobr><\/td><td align=\"right\"><nobr>3.89<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>TDS<\/nobr><\/td><td align=\"right\"><nobr>5.0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>FISH<\/nobr><\/td><td align=\"right\"><nobr>0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>ACB<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUC<\/nobr><\/td><td align=\"right\"><nobr>0.441<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCC<\/nobr><\/td><td align=\"right\"><nobr>0.441<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUF<\/nobr><\/td><td align=\"right\"><nobr>0.441<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AWOOD<\/nobr><\/td><td align=\"right\"><nobr>0.118<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUFV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><\/table><\/div>","<style> div.leaflet-popup-content {width:auto !important;overflow-y:auto; overflow-x:hidden;}<\/style><div style=\"max-height:25em;padding-right:15px;\"><table>\n\t\t\t   <thead><tr><th colspan=\"2\"><b>NopezLake<\/b><\/th><\/thead><\/tr><tr><td style=\"color: #888888;\"><nobr>SiteName<\/nobr><\/td><td align=\"right\"><nobr>NopezLake<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Drainage<\/nobr><\/td><td align=\"right\"><nobr>ShipIslandCreek<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Basin<\/nobr><\/td><td align=\"right\"><nobr>Nopez<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Substrate<\/nobr><\/td><td align=\"right\"><nobr>silt<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>NWI<\/nobr><\/td><td align=\"right\"><nobr>Lacustrine<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AREA_m2<\/nobr><\/td><td align=\"right\"><nobr>12,003<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>PERI_m<\/nobr><\/td><td align=\"right\"><nobr>511<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Depth_m<\/nobr><\/td><td align=\"right\"><nobr>5.00<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>TDS<\/nobr><\/td><td align=\"right\"><nobr>0.0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>FISH<\/nobr><\/td><td align=\"right\"><nobr>0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>ACB<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUC<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCC<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUF<\/nobr><\/td><td align=\"right\"><nobr>0.882<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AWOOD<\/nobr><\/td><td align=\"right\"><nobr>0.118<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUFV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><\/table><\/div>","<style> div.leaflet-popup-content {width:auto !important;overflow-y:auto; overflow-x:hidden;}<\/style><div style=\"max-height:25em;padding-right:15px;\"><table>\n\t\t\t   <thead><tr><th colspan=\"2\"><b>ParagonLake<\/b><\/th><\/thead><\/tr><tr><td style=\"color: #888888;\"><nobr>SiteName<\/nobr><\/td><td align=\"right\"><nobr>ParagonLake<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Drainage<\/nobr><\/td><td align=\"right\"><nobr>WilsonCreek<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Basin<\/nobr><\/td><td align=\"right\"><nobr>TipTop<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Substrate<\/nobr><\/td><td align=\"right\"><nobr>Silt<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>NWI<\/nobr><\/td><td align=\"right\"><nobr>Lacustrine<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AREA_m2<\/nobr><\/td><td align=\"right\"><nobr>36,915<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>PERI_m<\/nobr><\/td><td align=\"right\"><nobr>917<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Depth_m<\/nobr><\/td><td align=\"right\"><nobr>12.70<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>TDS<\/nobr><\/td><td align=\"right\"><nobr>0.0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>FISH<\/nobr><\/td><td align=\"right\"><nobr>1<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>ACB<\/nobr><\/td><td align=\"right\"><nobr>0.110<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUC<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCV<\/nobr><\/td><td align=\"right\"><nobr>0.463<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCC<\/nobr><\/td><td align=\"right\"><nobr>0.463<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUF<\/nobr><\/td><td align=\"right\"><nobr>0.088<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AWOOD<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUFV<\/nobr><\/td><td align=\"right\"><nobr>0.338<\/nobr><\/td><\/tr><\/table><\/div>","<style> div.leaflet-popup-content {width:auto !important;overflow-y:auto; overflow-x:hidden;}<\/style><div style=\"max-height:25em;padding-right:15px;\"><table>\n\t\t\t   <thead><tr><th colspan=\"2\"><b>ParagonWetland<\/b><\/th><\/thead><\/tr><tr><td style=\"color: #888888;\"><nobr>SiteName<\/nobr><\/td><td align=\"right\"><nobr>ParagonWetland<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Drainage<\/nobr><\/td><td align=\"right\"><nobr>WilsonCreek<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Basin<\/nobr><\/td><td align=\"right\"><nobr>TipTop<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Substrate<\/nobr><\/td><td align=\"right\"><nobr>Silt<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>NWI<\/nobr><\/td><td align=\"right\"><nobr>Riverine_UpperPerennial_UnconsolidatedBottom<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AREA_m2<\/nobr><\/td><td align=\"right\"><nobr>1,000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>PERI_m<\/nobr><\/td><td align=\"right\"><nobr>120<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Depth_m<\/nobr><\/td><td align=\"right\"><nobr>0.25<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>TDS<\/nobr><\/td><td align=\"right\"><nobr>0.0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>FISH<\/nobr><\/td><td align=\"right\"><nobr>0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>ACB<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUC<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCC<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUF<\/nobr><\/td><td align=\"right\"><nobr>0.500<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AWOOD<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUFV<\/nobr><\/td><td align=\"right\"><nobr>0.500<\/nobr><\/td><\/tr><\/table><\/div>","<style> div.leaflet-popup-content {width:auto !important;overflow-y:auto; overflow-x:hidden;}<\/style><div style=\"max-height:25em;padding-right:15px;\"><table>\n\t\t\t   <thead><tr><th colspan=\"2\"><b>PotholeLake<\/b><\/th><\/thead><\/tr><tr><td style=\"color: #888888;\"><nobr>SiteName<\/nobr><\/td><td align=\"right\"><nobr>PotholeLake<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Drainage<\/nobr><\/td><td align=\"right\"><nobr>ClearCreek<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Basin<\/nobr><\/td><td align=\"right\"><nobr>Glacier<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Substrate<\/nobr><\/td><td align=\"right\"><nobr>Silt<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>NWI<\/nobr><\/td><td align=\"right\"><nobr>Lacustrine<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AREA_m2<\/nobr><\/td><td align=\"right\"><nobr>5,994<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>PERI_m<\/nobr><\/td><td align=\"right\"><nobr>293<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Depth_m<\/nobr><\/td><td align=\"right\"><nobr>3.35<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>TDS<\/nobr><\/td><td align=\"right\"><nobr>0.0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>FISH<\/nobr><\/td><td align=\"right\"><nobr>1<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>ACB<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUC<\/nobr><\/td><td align=\"right\"><nobr>0.097<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCC<\/nobr><\/td><td align=\"right\"><nobr>0.097<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUF<\/nobr><\/td><td align=\"right\"><nobr>0.778<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AWOOD<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUFV<\/nobr><\/td><td align=\"right\"><nobr>0.125<\/nobr><\/td><\/tr><\/table><\/div>","<style> div.leaflet-popup-content {width:auto !important;overflow-y:auto; overflow-x:hidden;}<\/style><div style=\"max-height:25em;padding-right:15px;\"><table>\n\t\t\t   <thead><tr><th colspan=\"2\"><b>RamshornLake<\/b><\/th><\/thead><\/tr><tr><td style=\"color: #888888;\"><nobr>SiteName<\/nobr><\/td><td align=\"right\"><nobr>RamshornLake<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Drainage<\/nobr><\/td><td align=\"right\"><nobr>WilsonCreek<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Basin<\/nobr><\/td><td align=\"right\"><nobr>TipTop<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Substrate<\/nobr><\/td><td align=\"right\"><nobr>Silt<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>NWI<\/nobr><\/td><td align=\"right\"><nobr>Lacustrine<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AREA_m2<\/nobr><\/td><td align=\"right\"><nobr>38,913<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>PERI_m<\/nobr><\/td><td align=\"right\"><nobr>922<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Depth_m<\/nobr><\/td><td align=\"right\"><nobr>16.97<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>TDS<\/nobr><\/td><td align=\"right\"><nobr>5.0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>FISH<\/nobr><\/td><td align=\"right\"><nobr>1<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>ACB<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUC<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCC<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUF<\/nobr><\/td><td align=\"right\"><nobr>0.135<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AWOOD<\/nobr><\/td><td align=\"right\"><nobr>0.099<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUFV<\/nobr><\/td><td align=\"right\"><nobr>0.766<\/nobr><\/td><\/tr><\/table><\/div>","<style> div.leaflet-popup-content {width:auto !important;overflow-y:auto; overflow-x:hidden;}<\/style><div style=\"max-height:25em;padding-right:15px;\"><table>\n\t\t\t   <thead><tr><th colspan=\"2\"><b>ShipIslandLake<\/b><\/th><\/thead><\/tr><tr><td style=\"color: #888888;\"><nobr>SiteName<\/nobr><\/td><td align=\"right\"><nobr>ShipIslandLake<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Drainage<\/nobr><\/td><td align=\"right\"><nobr>ShipIslandCreek<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Basin<\/nobr><\/td><td align=\"right\"><nobr>Nopez<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Substrate<\/nobr><\/td><td align=\"right\"><nobr>Sand<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>NWI<\/nobr><\/td><td align=\"right\"><nobr>Lacustrine<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AREA_m2<\/nobr><\/td><td align=\"right\"><nobr>353,898<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>PERI_m<\/nobr><\/td><td align=\"right\"><nobr>4,313<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Depth_m<\/nobr><\/td><td align=\"right\"><nobr>22.86<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>TDS<\/nobr><\/td><td align=\"right\"><nobr>5.0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>FISH<\/nobr><\/td><td align=\"right\"><nobr>1<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>ACB<\/nobr><\/td><td align=\"right\"><nobr>0.036<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUC<\/nobr><\/td><td align=\"right\"><nobr>0.405<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCV<\/nobr><\/td><td align=\"right\"><nobr>0.012<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCC<\/nobr><\/td><td align=\"right\"><nobr>0.417<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUF<\/nobr><\/td><td align=\"right\"><nobr>0.357<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AWOOD<\/nobr><\/td><td align=\"right\"><nobr>0.071<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUFV<\/nobr><\/td><td align=\"right\"><nobr>0.119<\/nobr><\/td><\/tr><\/table><\/div>","<style> div.leaflet-popup-content {width:auto !important;overflow-y:auto; overflow-x:hidden;}<\/style><div style=\"max-height:25em;padding-right:15px;\"><table>\n\t\t\t   <thead><tr><th colspan=\"2\"><b>SkyhighLake<\/b><\/th><\/thead><\/tr><tr><td style=\"color: #888888;\"><nobr>SiteName<\/nobr><\/td><td align=\"right\"><nobr>SkyhighLake<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Drainage<\/nobr><\/td><td align=\"right\"><nobr>WilsonCreek<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Basin<\/nobr><\/td><td align=\"right\"><nobr>Skyhigh<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Substrate<\/nobr><\/td><td align=\"right\"><nobr>Silt<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>NWI<\/nobr><\/td><td align=\"right\"><nobr>Lacustrine<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AREA_m2<\/nobr><\/td><td align=\"right\"><nobr>39,087<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>PERI_m<\/nobr><\/td><td align=\"right\"><nobr>764<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Depth_m<\/nobr><\/td><td align=\"right\"><nobr>24.30<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>TDS<\/nobr><\/td><td align=\"right\"><nobr>0.0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>FISH<\/nobr><\/td><td align=\"right\"><nobr>1<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>ACB<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUC<\/nobr><\/td><td align=\"right\"><nobr>0.630<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCC<\/nobr><\/td><td align=\"right\"><nobr>0.630<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUF<\/nobr><\/td><td align=\"right\"><nobr>0.151<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AWOOD<\/nobr><\/td><td align=\"right\"><nobr>0.151<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUFV<\/nobr><\/td><td align=\"right\"><nobr>0.068<\/nobr><\/td><\/tr><\/table><\/div>","<style> div.leaflet-popup-content {width:auto !important;overflow-y:auto; overflow-x:hidden;}<\/style><div style=\"max-height:25em;padding-right:15px;\"><table>\n\t\t\t   <thead><tr><th colspan=\"2\"><b>StockingCapLake<\/b><\/th><\/thead><\/tr><tr><td style=\"color: #888888;\"><nobr>SiteName<\/nobr><\/td><td align=\"right\"><nobr>StockingCapLake<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Drainage<\/nobr><\/td><td align=\"right\"><nobr>ClearCreek<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Basin<\/nobr><\/td><td align=\"right\"><nobr>Birdbill<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Substrate<\/nobr><\/td><td align=\"right\"><nobr>Cobble<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>NWI<\/nobr><\/td><td align=\"right\"><nobr>Palustrine<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AREA_m2<\/nobr><\/td><td align=\"right\"><nobr>5,814<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>PERI_m<\/nobr><\/td><td align=\"right\"><nobr>353<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Depth_m<\/nobr><\/td><td align=\"right\"><nobr>4.02<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>TDS<\/nobr><\/td><td align=\"right\"><nobr>6.8<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>FISH<\/nobr><\/td><td align=\"right\"><nobr>1<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>ACB<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUC<\/nobr><\/td><td align=\"right\"><nobr>0.430<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCC<\/nobr><\/td><td align=\"right\"><nobr>0.430<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUF<\/nobr><\/td><td align=\"right\"><nobr>0.494<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AWOOD<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUFV<\/nobr><\/td><td align=\"right\"><nobr>0.076<\/nobr><\/td><\/tr><\/table><\/div>","<style> div.leaflet-popup-content {width:auto !important;overflow-y:auto; overflow-x:hidden;}<\/style><div style=\"max-height:25em;padding-right:15px;\"><table>\n\t\t\t   <thead><tr><th colspan=\"2\"><b>Terrace1Lake<\/b><\/th><\/thead><\/tr><tr><td style=\"color: #888888;\"><nobr>SiteName<\/nobr><\/td><td align=\"right\"><nobr>Terrace1Lake<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Drainage<\/nobr><\/td><td align=\"right\"><nobr>WaterfallCreek<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Basin<\/nobr><\/td><td align=\"right\"><nobr>Terrace<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Substrate<\/nobr><\/td><td align=\"right\"><nobr>Silt<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>NWI<\/nobr><\/td><td align=\"right\"><nobr>Lacustrine<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AREA_m2<\/nobr><\/td><td align=\"right\"><nobr>16,601<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>PERI_m<\/nobr><\/td><td align=\"right\"><nobr>520<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Depth_m<\/nobr><\/td><td align=\"right\"><nobr>6.00<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>TDS<\/nobr><\/td><td align=\"right\"><nobr>0.0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>FISH<\/nobr><\/td><td align=\"right\"><nobr>1<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>ACB<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUC<\/nobr><\/td><td align=\"right\"><nobr>0.396<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCC<\/nobr><\/td><td align=\"right\"><nobr>0.396<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUF<\/nobr><\/td><td align=\"right\"><nobr>0.604<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AWOOD<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUFV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><\/table><\/div>","<style> div.leaflet-popup-content {width:auto !important;overflow-y:auto; overflow-x:hidden;}<\/style><div style=\"max-height:25em;padding-right:15px;\"><table>\n\t\t\t   <thead><tr><th colspan=\"2\"><b>TobiasLake<\/b><\/th><\/thead><\/tr><tr><td style=\"color: #888888;\"><nobr>SiteName<\/nobr><\/td><td align=\"right\"><nobr>TobiasLake<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Drainage<\/nobr><\/td><td align=\"right\"><nobr>WilsonCreek<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Basin<\/nobr><\/td><td align=\"right\"><nobr>Harbor<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Substrate<\/nobr><\/td><td align=\"right\"><nobr>Silt<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>NWI<\/nobr><\/td><td align=\"right\"><nobr>Palustrine<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AREA_m2<\/nobr><\/td><td align=\"right\"><nobr>0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>PERI_m<\/nobr><\/td><td align=\"right\"><nobr>0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Depth_m<\/nobr><\/td><td align=\"right\"><nobr>0.00<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>TDS<\/nobr><\/td><td align=\"right\"><nobr>0.0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>FISH<\/nobr><\/td><td align=\"right\"><nobr>0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>ACB<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUC<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCC<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUF<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AWOOD<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUFV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><\/table><\/div>","<style> div.leaflet-popup-content {width:auto !important;overflow-y:auto; overflow-x:hidden;}<\/style><div style=\"max-height:25em;padding-right:15px;\"><table>\n\t\t\t   <thead><tr><th colspan=\"2\"><b>WalkaboutLake<\/b><\/th><\/thead><\/tr><tr><td style=\"color: #888888;\"><nobr>SiteName<\/nobr><\/td><td align=\"right\"><nobr>WalkaboutLake<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Drainage<\/nobr><\/td><td align=\"right\"><nobr>WilsonCreek<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Basin<\/nobr><\/td><td align=\"right\"><nobr>TipTop<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Substrate<\/nobr><\/td><td align=\"right\"><nobr>Cobble<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>NWI<\/nobr><\/td><td align=\"right\"><nobr>Lacustrine<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AREA_m2<\/nobr><\/td><td align=\"right\"><nobr>6,856<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>PERI_m<\/nobr><\/td><td align=\"right\"><nobr>336<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Depth_m<\/nobr><\/td><td align=\"right\"><nobr>5.70<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>TDS<\/nobr><\/td><td align=\"right\"><nobr>10.0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>FISH<\/nobr><\/td><td align=\"right\"><nobr>0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>ACB<\/nobr><\/td><td align=\"right\"><nobr>0.083<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUC<\/nobr><\/td><td align=\"right\"><nobr>0.817<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCC<\/nobr><\/td><td align=\"right\"><nobr>0.817<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUF<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AWOOD<\/nobr><\/td><td align=\"right\"><nobr>0.100<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUFV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><\/table><\/div>","<style> div.leaflet-popup-content {width:auto !important;overflow-y:auto; overflow-x:hidden;}<\/style><div style=\"max-height:25em;padding-right:15px;\"><table>\n\t\t\t   <thead><tr><th colspan=\"2\"><b>WelcomeLake<\/b><\/th><\/thead><\/tr><tr><td style=\"color: #888888;\"><nobr>SiteName<\/nobr><\/td><td align=\"right\"><nobr>WelcomeLake<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Drainage<\/nobr><\/td><td align=\"right\"><nobr>WilsonCreek<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Basin<\/nobr><\/td><td align=\"right\"><nobr>Harbor<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Substrate<\/nobr><\/td><td align=\"right\"><nobr>Silt<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>NWI<\/nobr><\/td><td align=\"right\"><nobr>Lacustrine<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AREA_m2<\/nobr><\/td><td align=\"right\"><nobr>17,159<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>PERI_m<\/nobr><\/td><td align=\"right\"><nobr>915<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>Depth_m<\/nobr><\/td><td align=\"right\"><nobr>3.08<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>TDS<\/nobr><\/td><td align=\"right\"><nobr>20.0<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>FISH<\/nobr><\/td><td align=\"right\"><nobr>1<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>ACB<\/nobr><\/td><td align=\"right\"><nobr>0.022<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUC<\/nobr><\/td><td align=\"right\"><nobr>0.034<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCV<\/nobr><\/td><td align=\"right\"><nobr>0.000<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUCC<\/nobr><\/td><td align=\"right\"><nobr>0.034<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUF<\/nobr><\/td><td align=\"right\"><nobr>0.820<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AWOOD<\/nobr><\/td><td align=\"right\"><nobr>0.067<\/nobr><\/td><\/tr><tr><td style=\"color: #888888;\"><nobr>AUFV<\/nobr><\/td><td align=\"right\"><nobr>0.056<\/nobr><\/td><\/tr><\/table><\/div>"],null,["AirplaneLake","BachelorMeadow","BarkingFoxLake","BirdbillLake","BobLake","CacheLake","DoeLake","EggWhiteLake","ElenasLake","FawnLake","FrogPondLake","GentianLake","GentianPonds","GoldenLake","GreggsLake","InandOutLake","MeadowLake","MooseLake","Mt.WilsonLake","NopezLake","ParagonLake","ParagonWetland","PotholeLake","RamshornLake","ShipIslandLake","SkyhighLake","StockingCapLake","Terrace1Lake","TobiasLake","WalkaboutLake","WelcomeLake"],{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null,null]},{"method":"addLayersControl","args":[["Esri.WorldGrayCanvas","OpenStreetMap","Esri.WorldTopoMap"],"Sites.sf",{"collapsed":true,"autoZIndex":true,"position":"topleft"}]}],"limits":{"lat":[45.07529212294912,45.16810160930147],"lng":[-114.6222594992278,-114.5715719888294]},"fitBounds":[45.07529212294912,-114.6222594992278,45.16810160930147,-114.5715719888294,[]]},"evals":[],"jsHooks":[]}</script>
```

**Question:** Try changing the basemap by clicking on the Layers symbol and selecting a different map. Which map is most informative for these data? Zoom in and out to find out where on Earth the sampling points are located. 

Note: see this week's bonus materials to learn more about creating maps with `tmap`.

## 3. Display raster data and overlay sampling locations, extract data {-} 

### a) Display raster data {-}

The raster data for this project are already available in the package `GeNetIt`. They are stored as a `SpatRaster` object from package `terra`. 


```r
RasterMaps <- rast(system.file("extdata/covariates.tif", package="GeNetIt"))
class(RasterMaps)
```

```
## [1] "SpatRaster"
## attr(,"package")
## [1] "terra"
```

Printing the name of the `SpatRaster` object displays a summary. A few explanations:

- **dimensions**: number of rows (nrow), number of columns (ncol), number of layers (nlyr). So we see there are 6 layers (i.e., variables).
- **resolution**: cell size is 30 m both in x and y directions (typical for Landsat-derived remote sensing data)
- extent: the bounding box that defines the spatial extent of the raster data.
- **coord.ref**: projected in UTM zone 11, with 'datum' (NAD83). 
- **source**: the file from which the data were imported.
- **names, min values, max values**: summary of the layers (variables).


```r
RasterMaps
```

```
## class       : SpatRaster 
## dimensions  : 426, 358, 6  (nrow, ncol, nlyr)
## resolution  : 30, 30  (x, y)
## extent      : 683282.5, 694022.5, 4992833, 5005613  (xmin, xmax, ymin, ymax)
## coord. ref. : NAD83 / UTM zone 11N (EPSG:26911) 
## source      : covariates.tif 
## names       :        cti,      err27, ffp,      gsp,  hli, nlcd 
## min values  :  0.8429851, 0.03906551,   0, 227.0000, 1014,   11 
## max values  : 23.7147598, 0.76376426,  51, 338.0697, 9263,   95
```

Now we can use `plot`, which knows what to do with a raster `SpatRaster` object.

Note: layer `nlcd` is a categorical map of land cover types. See this week's bonus materials for how to better display a categorical map in R.














































































