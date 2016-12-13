xquery version "3.0";

import module namespace request = "http://exist-db.org/xquery/request";
let $lieu := request:get-parameter("lieu", 'DPT')

return element {QName("http://www.w3.org/1999/xhtml", "html")} {
    
    
    <figure>
        <figcaption>Nombre de monuments par région :</figcaption>
    <svg class="chart" width="600" height="700" aria-labelledby="title desc" role="img">
            {
                
                let $monumentsregion :=  
                    if($lieu ='REG') then (
                        for $x in distinct-values(doc("merimee-MH.xml")/csv_data/row/REG)
                        let $count := count(
                            for $y in doc("merimee-MH.xml")/csv_data/row[REG=$x]
                                return $y
                            ) 
                        order by $count descending
                        return data($x)) 
                    else (for $x in distinct-values(doc("merimee-MH.xml")/csv_data/row/DPT)
                                let $count := count(
                                for $y in doc("merimee-MH.xml")/csv_data/row[DPT=$x]
                                    return $y
                                ) 
                            order by $count descending
                            return data($x))
                
                    for $region at $nb in $monumentsregion
                    let $count := count(
                        if($lieu ='REG') then (
                            for $x in doc("merimee-MH.xml")/csv_data/row[REG=$region]
                            return $x) 
                        else (for $x in doc("merimee-MH.xml")/csv_data/row[DPT=$region]
                            return $x)
                    )
                    let $y := $nb * 20
                    let $e := 10
                    let $test := $count
                    
                    
                    return  <g class="bar">
                                <rect width="{$test div 10}" height="19" y="{$y}" ></rect>
                                <text x="{($test+10) div 10}" y="{$y+8}" dy=".35em">{string($region)} : { string($count ) } </text>
                            </g>
                             
            }
    </svg>
    </figure>
        
}