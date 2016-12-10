xquery version "3.0";

import module namespace request = "http://exist-db.org/xquery/request";
 
let $ref := request:get-parameter("ref", "pa00132788")
let $refCap := upper-case($ref)
let $refLow := lower-case($ref)

return element {QName("http://www.w3.org/1999/xhtml", "html")} {
    
    for $x in doc("merimee-MH.xml")/csv_data/row[REF=$ref or REF=$refCap or REF=$refLow]
        return
            <div class="fiche-complete">
                { if(data($x/REF)) then <div>REF : {data($x/REF)}</div> else () } 
                { if(data($x/ETUD)) then <div>ETUD : {data($x/ETUD)}</div> else () } 
                { if(data($x/REG)) then <div>Région : {data($x/REG)}</div> else () } 
                { if(data($x/DPT)) then <div>Département : {data($x/DPT)}</div> else () } 
                { if(data($x/COM)) then <div>Commune : {data($x/COM)}</div> else () } 
                { if(data($x/INSEE)) then <div>INSEE : {data($x/INSEE)}</div> else () } 
                { if(data($x/TICO)) then <div>TICO : {data($x/TICO)}</div> else () } 
                { if(data($x/ADRS)) then <div>ADRS : {data($x/ADRS)}</div> else () } 
                { if(data($x/STAT)) then <div>STAT : {data($x/STAT)}</div> else () } 
                { if(data($x/AFFE)) then <div>AFFE : {data($x/AFFE)}</div> else () } 
                { if(data($x/PPRO)) then <div>PPRO : {data($x/PPRO)}</div> else () } 
                { if(data($x/AUTR)) then <div>AUTR : {data($x/AUTR)}</div> else () } 
                { if(data($x/SCLE)) then <div>Siècle(s) : {data($x/SCLE)}</div> else () } 
            </div>
}

