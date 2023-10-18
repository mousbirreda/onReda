
locals {
  netmask_table = {
    "24" = { "mask" = "255.255.255.0" }
    "25" = { "mask" = "255.255.255.128" }
    "26" = { "mask" = "255.255.255.192" }
    "27" = { "mask" = "255.255.255.224" }
    "28" = { "mask" = "255.255.255.240" }
  }

  #activeport1
  active1_split_range = split("/", var.hamgmtcidr)
  active1_range       = local.active1_split_range[0]
  active1_digits      = split(".", local.active1_range)
  active1_last_digit  = sum([tonumber(local.active1_digits[3]), 10])
  activeport1         = "${local.active1_digits[0]}.${local.active1_digits[1]}.${local.active1_digits[2]}.${local.active1_last_digit}"
  active1_mask        = local.active1_split_range[1]
  activeport1mask     = local.netmask_table[local.active1_mask].mask

  #activeport2
  active2_split_range = split("/", var.publiccidr)
  active2_range       = local.active2_split_range[0]
  active2_digits      = split(".", local.active2_range)
  active2_last_digit  = sum([tonumber(local.active2_digits[3]), 10])
  activeport2         = "${local.active2_digits[0]}.${local.active2_digits[1]}.${local.active2_digits[2]}.${local.active2_last_digit}"
  active2_mask        = local.active2_split_range[1]
  activeport2mask     = local.netmask_table[local.active2_mask].mask

  #activeport3
  active3_split_range = split("/", var.privatecidr)
  active3_range       = local.active3_split_range[0]
  active3_digits      = split(".", local.active3_range)
  active3_last_digit  = sum([tonumber(local.active3_digits[3]), 10])
  activeport3         = "${local.active3_digits[0]}.${local.active3_digits[1]}.${local.active3_digits[2]}.${local.active3_last_digit}"
  active3_mask        = local.active3_split_range[1]
  activeport3mask     = local.netmask_table[local.active3_mask].mask

  #activeport4
  active4_split_range = split("/", var.hasynccidr)
  active4_range       = local.active4_split_range[0]
  active4_digits      = split(".", local.active4_range)
  active4_last_digit  = sum([tonumber(local.active4_digits[3]), 10])
  activeport4         = "${local.active4_digits[0]}.${local.active4_digits[1]}.${local.active4_digits[2]}.${local.active4_last_digit}"
  active4_mask        = local.active4_split_range[1]
  activeport4mask     = local.netmask_table[local.active4_mask].mask


  #passiveport1
  passive1_split_range = split("/", var.hamgmtcidr)
  passive1_range       = local.passive1_split_range[0]
  passive1_digits      = split(".", local.passive1_range)
  passive1_last_digit  = sum([tonumber(local.passive1_digits[3]), 11])
  passiveport1         = "${local.passive1_digits[0]}.${local.passive1_digits[1]}.${local.passive1_digits[2]}.${local.passive1_last_digit}"
  passive1_mask        = local.passive1_split_range[1]
  passiveport1mask     = local.netmask_table[local.passive1_mask].mask

  #passiveport2
  passive2_split_range = split("/", var.publiccidr)
  passive2_range       = local.passive2_split_range[0]
  passive2_digits      = split(".", local.passive2_range)
  passive2_last_digit  = sum([tonumber(local.passive2_digits[3]), 11])
  passiveport2         = "${local.passive2_digits[0]}.${local.passive2_digits[1]}.${local.passive2_digits[2]}.${local.passive2_last_digit}"
  passive2_mask        = local.passive2_split_range[1]
  passiveport2mask     = local.netmask_table[local.passive2_mask].mask

  #passiveport3
  passive3_split_range = split("/", var.privatecidr)
  passive3_range       = local.passive3_split_range[0]
  passive3_digits      = split(".", local.passive3_range)
  passive3_last_digit  = sum([tonumber(local.passive3_digits[3]), 11])
  passiveport3         = "${local.passive3_digits[0]}.${local.passive3_digits[1]}.${local.passive3_digits[2]}.${local.passive3_last_digit}"
  passive3_mask        = local.passive3_split_range[1]
  passiveport3mask     = local.netmask_table[local.passive3_mask].mask

  #passiveport4
  passive4_split_range = split("/", var.hasynccidr)
  passive4_range       = local.passive4_split_range[0]
  passive4_digits      = split(".", local.passive4_range)
  passive4_last_digit  = sum([tonumber(local.passive4_digits[3]), 11])
  passiveport4         = "${local.passive4_digits[0]}.${local.passive4_digits[1]}.${local.passive4_digits[2]}.${local.passive4_last_digit}"
  passive4_mask        = local.passive4_split_range[1]
  passiveport4mask     = local.netmask_table[local.passive4_mask].mask


  #port1gateway
  gwp1_split_range = split("/", var.hamgmtcidr)
  gwp1_range       = local.gwp1_split_range[0]
  gwp1_digits      = split(".", local.gwp1_range)
  gwp1_last_digit  = sum([tonumber(local.gwp1_digits[3]), 1])
  port1gateway     = "${local.gwp1_digits[0]}.${local.gwp1_digits[1]}.${local.gwp1_digits[2]}.${local.gwp1_last_digit}"

  #port2gateway
  gwp2_split_range = split("/", var.publiccidr)
  gwp2_range       = local.gwp2_split_range[0]
  gwp2_digits      = split(".", local.gwp2_range)
  gwp2_last_digit  = sum([tonumber(local.gwp2_digits[3]), 1])
  port2gateway     = "${local.gwp2_digits[0]}.${local.gwp2_digits[1]}.${local.gwp2_digits[2]}.${local.gwp2_last_digit}"

}

