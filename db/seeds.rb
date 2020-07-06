# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#

require 'csv'

# UNIQ_MERCHANT_IDS = %w(401 1914 1791 2250 1769 2260 2312 1760 2310 1129 1889 1905 1754 1756 1762 1776 1470 2432 1817 2139 2024 1681 2452 1119 1288 1836 1226 2093 1979 2004 1657 1874 1557 2304 1753 1750 2179 1677 1387 1247 1951 2274 1602 1561 2589 1218 1775 1798 1868 1761 2313 1758 1653 2019 1937 1190 1567 1113 1670 1051 2140 1105 2012 1751 1468 1382 1056 2110 1336 1678 2161 2447 1259 1867 1664 2446 1757 1770 1306 1584 1947 1952 2169 2347 1972 2431 2309 403 1699 2181 1883 1666 1361 2451 1906 1764 1668 1604 1314 2013 1888 2101 2266 2445 1501 1103 1783 2153 1978 2170 1772 1752 1503 1885 1763 1009 2318 1879 2196 1134 2251 1493 1886 2200 1676 2261 2417 2166 1926 404 2449 2349 1995 1977 2014 1742 1873 2092 1765 1264 1969 1553 1733 1727 1872 1887 2314 2217 1971 1771 1799 1391 995 1340 1920 1790 2590 1268 1818 1904 2448 2020 2178 1346 2259 1871 1438 1348 1773 2138 2348 2249 1251 1919 1767 2180 1766 1759 2137 1891 1565 2190 2189 1694 2311 2258 2450 1467 1235 509 1768 1992 2317 1125 1970)


# # Create merchants 
# UNIQ_MERCHANT_IDS.map.with_index do |id,count| 
# 	merchants = Merchant.create!(email: "sample#{count}@sample.com", mapping_id: id, password: "sample123", password_confirmation: "sample123") 
# 	p merchants
# end

# Merchant.import merchants

# Create users 
# @users = 1
# csv_text = "#{Rails.root}/tmp/users.csv"
# csv = CSV.foreach(csv_text, :headers => true) do |row|
# 	users = User.create!(name: row[1], mobile: row[2])
# 	p users
# 	# break if @count == 10000
# 	# @count = @count + 1
# end


# Create payment types
# %w(card cash wallet).map do |type| 
# 	t = PaymentType.create!(mode: type) 
# 	p t
# end

# Create transactions
# headers = %w(id	user_id	amount_spent merchant_id bill_number	payment_type)	
csv_text = "#{Rails.root}/tmp/transactions.csv"
@count = 1
csv = CSV.foreach(csv_text, headers: true) do |row|
	user = User.find_by(id: row[1])
	merchant = Merchant.find_by(mapping_id: row[3])
	payment_type = PaymentType.find_by(mode: row[5])
	if user.present? && merchant.present?
		t = Transaction.create!(user: user, amount_spent: row[2], merchant_id: merchant.mapping_id, bill_number: row[4], payment_type: payment_type)
		p t
	end
end

# p @transactions
# Transaction.import! @transactions
