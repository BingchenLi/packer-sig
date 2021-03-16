provider "azurerm" {
  features {}
  subscription_id = "subscription_id"
}

resource "azurerm_resource_group" "shared_image_gallery_resource_group" {
  name     = "app-sig-rg"
  location = "West Europe"
}

resource "azurerm_resource_group" "managed_image_resource_group" {
  name     = "packer-build-image-rg"
  location = "West Europe"
}

resource "azurerm_shared_image_gallery" "sig" {
  name                = "App_image_gallery"
  resource_group_name = azurerm_resource_group.shared_image_gallery_resource_group.name
  location            = azurerm_resource_group.shared_image_gallery_resource_group.location

  tags = {
    env = "test"
  }
}

resource "azurerm_shared_image" "image_definition" {
  name                = "App-WinServer2016"
  gallery_name        = azurerm_shared_image_gallery.sig.name
  resource_group_name = azurerm_resource_group.shared_image_gallery_resource_group.name
  location            = azurerm_resource_group.shared_image_gallery_resource_group.location
  os_type             = "Windows"

  identifier {
    publisher = "publisher_name"
    offer     = "App"
    sku       = "WinServer2016-App"
  }
}
