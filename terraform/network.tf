// Static IP
resource "google_compute_address" "supercell_static_ip" {
  name = "supercell-static-ip"
}

// VPC
resource "google_compute_network" "supercell_vpc" {
  name                    = "supercell-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "supercell_subnet_public" {
  name          = "public-subnet"
  ip_cidr_range = "192.168.1.0/24"
  region        = var.gcloud_region
  network       = google_compute_network.supercell_vpc.id
}

resource "google_vpc_access_connector" "supercell_vpc_connector" {
  name          = "supercell-vpc-connector"
  ip_cidr_range = "192.168.8.0/28"
  network       = google_compute_network.supercell_vpc.name
}

// Router
resource "google_compute_router" "supercell_router" {
  name    = "supercell-router"
  network = google_compute_network.supercell_vpc.name
}

resource "google_compute_router_nat" "supercell_router_nat" {
  name   = "supercell-router-nat"
  router = google_compute_router.supercell_router.name
  region = google_compute_router.supercell_router.region

  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = google_compute_address.supercell_static_ip.*.self_link
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
