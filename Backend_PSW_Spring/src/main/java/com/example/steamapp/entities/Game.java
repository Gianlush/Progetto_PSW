package com.example.steamapp.entities;


import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;
import java.util.List;

@Getter
@Setter
@ToString
@EqualsAndHashCode
@Entity
@Table(name = "game", schema = "my_database")

public class Game {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private int id;


    @Basic
    @Column(name = "name")
    private String name;

    @Basic
    @Column(name = "genre")
    private String genre;

    @Basic
    @Column(name = "price")
    private float price;

    @Basic
    @Column(name = "quantity")
    private int quantity;

    @Version
    @JsonIgnore
    @ToString.Exclude
    @Column(name = "version")
    private long version;


    @OneToMany(mappedBy = "game")
    @JsonIgnore
    @ToString.Exclude
    private List<GamePerOrder> gamePerOrder;

}
