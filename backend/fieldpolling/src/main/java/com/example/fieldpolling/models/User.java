package com.example.fieldpolling.models;

import java.util.Collection;
import java.util.List;
import java.util.UUID;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.example.fieldpolling.helpers.UserRole;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;


@Entity(name = "users")
@Table(name = "users")
@Getter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of = "user_id")
public class User implements UserDetails {
    
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private UUID user_id;
    @Column(unique = true)
    private String login;
    @Column(unique = true)
    private String email;
    private String password;
    private UserRole role;

    public User(String login, String password, UserRole role) {
        this.login = login;
        this.password = password;
        this.role = role;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        if(this.role == UserRole.ADMIN) return List.of(new SimpleGrantedAuthority("ROLE_ADMIN"), new SimpleGrantedAuthority("ROLE_USER"));
        else return List.of(new SimpleGrantedAuthority("ROLE_USER"));
        // throw new UnsupportedOperationException("Unimplemented method 'getAuthorities'");
    }

    @Override
    public String getUsername() {
        return login;
        //throw new UnsupportedOperationException("Unimplemented method 'getUsername'");
    }
    @Override
    public boolean isAccountNonExpired() {
        return true;
        //throw new UnsupportedOperationException("Unimplemented method 'isAccountNonExpired'");
    }
    @Override
    public boolean isAccountNonLocked() {
        return true;
        //throw new UnsupportedOperationException("Unimplemented method 'isAccountNonLocked'");
    }
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
        //throw new UnsupportedOperationException("Unimplemented method 'isCredentialsNonExpired'");
    }
    @Override
    public boolean isEnabled() {
        return true;
        //throw new UnsupportedOperationException("Unimplemented method 'isEnabled'");
    }

}
