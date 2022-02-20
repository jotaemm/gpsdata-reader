%% Create an objects which represents a serial port
port = "COM3";
baudrate = 4800;
bits = 7;
timeout = 15;
serial_port = serialport(port, baudrate, "DataBits", bits, "Timeout", timeout);

%% Receive data from serial port and stores it in a string
tic
pattern = '\$GPGGA,[A-Z0-9,\.]+,\*[A-Z0-9]+';                               %pattern for de regexp
k = 1;                                                                      %iterator
n = 100;                                                                    %number of locations requested
location = cell([1 n]);                                                     %variable which stores GPGGA                               
while(k ~= n+1)
    string_buffer = readline(serial_port);                                  %read from the port   
    if strcmp("$GPGGA", extractBetween(string_buffer, 1, 6))                %generate the next index for location
        string_GPGGA = regexp(string_buffer, pattern, 'match');             %extrac GPGGA data
        location(1, k) = {string_GPGGA};                                    %store GPGGA data in a cell array
        k = k + 1;
    end
end
toc
%% Extract data from the cell array
k = 1;
latitude_utm =zeros([1 n]);
longitude_utm =zeros([1 n]);
while(k ~= n+1)
    [data_GPGGA,ierr]  =  nmealineread(convertStringsToChars(location{k}));
    latitude_utm(1,k) = data_GPGGA.latitude;
    longitude_utm(1,k) = data_GPGGA.longitude;
    k = k + 1;
end

% Draw the GPS Data in the map
figure(1)
geodensityplot(28.07, -15.45, 340, 'Radius',1)
hold on
geoplot(latitude_utm,longitude_utm,"Marker",".")
hold off
