declare function xf:current-date-time-millis() as xs:integer {
    xs:integer((current-dateTime() - dateTime(xs:date("1970-01-01"), xs:time("00:00:00-00:00"))) div xs:dayTimeDuration('PT0.001S'))
};

