# Passes if the Webbed::Method supplied is allowed to have a specific entity
Spec::Matchers.define :have_entity do |entity|
  match do |method|
    method.send("has_#{entity}_entity?")
  end
  
  failure_message_for_should do |method|
    "expected #{method.name} to have a #{entity} entity"
  end
  
  failure_message_for_should_not do |method|
    "expected #{method.name} to not have a #{entity} entity"
  end
  
  description do |method|
    "have a #{entity} entity"
  end
end