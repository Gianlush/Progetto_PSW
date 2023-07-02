package com.example.steamapp.repositories;

import com.example.steamapp.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;


@Repository
public interface UserRepository extends JpaRepository<User, Integer> {

    List<User> findByNameContaining(String name);

    List<User> findBySurnameContaining(String surname);

    User findByEmail(String email);

    boolean existsByEmail(String email);
}
