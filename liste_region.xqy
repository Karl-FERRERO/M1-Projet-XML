xquery version "3.0";

(:  declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "json";
declare option output:media-type "application/json"; :)

declare function local:getListeRegions()  {
        for $x in distinct-values(doc("merimee-MH.xml")/csv_data/row/REG)
        order by $x
        return <div class="region">{data($x)}</div>
        
};

local:getListeRegions()