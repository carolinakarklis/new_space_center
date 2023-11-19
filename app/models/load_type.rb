class LoadType < ApplicationRecord
  # Satélite, Sonda, Combustível, Descarte de lixo
  enum name: { satellite: 0, probe: 1, fuel: 2, trash_disposal: 3 }
end
