require 'spec_helper'

describe Saml::Elements::AttributeQuery do

  describe "Required fields" do
    [:_id, :version, :issue_instant, :subject].each do |field|
      it "should have the #{field} field" do
        expect(subject).to respond_to(field)
      end

      it "should check the presence of #{field}" do
        subject.send("#{field}=", nil)
        expect(subject).not_to be_valid
      end
    end
  end

  describe "Optional fields" do
    [:destination, :issuer, :attributes].each do |field|
      it "should have the #{field} field" do
        expect(subject).to respond_to(field)
      end

      it "should allow #{field} to blank" do
        subject.send("#{field}=", nil)
        subject.valid?
        expect(subject.errors.entries).to eq([])
        subject.send("#{field}=", "")
        subject.valid?
        expect(subject.errors.entries).to eq([])
      end
    end
  end

  it "includes the complex type AttributeQueryType" do
    expect(described_class.ancestors).to include Saml::ComplexTypes::AttributeQueryType
    expect(described_class.ancestors).to include Saml::ComplexTypes::SubjectQueryAbstractType
    expect(described_class.ancestors).to include Saml::ComplexTypes::RequestAbstractType
  end

  describe "parse" do
    let(:attribute_query_xml) { File.read(File.join('spec', 'fixtures', 'attribute_query.xml')) }
    let(:attribute_query) { Saml::Elements::AttributeQuery.parse(attribute_query_xml, single: true) }

    it "should parse the AttributeQuery" do
      expect(attribute_query).to be_a(Saml::Elements::AttributeQuery)
    end

    it 'should have 2 attributes' do
      expect(attribute_query.attributes.count).to eq 3
    end
  end
end
