xquery version "3.0";

for $x in doc("merimee-MH.xml")/csv_data/row
where $x/REF="PA00078014"
order by $x/REF
return data($x/TICO)