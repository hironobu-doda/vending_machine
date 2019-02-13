class VendingMachine
  # ステップ０　お金の投入と払い戻しの例コード
  # ステップ１　扱えないお金の例コード

  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  MONEY = [10, 50, 100, 500, 1000].freeze

  # （自動販売機に投入された金額をインスタンス変数の @slot_money に代入する）
  def initialize
    # 最初の自動販売機に入っている金額は0円
    @slot_money = 0
  end

  # 投入金額の総計を取得できる。
  def current_slot_money
    # 自動販売機に入っているお金を表示する
    @slot_money
  end

  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  # 投入は複数回できる。
  def slot_money(money)
    # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
    # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
    return false unless MONEY.include?(money)
    # 自動販売機にお金を入れる
    @slot_money += money
  end

  # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
  def return_money
    # 返すお金の金額を表示する
    puts @slot_money
    # 自動販売機に入っているお金を0円に戻す
    @slot_money = 0
  end
end


class Juice_management
# ステップ２　ジュースの管理

  def juice_name
    @juice1 = { name: "cola", price: 120, number: 5 }
  end

end


class Purchase
# ステップ３　購入(Purchase)

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
      end

      # 現在の売り上げ金額
      current_sales_amount = 120 * purchase_number

      # 在庫
      stock = number - purchase_number

      # 釣り銭
      change = money - 120 * purchase_number

      puts "現在の売り上げ金額：#{current_sales_amount}、在庫：#{stock}本、釣り銭：#{change}円"

      # number -= purchase_number

    else

    end

  end

end

vm = VendingMachine.new
jm = Juice_management.new
pc = Purchase.new

# 作成した自動販売機に100円を入れる
# vm.slot_money (100)

# 作成した自動販売機に入れたお金がいくらかを確認する（表示する）
vm.current_slot_money

# ジュースの情報を表示する(ステップ2)
puts "コーラの情報"
puts jm.juice_name.values_at(:name, :price, :number)

# ジュースの購入（ステップ3）
puts "100円を入れた時の挙動、コーラの残りの本数、10, 50, 100, 500, 1000しか入らない"
pc.maney_and_stock_judge(vm.slot_money(500), jm.juice_name[:number])

# 作成した自動販売機に入れたお金を返してもらう
puts "作成した自動販売機に入れたお金を返してもらう"
vm.return_money

# $irbをして、次のように入力して実行してみよう。require '/Users/doda_hironobu/vending_machine/sample.rb'
