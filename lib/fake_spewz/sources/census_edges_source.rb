require 'rgeo/shapefile'
module FakeSpewz
  module Sources
    class CensusEdgesSource < Source

      ROAD_FEATURE_CLASS_CODES = {
        "S1100" => {feature: "Primary Road", description: "Primary roads are generally divided, limited-access highways within the interstate highway system or under state management, and are distinguished by the presence of interchanges. These highways are accessible by ramps and may include some toll highways."},
        "S1200" => {feature: "Secondary Road", description: "Secondary roads are main arteries, usually in the U.S. Highway, State Highway or County Highway system. These roads have one or more lanes of traffic in each direction, may or may not be divided, and usually have at-grade intersections with many other roads and driveways. They often have both a local name and a route number."},
        "S1400" => {feature: "Local Neighborhood Road, Rural Road, City Street", description: "Generally a paved non-arterial street, road, or byway that usually has a single lane of traffic in each direction. Roads in this feature class may be privately or publicly maintained. Scenic park roads would be included in this feature class, as would (depending on the region of the country) some unpaved roads."},
        "S1500" => {feature: "Vehicular Trail (4WD) Road/Path Features", description: "An unpaved dirt trail where a four-wheel drive vehicle is required. These vehicular trails are found almost exclusively in very rural areas. Minor, unpaved roads usable by ordinary cars and trucks belong in the S1400 category."},
        "S1630" => {feature: "Ramp", description: "A road that allows controlled access from adjacent roads onto a limited access highway, often in the form of a cloverleaf interchange. These roads are unaddressable."},
        "S1640" => {feature: "Service Drive usually along a limited access highway", description: "A road, usually paralleling a limited access highway, that provides access to structures along the highway. These roads can be named and may intersect with other roads."},
        "S1710" => {feature: "Walkway/Pedestrian Trail", description: "A path that is used for walking, being either too narrow for or legally restricted from vehicular traffic."},
        "S1720" => {feature: "Stairway", description: "A pedestrian passageway from one level to another by a series of steps."},
        "S1730" => {feature: "Alley Road/Path Features", description: "A service road that does not generally have associated addressed structures and is usually unnamed. It is located at the rear of buildings and properties and is used for deliveries."},
        "S1740" => {feature: "Private Road for service vehicles (logging, oil fields, ranches, etc.)", description: "A road within private property that is privately maintained for service, extractive, or other purposes. These roads are often unnamed."},
        "S1750" => {feature: "Internal U.S. Census Bureau use Road/Path Features", description: "Internal U.S. Census Bureau use."},
        "S1780" => {feature: "Parking Lot Road", description: "The main travel route for vehicles through a paved parking area."},
        "S1820" => {feature: "Bike Path or Trail", description: "A path that is used for manual or small, motorized bicycles, being either too narrow for or legally restricted from vehicular traffic."},
        "S1830" => {feature: "Bridle Path Road/Path Features", description: "A path that is used for horses, being either too narrow for or legally restricted from vehicular traffic"},
      }

      ROUTE_TYPE_CODES = { 
        "C" => "County", 
        "I" => "Interstate",
        "M" => "Common Name",
        "O" => "Other",
        "S" => "State recognized",
        "U" => "U.S.",
      }

      ATTRIBUTE_MAP = {
         "STATEFP"=>"11",
         "COUNTYFP"=>"001",
         "TLID"=>76220322,
         "TFIDL"=>210411807,
         "TFIDR"=>210412332,
         "MTFCC"=>"S1400",
         "FULLNAME"=>"Ingomar St NW",
         "SMID"=>"122",
         "LFROMADD"=>"3700",
         "LTOADD"=>"3798",
         "RFROMADD"=>"3701",
         "RTOADD"=>"3799",
         "ZIPL"=>"20015",
         "ZIPR"=>"20015",
         "FEATCAT"=>"S",
         "HYDROFLG"=>"N",
         "RAILFLG"=>"N",
         "ROADFLG"=>"Y",
         "OLFFLG"=>"N",
         "PASSFLG"=>"",
         "EXTTYP"=>"N",
         "TTYP"=>"",
         "DECKEDROAD"=>"N",
         "ARTPATH"=>"N",
         "PERSIST"=>"",
         "GCSEFLG"=>"N",
         "OFFSETL"=>"N",
         "OFFSETR"=>"N",
         "TNIDF"=>55353749,
         "TNIDT"=>55353747
       }

      def initialize
      end

      def read_census_file(file_path)
        RGeo::Shapefile::Reader.open(file_path) do |file|
          puts "File contains #{file.num_records} records."  
          file.each do |record|  
            puts "Record number #{record.index}:"    
            puts "  Geometry: #{record.geometry.as_text}"    
            puts "  Attributes: #{record.attributes.inspect}"    
          end    
          file.rewind  
          record = file.next  
          puts "First record geometry was: #{record.geometry.as_text}"  
        end
      end


    end
  end
end