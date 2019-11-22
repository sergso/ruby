PASS = "pass"
CARGO = "cargo"

class Vagon
   @@vagon_count = 0

  def vagon_count
    @@vagon_count
  end

  def self.vagon_count
    @@vagon_count
  end
end

class Vagon_cargo < Vagon
  attr_reader :vagon_number
  def initialize
    @vagon_type = CARGO
    @vagon_number = @@vagon_count += 1
  end
end

class Vagon_pass < Vagon
  attr_reader :vagon_number
  def initialize
    @vagon_type = PASS
    @vagon_number = @@vagon_count += 1
  end

end
