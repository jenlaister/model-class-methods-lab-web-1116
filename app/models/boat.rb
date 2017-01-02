class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    Boat.limit(5)
  end

  def self.dinghy
    Boat.where('length < ?', 20)
  end
  #SELECT * FROM boats WHERE (length < 20)

  def self.ship
    Boat.where('length > ?', 20)
  end
  #SELECT * FROM boats WHERE (length > 20)

  def self.last_three_alphabetically
    Boat.order(name: :desc).limit(3)
  end
  #SELECT * FROM boats ORDER BY name DESC LIMIT 3

  def self.without_a_captain
    Boat.where(captain_id: nil)
  end

  def self.sailboats
    Boat.joins(:classifications).where(classifications: { name: 'Sailboat'})
  end

  def self.with_three_classifications
    Boat.joins(:classifications).group('boats.name').having('count(boats.name) = ?', 3)
  end

end
