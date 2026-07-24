<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<c:set var="creation" value="${empty type.id}" />
<c:set var="onglet"   value="types" />
<c:set var="titre"    value="${creation ? 'Nouveau type' : 'Modifier un type'}" />
<%@ include file="fragments/header.jsp" %>

<div class="entete">
    <div>
        <span class="micro">${creation ? 'Nouvelle entrée' : 'Réf. '}<c:if test="${not creation}">${type.id}</c:if></span>
        <h1>${creation ? 'Nouveau type' : 'Modifier le type'}</h1>
    </div>
</div>

<form class="fiche" action="${ctx}/type" method="post">

    <input type="hidden" name="id" value="${type.id}">

    <div class="champ">
        <label for="libelle" class="micro">Libellé</label>
        <input type="text" id="libelle" name="libelle" value="${type.libelle}"
               required autofocus placeholder="Périphérique">
        <span class="aide">Le nom de la catégorie tel qu'il apparaîtra sur les produits.</span>
    </div>

    <div class="actions-fiche">
        <button type="submit" class="bouton">Enregistrer</button>
        <a href="${ctx}/type" class="bouton secondaire">Annuler</a>
    </div>
</form>

<%@ include file="fragments/footer.jsp" %>
