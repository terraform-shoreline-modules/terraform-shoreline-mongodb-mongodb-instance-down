resource "shoreline_notebook" "mongodb_instance_down" {
  name       = "mongodb_instance_down"
  data       = file("${path.module}/data/mongodb_instance_down.json")
  depends_on = [shoreline_action.invoke_restart_mongodb]
}

resource "shoreline_file" "restart_mongodb" {
  name             = "restart_mongodb"
  input_file       = "${path.module}/data/restart_mongodb.sh"
  md5              = filemd5("${path.module}/data/restart_mongodb.sh")
  description      = "Check if the service has started successfully"
  destination_path = "/agent/scripts/restart_mongodb.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_restart_mongodb" {
  name        = "invoke_restart_mongodb"
  description = "Check if the service has started successfully"
  command     = "`chmod +x /agent/scripts/restart_mongodb.sh && /agent/scripts/restart_mongodb.sh`"
  params      = []
  file_deps   = ["restart_mongodb"]
  enabled     = true
  depends_on  = [shoreline_file.restart_mongodb]
}

