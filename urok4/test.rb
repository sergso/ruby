class Vagon
  attr_accessor :vagon_number, :vagon_type
  
  @@vagon_count_all ||= 0

  def initialize(value = "pass")
    @vagon_type = value
    @vagon_number = @@vagon_count_all += 1
    self.class.vagons[@vagon_number] = self
  end

  def self.vagons
    @vagons ||= Hash.new
  end
end