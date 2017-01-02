class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Captain.joins(boats: :classifications).where("classifications.name = ?", 'Catamaran')
  end

  def self.sailors
    Captain.joins(boats: :classifications).where("classifications.name = ?", 'Sailboat').uniq
  end

  def self.talented_seamen
    captains_of_sailboats = Captain.joins(boats: :classifications).where("classifications.name =?", 'Sailboat').uniq
    captains_of_motorboats =Captain.joins(boats: :classifications).where("classifications.name =?", 'Motorboat').uniq
    Captain.where(id: captains_of_sailboats.where(id: captains_of_motorboats))
  end

  def self.non_sailors
    non_sailors = Captain.joins(boats: :classifications).where("classifications.name = ?", 'Sailboat')
    Captain.where.not(id: non_sailors)
  end

end
