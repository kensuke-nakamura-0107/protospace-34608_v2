class Comment < ApplicationRecord

validates :text, presence: true

belongs_to :user,dependent: :destroy
belongs_to :prototype,dependent: :destroy

end
