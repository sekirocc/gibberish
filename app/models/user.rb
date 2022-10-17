class User < ApplicationRecord
    enum status: {
      active: 0,
      freezed: 1
    }

    enum gender: {
      unknown: 0,
      male: 1,
      female: 2
    }

    has_many :murmurs
end
