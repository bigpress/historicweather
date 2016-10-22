#!/bin/bash
command="curl  --retry 999 --retry-max-time 0 -C -"

LOCAL='weather_coruna_ruavalleinclan'
STATION='IACORUA23'

INI=1997
END=2016
FILE=${LOCAL}_${STATION}_${INI}_${END}.csv
SITE='airport'

echo "CET,Max TemperatureC,Mean TemperatureC,Min TemperatureC,Dew PointC,MeanDew PointC,Min DewpointC,Max Humidity, Mean Humidity, Min Humidity, Max Sea Level PressurehPa, Mean Sea Level PressurehPa, Min Sea Level PressurehPa, Max VisibilityKm, Mean VisibilityKm, Min VisibilitykM, Max Wind SpeedKm/h, Mean Wind SpeedKm/h, Max Gust SpeedKm/h,Precipitationmm, CloudCover, Events,WindDirDegrees" > ${FILE}

for YEAR in $(seq ${INI} ${END})
do
   echo "Year $YEAR"
   $command  "https://www.wunderground.com/history/${SITE}/${STATION}/${YEAR}/1/1/CustomHistory.html?dayend=31&monthend=12&yearend=${YEAR}&req_city=&req_state=&req_statename=&reqdb.zip=&reqdb.magic=&reqdb.wmo=&format=1" -o "${LOCAL}_${YEAR}.csv"
   tail -n +3 ${LOCAL}_${YEAR}.csv > ${LOCAL}_${YEAR}_1.csv
   sed 's/<br\ \/>//g' ${LOCAL}_${YEAR}_1.csv >> ${FILE}
   rm ${LOCAL}_${YEAR}.csv ${LOCAL}_${YEAR}_1.csv
done

