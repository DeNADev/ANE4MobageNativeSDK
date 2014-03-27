require 'rexml/document';

if ARGV.length > 0
    platform = ARGV[0]
else
    platform = "default"
end

define_ios     = platform == "ios" ? "true" : "false"
define_android = platform == "android" ? "true" : "false"
define_default = platform == "default" ? "true" : "false"

class_entries = REXML::Element.new

config = File.new("swc-config-#{platform}.xml", "w");

config.print <<XML;
<flex-config>
<compiler>
    <source-path>
        <path-element>src</path-element>
    </source-path>
    <define append="true">
        <name>DEFINE::IOS</name>
        <value>#{define_ios}</value>
    </define>
    <define append="true">
        <name>DEFINE::ANDROID</name>
        <value>#{define_android}</value>
    </define>
    <define append="true">
        <name>DEFINE::DEFAULT</name>
        <value>#{define_default}</value>
    </define>
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
