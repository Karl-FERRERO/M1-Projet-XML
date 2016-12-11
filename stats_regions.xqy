xquery version "3.0";

declare function local:getListeRegions()  {
        for $x in distinct-values(doc("merimee-MH.xml")/csv_data/row/REG)
        order by $x
        return data($x)
};



element {QName("http://www.w3.org/1999/xhtml", "html")} {
    <figure>
        <figcaption>Nombre de monuments par région :</figcaption>
    <svg class="chart" width="500" height="700" aria-labelledby="title desc" role="img">
    
        
            {
                
                let $monumentsregion := local:getListeRegions()
                
                    for $region at $nb in $monumentsregion
                    let $count := count(
                        for $x in doc("merimee-MH.xml")/csv_data/row[REG=$region]
                        return $x
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