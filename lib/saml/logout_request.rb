module Saml
  class LogoutRequest
    include Saml::ComplexTypes::RequestAbstractType

    attr_accessor :xml_value

    tag "LogoutRequest"

    attribute :not_on_or_after, Time, tag: "NotOnOrAfter", on_save: lambda { |val| val.utc.xmlschema if val.present? }

    element :name_id, String, tag: "NameID", namespace: 'saml'
    element :session_index, String, tag: "SessionIndex", namespace: 'samlp'

    validates :name_id, presence: true
  end
end
