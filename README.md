# gpsdata-reader
This repository contains two MATLAB files:
- gps_matlab.m: this file is a script in which the data from the gps are harvested and plotted in a map. Firstly, a serial port is configured to get the data which are harvested from the GPS device. The GPS data uses NMEA protocol, so, for getting the data which give the positioning information, regular expressions are used. GPGGA data from NMEA are extrated by defining the pattern for the regular expressions. Once the GPGGA data is obtained, these data is converted to latitude and longitude data with the function nmealineread.m. With the longitude and latitude information, the position is plotted using the Mapping Toolbox from Matlab.
- nmealineread.m: this file is a function used to convert the GPGGA data to latitude and longitude. This function is provided by rowetechinc (GitHub contributor)
