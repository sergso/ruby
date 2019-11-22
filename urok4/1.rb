PASS = "pass"
CARGO = "cargo"
class Vagon
def vagon_unhook(type,number,&bl)
  if type == CARGO
    Vagon_cargo.vagons.each do |key,val|
      #yield
      bl.call
    end

  elsif type == PASS
    Vagon_pass.vagons.each do |key,val|
      yield
    end

  end
end
vagon_unhook do
  if val.vagon_number == number
    if val.vagon_hook == 0
      raise "Вагон с номером #{val.vagon_number} уже отцеплен от поезда"
    end
    val.vagon_hook = 0
  end
end

end