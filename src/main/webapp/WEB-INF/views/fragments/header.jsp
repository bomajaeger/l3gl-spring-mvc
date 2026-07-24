<%--
    Fragment d'en-tête commun à toutes les vues.
    La page appelante doit définir la variable "onglet" AVANT l'inclusion :
        <c:set var="onglet" value="produits" />
    afin que le rail de navigation marque le bon élément comme actif.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${empty titre ? 'Registre' : titre} — Registre</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Archivo:wght@400;500;600;700&family=DM+Mono:wght@400;500&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="${ctx}/assets/css/app.css">
</head>
<body>

<nav class="rail">
    <div class="rail-marque">
        <span class="micro">Groupe 2 — L3GL</span>
        <p class="titre">Registre</p>
    </div>

    <div class="rail-nav">
        <a href="${ctx}/product" class="${onglet eq 'produits' ? 'actif' : ''}">Produits</a>
        <a href="${ctx}/type"    class="${onglet eq 'types'    ? 'actif' : ''}">Types</a>
    </div>

    <div class="rail-pied">Stock &amp; catalogue</div>
</nav>

<main class="contenu">
    <div class="cadre">
