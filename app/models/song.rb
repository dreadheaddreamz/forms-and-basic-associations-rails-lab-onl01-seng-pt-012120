class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes
  validates :title, presence: true

  def artist_name=(artist)
    self.artist = Artist.find_or_create_by(name: artist)
  end

  def artist_name
    self.artist ? self.artist.name : nil
  end

  def note_contents
    self.notes.collect(&:content)
  end

  def note_contents=(note_contents)
    note_contents.each do |content|
      unless content.empty?
        self.notes << Note.create(content: content)
        self.save
      end
    end
  end

  
end


