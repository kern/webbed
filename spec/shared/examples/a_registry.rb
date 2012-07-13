shared_examples "a registry" do
  before do
    registry.register(obj1)
  end

  it "can find objects given their look-up keys" do
    expect(registry.look_up(lookup_key)).to eq(obj1)
  end

  it "can unregister objects" do
    registry.unregister(lookup_key)
    expect do
      registry.look_up(lookup_key)
    end.to raise_error(IndexError)
  end 

  context "when registering an object with an already registered look-up key" do
    it "overwrites the previous object" do
      registry.register(obj2)
      expect(registry.look_up(lookup_key)).to eq(obj2)
    end
  end
end
