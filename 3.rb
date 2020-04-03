class Empl
	attr_reader :name
	def name=(name)
		@name=name
	end
	def initialize(name = "Anonymous")
		if name == ""
			raise "Name BLANK!!!"
		end
		self.name=name
	end
	
	def print_name
		puts "Name employs #{@name}"
	end
end

class ZpEmpl < Empl
	attr_reader :zp
	def zp=(zp)
	if zp<0
			raise "ZP -  #{zp} - is invalid"
		end
		@zp=zp
	end
	def initialize(name="Anonim",zp= 0.0)
		super(name)	
			self.zp = zp.to_f
	end
	
	def pay_stub
		print_name
		pay_period = (@zp/365)*14
		result = format("Pay this period:,%0.2f", "#{pay_period}")
		puts result
	end
	
end

class HourEmpl < Empl
	attr_reader :hours_zp, :hours_week
	def hours_zp=(hours_zp)
		if hours_zp<0
			raise "ZP in Hours -  #{hours_zp} - is invalid"
		end
		@hours_zp=hours_zp
	end
	def hours_week=(hours_week)
		if hours_week<0
			raise "ZP in week -  #{hours_week} - is invalid"
		end
		@hours_week=hours_week
	end

	def initialize(name="Anonim",hours_zp=0.0, hours_week = 0)
		
		self.hours_zp = hours_zp
		self.hours_week = hours_week
		super(name)
		
	end
	
	
	def pay_stub
		print_name
		pay_period = (hours_zp * hours_week * 2)
		result = format("Pay this period:,%0.2f", "#{pay_period}")
		puts result
	end

	def self.security(name)
		HourEmpl.new(name, 20, 30)
	end
	def self.kassir(name)
		HourEmpl.new(name,30,45)
	end
	def self.cleaner(name)
		HourEmpl.new(name,30,45)
	end
end
serg = ZpEmpl.new
serg.name = "Serg"
serg.zp = 400000
serg.pay_stub
vova = HourEmpl.kassir("Vova").pay_stub

#Вызав класса/метода одной строкой
den_hour = HourEmpl.new("Den", 15.50, 40).pay_stub
#Вызов метода с указанием всех параметров отдельно - резельтат тот же
den_hour= HourEmpl.new
den_hour.name = "Den"
den_hour.hours_zp = 15.50
den_hour.hours_week = 40
den_hour.pay_stub



