require 'rexml/document';

class_entries = REXML::Element.new

config = File.new("swc-config.xml", "w");

config.print <<'XML';
<flex-config>
<compiler>
    <source-path>
        <path-element>src</path-element>
    </source-path>
</compiler>
<include-classes>
XML

doc = REXML::Document.new( File.read( '.flexLibProperties' ) );
doc.elements.each('/flexLibProperties/includeClasses/classEntry')  do
    |elem|
    config.puts "        <class>#{elem.attributes["path"]}</class>";
end

config.print <<'XML';
</include-classes>
</flex-config>
XML
config.close();