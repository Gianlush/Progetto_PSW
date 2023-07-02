package com.example.steamapp.repositories;


import com.example.steamapp.entities.Purchase;
import com.example.steamapp.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public interface PurchaseRepository extends JpaRepository<Purchase,Integer> {

    List<Purchase> findByUserOrderByShopDateDesc(User user);

    @Query("select o from Purchase o where o.shopDate > ?1 and o.shopDate < ?2 and o.user = ?3")
    List<Purchase> findByUserInPeriod (Date start, Date end, User user);
}
