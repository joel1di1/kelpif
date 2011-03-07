require 'open-uri'

root_urls = ["http://www.nicolas.com/fr/commander_bordeaux.html"]

# ,"http://www.nicolas.com/fr/commander_bourgogne.html","http://www.nicolas.com/fr/commander_cotesdurhone_cotesdurhone.html","http://www.nicolas.com/fr/commander_bordeaux.hcommander_languedocroussillon.htmltml","http://www.nicolas.com/fr/commander_valleedelaloirecentre.html","http://www.nicolas.com/fr/commander_autresregions_alsace.html","http://www.nicolas.com/fr/commander_vinsdumonde_argentine.html","http://www.nicolas.com/fr/commander_vinsbio_vinsbio.html","http://www.nicolas.com/fr/commander_finesbouteilles.html"]


root_urls.each do |root_url|
  doc = Nokogiri::HTML(open(root_url))
  puts root_url
  table_lines = doc.xpath("//table[@class='cpt_fav_table_commande']/tr")
  
  #remove titles
  table_lines.delete(table_lines[0])
  
  line_index=0
  table_lines.each do |table_line| 
    selector = line_index%2 + 1;
    contents = table_line.xpath("./td[@class='sr_td_contenu_#{selector}']")
    name = contents[1].xpath("./a/img")[0]['alt']
    appellation =  contents[2].inner_text.strip
    millesime =  contents[3].inner_text.strip
    puts (name +"|"+ appellation  +"|"+ millesime)
    line_index = line_index+1
  end
    
  puts "end"
end
