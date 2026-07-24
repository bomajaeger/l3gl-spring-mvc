<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page isELIgnored="false" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<c:set var="onglet" value="types" />
<c:set var="titre"  value="Types" />
<%@ include file="fragments/header.jsp" %>

<div class="entete">
    <div>
        <span class="micro">Classement</span>
        <h1>Types <span class="compteur">${fn:length(types)}</span></h1>
    </div>
    <a href="${ctx}/type/new" class="bouton">Ajouter un type</a>
</div>

<c:if test="${not empty message}"><div class="message">${message}</div></c:if>
<c:if test="${not empty erreur}"><div class="message erreur">${erreur}</div></c:if>

<div class="panneau">
    <c:choose>
        <c:when test="${empty types}">
            <div class="vide">
                <p>Aucun type enregistré. Les types servent à classer les produits du catalogue.</p>
                <a href="${ctx}/type/new" class="bouton">Ajouter le premier type</a>
            </div>
        </c:when>

        <c:otherwise>
            <table class="registre">
                <thead>
                <tr>
                    <th style="width:80px">Réf.</th>
                    <th>Libellé</th>
                    <th style="width:180px" class="col-montant">Produits</th>
                    <th style="width:180px" class="col-actions">Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="type" items="${types}">
                    <tr>
                        <td><span class="ref"><fmt:formatNumber value="${type.id}" pattern="000" /></span></td>

                        <td class="nom">${type.libelle}</td>

                            <%-- Collection chargée par le JOIN FETCH du repository :
                                 sans lui, cet accès déclencherait une LazyInitializationException. --%>
                        <td class="col-montant">
                            <span class="montant">${fn:length(type.products)}</span>
                        </td>

                        <td class="col-actions">
                            <a href="${ctx}/type/edit/${type.id}" class="lien-action">Modifier</a>
                            <form action="${ctx}/type/delete/${type.id}" method="post" class="form-inline"
                                  onsubmit="return confirm('Supprimer le type « ${type.libelle} » ?');">
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
