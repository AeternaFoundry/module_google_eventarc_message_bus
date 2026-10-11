resource "google_eventarc_message_bus" "eventarc_message_buses" {
  for_each = var.eventarc_message_buses

  location        = each.value.location
  message_bus_id  = each.value.message_bus_id
  annotations     = each.value.annotations
  crypto_key_name = each.value.crypto_key_name
  deletion_policy = each.value.deletion_policy
  display_name    = each.value.display_name
  labels          = each.value.labels
  project         = each.value.project

  dynamic "logging_config" {
    for_each = each.value.logging_config != null ? [each.value.logging_config] : []
    content {
      log_severity = logging_config.value.log_severity
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

