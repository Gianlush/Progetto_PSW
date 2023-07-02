package com.example.steamapp.entities;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;
import javax.persistence.*;
import java.util.*;


@Getter
@Setter
@EqualsAndHashCode
@ToString
@Entity
@Table(name = "user", schema = "my_database")

public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private int id;


    @Basic
    @Column(name = "name")
    private String name;


    @Basic
    @Column(name = "surname")
    private String surname;


    @Basic
    @Column(name = "email")
    private String email;


    @OneToMany(mappedBy = "user")
    @JsonIgnore
    @ToString.Exclude
    private List<Purchase> purchase;

}
