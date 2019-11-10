// This is a template which will generate Terraform configuration file for all IAM users (eg, users.tf.json)
// Only change this template and not the generated users.tf.json

local users = import "users.json";

local source_iam_user = "git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-user?ref=v2.3.0";
local source_iam_group = "git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-group-with-policies?ref=v2.3.0";
local aws_region = "eu-west-1";

local users_fixed = [
  u + { replaced_username: std.strReplace(u.aws, ".", "_") }
  for u in std.filter(function(v) std.objectHas(v, "aws"), users)
];

{
  module: {
    [user.replaced_username]: {
      source: source_iam_user,

      name: user.aws,
      password_reset_required: false,
      force_destroy: true,
      create_iam_user_login_profile: false,
    } for user in users_fixed
  } +
  {
    [user.replaced_username + "_login_profile"]: {
      source: "./iam-user-login-profile",

      username: "${module." + user.replaced_username + ".this_iam_user_name}",
    } for user in users_fixed
  } + {
    ["developers_group"]: {
      source: source_iam_group,

      name: "developers",
      group_users: ["${module." + user.replaced_username + ".this_iam_user_name}" for user in users_fixed],
      custom_group_policy_arns: ["arn:aws:iam::aws:policy/PowerUserAccess"],
    }
}
  ,
  output: {
    [user.replaced_username]: {
      value: [
      "export AWS_ACCESS_KEY_ID=${module." + user.replaced_username + ".this_iam_access_key_id} AWS_SECRET_ACCESS_KEY=${module." + user.replaced_username + ".this_iam_access_key_secret} AWS_REGION=" + aws_region,
      "https://${data.aws_iam_account_alias.current.account_alias}.signin.aws.amazon.com/console/",
      "Username: " + "${module." + user.replaced_username + "_login_profile.username}",
      "Password: " + "${module." + user.replaced_username + "_login_profile.password}"]
    } for user in users_fixed
  }
}
