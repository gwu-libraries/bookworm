class Work < ApplicationRecord
  validates :doi, presence: true

  belongs_to :investigation

  # reference_connections "names" the Connection join table for accessing through the reference association
  has_many :reference_connections, foreign_key: :citation_id, class_name: "Connection"
  # source: :reference matches with the belong_to :reference identification in the Connection model
  has_many :references, through: :reference_connections, source: :reference

  # citation_connections "names" the Connection join table for accessing through the citation association
  has_many :citation_connections, foreign_key: :reference_id, class_name: "Connection"

  # source: :citation matches with the belong_to :citation identification in the Connection model
  has_many :citations, through: :citation_connections, source: :citation 

  def citation_reference_tree_json
    result = {
      "name": self.title,
      "children": [
        {
        "name": "citations",
        "children": self.citations.map {|citation| {"name": citation.title}}
        },
        {
        "name": "references",
        "children": self.references.map {|citation| {"name": citation.title}}
        }
      ]
    }
  end
end