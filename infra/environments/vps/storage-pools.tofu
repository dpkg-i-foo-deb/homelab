module "storage_pools" {
    source = "./storage-pools"

    providers = {
        incus = incus
    }
}