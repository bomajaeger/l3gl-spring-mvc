<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page isELIgnored="false" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<c:set var="onglet" value="produits" />
<c:set var="titre"  value="Produits" />
<%@ include file="fragments/header.jsp" %>

<div class="entete">
  <div>
    <span class="micro">Catalogue</span>
    <h1>Produits <span class="compteur">${fn:length(products)}</span></h1>
  </div>
  <a href="${ctx}/product/new" class="bouton">Ajouter un produit</a>
</div>

<c:if test="${not empty message}"><div class="message">${message}</div></c:if>
<c:if test="${not empty erreur}"><div class="message erreur">${erreur}</div></c:if>

<div class="panneau">
  <c:choose>
    <%-- État vide : on invite à agir plutôt que d'afficher un tableau creux. --%>
    <c:when test="${empty products}">
      <div class="vide">
        <p>Aucun produit enregistré pour le moment.</p>
        <a href="${ctx}/product/new" class="bouton">Ajouter le premier produit</a>
      </div>
    </c:when>

    <c:otherwise>
      <table class="registre">
        <thead>
        <tr>
          <th style="width:80px">Réf.</th>
          <th>Libellé</th>
          <th style="width:180px">Type</th>
          <th style="width:160px" class="col-montant">Prix</th>
          <th style="width:180px" class="col-actions">Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="product" items="${products}">
          <tr>
              <%-- Référence sur 3 chiffres : 1 devient 001, comme sur une fiche d'inventaire. --%>
            <td><span class="ref"><fmt:formatNumber value="${product.id}" pattern="000" /></span></td>

            <td class="nom">${product.libelle}</td>

            <td>
              <c:choose>
                <c:when test="${not empty product.type}">
                  <span class="etiquette">${product.type.libelle}</span>
                </c:when>
                <c:otherwise>
                  <span class="etiquette vide">Non classé</span>
                </c:otherwise>
              </c:choose>
            </td>

              <%-- Montants en FCFA : entiers, séparateur de milliers, jamais de décimales. --%>
            <td class="col-montant">
                            <span class="montant">
                                <fmt:formatNumber value="${product.prix}" pattern="#,##0" />
                                <span class="unite">FCFA</span>
                            </span>
            </td>

            <td class="col-actions">
              <a href="${ctx}/product/edit/${product.id}" class="lien-action">Modifier</a>
              <form action="${ctx}/product/delete/${product.id}" method="post" class="form-inline"
                    onsubmit="return confirm('Supprimer le produit « ${product.libelle} » ?');">
                <button type="submit">Supprimer</button>
              </form>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </c:otherwise>
  </c:choose>
</div>

<%@ include file="fragments/footer.jsp" %>
