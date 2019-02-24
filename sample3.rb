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
    return @slot_money unless MONEY.include?(money)
    # 自動販売機にお金を入れる
    @slot_money += money
    puts "現在#{@slot_money}円が投入されています"
    puts "続けてお金を投入してください。お金の投入を終了する場合は、10,50,100,500,1000円以外の値を入力してください"
    # 再帰処理
    slot_money(gets.to_i)
  end

  # 購入可能なドリンクリスト
  def purchasable_drinks
    if @slot_money >= 200
      puts "『レッドブル、コーラ、水』が買えます"
    elsif @slot_money >=120
      puts "『コーラ、水』が買えます"
    elsif @slot_money >= 100
      puts "『水』が買えます"
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
    @juice2 = { name: "レッドブル", price: 200, number: 5 }
    @juice3 = { name: "水", price: 100, number: 5 }
    juices = [@juice1, @juice2, @juice3]
    juices.each do |juice|
      puts juice.values_at(:name, :price, :number)
    end
  end

  # どのジュースを買うか選択させるメソッド
  # def purchase_selection
  #   puts "購入したいジュースの番号を入力してください"
  #   puts "1: コーラ"
  #   puts "2: レッドブル"
  #   puts "3: 水"
  #   selection = gets.to_i
  #   case selection
  #     when 1
  #       puts "コーラを購入します"
  #       puts @juice1[:number]
  #     when 2
  #       puts "レッドブルを購入します"
  #     when 3
  #       puts "水を購入します"
  #     else
  #       puts "残念"
  #   end
  # end
# end
#
# # ステップ３ 購入(Purchase)
# class Purchase

  # どのジュースを買うか選択させるメソッド
  def purchase_selection
    puts "購入したいジュースの番号を入力してください"
    puts "1: コーラ"
    puts "2: レッドブル"
    puts "3: 水"
    selection = gets.to_i
    case selection
      when 1
        puts "コーラを購入します"
        return @juice1
      when 2
        puts "レッドブルを購入します"
        return @juice2
      when 3
        puts "水を購入します"
        return @juice3
      else
        puts "1,2,3番から選択してください"
        purchase_selection
    end
  end

  # 投入金額、在庫の点で購入できるか判定するメソッド
  def maney_and_stock_judge(money, number, price)
    if money >= price && number > 0
      puts "何本買うか入力してください"
      purchase_number =  gets.to_i
      # 在庫が0未満の場合、または投入額より購入額が多い場合は再入力
      if (number - purchase_number) < 0 || (money - price * purchase_number) < 0
        puts "本数を減らしてください"
        maney_and_stock_judge(money, number, price)
      else
        current_sales_amount = price * purchase_number
        stock = number - purchase_number
        change = money - price * purchase_number
        puts "現在の売り上げ金額：#{current_sales_amount}、在庫：#{stock}本、釣り銭：#{change}円"
      end
    else
     puts "お金か在庫が足りないです"
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
puts "10,50,100,500,1000円を入力してください"
total_fee = vm.slot_money(gets.to_i)

# 3.購入可能なドリンクリスト
vm.purchasable_drinks

# 4.購入するジュースの選択処理
juice_information = jm.purchase_selection

# 5.ジュースの購入（ステップ3）
jm.maney_and_stock_judge(total_fee, juice_information[:number], juice_information[:price])
