package com.example.steamapp.repositories;

import com.example.steamapp.entities.Game;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GameRepository extends JpaRepository<Game, Integer> {

    Page<Game> findByGenreStartingWith(String genre, Pageable paging);

    Page<Game> findByNameStartingWith(String name, Pageable paging);

    Game findByName(String name);

    boolean existsByName(String name);

}
