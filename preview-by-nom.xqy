xquery version "3.0";

import module namespace request = "http://exist-db.org/xquery/request";

declare namespace functx = "http://www.functx.com";
declare function functx:capitalize-first
  ( $arg as xs:string? )  as xs:string? {

   concat(upper-case(substring($arg,1,1)),
             substring($arg,2))
 } ;
 
let $nom := request:get-parameter("nom", "tour")
let $nomCap := upper-case($nom)
let $nomLow := lower-case($nom)
let $nomCapFirst := functx:capitalize-first($nomLow)
    
let $page := number(request:get-parameter("page", 1))
let $records := 16
let $start := ($page+-1)*$records+1

let $correspondance :=
        for $x in doc("merimee-MH.xml")/csv_data/row[matches(TICO, $nom) or matches(TICO, $nomCapFirst) or matches(TICO, $nomCap) or matches(TICO, $nomLow)]
        return $x
        
let $nbPages := floor(count($correspondance) div $records)

return element {QName("http://www.w3.org/1999/xhtml", "html")} {
    
    <div id="conteneur-fiches" data-totalpages="{$nbPages}"> {
        for $x at $count in subsequence($correspondance, $start, $records)
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

