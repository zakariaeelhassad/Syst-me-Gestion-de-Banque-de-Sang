package org.example.entities.models;

import org.example.entities.enums.BloodGroup;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@AllArgsConstructor
@NoArgsConstructor
@MappedSuperclass
public abstract class Person {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
        private String id;

    @NotBlank
    @Column(nullable = false , length = 100)
    private String nom;

    @NotBlank
    @Column(nullable = false , length = 100)
    private String prenom;

    @NotBlank
    @Column(nullable = false , unique = true , length = 15)
    private String cin;

    @NotBlank
    @Column(nullable = false , length = 10)
    private String sexe;

    @NotNull
    @Column(name = "date_naissance" , nullable = false )
    private LocalDate dateNaissance;

    @Enumerated(EnumType.STRING)
    @Column( name = "blood_group")
    private BloodGroup bloodGroup;
}