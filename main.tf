terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "=3.1.0"
    }
  }
  backend "azurerm" {

  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}

locals {
  loc_for_naming = lower(replace(var.location, " ", ""))
}

resource "azurerm_resource_group" "magic8ball" {
  name     = "rg-functions-magic8ball-${local.loc_for_naming}"
  location = var.location
}

resource "random_string" "magic8ball_unique" {
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_storage_account" "magic8ball" {
  name                     = "magic8ball${random_string.magic8ball_unique.result}"
  resource_group_name      = azurerm_resource_group.magic8ball.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "magic8ball" {
  name                = "azure-functions-magic8ball-service-plan"
  location            = azurerm_resource_group.magic8ball.location
  resource_group_name = azurerm_resource_group.magic8ball.name
  kind                = "functionapp"
  reserved            = true

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "magic8ball" {
  name                       = "magic8ball${random_string.magic8ball_unique.result}"
  location                   = azurerm_resource_group.magic8ball.location
  resource_group_name        = azurerm_resource_group.magic8ball.name
  app_service_plan_id        = azurerm_app_service_plan.magic8ball.id
  storage_account_name       = azurerm_storage_account.magic8ball.name
  storage_account_access_key = azurerm_storage_account.magic8ball.primary_access_key
  version = "~3"
  os_type = "linux"

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"   = "python"
  }

  site_config {
    linux_fx_version= "Python|3.8"        
    ftps_state = "Disabled"
  }

  
}

resource "null_resource" "publish_magic8ball"{
  depends_on = [
    azurerm_function_app.magic8ball
  ]
  triggers = {
    index = "${base64sha256(file("${path.module}/magic8ball/Magic8BallHttpTrigger/__init__.py"))}"
  }
  provisioner "local-exec" {
    working_dir = "magic8ball"
    command     = "func azure functionapp publish ${azurerm_function_app.magic8ball.name}"
  }
}



resource "azurerm_resource_group" "drawacard" {
  name     = "rg-functions-drawacard-${local.loc_for_naming}"
  location = var.location
}

resource "random_string" "drawacard_unique" {
  length  = 8
  special = false
  upper   = false
}


resource "azurerm_storage_account" "drawacard" {
  name                     = "drawacard${random_string.drawacard_unique.result}"
  resource_group_name      = azurerm_resource_group.drawacard.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "drawacard" {
  name                = "azure-functions-drawacard-service-plan"
  location            = azurerm_resource_group.drawacard.location
  resource_group_name = azurerm_resource_group.drawacard.name
  kind                = "functionapp"
  reserved            = true

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "drawacard" {
  name                       = "drawacard${random_string.drawacard_unique.result}"
  location                   = azurerm_resource_group.drawacard.location
  resource_group_name        = azurerm_resource_group.drawacard.name
  app_service_plan_id        = azurerm_app_service_plan.drawacard.id
  storage_account_name       = azurerm_storage_account.drawacard.name
  storage_account_access_key = azurerm_storage_account.drawacard.primary_access_key
  version = "~3"
  os_type = "linux"

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"   = "python"
  }

  site_config {
    linux_fx_version= "Python|3.8"        
    ftps_state = "Disabled"
  }

  
}

resource "null_resource" "publish_drawacard"{
  depends_on = [
    azurerm_function_app.drawacard
  ]
  triggers = {
    index = "${base64sha256(file("${path.module}/drawacard/DrawacardHttpTrigger/__init__.py"))}"
  }
  provisioner "local-exec" {
    working_dir = "drawacard"
    command     = "func azure functionapp publish ${azurerm_function_app.drawacard.name}"
  }
}