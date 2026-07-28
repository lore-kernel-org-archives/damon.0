Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010058.outbound.protection.outlook.com [52.101.84.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736622EEE85;
	Tue, 28 Jul 2026 14:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.58
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250185; cv=fail; b=cu2rdq6V3kTf6R023B0sV2fDPgmMJFHpeabY+sMSerqDqC81ACOvYEbWeTVsiGKtEzyMC5JHZleQENAsMWAZ6UIwSFTch2GAFVplwNjGdCc7LnRpYMW+fsqp3rD/WzzShWbZW5vKo9uM1DxP1nKA47u5Cr3SLK/TqUgBuxmbAmI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250185; c=relaxed/simple;
	bh=nrwC/VIlEyb1Tisi7TcZVQOBkpnJ4/9N8b9SLmkplG8=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l+MgWXmf8ahSFHutoLzSCdLzur4QoVL8Z9x85+Ho0LvbpythnRz9W/ab6Y9qHgPCPLDwoidyOZdds8CcnYNrGUP5PfBuJkHn7Koi1iv3ooa40hcA6sSxqcfDR0++bUU/Jl03888CKS/0+aJVURCNYidDfBdBNRLd5J3Gwq22WPo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=muYOoUmt; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=muYOoUmt; arc=fail smtp.client-ip=52.101.84.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="muYOoUmt";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="muYOoUmt"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=AphV2D8541+ujH7YDX50KK1BMCErKTma1yfFy3e/rqlfI0kPTWRoruYznUOfljb4HkzdmZum7Z3Leh2exWP74SpR62vzDahWka7IhN/oUwhR+gHsmoCiP/mN+0lkwzW+zPHaUN7Tox9DGAypu4ALR31LGie9E8EYThA41gEECL7J765qayk0Qd3lQ9D4gMN6wdODHBonjaiK4kkPtFPB1PzydYbFhxlMY61e09bonGr0UTs95ndQZEe08xuPOHAcdNkREhNxpzVafoMOz9nJ1WjezQvFJ89LpN0DLHvmlu75wkrSFmop8wWwHCIXLH0S8UvNZWSZ5PFo971V90bi/Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrwC/VIlEyb1Tisi7TcZVQOBkpnJ4/9N8b9SLmkplG8=;
 b=GCEYn6sRVpMpu30td8Mg2fU/npcaXACiR7rr7J3odHBBk6iOvMe5ifaktNIaN3IsENG4lwafovnC0WnZBqLJKOppWpzS0T3Dbl9nEb6ijK+FlNxKBWC97U5xLucKaUGEpJtO90odnw7sd8rA+NUciSXFNyD1kvCoWeVx488W893I0f5RWtVtotfcaHpOSLW0rlHQolGz1Bqz1oPeBDPuO4Q5NCaLj5vdwqVCS25565aphcH+fUg1PZRWPASM43MbTPZyDlz+hxDAAMLaOyCpvg0qTTVNjiOAHhv0zGamSYK0eYDh9cVz8SiPyjqyAJ3GxSr3tX1C5ih610aqLL1Drg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrwC/VIlEyb1Tisi7TcZVQOBkpnJ4/9N8b9SLmkplG8=;
 b=muYOoUmtwEgIEobaSZTH8bFbYPAo2jA8vFuhUiIzHa3y6WoeQ64PdFEICntkakzznWcQX9bdAUyo9KR0vbmppGV7+3eWBAKva9PqaeDcs5fa42PpdISYkhgkLC3GxidvkJvtEK1020VBFgs3GRHLLylcLfl69zbE2NpNmSjWWm8=
Received: from DUZP191CA0030.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::19)
 by AM9PR08MB5905.eurprd08.prod.outlook.com (2603:10a6:20b:282::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 14:49:38 +0000
Received: from DU2PEPF00028D0E.eurprd03.prod.outlook.com
 (2603:10a6:10:4f8:cafe::6e) by DUZP191CA0030.outlook.office365.com
 (2603:10a6:10:4f8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 14:49:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D0E.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Tue, 28 Jul 2026 14:49:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMWGh34TvTVwYCslMJ0kKm7lIWOgadltNHgsZyCQF2G7YhNfRgP2JUezzmFywZcPAViK3NNLn5CewEI7LaEMxgQ9hTa2OV9KELhPE1J/rxrb/oaogsroyQBz2kHMIQ/GoRbZzCaMW/EEySjCl/PNDM/FuiDA9cCfcyuk29BmHPNl63XWbrpbCcEW0+qhnYzqDC+YfrewjKK+abh/+G+P+3GIivE+zdOZOcODRFCKeKVX6+SqPAjmj/iQaZV37x+2TB55qV4N57hnPcpSmyfrBuzbk2HD74F48c4FLnyQilLMsub4cKrS3UChdgx4kJzdLDsPNbAqGi32ugVg1Nc4Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrwC/VIlEyb1Tisi7TcZVQOBkpnJ4/9N8b9SLmkplG8=;
 b=Zf+4PJdWXEftXJLlDZFD9mtLh/HmRk0rkiPBKYK7D8z9ouB3r81lOQq+SAbky2SBQ6KxSrpqqfOhdVTFzDM5XhIOuxN1j8IS7PCSzSBjjUb3M7W+573jaxdz8kY7ChdL+AcU/3Ryrn5mXAbGOLebhY2SX6csoTmlxxu/FuWNxn6YlGbhdKRSoFNgp2ReJWIyrhl8hmZcyzKD0zO/7ksNz6P4dxzX+I9uu1Z8ta9Ww29Upy77J+YrSVQPUemlBlNyPblhijjVqtcQ3Uucsg1+yrMIbL/Q173yuhtyuQZqybjEyZr2qqQkqugdsva/Dreg3W/+dt5aUPJPOJNgYyd3Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrwC/VIlEyb1Tisi7TcZVQOBkpnJ4/9N8b9SLmkplG8=;
 b=muYOoUmtwEgIEobaSZTH8bFbYPAo2jA8vFuhUiIzHa3y6WoeQ64PdFEICntkakzznWcQX9bdAUyo9KR0vbmppGV7+3eWBAKva9PqaeDcs5fa42PpdISYkhgkLC3GxidvkJvtEK1020VBFgs3GRHLLylcLfl69zbE2NpNmSjWWm8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com (2603:10a6:803:80::16)
 by AM9PR08MB5908.eurprd08.prod.outlook.com (2603:10a6:20b:283::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 14:48:35 +0000
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4]) by VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4%3]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 14:48:35 +0000
Message-ID: <eb7e1543-1599-4d58-875c-ec2b2bff778f@arm.com>
Date: Tue, 28 Jul 2026 15:48:34 +0100
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@arm.com, linux-perf-users@vger.kernel.org,
 damon@lists.linux.dev, bpf@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH RFC 01/11] mm: introduce hw_pte_t for PTE table storage
To: sashiko-reviews@lists.linux.dev
References: <20260727164715.2866609-1-usama.anjum@arm.com>
 <20260727164715.2866609-2-usama.anjum@arm.com>
 <20260727165824.0377C1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@arm.com>
In-Reply-To: <20260727165824.0377C1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0615.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::17) To VI1PR08MB3421.eurprd08.prod.outlook.com
 (2603:10a6:803:80::16)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3421:EE_|AM9PR08MB5908:EE_|DU2PEPF00028D0E:EE_|AM9PR08MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: c196e69d-e428-4ba1-f1be-08deecb77298
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|10067099003|11063799006|4143699003|6133799003|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 sV3zbvLaqjqG6dom3Gp91uoha3PwtCEthywwPY2iDwBbMVF/A58V5nGsW17bRW8kfMFUE4ROoVg90YSvX/Z+/sKcgzQNNFfULLrDt8W+eXywSC8w9yIWJF3BRpKdInDInHroC866Kbv6CVTYBw5c6W6s103C6Nt82JgnRluQsy7T97uDqSXnfd4g9keBYsT4wgFo+CP7rbPclQr6yEjb845MtWB5tJarATzAAMhXGYajzGIFzp6BI4KLaAS3vTBjF8ojVmbmEMYDKb2LKc7b+VnY8lqvGIsmnOZmK2S7nQF/R4sVGqd8HoL6Va+WDgpF1H5PnPLd0ehjWu4SQXQfd74Q8O0xpgcmaBi8mxMfx7Dwu5UJLWou7JSdYfCQvhLPp+BE7hmHdyz+Vc7JwkiBK8WtUM9VVDlUJvEWaXvisCmWTcp96IsfGGyb0u/TEVma+SVTTVjQJ/DVkqz+b7eIenHL8vRn/FlTgnQl70sToblZTV1GhKqMww+NS7DZ5vv0X6NQEv5clWUeBANLqoHLLxBoTp3eqTElA75hG+fZBnRQY5bZWlsZucDqVa7sTt+C6cfDx+id9su9eQ2nvaZCMW0P18UMg3+BKUe6MLqoh6/5357a0NwtqTHyCqm1C26BvZD7b/BaRUj+rMW6xtgpp5lgm3oCHqx2GB9m27+xcTQ=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3421.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(11063799006)(4143699003)(6133799003)(56012099006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 G2QCW6D28HW5CuPmUza9hmT7FjGE/P8L2zLpAkpxKIpRYHb0QYyo0J9XS/j+JTMNxBQeXzFw/dMyr1fFVJ9ujMSCm4+NV3TVVdDB9BITHG5zh9WTjmumByNIMvu8koRt8bXmWp4/e4gZBzb2dRBKD+hUYD5hsPwMrMkgvxf1yx2hpDCenY7WPGiMStdkSGbZPN76nfb57Slv2reyGWfaGcAf0xIPQt7+r4Jl5UUIr3/4Vd7sgPx2okyKoh10G0a47MF31PZNRdj5EaE4dobQQN201fWJaxxJVdaQLEQnMiRMlefjbLEHAZwzBqQRYSXaRVahBLOHQuFC8ocwRZmV2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5908
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	217ee18f-0aab-4363-5fa9-08deecb74d78
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|35042699022|1800799024|14060799003|36860700016|82310400026|376014|10067099003|11063799006|4143699003|6133799003|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1uoT26N9FuSGLXTYmXSjYu2xc28ja5I7hln57wwCnkd6CZWgQl50B/fBiXtTyQQMYsLkqjtjt3lnLfc3bzbhsHI1n+EpNibOCGuyQ90Oq6wpatkO78oOQPuscEWvpxmCv01nNAl1p5iYnOEXwkT9rdVET2uaw9gOqPuqZ3lDBX0AY+PiKQSlBo5unZKyGYLKkcV2SiHLc4yK9SAOis2ga8qHe7yNBjHwViIcC8/Hx/7nkVLjEtjucesLyldsL9Vrls5GRprDIUq0OfEfqRH8k1YR0tk3VXqI1VgKDNscITE9Ns5AiDVzzYUxnyaE6nVj1exNfUKvBWW44wry/glIOwaeTbor2bD9omtXRkHgkba499M8i7+mED2MDu/6O4t7GuSDpOp08wenm6dt7guB+4aW9+0FXV/PzBdP1YvHR2CZJ3+UzE/uSzkuks71bOCQLrzKFkF7mJiU04VcK9crPOz5kSvpLKyQojFIkUhWWLmq2xpXKSwLj+9NJ8scVh8imUU6K6MlF9i8SeevcZ9Br92vuctMl2UoeHLfsNIpLnHYr83ALwhu2CWM0gQOzt8bU7eK1twJRY0xkPhYbsasWaMorh3ZrXwXIlC4W3C+ehzkumuq9NRECSMs1KA9BaHG/uFWOH5PD6YTWhJTIVRKGvDLG2fQAiFp9cV+b97Wr5oTjRaY3wb411IYxgv1YS6qKJosF0WZMmI8itT/E28NlQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(35042699022)(1800799024)(14060799003)(36860700016)(82310400026)(376014)(10067099003)(11063799006)(4143699003)(6133799003)(56012099006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4vg/3N5zhqH5RfRS8PyQZ00MONmlhr4NujHibeMjCXHAXZEdi49+mcriabCC7x5Lba5f/i+2IxO9vZq58N55yFUjiz1oJ2GHqyhjli9TsMdA2mnGXBuN4WAUrdoRQARmIIRNv7MMYsRZnT7Gog6nXWWugQvWaSMwv9NGq0lref+5hZUy59hq7FzUSBWt8s4SFT7UOUei1AT1sd5Tq02+8ejEYUoeK3JTGmOofG/cPy9fZ/KY83AGY1FAZBZHkZajA+QcWgD5+17tnzbHpssFmA7b/eiypnAhsejpu+04rKuAhhwzIZHzbl8Z2spyJIr/+YQCyflHLw0aY9eLQgr9XancdzN/duECI8EX3MP+vKnBiO2x1HBu6SeSC5uF3V0nozf+rVfRHuhBz7JdrE9Dq/o7mRdpe6KnZlnOKB641TDL0R/rv/UdcQLWQtB0HSjM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 14:49:37.7998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c196e69d-e428-4ba1-f1be-08deecb77298
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5905

On 27/07/2026 5:58 pm, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The header `<linux/pgtable_types.h>` incorrectly assumes `<asm=
/page.h>` universally defines `pte_t` and architecture opt-ins, leading to =
missing types on x86 and a structural inclusion hazard for opting in.
> --
>
> --- Patch [1]: [PATCH RFC 01/11] mm: introduce hw_pte_t for PTE table sto=
rage ---
> commit de503ea03294c1c9976ce045b5e820dbc0f34eba
> Author: Muhammad Usama Anjum <usama.anjum@arm.com>
>
> mm: introduce hw_pte_t for PTE table storage
>
> This commit introduces hw_pte_t as a generic name for a PTE table element=
.
> It defines it as an alias of pte_t by default, allowing architectures to
> retain their existing representation until they opt in to a distinct type=
.
>
>> diff --git a/include/linux/pgtable_types.h b/include/linux/pgtable_types=
.h
>> new file mode 100644
>> index 0000000000000..ed5dba42a4f8c
>> --- /dev/null
>> +++ b/include/linux/pgtable_types.h
>> @@ -0,0 +1,11 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_PGTABLE_TYPES_H
>> +#define _LINUX_PGTABLE_TYPES_H
>> +
>> +#include <asm/page.h>
>> +
>> +#ifndef __HAVE_ARCH_HW_PTE_T
>> +#define hw_pte_t pte_t
>> +#endif
>
> [Severity: Medium]
> Is <asm/page.h> guaranteed to define pte_t on all architectures before it=
 is
> used here?
>
> On x86, pte_t is defined in <asm/pgtable_types.h>, which is not included =
by
> <asm/page.h>. This means pte_t might not be defined when the default hw_p=
te_t
> alias is created.
No. The commit message was imprecise here. hw_pte_t is defined as a macro a=
lias.
pte_t does not need to be defined when this macro is defined; it only needs=
 to
be defined where hw_pte_t is expanded. The current x86 consumers make pte_t
visible through <asm/pgtable_types.h> before expanding hw_pte_t.

>
> Could this also create an inclusion hazard for architectures opting in?
>
> If x86 were to opt into hw_pte_t by defining __HAVE_ARCH_HW_PTE_T in
> <asm/pgtable_types.h>, any files including <linux/pgtable_types.h> first =
would
> incorrectly alias hw_pte_t to pte_t. When <asm/pgtable_types.h> is
> subsequently included, its explicit definition of hw_pte_t would macro-ex=
pand
> to a conflicting redefinition of pte_t, breaking the build.
An architecture opting in must make both __HAVE_ARCH_HW_PTE_T and hw_pte_t =
visible
before the generic fallback is processed. Arm64 does this through asm/page.=
h which
includes asm/pgtable-types.h. A future x86 conversion would have to establi=
sh the
same ordering.

--
Thanks,
Usama

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
