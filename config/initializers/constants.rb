# 単位変換用の定数
module Conv_Unit
        KgToLBS = 2.20462
end

# PFCバランス計算用の定数
module Calc_PFC
        # Pは体重(lbs)の1.0〜1.5倍が理想
        # 間をとって1.25を採用
        ProteinFromLBS = 1.25
        # FはPの30%が理想
        FatFromProtein = 0.3
        # CはPの200%が理想
        CarbFromProtein = 2.0
end