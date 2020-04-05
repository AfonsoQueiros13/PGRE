#!/bin/bash
wget -S --header="Accept-Encoding: gzip, deflate" --header='Accept-Charset: UTF-8' --header='Content-Type: application/json' -O response.json --post-data '{"param1":"myspecialValue1","param2":"my special value 2"}' http://localhost:85
wget -S --header="Accept-Encoding: gzip, deflate" --header='Accept-Charset: UTF-8' --header='Content-Type: application/json' -O response.json --post-data '{"param1":"myspecialValue1","param2":"my special value 2"}' http://localhost:90

