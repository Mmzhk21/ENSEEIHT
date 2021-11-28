
#ifndef POINT__H
#define POINT__H

/**
 *  \author KJR <nom@n7.fr>
 *  \file point.h
 *  Objectifs :
 *	Définition d'un module Point.
 *	Un Point est représenté par ses coordonnées géographiques en 
 *	degrés décimaux. 
 */

struct Point {
    float longitude;
    float latitude;
};
typedef struct Point Point;

/**
 * \brief Initialiser un point connaissant longitude et latitude
 * \param p le point a initialiser
 * \param long la longitude
 * \param lat la latitude
 */
void initialiser_point(Point *p, float longi, float lat);


/**
 * \brief Lire la longitude 
 * \param p le point
 * \return float la longitude en degres decimaux
 */
float lire_longitude(Point p);

/**
 * \brief Lire la latitude 
 * \param p le point
 * \return float la latitude en degres decimaux
 */
float lire_latitude(Point p);

/**
 * \brief copier le point p_orig dans p_dest
 * \param p_orig point à copier
 * \param p_dest point à éditer
 */
void copier_point(Point *p_dest, Point p_orig);

/**
 * \brief transforme la description d'un point en chaine de caractères
 * \param str chaine de caracteres
 * \param p point
 */
void point_tostring(char *str, Point p);
#endif
