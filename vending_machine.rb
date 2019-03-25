class VendingMachine
  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  MONEY = [10, 50, 100, 500, 1000].freeze
  
  # 最初の自動販売機に入っている金額は0円
  def initialize
    @slot_money = 0
  end
  
  # 自動販売機に入っているお金を表示するメソッド
  def current_slot_money
    puts "現在の投入金額は#{@slot_money}円です"
  end
  
  # お金を投入するメソッド
  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  # 投入は複数回できる。
  # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
  # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
  def slot_money(money)
    if MONEY.include?(money)
      @slot_money += money
      puts "現在#{@slot_money}円が投入されています。"
      puts "続けてお金を投入してください。払い戻しの場合は[0]、ジュースを購入する場合は[1]を入力してください。"
      slot_money(gets.to_i)
      
      # 払い戻しの場合
    elsif money == 0
      return_money
      exit
      
      # 購入処理に進む場合
    elsif money == 1
      return @slot_money
      
      # その他の入力が行われた場合
    else
      puts "使えないお金なので返却します。"
      puts "現在#{@slot_money}円が投入されています。"
      puts "続けてお金を投入してください。払い戻しの場合は[0]、ジュースを購入する場合は[1]を入力してください。"
      slot_money(gets.to_i)
    end
  end
  
  # 購入可能なドリンクリストを表示するメソッド
  def purchasable_drinks
    if @slot_money >= 200
      puts "『レッドブル、コーラ、水』が買えます。"
    elsif @slot_money >=120
      puts "『コーラ、水』が買えます。"
    elsif @slot_money >= 100
      puts "『水』が買えます。"
    else
      puts "お金が足りません。再度お金[10,50,100,500,1000円]を入力してください。"
      slot_money(gets.to_i)
    end
  end
  
  # 返すお金の金額を表示するするメソッド
  # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力し、０円に戻す
  def return_money
    puts "#{@slot_money}円返却します。"
    @slot_money = 0
  end
end


class Juice_management

  def initialize
    @juice1 = { name: "コーラ", price: 120, number: 5 }
    @juice2 = { name: "レッドブル", price: 200, number: 5 }
    @juice3 = { name: "水", price: 100, number: 5 }

    @current_sales_amount = 0
  end
  
  # ドリンクの情報を出力するメソッド
  def juice_name
    @juices = [@juice1, @juice2, @juice3]
    @juices.each do |juice|
      puts "- #{juice.values[0]} (値段:#{juice.values[1]}円,  在庫:#{juice.values[2]})"
    end
  end

  # どのドリンクを買うか選択させるメソッド
  # 在庫（juice[:number])が0だと選択が表示されなくなる
  def purchase_selection

    puts "購入したいジュースの番号を入力してください。"
    if @juice1[:number] > 0
      puts "1: #{@juice1[:name]}(#{@juice1[:price]}円)"
    end

    if @juice2[:number] > 0
      puts "2: #{@juice2[:name]}(#{@juice2[:price]}円)"
    end

    if @juice3[:number] > 0
      puts "3: #{@juice3[:name]}(#{@juice3[:price]}円)"
    end

    if @change
      puts "0: 購入終了"
    end

    selection = gets.to_i
    # 在庫が0だと選択できなくなる
    if selection == 1 && @juice1[:number] > 0
        puts "コーラを購入します。"
        return @juice1
    elsif selection == 2 && @juice2[:number] > 0
        puts "レッドブルを購入します。"
        return @juice2
    elsif selection == 3 && @juice3[:number] > 0
        puts "水を購入します。"
        return @juice3
    # @changeがある時に0入力したら、お釣りが出力される。（1回目の選択では@changeがないので、絶対に選択できない。2回目以降は@changeがあるので選択可能）
    elsif selection == 0 && @change
        puts "お釣り:#{@change}円"
        exit
    else
        puts "項目の番号から選択してください。"
        purchase_selection
    end
  end

  # 投入金額、在庫の点で購入できるか判定するメソッド
  def maney_and_stock_judge(money, number, price, name)
    if money >= price && number > 0
      @current_sales_amount += price
      stock = number - 1
      @change = money - price
      puts "現在の売り上げ金額：#{@current_sales_amount}円、#{name}の在庫：#{stock}本、残金：#{@change}円"

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
    # お金がない場合
    else
      # これを入れないと、1回目の購入でお金が足りない場合（例えば10円）、@changeがないためエラーになる
      @change = money
      puts "お金が足りません。残金：#{@change}円"
      # ここから繰り返し
      ps = purchase_selection
      maney_and_stock_judge(@change, ps.values[2], ps.values[1], ps.values[0])
    end
  end
end

vm = VendingMachine.new

jm = Juice_management.new

# 1.ジュースの情報を表示する
jm.juice_name

# 2.投入金額の合計をtotal_feeに代入
puts "[10,50,100,500,1000円]を入力してください。"
total_fee = vm.slot_money(gets.to_i)

# 3.投入金額の合計から、購入可能なドリンクリストを表示する
vm.purchasable_drinks

# 4.購入するジュースの選択処理
juice_information = jm.purchase_selection

# 5.ジュースの購入（ステップ3）
jm.maney_and_stock_judge(total_fee, juice_information[:number], juice_information[:price], juice_information[:name])