alert_backup_jobs_failed = {
  enabled           = true
  threshold         = 1
  frequency         = "PT1H"
  action_group_name = "alz"
}

alert_backup_jobs_completed = {
  enabled           = true
  threshold         = 1
  frequency         = "PT1H"
  action_group_name = "alz"
}

alert_restore_jobs_failed = {
  enabled           = true
  threshold         = 1
  frequency         = "PT1H"
  action_group_name = "alz"
}