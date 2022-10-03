output "inventory" {
  value = data.template_file.inventory.rendered
}

data "template_file" "inventory" {
  template = file("${path.module}/inventory.ini.tpl")

  vars = {
    entry_cplanes = join("\n", formatlist("%s ansible_host=%s", aws_instance.k8s-cplane.*.tags.Name, aws_instance.k8s-cplane.*.public_dns))
    entry_nodes   = join("\n", formatlist("%s ansible_host=%s", aws_instance.k8s-node.*.tags.Name, aws_instance.k8s-node.*.public_dns))
  }
}

resource "null_resource" "inventory" {
  provisioner "local-exec" {
    command = "echo '${data.template_file.inventory.rendered}' > ${var.INVENTORY_FILE}"
  }
  triggers = {
    template = data.template_file.inventory.rendered
  }
}

