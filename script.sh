#!/bin/bash

while getopts ":aesivn" option; do
  case "$option" in
    a)
      container_ids=$(docker ps -a -q)
      if [ -z "$container_ids" ]; then
        echo "Aucun conteneur Docker trouvé."
      else
        echo "Démarrage des conteneurs Docker..."
        for container_id in $container_ids; do
          docker start $container_id
          echo "Conteneur $container_id démarré."
        done
      fi
      ;;
    e)
      container_ids=$(docker ps -q)
      if [ -z "$container_ids" ]; then
        echo "Aucun conteneur Docker en cours d'exécution."
      else
        echo "Arrêt des conteneurs Docker..."
        for container_id in $container_ids; do
          docker stop $container_id
          echo "Conteneur $container_id arrêté."
        done
      fi
      ;;
    s)
      container_ids=$(docker ps -a -q)
      if [ -z "$container_ids" ]; then
        echo "Aucun conteneur Docker trouvé."
      else
        echo "Suppression des conteneurs Docker..."
        for container_id in $container_ids; do
          docker rm $container_id
          echo "Conteneur $container_id supprimé."
        done
      fi
      ;;
    i)
      image_ids=$(docker images -q)
      if [ -z "$image_ids" ]; then
        echo "Aucune image Docker trouvée."
      else
        echo "Suppression des images Docker..."
        for image_id in $image_ids; do
          docker rmi $image_id
          echo "Image $image_id supprimée."
        done
      fi
      ;;
    v)
      volume_ids=$(docker volume ls -q)
      if [ -z "$volume_ids" ]; then
        echo "Aucun volume Docker trouvé."
      else
        echo "Suppression des volumes Docker..."
        for volume_id in $volume_ids; do
          docker volume rm $volume_id
          echo "Volume $volume_id supprimé."
        done
      fi
      ;;
    n)
      network_ids=$(docker network ls -q)
      if [ -z "$network_ids" ]; then
        echo "Aucun réseaux Docker trouvé."
      else
        echo "Suppression des réseaux Docker..."
        for network_id in $network_ids; do
          docker network rm $network_id
          echo "réseau $network_id supprimé."
        done
      fi
      ;;
    \?)
      echo "Option invalide: -$OPTARG" >&2
      exit 1
      ;;
  esac
done
