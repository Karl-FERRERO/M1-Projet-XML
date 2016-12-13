xquery version "3.0";

declare function local:getListeRegions()  {
        for $x in distinct-values(doc("merimee-MH.xml")/csv_data/row/REG)
        let $count := count(
                        for $y in doc("merimee-MH.xml")/csv_data/row[REG=$x]
                        return $y
                    ) 
        order by $count descending
        return  <STAT><REG>{string($x)}</REG><COUNT>{string($count)}</COUNT></STAT>
};


local:getListeRegions()