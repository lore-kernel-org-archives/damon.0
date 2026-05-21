Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023078.outbound.protection.outlook.com [40.107.162.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678E935838E
	for <damon@lists.linux.dev>; Thu, 21 May 2026 20:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779394885; cv=fail; b=tcW1qa71bmr6LVJWmXn0gBS869NH9VCqoXDgYS6iftSiImjqaLHZ3/ttk1PXZbABxC8CdvOxzwkY9X01Ir9xxGp749/LbU1ZO2VHj/rOu5G+a2Zhog+AjxCY02CGsNE6IeQIb6mnE/rwmz469OlQdrcuRifRkex54keomCCKQas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779394885; c=relaxed/simple;
	bh=iSpD8/fobi/QdifUqXa0c7ywpqo2+s5tR3vdl/A73yw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r34XQoy2VEkpkDu0HlYMYsIiSJ1GnuooSg+DiYKj0RpqiriP1T6KE4SHGHf9AOfL+Dcdn/ZXHBGAhSof3asCV925AoF3vkSe7yt/HRUMvedm5uPUdVK1xa64KjHkE6iHM5T2dHcioWLZXdXZJRUYyevOVpo8ctk0Fi4zvOVJGrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lnu.edu.ua; spf=pass smtp.mailfrom=lnu.edu.ua; dkim=pass (1024-bit key) header.d=lnueduua.onmicrosoft.com header.i=@lnueduua.onmicrosoft.com header.b=VIbSKTuL; arc=fail smtp.client-ip=40.107.162.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lnu.edu.ua
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lnu.edu.ua
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lnueduua.onmicrosoft.com header.i=@lnueduua.onmicrosoft.com header.b="VIbSKTuL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cab37G6mfYkN0FEYwNX3Wn7IpWqqvuDYKjURZ1d54XX2iZ5auVoyT0tEYGatvdNZDtDBeEAYE7BTRPqZEveayjYOgbMuJ+lKgSHbHw9E2EDIOHClcuSmfRQdwPL8uZMRIH4/w7wySKGDHEVCBXye5giS2y187EioVfFlHlgdAK0J6Y7WWYUy+JxN/qbmMT3wlj7zmXIIqVNqoHrh8PlLhBW+ZIwZquHajshz1MWPl3Zc/Lwa6uD7kjLy8q7hb0KY2FEr9xSm9qkQWbDbekTGatlu4S+BmpMDAXa2BIGJWrU/JDbS1FhuA4sJcEOkjVTcVJ5SXI1dTpogYF3btrfjdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aUJ0reA4G4VK7j4GC+xEsy8lfJQh34XyjnGk53bKgM=;
 b=WyiPjvASpTiiOAMuLA70zW3Tj2J1MNZ1vuyMm3s/qq2KApABoq5YxhrErs5B4g+qW06Ki1hpTEtXStArC4HApq/3l2nIB/tQs/indLuZXL7W9lxSZCOQn96ZDCMfnt47rOPEy2920ZyfH4uib5IP14Y5qaJ8MyhHbund4Tft9zTrbpKpeS591dP7S/CgRwb9iqYPSyhfCLu/tkCSVmDX4+QPxGnZ74Dk2VEGXEZ4ISDfk8R4oXZnkIAmcKVEzy5WFzLUwfn6N0Z/rZzN9195ptGpQ5JUIKtenxDApDlX9LiB1VdkUCXTGRlv/O9jzwTpeyT9tsSo1kU6A+jyFqUTZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lnu.edu.ua; dmarc=pass action=none header.from=lnu.edu.ua;
 dkim=pass header.d=lnu.edu.ua; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lnueduua.onmicrosoft.com; s=selector2-lnueduua-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aUJ0reA4G4VK7j4GC+xEsy8lfJQh34XyjnGk53bKgM=;
 b=VIbSKTuL6KTTHMyTEVXmLVw8wvKcmqDqasAgt+9l7DgKv01UHEhFSqDWExiILcKDTYZ/Nfj82pF/4l7k1XJAhOPDWDISqcqoqEu+SjcA1TS+pw+TP+nq43QbLP9esg2D8gaDgkpvfwnmc4Z6ctKdNfI+eAobfDdAm4W++Kw9FqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lnu.edu.ua;
Received: from VI0P190MB2524.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:2ca::9)
 by VI1P190MB0655.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:128::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 20:21:21 +0000
Received: from VI0P190MB2524.EURP190.PROD.OUTLOOK.COM
 ([fe80::b775:39dc:b909:e5d0]) by VI0P190MB2524.EURP190.PROD.OUTLOOK.COM
 ([fe80::b775:39dc:b909:e5d0%5]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 20:21:21 +0000
From: Maksym Shcherba <maksym.shcherba@lnu.edu.ua>
To: SeongJae Park <sj@kernel.org>
Cc: Maksym Shcherba <maksym.shcherba@lnu.edu.ua>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 2/2] Docs/admin-guide/mm/damon/usage: clarify current_value of quota goals
Date: Thu, 21 May 2026 23:20:20 +0300
Message-Id: <20260521202020.126500-3-maksym.shcherba@lnu.edu.ua>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260521202020.126500-1-maksym.shcherba@lnu.edu.ua>
References: <20260521202020.126500-1-maksym.shcherba@lnu.edu.ua>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0021.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::29) To VI0P190MB2524.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:2ca::9)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P190MB2524:EE_|VI1P190MB0655:EE_
X-MS-Office365-Filtering-Correlation-Id: 861386f0-6572-4cef-2a99-08deb77685b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|786006|19092799006|7416014|376014|52116014|10062099007|56012099003|22082099003|18002099003|38350700014|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info:
	4ElwgaFXrYCfSvE4lRHLDTQT1K+YXQfGU25V/kcLzO+OG2LalfP/jYBlQRo5xXFjUtbpQen9o8spWbXvGlWXgXoZMgHDDw0BGekrKfVU0PnU02HT5w/zmeQ7MGOYxW4k4uAtLtx0vXIzQB9evbrCOSoj/wNHDIHmOltmUiZTnp8fuIWA1DyEbiT67eHaI/RDnXQvoMhGs9pwJHJfJOrjlye2lKIYVHGwhYRjNACbxY2KrPtjT2rPfmiowp+YcrUkvpIyrNvC7MNNsxWEKT6OaRVivRCvnumzhjtSOi5FOZt/DndJfhOyydVI64MWb2+MpG92vDDDdWLKL0aeRbQ4/RwwTYUJM0ANOSPN+56M1gV83M8qpbmrRHVw4B0U3CTrdcDG73vxzqBmbh4sCQwD0+V8Sni51swKi/AM6iIWcsH5qc2+LxebUm/F0g47PSWNBjrY0KGBHmdnSnQcJDaTPGWYa6/Mj59+jkDMkiE9bvb857WQ0x1FG3CtsAbvCjDctfL/VHtMmkY6bJKLAmEcLeZiFlEzfU/l/4W+I6e1v0NbKZlGegFam1IzSE306XNn5s5fgLjqnhHqZmgAcz41QNVErx3pCB7I7utBuXGdPeDEtyYrtso+G26r9HY8hs4K84ByM5Bq0N0gvnnUwpxrFzjyeB8O29aT5wgIfpglATtnLM6XN0sJ3inkT027drQxcXc3LCh23guVQOkTxwpwVYFiFazxHnoimF3iidyJg/E47Z20tN0TvUIp8DH4y5Ls
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0P190MB2524.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(786006)(19092799006)(7416014)(376014)(52116014)(10062099007)(56012099003)(22082099003)(18002099003)(38350700014)(3023799007)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AWn8VaEy7Tlx6l2kToYGsLkcpRu9nbq/FBq6zUA0kX8ivFOb7/XJioWWCpcZ?=
 =?us-ascii?Q?HweOTTxgWXQ4jNvsN2BJ8UG8Ats9EsirHQ0z9iaqw4k4wtZmokVvkx+N3pc8?=
 =?us-ascii?Q?6WoaU74Zr6Pnr7N8sBahvdpLND2HAK8sdYq+9ag8SaYi8vpIQx7zNweXF/4x?=
 =?us-ascii?Q?ukCORmxlTHiTxvshQw9bPCnlrsD8i7z2/4kUa4tV6YNj+Ls9vTUN+XwK1ISK?=
 =?us-ascii?Q?mmSm+nqDSf0VgOiPbPuEOuGSvmNhEs6D5XGXNujsAz2N8cWwjEFoQooK5WI/?=
 =?us-ascii?Q?jyvNoO5Ukb/sHnSbclwueIOLhl7NmkrE0pnDuxaln07IL3orldkb56rXDJzN?=
 =?us-ascii?Q?+3CjajJpLZ0w8wlytWfflNaInczAkgk1O/0CCr2/dPyqHPJr/bvNCrqC1QpG?=
 =?us-ascii?Q?Wn0PTa2GylRP9K7ha+n4eujVNOGr6lS0Iq03YS8RZGBxIK2NVwFXoGt0knpp?=
 =?us-ascii?Q?bRQ2NyYpahByyuYtfgvPxSiN/r6PonPoOUUReEPxdO34j/vbg5qK4VC7L5Nb?=
 =?us-ascii?Q?6ufLQjmOCA8wP16vsZEiJ9WUlUG2LdANU3wHDJLLH2CnzUTl3tpSWnDfsSb/?=
 =?us-ascii?Q?hrC0CShlp+JgPfgA+JhDVEXzKw/vXcvB8dcXdLnSgKG9qaaiIXfKMy3hpOic?=
 =?us-ascii?Q?MYifyL+WHC/yt7B8Qn8jYMqVfzhwcJFfLypVjNtu4tI3tKPcMXpq6A9lcWNK?=
 =?us-ascii?Q?kG8Nje/dXaztApBa4EUwiMUJDbL1vb6I+SxGLIn+OErqA32wjqnB18b6ZnQH?=
 =?us-ascii?Q?0HOu0PEWxS5B8p9cY7YG8MdEl4faKpkl7lq1EApVYd3Xd6EXWH2zj7ZZT+GR?=
 =?us-ascii?Q?W2wProN8M2kwZYHSSkzDq71Xhs0FYDpq6j9W+oXony8ytAUqewXPUmuqq+Un?=
 =?us-ascii?Q?o3Rt3QW7/s7B/WVIzRP7pFdXGyhkr2JdLhYS96j+BjZCMWF+zoC+hPrU0d/x?=
 =?us-ascii?Q?stZjnK7cDBGDZfWhgZhpNYMflPA9CbEXFw2jRgUQhuum+U78KcSGMItuZGgu?=
 =?us-ascii?Q?i9u1hbDjTg2xAB3M252A/cp9/tgg5FonVvTfZfaa9FJyqjtuJiBrK3V8gq7h?=
 =?us-ascii?Q?SU2feaE8n3eLHMBk5upgFfB74woF7P11zjdlE87k/rZMdGG2A7tA9D3lk53Y?=
 =?us-ascii?Q?xXCWzOyquHaetByvT004rOWOney5N+W02hVhNGDRh+4b92jY1t1wpAeorcoP?=
 =?us-ascii?Q?fVA24HYDNHu2IKcNXbxg+ecJM8sEJU5DGd90i6E8dR2cVjtkORntI8Yy+WVV?=
 =?us-ascii?Q?zZDE7HksiOcXLtaCSWOIBFXGZc3jSdZVx+et25urCJmhNeUfWKq03etnMavy?=
 =?us-ascii?Q?oZ12XRSMBcF6gkmP2pGfAkoFsJVHDB0l47ZCj7IWYzHo/Oai8SkXDQ6oNgIN?=
 =?us-ascii?Q?B7mQDR0qrNt1JN7LN3WdvIuKg2NygQ5EfLI4wt71K7gWm7H99bA4LAHHDxz5?=
 =?us-ascii?Q?vfdCq7+Zx4hhecnax3LHF8AxK9smlHABTARXTZvrebBHxiyXHpPMw0fW1uX/?=
 =?us-ascii?Q?/zhSGhcE2qIgTqGW4YaW9ddakGbA3DPSGUhaQ4xLoYOXgv8di4qDAHaxEpDz?=
 =?us-ascii?Q?JmQcdIpHJLCLoG3i52mmcvHEYQ78moYaRIeQkeoWUWZPFTzsFr7AQP92Yix/?=
 =?us-ascii?Q?d/br/k1KR8ddhudLVQlz5d8K6H5Y88Zfpf5Abg3jkOANW68ghLLuH0nqhyAg?=
 =?us-ascii?Q?/+JGPNnRbVUagD4RlM1dYgHq8peqWjOmpxjwaEw1l4aM/NP5cRF91/5VEaqx?=
 =?us-ascii?Q?qcX5Cv2vQWk4ui+19pMFG45JgRia1SU=3D?=
X-OriginatorOrg: lnu.edu.ua
X-MS-Exchange-CrossTenant-Network-Message-Id: 861386f0-6572-4cef-2a99-08deb77685b6
X-MS-Exchange-CrossTenant-AuthSource: VI0P190MB2524.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 20:21:21.2219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70a28522-969b-451f-bdb2-abfea3aaa5bf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j8wEtoHAEqt1t3VkI+InFayBJtjbkHz6ATR+s1xClZCWL67oFywktB0NJB7XP9hs7zOyt3k8r3ZF9xrDVsMzC3ZoRpD4CEXGWfTzAvkNGVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P190MB0655

The sysfs interface for DAMON quota goals includes a `current_value` file.
This file is not updated by the kernel and only serves to receive user
input.

Clarify in the documentation that the kernel does not update
`current_value`, and that reading it only has meaning when `target_metric`
is set to `user_input`.

While at it, fix missing commas in the goal files list.

Assisted-by: Antigravity:Gemini-3.1-Pro
Signed-off-by: Maksym Shcherba <maksym.shcherba@lnu.edu.ua>
---
 Documentation/admin-guide/mm/damon/usage.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index e3e2ccab218a..5b85a7a2ddf0 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -511,10 +511,12 @@ to ``N-1``.  Each directory represents each goal and current achievement.
 Among the multiple feedback, the best one is used.
 
 Each goal directory contains five files, namely ``target_metric``,
-``target_value``, ``current_value`` ``nid`` and ``path``.  Users can set and
+``target_value``, ``current_value``, ``nid``, and ``path``.  Users can set and
 get the five parameters for the quota auto-tuning goals that specified on the
 :ref:`design doc <damon_design_damos_quotas_auto_tuning>` by writing to and
-reading from each of the files.  Note that users should further write
+reading from each of the files.  Because the kernel does not update
+``current_value``, reading it only makes sense when ``target_metric`` is
+``user_input``.  Note that users should further write
 ``commit_schemes_quota_goals`` to the ``state`` file of the :ref:`kdamond
 directory <sysfs_kdamond>` to pass the feedback to DAMON.
 
-- 
2.34.1
