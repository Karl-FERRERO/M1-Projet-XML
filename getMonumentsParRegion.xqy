xquery version "3.0";

declare function local:getListeRegions()  {
        for $x in distinct-values(doc("merimee-MH.xml")/csv_data/row/REG)
        order by $x
        return data($x)
};


        
            
                let $monumentsregion := local:getListeRegions()
                
                    for $region in $monumentsregion
                    let $count := count(
                        for $x in doc("merimee-MH.xml")/csv_data/row[REG=$region]
                        return $x
                    ) 
                    
                    return  <STAT>
                               <REG>{string($region)}</REG><COUNT>{string($count)}</COUNT>
                            </STAT>
                           
            
    
        
