package org.example.entities.models;

import org.example.entities.enums.DonorStatus;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import java.time.LocalDate;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "donneurs")
public class Donneur extends Person {

    @Column(name = "date_dernier_don")
    private LocalDate dateDernierDon;

    @NotNull
    @Column(name = "contre_indication", nullable = false)
    private Boolean contreIndication;

    @NotNull
    @Column(name = "puche_disponible", nullable = false)
    private Integer pucheDisponible;

    @Column(length = 500)
    private String notes;

    @Enumerated(EnumType.STRING)
    @Column(name = "donor_status", nullable = false)
    private DonorStatus donorStatus;

}
