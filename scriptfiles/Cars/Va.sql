/*
 Navicat MySQL Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50609
 Source Host           : localhost:3306
 Source Schema         : samp

 Target Server Type    : MySQL
 Target Server Version : 50609
 File Encoding         : 65001

 Date: 25/07/2020 22:38:32
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for va
-- ----------------------------
DROP TABLE IF EXISTS `va`;
CREATE TABLE `va`  (
  `ID` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `VehicleID` int(11) NULL DEFAULT NULL,
  `Slot` int(11) NULL DEFAULT NULL,
  `Model` int(11) NULL DEFAULT NULL,
  `X` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Y` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Z` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `RX` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `RY` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `RZ` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `TagObjects` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of va
-- ----------------------------
INSERT INTO `va` VALUES (1, 45, 0, 18648, '1.000000', '0.000000', '-0.550000', '0.000000', '0.000000', '0.000000', 0);
INSERT INTO `va` VALUES (2, 22, 0, 1002, '0.000000', '-2.399999', '0.399999', '0.000000', '0.000000', '0.000000', NULL);
INSERT INTO `va` VALUES (3, 22, 1, 18651, '0.960000', '0.000000', '-0.639999', '0.000000', '0.000000', '0.000000', 1);
INSERT INTO `va` VALUES (4, 9, 0, 1003, '0.000000', '0.000000', '0.000000', '0.000000', '0.000000', '0.000000', NULL);
INSERT INTO `va` VALUES (5, 9, 1, 1002, '0.000000', '0.000000', '0.000000', '0.000000', '0.000000', '0.000000', NULL);
INSERT INTO `va` VALUES (6, 2, 0, 18646, '-0.550000', '0.350000', '0.750000', '0.000000', '0.000000', '0.000000', 0);
INSERT INTO `va` VALUES (7, 8, 0, 18651, '-1.100000', '0.000000', '-0.500000', '0.000000', '0.000000', '0.000000', 1);
INSERT INTO `va` VALUES (8, 8, 1, 18651, '1.100000', '0.000000', '-0.500000', '0.000000', '0.000000', '0.000000', 1);
INSERT INTO `va` VALUES (9, 2, 1, 1607, '0.000000', '0.000000', '1.000000', '0.000000', '0.000000', '0.000000', 0);
INSERT INTO `va` VALUES (10, 11, 0, 18651, '-1.000000', '0.000000', '-0.600000', '0.000000', '0.000000', '0.000000', 1);
INSERT INTO `va` VALUES (11, 11, 1, 18651, '1.000000', '0.000000', '-0.600000', '0.000000', '0.000000', '0.000000', 1);
INSERT INTO `va` VALUES (12, 11, 2, 18651, '0.000000', '3.799998', '-0.499999', '0.800000', '3.399998', '4.399998', 0);
INSERT INTO `va` VALUES (13, 11, 3, 18651, '0.000000', '0.000000', '0.000000', '0.000000', '0.000000', '0.000000', NULL);
INSERT INTO `va` VALUES (14, 12, 0, 18694, '-0.300000', '0.000000', '0.000000', '0.000000', '0.000000', '0.000000', 1);
INSERT INTO `va` VALUES (15, 2, 2, 19079, '-0.650000', '-2.649998', '0.550000', '0.000000', '-89.099998', '0.000000', 1);
INSERT INTO `va` VALUES (16, 2, 3, 1003, '0.000000', '-2.449998', '0.299999', '0.000000', '0.000000', '0.000000', 1);
INSERT INTO `va` VALUES (17, 14, 0, 18648, '-1.100000', '0.000000', '-0.600000', '0.000000', '0.000000', '0.000000', 1);
INSERT INTO `va` VALUES (19, 2, 5, 18650, '0.950000', '0.000000', '-0.600000', '0.000000', '0.000000', '0.000000', 1);
INSERT INTO `va` VALUES (20, 2, 6, 18650, '-1.000000', '0.000000', '-0.600000', '0.000000', '0.000000', '0.000000', 1);
INSERT INTO `va` VALUES (21, 14, 1, 18651, '1.100000', '0.000000', '-0.650000', '0.000000', '0.000000', '0.000000', 1);
INSERT INTO `va` VALUES (22, 14, 2, 19419, '0.000000', '-0.100000', '0.650000', '0.000000', '0.000000', '0.000000', 1);
INSERT INTO `va` VALUES (25, 8, 2, 1001, '0.000000', '-2.349999', '0.299999', '0.000000', '0.000000', '0.000000', 1);
INSERT INTO `va` VALUES (26, 8, 3, 19308, '0.000000', '-0.200000', '0.800000', '0.000000', '0.000000', '0.000000', 0);
INSERT INTO `va` VALUES (27, 8, 4, 1609, '0.000000', '0.000000', '2.299999', '0.000000', '0.000000', '0.000000', 0);
INSERT INTO `va` VALUES (28, 8, 5, 19419, '0.000000', '0.000000', '0.700000', '0.000000', '0.000000', '0.000000', 1);
INSERT INTO `va` VALUES (29, 2, 4, 19620, '0.000000', '0.000000', '0.000000', '0.000000', '0.000000', '0.000000', NULL);
INSERT INTO `va` VALUES (30, 2, 7, 19620, '0.000000', '-0.200000', '0.699999', '0.000000', '0.000000', '0.000000', 1);
INSERT INTO `va` VALUES (31, 16, 0, 19620, '0.000000', '-0.200000', '0.800000', '0.000000', '0.000000', '0.000000', 1);
INSERT INTO `va` VALUES (32, 16, 1, 1003, '0.000000', '-2.200000', '0.335999', '0.000000', '0.000000', '0.000000', 1);
INSERT INTO `va` VALUES (33, 18, 0, 18648, '0.000000', '0.000000', '0.000000', '0.000000', '0.000000', '0.000000', 0);
INSERT INTO `va` VALUES (34, 18, 1, 18650, '1.000000', '0.000000', '-0.300000', '0.000000', '0.000000', '0.000000', 0);
INSERT INTO `va` VALUES (35, 17, 0, 1146, '0.000000', '-2.399999', '0.400000', '0.000000', '0.000000', '0.000000', 1);
INSERT INTO `va` VALUES (36, 17, 1, 18648, '1.100000', '0.000000', '-0.500000', '0.000000', '0.000000', '0.000000', 1);
INSERT INTO `va` VALUES (38, 18, 2, 1001, '0.000000', '-2.099999', '0.350000', '0.000000', '0.000000', '0.000000', 1);
INSERT INTO `va` VALUES (39, 18, 3, 19620, '0.000000', '-0.600000', '0.800000', '0.000000', '0.000000', '0.000000', 1);
INSERT INTO `va` VALUES (40, 17, 2, 18648, '-1.100000', '0.000000', '-0.500000', '0.000000', '0.000000', '0.000000', 1);
INSERT INTO `va` VALUES (41, 17, 3, 19620, '0.000000', '0.200000', '0.700000', '0.000000', '0.000000', '0.000000', 1);
INSERT INTO `va` VALUES (42, 18, 4, 19419, '0.000000', '-0.600000', '0.750000', '0.000000', '0.000000', '0.000000', 0);
INSERT INTO `va` VALUES (44, 20, 0, 3528, '0.000000', '0.000000', '0.000000', '0.000000', '0.000000', '0.000000', 1);
INSERT INTO `va` VALUES (45, 20, 1, 19620, '0.000000', '0.000000', '0.699999', '0.000000', '0.000000', '0.000000', 1);
INSERT INTO `va` VALUES (46, 20, 2, 19150, '0.000000', '0.000000', '0.000000', '0.000000', '0.000000', '0.000000', NULL);
INSERT INTO `va` VALUES (47, 20, 3, 1147, '0.000000', '-2.399999', '0.399999', '0.000000', '0.000000', '0.000000', 1);
INSERT INTO `va` VALUES (48, 20, 4, 18651, '-0.800000', '0.000000', '-0.700000', '0.000000', '0.000000', '0.000000', 1);
INSERT INTO `va` VALUES (49, 20, 5, 18651, '0.800000', '0.000000', '-0.800000', '0.000000', '0.000000', '0.000000', 1);
INSERT INTO `va` VALUES (50, 24, 0, 1003, '0.000000', '0.000000', '0.000000', '0.000000', '0.000000', '0.000000', NULL);
INSERT INTO `va` VALUES (51, 24, 1, 19419, '0.000000', '0.000000', '0.000000', '0.000000', '0.000000', '0.000000', NULL);
INSERT INTO `va` VALUES (52, 24, 2, 1147, '0.000000', '0.000000', '0.000000', '0.000000', '0.000000', '0.000000', NULL);
INSERT INTO `va` VALUES (53, 24, 3, 1002, '0.000000', '0.000000', '0.000000', '0.000000', '0.000000', '0.000000', NULL);
INSERT INTO `va` VALUES (54, 24, 4, 19620, '0.000000', '0.000000', '0.000000', '0.000000', '0.000000', '0.000000', NULL);
INSERT INTO `va` VALUES (55, 23, 0, 19620, '0.000000', '0.000000', '0.700000', '0.000000', '0.000000', '0.000000', 1);
INSERT INTO `va` VALUES (56, 23, 1, 1146, '0.000000', '-2.399999', '0.300000', '0.000000', '0.000000', '0.000000', 1);
INSERT INTO `va` VALUES (57, 23, 2, 19311, '0.000000', '-2.399999', '0.499999', '0.099999', '2.200000', '92.000000', 1);
INSERT INTO `va` VALUES (58, 23, 3, 19150, '0.000000', '0.099999', '1.000000', '0.000000', '0.000000', '0.000000', 1);
INSERT INTO `va` VALUES (59, 23, 4, 3790, '1.200000', '0.000000', '-0.500000', '0.000000', '0.000000', '-91.000000', 1);
INSERT INTO `va` VALUES (60, 23, 5, 18646, '0.800000', '-1.900000', '0.310000', '0.000000', '0.000000', '0.000000', 1);
INSERT INTO `va` VALUES (61, 25, 0, 18648, '0.000000', '0.000000', '0.000000', '0.000000', '0.000000', '0.000000', NULL);
INSERT INTO `va` VALUES (62, 25, 1, 18650, '0.000000', '0.000000', '0.000000', '0.000000', '0.000000', '0.000000', NULL);
INSERT INTO `va` VALUES (63, 27, 0, 1147, '0.000000', '-2.200000', '0.400000', '0.000000', '0.000000', '0.000000', 1);

SET FOREIGN_KEY_CHECKS = 1;
