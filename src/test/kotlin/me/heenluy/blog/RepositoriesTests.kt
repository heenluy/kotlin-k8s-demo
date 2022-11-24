package me.heenluy.blog

import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager
import org.springframework.data.repository.findByIdOrNull

@DataJpaTest
class RepositoriesTests @Autowired constructor(
    val entityManager: TestEntityManager,
    val userRepository: UserRepository,
    val articleRepository: ArticleRepository) {

    @Test
    fun `When findByIdOrNull then return Article`() {
        val john = User("@john", "john", "mcAlister")
        entityManager.persist(john)
        val article = Article("Demo from Spring guide", "Dear Spring community ...", "Lorem ipsum", john)
        entityManager.persist(article)
        entityManager.flush()
        val found = articleRepository.findByIdOrNull(article.id!!)
        assertThat(found).isEqualTo(article)
    }

    @Test
    fun `When findByLogin then return User`() {
        val john = User("@john", "john", "mcAlister")
        entityManager.persist(john)
        entityManager.flush()
        val user = userRepository.findByLogin(john.login)
        assertThat(user).isEqualTo(john)
    }
}