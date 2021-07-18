package com.example.steamapp.services;


import com.example.steamapp.entities.Game;
import com.example.steamapp.repositories.GameRepository;
import com.example.steamapp.utility.exceptions.GameAlreadyExistException;
import com.example.steamapp.utility.exceptions.GameNotExistingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class GameService {

    @Autowired
    private GameRepository gameRepository;


    @PreAuthorize("hasAuthority('admin')")
    @Transactional
    public Game addGame(Game game) {
        if(gameRepository.existsByName(game.getName()))
            throw new GameAlreadyExistException();
        return gameRepository.save(game);
    }


    @PreAuthorize("hasAuthority('admin')")
    @Transactional
    public Game restockGame(String name, int quantity) {
        if(!gameRepository.existsByName(name))
            throw new GameNotExistingException();
        Game game = gameRepository.findByName(name);
        game.setQuantity(quantity);
        return game;
    }


    @Transactional(readOnly = true)
    public List<Game> showAllGames(int pageNumber, int pageSize, String sortBy){
        Pageable paging = PageRequest.of(pageNumber,pageSize,Sort.by(sortBy));
        Page<Game> pagedResult = gameRepository.findAll(paging);
        if (pagedResult.hasContent()) {
            return pagedResult.getContent();
        }
        else {
            return new ArrayList<>();
        }
    }


    @Transactional(readOnly = true)
    public List<Game> showGameByGenreContaining(String genre, int pageNumber, int pageSize, String sortBy){
        Pageable paging = PageRequest.of(pageNumber,pageSize,Sort.by(sortBy));
        Page<Game> pagedResult = gameRepository.findByGenreStartingWith(genre,paging);
        if (pagedResult.hasContent()) {
            return pagedResult.getContent();
        }
        else {
            return new ArrayList<>();
        }
    }



    @Transactional(readOnly = true)
    public List<Game> showAllByNameContaining(String name, int pageNumber, int pageSize, String sortBy){
        Pageable paging = PageRequest.of(pageNumber,pageSize,Sort.by(sortBy));
        Page<Game> pagedResult = gameRepository.findByNameStartingWith(name,paging);
        if (pagedResult.hasContent()) {
            return pagedResult.getContent();
        }
        else {
            return new ArrayList<>();
        }
    }
}
