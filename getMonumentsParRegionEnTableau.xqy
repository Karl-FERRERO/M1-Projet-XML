xquery version "3.0";

import module namespace request = "http://exist-db.org/xquery/request";

let $lieu := request:get-parameter("lieu", 'DPT')

return element {QName("http://www.w3.org/1999/xhtml", "html")} {
    
    <table>
        <tr><th>{$lieu}</th><th>Nombre de monuments</th></tr>
            {
                let $monumentsregion :=  
                    if($lieu ='REG') then (
                        for $x in distinct-values(doc("merimee-MH.xml")/csv_data/row/REG)
                        let $count := count(
                            for $y in doc("merimee-MH.xml")/csv_data/row[REG=$x]
                                return $y
                            ) 
                        order by $count descending
                        return data($x)
                        
                        ) else (
                            for $x in distinct-values(doc("merimee-MH.xml")/csv_data/row/DPT)
                        let $count := count(
                            for $y in doc("merimee-MH.xml")/csv_data/row[DPT=$x]
                                return $y
                            ) 
                            order by $count descending
                            return data($x)
                            )
                
                
                    
                
                    for $region in $monumentsregion
                    let $count := count(
                        if($lieu ='REG') then (
                            for $x in doc("merimee-MH.xml")/csv_data/row[REG=$region]
                            return $x)else (
                                for $x in doc("merimee-MH.xml")/csv_data/row[DPT=$region]
                            return $x
                                )
                    )
                    return <tr> 
                               <td>{ string($region) }</td>
                               <td>{ string($count ) }</td>
                           </tr>
            }
    </table>
        
}