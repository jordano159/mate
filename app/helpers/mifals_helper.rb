module MifalsHelper
  def mifals_total
    total = 0
    Mifal.all.each do |mifal|
      total += mifal.kids.count
    end
    total
  end
end
