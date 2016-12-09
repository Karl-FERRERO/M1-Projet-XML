xquery version "3.0";

declare function local:getListeDepartements()  {
    
    for $x in distinct-values(doc("merimee-MH.xml")/csv_data/row/DPT)
    order by $x
    return <div class="departement">{data($x)}</div>
};

local:getListeDepartements()