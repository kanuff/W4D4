# == Schema Information
#
# Table name: tracks
#
#  id         :bigint           not null, primary key
#  album_id   :integer          not null
#  title      :string           not null
#  ord        :integer          not null
#  bonus      :boolean          default(FALSE)
#  lyrics     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Track < ApplicationRecord

  validates :album_id, :title, :ord, presence: true
  validates :bonus, :inclusion {:in [true, false]}

  belongs_to :album,
  foreign_key: :album_id,
  class_name: :Album
end
