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
    puts "現在の投入金額は#{@slot_money}円です"
  end

  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  # 投入は複数回できる。
  # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
  # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
  def slot_money(money)

    # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
    # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
    if MONEY.include?(money)
      @slot_money += money
      puts "現在#{@slot_money}円が投入されています。"
      puts "続けてお金を投入してください。払い戻しの場合は[0]、ジュースを購入する場合は[1]を入力してください。"
      slot_money(gets.to_i)
    elsif money == 0
      return_money
      exit
    elsif money == 1
      return @slot_money
    else
      puts "使えないお金なので返却します。"
      puts "現在#{@slot_money}円が投入されています。"
      puts "続けてお金を投入してください。払い戻しの場合は[0]、ジュースを購入する場合は[1]を入力してください。"
      slot_money(gets.to_i)
    end
  end

  # 購入可能なドリンクリスト
  def purchasable_drinks
    if @slot_money >= 200
      puts "『レッドブル、コーラ、水』が買えます。"
    elsif @slot_money >=120
      puts "『コーラ、水』が買えます。"
    elsif @slot_money >= 100
      puts "『水』が買えます。"
    end
  end

  # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
  # 返すお金の金額を表示する
  # 自動販売機に入っているお金を0円に戻す
  def return_money
    puts "#{@slot_money}円返却します。"
    @slot_money = 0
  end
end




#  ステップ２ ジュースの管理
class Juice_management
  def juice_name
    @juice1 = { name: "コーラ", price: 120, number: 5 }
    @juice2 = { name: "レッドブル", price: 200, number: 5 }
    @juice3 = { name: "水", price: 100, number: 5 }
    juices = [@juice1, @juice2, @juice3]
    juices.each do |juice|
      # puts juice.values_at(:name, :price, :number)
      puts "#{juice.values[0]}, 値段:#{juice.values[1]} 在庫:#{juice.values[2]}"
    end
  end



  # どのジュースを買うか選択させるメソッド
  def purchase_selection
    puts "購入したいジュースの番号を入力してください。"
    puts "1: コーラ"
    puts "2: レッドブル"
    puts "3: 水"
    selection = gets.to_i
    case selection
      when 1
        puts "コーラを購入します。"
        # puts @juice1[:number] - 1
        return @juice1
      when 2
        puts "レッドブルを購入します。"
        return @juice2
      when 3
        puts "水を購入します。"
        return @juice3
      when 0
        puts @change
        exit
      else
        puts "1,2,3番から選択してください。"
        purchase_selection
    end
  end

  def initialize
    @current_sales_amount = 0
  end

  # 投入金額、在庫の点で購入できるか判定するメソッド
  def maney_and_stock_judge(money, number, price, name)
    if money >= price && number > 0
      @current_sales_amount += price
      stock = number - 1
      @change = money - price
      # current_sales_amount = money + change
      puts "現在の売り上げ金額：#{@current_sales_amount}円、#{name}の在庫：#{stock}本、釣り銭：#{@change}円"

      # もしprice ==120 ならコーラの本数を1本減らす、
      if price == 120
        @juice1[:number] = stock
      elsif price == 200
        @juice2[:number] = stock
      elsif price == 100
        @juice3[:number] = stock
      end

      

      # ここから繰り返し
      ps = purchase_selection
      maney_and_stock_judge(@change, ps.values[2], ps.values[1], ps.values[0])
    else
      puts "お金か在庫が足りないです。"
    end
  end
end



# クラスをインスタンス化して、インスタンス変数に代入した
vm = VendingMachine.new
jm = Juice_management.new
# pc = Purchase.new



# 1.ジュースの情報を表示する
jm.juice_name

# 2.お金の投入
puts "[10,50,100,500,1000円]を入力してください。"
total_fee = vm.slot_money(gets.to_i)

# 3.購入可能なドリンクリスト
vm.purchasable_drinks

# 4.購入するジュースの選択処理
juice_information = jm.purchase_selection

# 5.ジュースの購入（ステップ3）
jm.maney_and_stock_judge(total_fee, juice_information[:number], juice_information[:price], juice_information[:name])
