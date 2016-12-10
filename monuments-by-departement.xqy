xquery version "3.0";

import module namespace request = "http://exist-db.org/xquery/request";

let $departement := request:get-parameter("departement", "06")
let $page := number(request:get-parameter("page", 1))
let $records := 16
let $start := ($page+-1)*$records+1

let $monumentsdpt :=
    for $x in doc("merimee-MH.xml")/csv_data/row
    where $x/DPT=$departement
    return $x
    
let $nbPages := floor(count($monumentsdpt) div $records)

return element {QName("http://www.w3.org/1999/xhtml", "html")} {
    
    <div id="conteneur-fiches" data-totalpages="{$nbPages}"> {
    for $x at $count in subsequence($monumentsdpt, $start, $records)
    return
       <div class="fiche">
                <h1>
                    <span>{data($x/REF)}</span> <br/>
                    <span>{data($x/TICO)}</span>
                    (<span>{data($x/COM)}</span>)
                </h1>
                <p>{data($x/PPRO)}</p>
            </div>
    }
    </div>
}


