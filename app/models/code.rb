class Code < ApplicationRecord
  enum gender: {
      male: 0,
      female: 1,
      unknown: 2
  }

  enum combat_rule: {
      single: 0,
      double: 1,
      multi: 2,
      battle_royal: 3
  }

end
