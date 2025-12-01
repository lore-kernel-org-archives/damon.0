Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CF521CC4F
	for <damon@lists.linux.dev>; Mon,  1 Dec 2025 10:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764584551; cv=fail; b=SWTALacIRV+YjKTHJYX+BdRcGuIW3wv7s4VQis+kJ9iIeqG89HIc2mVZL8nHE9jyjAViFNaX41I36UcdeV1hCesDxmQ7G5/Fz0dDneOt9nOE6M3Kn8CTsfQ7kHuz3bkKxJ6zAtf/Yib5A/Bm3rNIt+nhQvybsqGoYzyCAxaD87g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764584551; c=relaxed/simple;
	bh=cD+56uX87ImYxExCVAbdkNWUSEfhG6IluDhavzRA3eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kM/Io+igXkJ1tV2vUXEX41M0l0NtunumcTb++wWYyGaDjc1/9hEze+YfnkUn1QfFklJCBkWKW6WqEhgW8ysoxZghB94vcFv7K5yW6TmzitzxTarAZIRXEtioX8JL9hYf8cZH8CGAS7rAstROx0MPWQ7poRTnpY1Rq6N3n1rtmPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CGDJ+PN8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qmyWAE8m; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CGDJ+PN8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qmyWAE8m"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B18rksX1542411;
	Mon, 1 Dec 2025 10:22:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=jK45OCXHZTXyrZUpes
	VlQ5kMZYLYlGXJ8oD7Y1FNodY=; b=CGDJ+PN8KEcLOkXz5J0+wKTFHzHB39dUcq
	plFoZhHtwnMFk35CO7sy9gaJNSrMRggtzmpwajVoeG/pbPN8Nqwn733hwmroh6lK
	dSn4r4DNeGejCYkHsqjhzP/SyRQi4hpcb9C9Hgp0Yys7pU6Agfv2myhHAwciIsy7
	+YhPqIRhpO6d6rj5SYSCwKXXAxT2wMRqZxOwiwxHHlH4DV+WNe4cGBVoVLe8GVAz
	bubzgExH5gRkGEm1oQgHoBFU1irv/RyDer5RY0NaWSQ+/aFtAsFVDyF7hNgtK7tW
	67v2r3Alj94P+7nxVAXjseT8XFsBhSHHWO+IaIxQFtxG9sKXFFRg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4as7wn8527-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Dec 2025 10:22:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B19fxCT023070;
	Mon, 1 Dec 2025 10:22:20 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011071.outbound.protection.outlook.com [40.93.194.71])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq9bb9nt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Dec 2025 10:22:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4MdtVFv3AM8uIeRmhBQjGVPuXCHdDyCW3+PpPLAmWZQuZgCbbjhOJLvC7By5pNEj+p1I2iHT83REWx5XGvf9p7tCilYzsa4v87a2uznCTkFOau2E6eKbGQ/qx83OdtBLoD45jPIMVULR+emSd3K4WtnMGhBJmidOloYrV8wPr67PFzdpSS7ZI8O8Q6TvrfPs6jCY7fRnIO7hyUv3feXTambaQbbuqSXQJXuWfZim3dA5Tucv3dpPZRdJ63rFgRR8pHsOFWLPM//XLdL30xWe5iCtQPKoR8ezbi+aKCLfSQvv1uspTLPk+4qZbAbAKbZv1mMO23bff2O4K2CgoaV9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jK45OCXHZTXyrZUpesVlQ5kMZYLYlGXJ8oD7Y1FNodY=;
 b=CA3xO+nLdX/A5+bbP3mPksZl4bsYX3fiQ6QqTc8e1a/0+cm+dcShTmS9W890O3nxvR2/N+UbM0FpWTCqbKS+3X+WNArnoizxZG3uVbJjYVqbQo5FWVWhgCK/DRRocRrgciuFNgcDWjMfzuw6c6gwKd204X/NYS3Kaqkj+baRcp40BnnPhP2hVVptp1YnH4z6WkOQiYUMOiMZfTXtxQab2p+qC4YqU7pV5gZUdw85YvPnE7WpYTTgCGrlZnfG0mqJRzQM+EEDO2A6NVwmj13VrwdFyUOu7RQ1KvI+qoKXX3YwecV0oyL6RC3EESwe2n8ZKrV1N+96JqnB7d95bcgadw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jK45OCXHZTXyrZUpesVlQ5kMZYLYlGXJ8oD7Y1FNodY=;
 b=qmyWAE8mOmJzmH9KGMR8zPJ7N3DHErAZJFFtvEHeGWj5SAvtVYttpJfVQ5PWiff0uWqEyC+X/fNzjxqxAEaxhkJJkktTtEY7Iugi8t1vmuhHKfHzHS+ord15eeMHj/9OmRuQJOzA8I7zgEY771QuJ05tDxmH48ctAZia7ApsQ3I=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY5PR10MB6021.namprd10.prod.outlook.com (2603:10b6:930:3f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 10:22:17 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 10:22:17 +0000
Date: Mon, 1 Dec 2025 10:22:14 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, Xin Hao <xhao@linux.alibaba.com>,
        Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
        Andrew Paniakin <apanyaki@amazon.com>
Subject: Re: A rough plan for CPUs/write-only monitoring RFC v3 and future
Message-ID: <28004730-6394-4c5b-949e-8ef15b0642af@lucifer.local>
References: <20251128193947.80866-1-sj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128193947.80866-1-sj@kernel.org>
X-ClientProxiedBy: LO4P265CA0110.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY5PR10MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dc780d3-596b-4438-945f-08de30c3810d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BN67OS6+CLuSvX8zksDzYuQQ8dy03XvwcO41L9Dh8/w9ejFxDNsc7uoIL3VB?=
 =?us-ascii?Q?JkMLuSJdpnNUF5WMRT+HBTCEscm0og82DPdJoFN90FtbZEHYhJtIIRds1E3j?=
 =?us-ascii?Q?Ywdp1CDke2T3L0R9YtwmpyEx5CPJG+epfhMrVmtX0F0x94p6dj25O4F2QLii?=
 =?us-ascii?Q?2NLWtJCHjUbJdsTHoA67ezs5jbdLtviC3A1dcJpXK1I7237nM0F2frHrAkbn?=
 =?us-ascii?Q?oTSJ50W1WsUo5wdbLYTcDndydz0HJ3JTJ9fCDiMablcqsHP0r3mtmBng7eH7?=
 =?us-ascii?Q?PrN0h2p50ViaOhH+iPW7p1pnSJevzf3tn6q/Okw3w3HdGCO9cv7QTNWXTQ2W?=
 =?us-ascii?Q?weR/JlbOPSgdXy04yy4MPfLGXEgIXisgKnX03N8uSkLCWfPLdmqhawrmACrh?=
 =?us-ascii?Q?6HjKAyRqzqJ0f3YmU64DJQESJnN46TJOBWRjZ6a6oIy89yeeTBv+b9+A6cga?=
 =?us-ascii?Q?NMIASijw/q2eiomyNAxof3NQ9PCFCoFd57dB7pywYBDP8Feu9hUls8YzbtBU?=
 =?us-ascii?Q?IjSybk7+Hpj6gwCnh1RGtQGrqrsmtvQ2ldA2bANHleBHI4HTYhQotV9Rgaqk?=
 =?us-ascii?Q?BdI5YUyzhERtCIaE8MOToXqdwOLu/tvx6no4kV08iVu9ZRXDka7WOcrAydsR?=
 =?us-ascii?Q?3T37cLd/Sx5UuFFsRwacup61XDFKNIkgtPe4p2kSg8VkmCQhlVh5hRQWGJyv?=
 =?us-ascii?Q?8/TP1WBLinEMmDgWMl/JILLKKI/NUUdoXtW+kOJrjfzgQd5t0ShzLQFPe3tU?=
 =?us-ascii?Q?PtTNsAT3SaKtnbbsL4BA+ZXTLJwXOC4jolWr1LPCwC5dESN8TQnPVvOczfD9?=
 =?us-ascii?Q?7EIvLXnb5KUGfkHMEtTTEsh41v+iNd8inwi3NA5acUoEcNpguF/13xIKfnhj?=
 =?us-ascii?Q?GO+O2qt0d+A3J9jfJUanvIxzSkzljbg58prkxuYoJLRPlYdBxVf7gh7J70b2?=
 =?us-ascii?Q?aD0Rk05RXvDfNVTjkn/L7uHSw9dHETFaZ4sFRbkOSAEjc47ey8Slw7YfMMRK?=
 =?us-ascii?Q?vSnX8tZfNvnPq0Ik3IZHXlGuYKiWq/P53eqMiSI9gbfTqNp1xBkgtWo/ffp0?=
 =?us-ascii?Q?NgvYyAbiRsTH0KupKUdn+WM84UaGxLYbfLhFxttyHpISH0M+9+oP51yRQgZS?=
 =?us-ascii?Q?vFg0os25Cru0R5M1m2fh8Qu+uxPvcMTOu0j1HO3nHQ2tOCm+GgVla2E/4yky?=
 =?us-ascii?Q?g6tYM8KNrKX39AIpcKL5xy1ZwN07oXl6sl3K+xUbuT0EfC65dI/atbvEih/R?=
 =?us-ascii?Q?TU14cmCd/I5zjcdyg4LYwSX9F10+s4ZwG8abKULVaiVQHWBn6d6gztxyvnAa?=
 =?us-ascii?Q?jAZVVFP+bjCn2tFzDbc5Ddl0OqGIrwsA6+XTxCti1znN0Ot1h65kA63o5eGH?=
 =?us-ascii?Q?v8t8t7KxGgchvnYoe0eQ5H2732kC2A4FF78MkrjsOhb4bzFA6A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cfvXlhOY0ucaOVq14fSuSQXlgkWSCYbYeYn6aPGFbJBjo3wQIIOAlK3pKHP4?=
 =?us-ascii?Q?t3LLv4fTtBfNmoRiLQQ2C0soRBU0toWphVi2pmdP9LnERDKgIkhtqJCXfp65?=
 =?us-ascii?Q?Eea0SyEpRtuWy2UQ5A4iq3INUozd+wZt2HrabHrCrceKQQWDRnqnPngMsCPV?=
 =?us-ascii?Q?r4/BDLNRpY4huwDIQ6gMcpHQwOIRIDJ0ZfC4JyQJ5nZAksAEAQoenSlTtFcs?=
 =?us-ascii?Q?AfNuOqH7xzOV9xSJsV1SdsdC7U5iTDCkxvC525Q3jSuTTYBZMgUE0iyck9KK?=
 =?us-ascii?Q?oquiA1zSDS2J1Fy8QJU5Uq5vbAFgy/O06Qq6v9sBkWQ7TA+ooA0s7QJSCg9D?=
 =?us-ascii?Q?3hP7EVJ3Gou1n6vOY9jj7NFbixOkfqWUvFBxPDkoJ3+PMiUEevfW2FoJ8zLf?=
 =?us-ascii?Q?8UxuplTGYclGDp6cDX3k4B0ogWa6ZZaEyt8ekz9+eB5ZWb/zv0em/nCIcilf?=
 =?us-ascii?Q?7AjtODH8bhlj9QcqmEazuXAs3LQXPj5G2wBgPas01hwjWlv2XZGckBOcwCb1?=
 =?us-ascii?Q?iQMFIuvhLMYEoxHQarUlwt/IC2SyiKvZp358PI5vEA14FqD9B7plVuG/SMnv?=
 =?us-ascii?Q?PsdCjOz34PMxqGHypJv1U4cJK80AgUpeXL2UwIBMi6tCiVwQbBKrbL1Opy7y?=
 =?us-ascii?Q?ARghIgpsDa3D5yjF9/Nkjw/fCXYcJ3YHzjZ/uCWg1WFaSqtZu3boVNUAnU7g?=
 =?us-ascii?Q?hVPifEb/72Cy47iOm2ZrMN7QF+2raxXMDh8SGI8zZbN2L4RYyro69agtrL1R?=
 =?us-ascii?Q?rMIUcoAfP+zwXn7jkfHfHw7R2NYpxF02YLTYccAAiZNwvKNr2ARBa2eDMXem?=
 =?us-ascii?Q?sDKsE9Cf0Qia+OGvX2QHtTjyIPPHlIWCA9Tm0tNB81hpIkxjKDRH7MEZbGEe?=
 =?us-ascii?Q?4fZfFqhKPS1pFmpQTsKkjR9ZMs8VQpOrtpuAnb/Ow71othiySWk9w3hSLtXz?=
 =?us-ascii?Q?uTEb6959UpmgTo9Hdjk0LUwKdgnANjf4lxrqq04dawS4zZIwunENh6+dUsJZ?=
 =?us-ascii?Q?nNC4umVKPX0iecPlbKLBvGzPNToD0RpZKVlB4DffB1Sro96LHDAI69qexMnW?=
 =?us-ascii?Q?xfh3GX1sNxdERFt1D7GKmblQsWP8j8ENLhJlCd7HzyqB2aiM5UyNq/14BqUX?=
 =?us-ascii?Q?3sxq3mzo7wGleSjyBnPjep/rG/E4wOKcD9IdFcLIshUfgjqdK5RA/gOmKEbR?=
 =?us-ascii?Q?SS9fsOIGLG65ZAXW3x0bsw498LAyCbdY1M7IydEynb4nHtjQ+vtzfqk6hEUu?=
 =?us-ascii?Q?9iYeS1bkntmKMCL/ZewjHd3JmsyWS7OrO+BS5AawwpVZAJRf8tjh4G0FP0A1?=
 =?us-ascii?Q?QZQOqtU0zQxhECfFn5v5byD30OOFk5Pf1k+/DnA8/dC9KoKUe3cjs4sZT59y?=
 =?us-ascii?Q?1zUqz4HoOg9E48C87y5SvPIz7MP73AItYmUhZN8PApgdqHxcLCupUMRTuPd8?=
 =?us-ascii?Q?FVk8NJmw8omcN7fGZv1wGBTkRYIDFVzj1gEdKKBM7hzv2xAJ86imzwinatiQ?=
 =?us-ascii?Q?6W9rdw+AIejPoWwVeEDKIlH3VMeoEMzF0Q2DzBs3Wsgf9jNWpLfJg4ZPAazy?=
 =?us-ascii?Q?WwN4jxHgyNxsY0VRyj8fM5PWyvvTlyNhKPCP6wxAFE4Nvrlzyv1f5owj7LSa?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5dv1yzAkbJq+1iuGC3McQomcmfZXdBQ2d5ieJI2ObCeVU9Qw5vhxkoLFjoscC9yTcckBIToAEkFYiBD7ux4yVzi3MdF8AG7SxdJpfTIKxQXuj0VtkO/GayVIjqWNui7w9TwgVvdGEcABBjqVcdHswBaDRAdNm81i0+JZ+Nwj5p/EXdSrbe7zEzuTOz/zan9K5ggp5fBL66+1Y/scXqfOmG7IL8qKXRqWjFd4RNTOS1He6WZGS38zoZH7SV3pct0ZHU1QBGHOmxoFop7E25RfteS5jjKE/KpovjLdNUqFL6wCidlEV2JuSTJKP012bYFaIOj25sstp7kQKqglhkCGf0zIwJA1+8QZXwegxY153kNOrm+7ZbX+ViTbWVmy0uWqnjC4W/H+DDyHvnYEP31FpH+/4IzUwLC1PqRDMhHGYlBc67kRdwt6a9V/b92Aw69ZXx7jsGyavVvsGwTyvLohJ3hLXDkNUsum9qw2W8I/KLWziLjqDLVJx5LX6mJOJCpALD57osl+R7/bL8Pdo/xTDYD2naE6+JRVYZbc7eG29JHa1h9x3qBil4/1XhfAw0KuGYKh6cnsC4Segk/cOQEPLVVb7VWFy4oOmHkzDpiWxLo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc780d3-596b-4438-945f-08de30c3810d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 10:22:17.6999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmpV9Ch5gYMBWforAlQsv3n/fBvwL6/IVmX4dyTBFSpmTL3/MvUTRLb3/ixbgZj9+re0eZ1aV77PA41HmZOSr7xssK7XKtD2re1cYDhkKoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6021
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512010083
X-Proofpoint-GUID: Z-jNiJaLlwSF7lt9cz7f7iN_LFDgiesm
X-Proofpoint-ORIG-GUID: Z-jNiJaLlwSF7lt9cz7f7iN_LFDgiesm
X-Authority-Analysis: v=2.4 cv=SbX6t/Ru c=1 sm=1 tr=0 ts=692d6c5e b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=_hqgX1VUr-H2dAzd:21 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=fLlSqHoUAAAA:8 a=VwQbUJbxAAAA:8 a=SRrdq9N9AAAA:8
 a=pGLkceISAAAA:8 a=OGjWj8McAAAA:8 a=07d9gI8wAAAA:8 a=ag1SF4gXAAAA:8
 a=EP6vid_HUh1w5-dASVcA:9 a=CjuIK1q_8ugA:10 a=X1VMFabGxh4T5SFHm4bH:22
 a=UYjydHh6ynBBc6_pBLvz:22 a=e2CUPOnPG4QKp8I52DXD:22 a=Yupwre4RP9_Eg_Bd0iYG:22
 cc=ntf awl=host:12098
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAxMDA4NCBTYWx0ZWRfXz6e5KPCBQ+z1
 eS6b3wMx8alxzNsmR4yunGMLGBhLPPXjkWjJ1IUkihB7aXpUu/aSRgnGoaHFaluMPITHPyzA3eP
 gdaGmsTcU0fu4bC5Y04ZmRoGHRr5LsZ45OnsAc82I5jzZ+p2g0IjUqD5LWyNPkcyp40iBNNCbiS
 WJ3/jHbVFu+O/0OXvbRwxhWcaDg4/qIGI4+eI2rZfftNeBFkUbz+AMzpAt8B8YGntJ7LWxv3D6f
 sSeodwagzQ7dZ/TEs2+Qbse4/8v5xcoNTh+N7UIpI9Kp6dcYuPe+3AIeIOzxFmKi24xdoUsI4ZZ
 iEpmw0iorZ2NQf9A9+gHPfG23hZnVGlZ0UGNJAwULMeUgIo7dEui94S52AE+ReVZy3wy+FGheZi
 SO+eY7SLpjwnqUnwSVm4Px+dyYnas4ZfZK/Hwpyx1xXZ/N77Clo=

On Fri, Nov 28, 2025 at 11:39:46AM -0800, SeongJae Park wrote:
> Hello DAMON community,
>
>
> I'm working [1] on extending DAMON to monitor accesses that are made by
> specific CPUs, and/or for writes.  The aimed usages include NUMA hit/miss
> monitoring [2], Kernel Same page Merging scan target selection [3,4], cache
> aware CPU scheduling, live migration target VM selection [5], and general
> NUMA-aware pages migration [6].
>
> I posted its first working version as RFC v2 [7] about four months ago.  After
> the posting, it got interests and tests publicly [5] and privately.  RFC v2
> was, however, a never upstreamable hack that was made for only showing if it
> can be implemented.  For making it upstreamed, a significant amount of efforts
> are expected [8].  And after the posting, I was unfortunately unable to spend
> meaningful time on it due to other events and work.  I received more continued
> interests in the work recently, and hence I'm trying to spend more time on it.
>
> The Rough Plan
> --------------
>
> The rough plan of it that I shared on DAMON blog [8] was just saying "it needs
> to be upstreamed and it will require a significant amount of effort".  So I'm
> sharing yet another rough plan here.
>
> This work require multiple changes including
> 1. extending DAMON for receiving access report from other subsystems
>    (damon_report_access() [9]),
> 2. making other subsystem who can capture origin CPU/writeness of accesses
>    (e.g., page fault handler [10]) report the information to DAMON,
> 3. extending DAMON for filtering the reports for origin CPU/writeness of
>    accesses.
>
> The first part in the current implementation has many rooms to improve in terms
> of performance.  I don't think that's upstreaming blocker though, unless some
> early testers find a problem of it.  So I think this is not a blocker for this
> project, at least at the moment.
>
> For the second part, I'm trying to modify the page fault handler, to use
> information like NUMA balancing hint faults.  As Lorenzo pointed out on RFC v2,
> it needs to have clean and non disruptive design.  Also this requires alignment
> of multiple stakeholders, including MM core and NUMA balancing maintainers.  I
> think this is the biggest challenge of this project.  Using other subsystems or
> features such as instruction sampling can be another way to go.  But for
> general availability of it on any architecture and virtual machine internal
> cases, people I privately discussed preferred this fault based approach.  I
> will try to make the alignment with the stakeholders, after the upcoming LPC [11].
> Unless I make good progress on this part very quickly, I will propose an
> LSFMMBPF'26 [12] session for this.  So hopefully we will make some alignment
> among the stakeholders by LSFMM.  Hopefully we will get a more concrete
> upstreaming plan and timeline, at least after the LSFMM'26.

I think it will be difficult (though not saying impossible :) to get alignment
on overload NUMA for this, I think at the very least we'd have to _allow_ for
there to be clashes between the two and possibly spurious results in either
direction.

I think my recent softleaf changes should at least make this more
viable. Though, if you wish to retain the entire PTE entry it doesn't seem
feasible to utilise this, but rather we'd have to simply overload NUMA (and
possibly rename it to something else...)

Another way might be to, when marking PTEs for the DAMON mechanism, store the
complete PTE entry elsewhere, insert a softleaf entry that contains the index of
this entry, and on fault restore it from this 'elsewhere' location.

I have some doubts that overloading NUMA is going to be something that'll be
upstreamable, because of the added complexity and natural clashes between NUMA
and this new mechanism.

So perhaps this alternative will work better?

>
> The third part in current implementation is very ugly.  Especially its kernel
> API and user ABI need to be redesigned from the beginning.  The interface is
> better to be stabilized sooner, as changes of the interface will make the early
> users/testers be confused and frustrated.  I started working on this, and
> hopefully I will share RFC v3 of this project with the stabilized interface, by
> upcoming LPC'25.
>
> Summary and Message for User/Tester
> -----------------------------------
>
> To summarize the major expected timeline here,
>
> 1. By LPC'25 (2025-12-13), another version having stabilized DAMON interface
>    will be shared.
> 2. By LSFMMBPF'26 (2026-05-06), an alignment on part 2 stakeholders will be
>    made.

Sadly I am not attending LPC '25, but of course intend to be there at LSF '26 :)

> 3. After the alignment, a more clear plan will be made.
>
> If you are already using or testing RFC v2 of this project, please be aware the
> kernel API and user ABI will significantly be changed on the version that I am willing to
> share by LPC'25.  It means if you are directly using or testing the features
> via the kernel API and/or user ABI, your usages or tests might need to be
> updated.
>
> The support of the features on DAMON user-sapce tool (damo) is also
> experimental at the moment, and that will also be changed in more stable form
> in future.  But, the experimental interface will support both before-LPC and
> after-LPC DAMON for the short term.  Hence, if you are using or testing the
> features via DAMON user-space tool's experimental interface, you will not need
> to make any change in the short term.
>
> Please feel free to raise any questions or comments on the plan and the
> project.
>
> References
> ----------
>
> [1] https://damonitor.github.io/posts/write_only_cpus_only_monitoring/
> [2] https://lore.kernel.org/linux-mm/cover.1645024354.git.xhao@linux.alibaba.com/
> [3] https://lore.kernel.org/lkml/20220203131237.298090-1-pedrodemargomes@gmail.com/
> [4] https://lore.kernel.org/damon/20250129044041.25884-1-pedrodemargomes@gmail.com/
> [5] https://lore.kernel.org/all/aJAfTUh-49pYuhbg@3c06303d853a/
> [6] https://lpc.events/event/19/contributions/2066/
> [7] https://lore.kernel.org/all/20250727201813.53858-1-sj@kernel.org/
> [8] https://damonitor.github.io/posts/write_only_cpus_only_monitoring/#cautions-and-plan-to-drop-experimental-tag
> [9] https://lwn.net/Articles/1016525/
> [10] https://lore.kernel.org/all/20250727201813.53858-6-sj@kernel.org/
> [11] https://lpc.events/event/19/
> [12] https://events.linuxfoundation.org/lsfmmbpf/
>
>
> Thanks,
> SJ

Cheers,  Lorenzo
