xquery version "3.0";

declare function local:getListeRegions()  {
        for $x in distinct-values(doc("merimee-MH.xml")/csv_data/row/REG)
        order by $x
        return data($x)
};

element {QName("http://www.w3.org/1999/xhtml", "html")} {
    
    <table>
        <tr><th>Région</th><th>Nombre de monuments</th></tr>
            {
                let $monumentsregion := local:getListeRegions()
                
                    for $region in $monumentsregion
                    let $count := count(
                        for $x in doc("merimee-MH.xml")/csv_data/row[REG=$region]
                        return $x
                    )
                    return <tr> 
                               <td>{ string($region) }</td>
                               <td>{ string($count ) }</td>
                           </tr>
            }
    </table>
        
}