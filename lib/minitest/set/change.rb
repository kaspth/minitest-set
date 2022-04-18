class Minitest::Set::Change
  def initialize(object, **attributes)
    @object, @attributes = object, attributes
  end

  def setup
    @previous_attributes = extract_previous_attributes
    set attributes
  end

  def teardown
    set previous_attributes
  end

  private
    attr_reader :object, :attributes, :previous_attributes

    def extract_previous_attributes
      attributes.keys.to_h { |name| [ name, object.public_send(name) ] }
    end

    def set(attributes)
      attributes.each { |name, value| object.public_send("#{name}=", value) }
    end
end
