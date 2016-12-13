xquery version "3.0";
import module namespace request = "http://exist-db.org/xquery/request";
let $lieu := request:get-parameter("lieu", 'DPT')

return element {QName("http://www.w3.org/1999/xhtml", "html")} {
    
  
    if($lieu ='REG') then (
        for $x in distinct-values(doc("merimee-MH.xml")/csv_data/row/REG)
            let $count := count(
                            for $y in doc("merimee-MH.xml")/csv_data/row[REG=$x]
                            return $y
                        ) 
            order by $count descending
            return  <STAT><REG>{string($x)}</REG><COUNT>{string($count)}</COUNT></STAT>) 
    else (
        for $x in distinct-values(doc("merimee-MH.xml")/csv_data/row/DPT)
            let $count := count(
                            for $y in doc("merimee-MH.xml")/csv_data/row[DPT=$x]
                            return $y
                        ) 
            order by $count descending
            return  <STAT><REG>{string($x)}</REG><COUNT>{string($count)}</COUNT></STAT>)

    
     
}



