class Meta
  include ActiveAttr::Model

  attribute :rating
  attribute :have
  attribute :want
  attribute :formats
end

class Album
  include Elasticsearch::Persistence::Model

  index_name [Rails.application.engine_name, Rails.env].join('-')


  mapping _parent: { type: 'artist' } do
  end

  attribute :artist
  attribute :artist_id, type: String, mapping: { index: 'not_analyzed' }
  attribute :label, type: Hash, mapping: { type: 'object' }

  attribute :title
  attribute :released, type: Date
  attribute :notes
  attribute :uri

  attribute :tracklist, type: Array, mapping: { type: 'object' }

  attribute :styles
  attribute :meta, type: Meta, mapping: { type: 'object' }

  attribute :suggest, type: Hashie::Mash, mapping: {
    type: 'object',
    properties: {
      title: {
        type: 'object',
        properties: {
          input:   { type: 'completion' },
          output:  { type: 'keyword', index: false },
          payload: { type: 'object', enabled: false }
        }
      },
      track: {
        type: 'object',
        properties: {
          input:   { type: 'completion' },
          output:  { type: 'keyword', index: false },
          payload: { type: 'object', enabled: false }
        }
      }
    }
  }
end
