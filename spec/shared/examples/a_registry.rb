shared_examples "a registry" do
  before do
    registry.register(obj1)
  end

  it "can register objects" do
    registry.look_up(lookup_key) == obj1
  end

  it "can unregister objects" do
    registry.register(obj1)
  end

  it "can find objects given their look-up keys" do
    registry.look_up(lookup_key).should == obj1
  end

  it "can unregister objects" do
    registry.unregister(lookup_key)
    expect do
      registry.look_up(lookup_key)
    end.to raise_error(KeyError)
  end 

  context "when registering an object with an already registered look-up key" do
    it "overwrites the previous object" do
      registry.register(obj2)
      registry.look_up(lookup_key).should == obj2
    end
  end
end
