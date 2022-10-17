class Murmur < ApplicationRecord

  enum visibility: {
    is_private: 0,
    is_public: 1,
    is_grouped_public: 2
  }

  belongs_to :user
end
