// This template is not working, but it should create IAM login profile and decrypt the password using couple hacks....

// This is a template which will generate Terraform configuration file for all IAM users (eg, users.tf.json)
// Only change this template and not the generated users.tf.json

local users = import "users.json";

local source_iam_user = "git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-user?ref=v2.1.0";
local source_iam_group = "git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-group-with-policies?ref=v2.1.0";
local source_shell_resource = "git::https://github.com/matti/terraform-shell-resource.git?ref=v0.12.0";
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

      pgp_key: "keybase:antonbabenko",
      create_iam_user_login_profile: true,
    } for user in users_fixed
  } + {
    [user.replaced_username + "_decrypt_password"]: {
      source: source_shell_resource,

      command: "${module." + user.replaced_username + ".keybase_password_decrypt_command}",
    } for user in users_fixed
  } + {
    ["developers_group"]: {
      source: source_iam_group,

      name: "developers",
      group_users: [user.aws for user in users_fixed],
      custom_group_policy_arns: ["arn:aws:iam::aws:policy/PowerUserAccess"],
    }
}
  ,
  output: {
    [user.replaced_username]: {
      value: "export AWS_ACCESS_KEY_ID=${module." + user.replaced_username + ".this_iam_access_key_id} AWS_SECRET_ACCESS_KEY=${module." + user.replaced_username + ".this_iam_access_key_secret} AWS_REGION=" + aws_region,
    } for user in users_fixed
  } + {
    [user.replaced_username + "_console"]: {
      value: "Username: ${module." + user.replaced_username + ".this_iam_user_name}\nDecrypt password command: ${module." + user.replaced_username +".keybase_password_decrypt_command}\nPassword: ${module." + user.replaced_username + "_decrypt_password.stdout}\nConsole login URL: https://tfworkshop.signin.aws.amazon.com/console",
    } for user in users_fixed
  }
}
