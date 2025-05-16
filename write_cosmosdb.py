
# Install and restart (Databricks)
%pip install azure-cosmos
%restart_python

# Python script (Azure Cosmos DB write)
from azure.cosmos import CosmosClient

# Cosmos DB connection details
cosmos_uri = "https://smartcitycosmosdb22095834.documents.azure.com:443/"
cosmos_key = "YOUR_KEY_HERE"
database_name = "SmartCityData"
container_name = "SensorData"

# Initialize the Cosmos Client
client = CosmosClient(cosmos_uri, credential=cosmos_key)

# Get the database and container client
database = client.get_database_client(database_name)
container = database.get_container_client(container_name)

# Air Quality data
for row in df_airquality.collect():
    document = {
        'id': row.sensor_id,
        'sensor_id': row.sensor_id,
        'timestamp': str(row.timestamp),
        'location': row.location,
        'air_quality_index': row.air_quality_index,
        'pm2_5': row.pm2_5,
        'pm10': row.pm10
    }
    container.upsert_item(body=document)

# Traffic data
for row in df_traffic.collect():
    document = {
        'id': str(row.sensor_id),
        'sensor_id': row.sensor_id,
        'timestamp': str(row.timestamp),
        'location': row.location,
        'vehicle_count': row.vehicle_count,
        'avg_speed_kmh': row.avg_speed_kmh
    }
    container.upsert_item(body=document)

# Energy data
for row in df_energy.collect():
    document = {
        'id': row.sensor_id,
        'sensor_id': row.sensor_id,
        'timestamp': str(row.timestamp),
        'location': row.location,
        'energy_consumed_kwh': row.energy_consumed_kwh,
        'peak_load_mw': row.peak_load_mw
    }
    container.upsert_item(body=document)
