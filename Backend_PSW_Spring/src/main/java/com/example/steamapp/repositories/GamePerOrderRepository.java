package com.example.steamapp.repositories;

import com.example.steamapp.entities.GamePerOrder;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface GamePerOrderRepository extends JpaRepository<GamePerOrder, Integer> {

}
