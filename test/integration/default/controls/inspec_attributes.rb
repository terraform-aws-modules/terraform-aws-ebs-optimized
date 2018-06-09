# frozen_string_literal: true

supported =
  attribute(
    "supported",
    description: ""
  )

unsupported_type_result =
  attribute(
    "unsupported",
    description: ""
)

unknown_type_result =
  attribute(
    "unknown",
    description: ""
)

ebs_optimized_instance_id =
  attribute(
    "ebs_optimized_instance_id",
    description: ""
  )
puts  ebs_optimized_instance_id

not_ebs_optimized_instance_id =
  attribute(
    "not_ebs_optimized_instance_id",
    description: ""
  )

control 'ebs_optimized' do
  describe aws_ec2_instance(not_ebs_optimized_instance_id) do
    it { should exist }
    # ebs_optimized is not an attribute we can test through inspec yet
  end

  describe aws_ec2_instance(ebs_optimized_instance_id) do
    it { should exist }
  end
end
