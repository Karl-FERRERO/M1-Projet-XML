xquery version "3.0";

import module namespace request = "http://exist-db.org/xquery/request";

element {QName("http://www.w3.org/1999/xhtml", "html")} {
    
    let $departement := request:get-parameter("departement", "06")
    let $page := number(request:get-parameter("page", 1))
    let $records := 5
    let $start := ($page+-1)*$records+1
     
    let $monumentsdpt :=
        for $x in doc("merimee-MH.xml")/csv_data/row
        where $x/DPT=$departement
        return $x

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


