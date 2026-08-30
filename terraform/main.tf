locals {
  report_source_dir = "../DevelopmentRnD/Contoso Sales Report/Contoso Sales Analysis.Report"
}

# Create Report with PBIR format, with visuals
resource "fabric_report" "example_pbir_with_visuals" {
  display_name = var.report_name
  workspace_id = var.dev_workspace_id
  format       = "PBIR"
  definition = {
    for f in fileset("${path.module}/${local.report_source_dir}", "**/*") :
    f => {
      source = "${path.module}/${local.report_source_dir}/${f}"
    } if startswith(f, "definition/") || startswith(f, "StaticResources/") || f == "definition.pbir" || f == "semanticModelDiagramLayout.json"
  }
}
