xquery version "3.0";

import module namespace request = "http://exist-db.org/xquery/request";

let $region := request:get-parameter("region", "Alsace")
let $page := number(request:get-parameter("page", 1))
let $records := 16
let $start := ($page+-1)*$records+1
     
let $monumentsregion :=
    for $x in doc("merimee-MH.xml")/csv_data/row
    where $x/REG=$region
    return $x
    
let $nbPages := floor(count($monumentsregion) div $records)
        
return element {QName("http://www.w3.org/1999/xhtml", "html")} {

    <div id="conteneur-fiches" data-totalpages="{$nbPages}"> {
    for $x at $count in subsequence($monumentsregion, $start, $records)
    return
       <div class="fiche">
            <div>{data($x/TICO)}</div>
            <div>
                { if(data($x/COM)) then data($x/COM) || " " else () } 
                { if(data($x/DPT)) then data($x/DPT) || " " else () } 
                { if(data($x/REG)) then data($x/REG) else () } 
            </div>
            <div>{data($x/REF)}</div>
        </div>
    }
    </div>
}