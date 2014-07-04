holder = []
in_headers = false
what = false
in_geo = false
line_counter = 0
File.foreach('mss_2014.kml') do |line|
  if line =~ /<ul class="textattributes">/
    what = true
  elsif what
    in_headers = true
    what = false
  elsif line =~ /<MultiGeometry>/
    holder << line
    in_geo = true
  elsif in_headers
    if line =~ /^\s*$/
      holder << 'NULL'
      line_counter += 1
    elsif line_counter == 0
      holder << line.gsub(/\s*<li><strong><span class="atr-name">WARD<\/span>:<\/strong>\s*<span class="atr-value">(\d*)<\/span><\/li>/, '\1')
      line_counter += 1
    elsif line_counter == 1
      holder << line.gsub(/<li><strong><span\s*class="atr-name">WARD_NUM<\/span>:<\/strong>\s*<span\s*class="atr-value">(\d*)<\/span><\/li>/, '\1')
      line_counter += 1
    elsif line_counter == 2
      holder << line.gsub(/<li><strong><span\s*class="atr-name">SWEEP<\/span>:<\/strong>\s*<span\s*class="atr-value">(\d*)<\/span><\/li>/, '\1')
      line_counter += 1
    elsif line_counter == 3
      holder << line.gsub(/<li><strong><span\s*class="atr-name">WARDSWEEP<\/span>:<\/strong>\s*<span\s*class="atr-value">(\d*\w?)<\/span><\/li>/, '\1')
      line_counter += 1
    elsif line_counter == 4
      holder << line.gsub(/<li><strong><span\s*class="atr-name">WARD_SECTI<\/span>:<\/strong>\s*<span\s*class="atr-value">(\d*\w?)<\/span><\/li>/, '\1')
      line_counter += 1
    elsif line_counter == 5
      holder << line.gsub(/<li><strong><span\s*class="atr-name">MONTH_4<\/span>:<\/strong>\s*<span\s*class="atr-value">(\S*)<\/span><\/li>/, '\1')
      line_counter += 1
    elsif line_counter == 6
      holder << line.gsub(/<li><strong><span\s*class="atr-name">MONTH_5<\/span>:<\/strong>\s*<span\s*class="atr-value">(\S*)<\/span><\/li>/, '\1')
      line_counter += 1
    elsif line_counter == 7
      holder << line.gsub(/<li><strong><span\s*class="atr-name">MONTH_6<\/span>:<\/strong>\s*<span\s*class="atr-value">(\S*)<\/span><\/li>/, '\1')
      line_counter += 1
    elsif line_counter == 8
      holder << line.gsub(/<li><strong><span\s*class="atr-name">MONTH_7<\/span>:<\/strong>\s*<span\s*class="atr-value">(\S*)<\/span><\/li>/, '\1')
      line_counter += 1
    elsif line_counter == 9
      holder << line.gsub(/<li><strong><span\s*class="atr-name">MONTH_8<\/span>:<\/strong>\s*<span\s*class="atr-value">(\S*)<\/span><\/li>/, '\1')
      line_counter += 1
    elsif line_counter == 10
      holder << line.gsub(/<li><strong><span\s*class="atr-name">MONTH_9<\/span>:<\/strong>\s*<span\s*class="atr-value">(\S*)<\/span><\/li>/, '\1')
      line_counter += 1
    elsif line_counter == 11
      holder << line.gsub(/<li><strong><span\s*class="atr-name">MONTH_10<\/span>:<\/strong>\s*<span\s*class="atr-value">(\S*)<\/span><\/li>/, '\1')
      line_counter += 1
    elsif line_counter == 12
      holder << line.gsub(/<li><strong><span\s*class="atr-name">MONTH_11<\/span>:<\/strong>\s*<span\s*class="atr-value">(\S*)<\/span><\/li>/, '\1')
      line_counter += 1
    elsif line_counter == 13
      holder << line.gsub(/<li><strong><span\s*class="atr-name">SHAPE_AREA<\/span>:<\/strong>\s*<span\s*class="atr-value">(\d*\.\d*\D*\d*)<\/span><\/li>/, '\1')
      line_counter += 1
    elsif line_counter == 14
      holder << line.gsub(/<li><strong><span\s*class="atr-name">SHAPE_LEN<\/span>:<\/strong>\s*<span\s*class="atr-value">(\d*\.\d*)<\/span><\/li>/, '\1')
      line_counter = 0
      in_headers = false
    end
  elsif in_geo
    if line =~ /<\/MultiGeometry>/
      in_geo = false
      holder << line
    else
      holder << line
    end
  end
end
File.open('the_business.sql', 'w') do |f|
  f.write("SET STANDARD_CONFORMING_STRINGS TO ON;\n")
  f.write("BEGIN;\n")
  f.write("CREATE TABLE \"regions\" (gid serial,\n")
  f.write("\"ward\" varchar(2),\n")
  f.write("\"ward_num\" int4,\n")
  f.write("\"sweep\" int4,\n")
  f.write("\"wardsweep\" varchar(5),\n")
  f.write("\"ward_secti\" varchar(254),\n")
  f.write("\"month_4\" varchar(254),\n")
  f.write("\"month_5\" varchar(254),\n")
  f.write("\"month_6\" varchar(254),\n")
  f.write("\"month_7\" varchar(254),\n")
  f.write("\"month_8\" varchar(254),\n")
  f.write("\"month_9\" varchar(254),\n")
  f.write("\"month_10\" varchar(254),\n")
  f.write("\"month_11\" varchar(254),\n")
  f.write("\"shape_area\" numeric,\n")
  f.write("\"shape_len\" numeric);\n")
  f.write("ALTER TABLE \"regions\" ADD PRIMARY KEY (gid);\n")
  f.write("SELECT AddGeometryColumn('','regions','geom','4326','GEOMETRYCOLLECTION',2);\n")
  hds = true
  geo = false
  thing = []
  holder.each do |line|
    if thing.count >= 15
      str = "('#{thing[0]}','#{thing[1]}','#{thing[2]}','#{thing[3]}','#{thing[4]}','#{thing[5]}','#{thing[6]}','#{thing[7]}','#{thing[8]}','#{thing[9]}','#{thing[10]}','#{thing[11]}','#{thing[12]}','#{thing[13]}','#{thing[14]}',"
      str.gsub!(/\s/, "")
      f.write("INSERT INTO \"regions\" (\"ward\",\"ward_num\",\"sweep\",\"wardsweep\",\"ward_secti\",\"month_4\",\"month_5\",\"month_6\",\"month_7\",\"month_8\",\"month_9\",\"month_10\",\"month_11\",\"shape_area\",\"shape_len\",geom) VALUES #{str}") 
      thing = []
      f.write("ST_GeomFromKML('#{line}")
      hds = false
      geo = true
    elsif hds
      thing << line
    elsif geo
      if line =~ /<\/MultiGeometry>/
        f.write("#{line}'));\n")
        geo = false
        hds = true
      else
        f.write(line)
      end
    end
  end
  f.write("CREATE INDEX \"regions_geom_gist\" ON \"regions\" USING GIST (\"geom\");\n")
  f.write("COMMIT;")
end
