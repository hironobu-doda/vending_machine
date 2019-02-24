class VendingMachine
 # ステップ０ お金の投入と払い戻しの例コード
 # ステップ１ 扱えないお金の例コード
 # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
 MONEY = [10, 50, 100, 500, 1000].freeze

 #（自動販売機に投入された金額をインスタンス変数の @slot_money に代入する）
 # 最初の自動販売機に入っている金額は0円
 def initialize
   @slot_money = 0
 end

 # 投入金額の総計を取得
 # 自動販売機に入っているお金を表示する
 def current_slot_money
   @slot_money
 end

 # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
 # 投入は複数回できる。
 # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
 # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
 def slot_money(money)
   if MONEY.include?(money)
     @slot_money += money
     slot_money(gets.to_i)
   else
     puts "#{money}は使えません。"
     return @slot_money
   end
 end

 # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
 # 返すお金の金額を表示する
 # 自動販売機に入っているお金を0円に戻す
 def return_money
   puts @slot_money
   @slot_money = 0
 end
end

#  ステップ２ ジュースの管理
class Juice_management
 def juice_name
   @juice1 = { name: "cola", price: 120, number: 5 }
   @juice2 = { name: "redbull", price: 200, number: 5}
   @juice3 = { name: "water", price: 100, number: 5}

   juice = [@juice1, @juice2, @juice3]
   juice.each do |juice|
     puts juice.values_at(:name, :price, :number)
   end

   #購入選択

 end
end

# ステップ３ 購入(Purchase)
class Purchase

  def judge
    puts "コーラを買う時は1を押してください"
    puts "レッドブルを買う時は2を押してください"
    puts "水を買う時は3を押してください"

    juice = gets.to_i

    case juice
    when 1

    when 2

    when 3

    end

  def maney_and_stock_judge(money, number)
   # 投入金額が120円以上かつ、コーラの本数が0本より大きい場合
   if money >= 120 && number > 0
     # 購入本数を入力
     puts "何本買うか入力してください"
     purchase_number =  gets.to_i
     # 在庫が0未満の場合、または投入額より購入額が多い場合は再入力
     if (number - purchase_number) < 0 || (money - 120 * purchase_number) < 0
       puts "本数を減らしてください"
       maney_and_stock_judge(money, number)
     else
       # 現在の売り上げ金額
       current_sales_amount = 120 * purchase_number
       # 在庫
       stock = number - purchase_number
       # 釣り銭
       change = money - 120 * purchase_number
       puts "現在の売り上げ金額：#{current_sales_amount}、在庫：#{stock}本、釣り銭：#{change}円"
     end
   else
    puts “お金か在庫が足りないです”
   end
 end
end

vm = VendingMachine.new
jm = Juice_management.new
pc = Purchase.new

# 作成した自動販売機に入れたお金がいくらかを確認する（表示する）
puts "現在の投入金額は#{vm.current_slot_money}円です"

# ジュースの情報を表示する(ステップ2)
# puts “コーラの情報”
puts jm.juice_name.values_at(:name, :price, :number)

# # # ジュースの購入（ステップ3）
puts "10,50,100,500,1000円を入力してください"
pc.maney_and_stock_judge(vm.slot_money(gets.to_i), jm.juice_name[:number])
