<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<c:set var="creation" value="${empty product.id}" />
<c:set var="onglet"   value="produits" />
<c:set var="titre"    value="${creation ? 'Nouveau produit' : 'Modifier un produit'}" />
<%@ include file="fragments/header.jsp" %>

<div class="entete">
    <div>
        <span class="micro">${creation ? 'Nouvelle entrée' : 'Réf. '}<c:if test="${not creation}">${product.id}</c:if></span>
        <h1>${creation ? 'Nouveau produit' : 'Modifier le produit'}</h1>
    </div>
</div>

<form class="fiche" action="${ctx}/product" method="post">

    <%-- Champ pivot : vide en création (INSERT), renseigné en modification (UPDATE).
         C'est lui qui fait basculer le merge() du repository d'un cas à l'autre. --%>
    <input type="hidden" name="id" value="${product.id}">

    <div class="champ">
        <label for="libelle" class="micro">Libellé</label>
        <input type="text" id="libelle" name="libelle" value="${product.libelle}"
               required autofocus placeholder="Clavier mécanique">
    </div>

    <div class="champ">
        <label for="prix" class="micro">Prix</label>
        <input type="number" id="prix" name="prix" min="0" step="1"
               value="${product.prix}" required placeholder="15000">
        <span class="aide">En francs CFA, sans décimales ni séparateur.</span>
    </div>

    <div class="champ">
        <label for="typeId" class="micro">Type</label>
        <%-- On transmet l'identifiant seul plutôt que l'objet imbriqué : le contrôleur
             recharge le Type depuis la base, ce qui évite de rattacher une entité détachée. --%>
        <select id="typeId" name="typeId">
            <option value="">— Non classé —</option>
            <c:forEach var="t" items="${types}">
                <option value="${t.id}" ${product.type.id eq t.id ? 'selected' : ''}>${t.libelle}</option>
            </c:forEach>
        </select>
        <c:if test="${empty types}">
            <span class="aide">Aucun type disponible. <a href="${ctx}/type/new">Créer un type</a> d'abord.</span>
        </c:if>
    </div>

    <div class="actions-fiche">
        <button type="submit" class="bouton">Enregistrer</button>
        <a href="${ctx}/product" class="bouton secondaire">Annuler</a>
    </div>
</form>

<%@ include file="fragments/footer.jsp" %>
