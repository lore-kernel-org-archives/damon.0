Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011002.outbound.protection.outlook.com [52.103.1.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3953FAE1A
	for <damon@lists.linux.dev>; Wed,  8 Jul 2026 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.1.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783498097; cv=fail; b=q6bgxhbXq8PSR+/+3EUIzp5MyFPX1I/QNe7P8v79CfzaQNcX4eCCudfBNvZ5dmWlnjue97A4DolGZ5iaFHqzPwo1lMrAGbI9bi2JBa4WBYuvsJQuqJwVtQtKspWkDlsGa17hI5oOnkhqgRXN0Lo204idGcxXyQlxF3BZKfeJZj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783498097; c=relaxed/simple;
	bh=G+lmbjTV7mpu0CTAnP338jRVhHEnEIsdq4wpCjo/A+8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=b3YdJnzT7uiZw1SqFHp7AJ4zEPQZCzKurE7kmui3nEQYtPeFTAJhsqo9NFPY2JR+ZfnsAi8cuU8pW+wqV5o3M/GvtuK2k8s8nCtFDlzl7NXEMU4Km3NNvy8iTPFfTai3JNnVPVCZHn6WGB0DMvpPK5wTS7+eRIbD/SbVqRNveFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=A5rmMcsm; arc=fail smtp.client-ip=52.103.1.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="A5rmMcsm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xUT1S0gEAmeEA19owuQ5lhYqQ0I+W+aIJDev1iceRRFxiokb+Nm7g84k7M20jwxgx5FqBCtQPgO+CO4WZBzlVjFOckrQZ5TEaeP76fSJYgWgE3SqSnUJk76+U0A4ztXoE2zc3YjnqxBYaLMghbR5gv74ajKqRz4eQH3ytqVhyAweBpHgvaoFX4tFMLt0gdPjEm1rnHEUQoJk+sCGFn9KTTJpQ5xrNubyYfKRhhrV4lDhY9ulnTaSm8D8ayHKOFsbkRev7Js27jiAu4Ga7g00Mkj7FM2RCzxCpZnQ9NZUb0+QcmfSlmnUXGnv8vqCP8lTyefLcenvpii1udl3T+n8SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9vu99FBvV3snrIqZFzfRHd3gWh6Dp0UOlms2yOGh3Q=;
 b=YwPi2OGWqAbcI2OZJt2rU795o9QI98THtGJ1pydootOGzH+s/8YXFmuiPrywEuIrNDnbn9kT31J6ZMHXHHdR3LtBFLYuzmj/081sp0Mirqnv9ZXv9JT/4UiSomMFi3A53TsPGfbP+I7TgFxrDoBO+PP2l3G6M699mYEhLrhOTRP6m27CCFWBzHxvuI8CdHLbWWxLk4K2uf5BDncjDyW9hF0AfA885i+KP38AVVAfe9AQtQACThmfvfn+LBOlZzxh4klwYarvRY7s2jHIsudHhEPE+OxP3niIKPrl7BB77Hh71LI8NgwzBxU8qwyaJM5qfGfm0THbyaik8SDuB8VOpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9vu99FBvV3snrIqZFzfRHd3gWh6Dp0UOlms2yOGh3Q=;
 b=A5rmMcsmoMv860bqgsbI5RD1wEV0wKLyylMSW2FkSq8n1U6GO6B1uV3DMxlgOR/Pn0lTEvW1WZL5KChjTkbbktVCFot+JMqlqtVftu8coQwb5J9qA3DZ4q7cmJ8omgF3N233YKzbByhou2kgHSVnH9hkR5mmhNLhOfL9Oom75hvA8saO7NvTNux/quWQWCLwf/8dk3CxoAiulRdYl6xier3pNvzLe4Ox5q5lKlytxxXqNw62tWi3z/ireOGQD8oWiYyQ12vnydpaH0TLql59UKOTRwuhZo7sWjMzJpxybn2+rMmjvpIxLgYDAiR6w2qh1K90aSnPOpY3kt1FE6E+bw==
Received: from BY5PR02MB6642.namprd02.prod.outlook.com (2603:10b6:a03:20c::23)
 by IA0PR02MB9808.namprd02.prod.outlook.com (2603:10b6:208:490::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 08:08:09 +0000
Received: from BY5PR02MB6642.namprd02.prod.outlook.com
 ([fe80::97a8:6e72:40bb:875d]) by BY5PR02MB6642.namprd02.prod.outlook.com
 ([fe80::97a8:6e72:40bb:875d%5]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 08:08:09 +0000
From: zjh <jiahuitry@outlook.com>
To: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: zjh <jiahuitry@outlook.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon: prevent migration fallback to non-target nodes
Date: Wed,  8 Jul 2026 01:07:54 -0700
Message-ID:
 <BY5PR02MB6642F4D1A8BA92BFF3A034B4B5FF2@BY5PR02MB6642.namprd02.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:990:56::19) To BY5PR02MB6642.namprd02.prod.outlook.com
 (2603:10b6:a03:20c::23)
X-Microsoft-Original-Message-ID:
 <20260708080755.19291-1-jiahuitry@outlook.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR02MB6642:EE_|IA0PR02MB9808:EE_
X-MS-Office365-Filtering-Correlation-Id: cc997e2d-499e-4e4b-9299-08dedcc80c57
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrO+2YmbT5jW+WUSUt4IT5vRdGfOu7SFjpgcA8gOlPoQYlu0lY7cIWoD7nCorPQ2juJA/VYm13a7R9Y0DrOPgbWcAbZa0A7fHWGkkrFQYXlrVU9PLx1EyjZ7INyOzTwYcTq6HQBjs4O/st6b3WAIhQNky7cbjOQvN6VgSQO8gnkUVgUQ2v5ytxbWgXMqosPutoosKIa2yPesSIY0HaghNf7vhvR/bujeZVlpeBgcUfckZBiPBd+r0Qa3bk+Wvan4e6vrTL6hNS2YBYG/WJfyo2zF78zqWJir62pQTpFUsnugReAVwvrZXw4mxniQDL2a2iHQUlPEuBr7ljB9xdmxPSLE67gy9kU4Wkk7uz30mVLLoqEOcJ/qhNHriMBF0SpxDGYm4JJdUq89Xr2vYXauyKFQmDv0/07kyNXFlmWr1h+YnfaRVAObEk8hCnAZ/y85q1y/kFUNT/lHzGSqxC/OKIddzaluG4+iRPzqoBJCNSuTyis8nASQhsuc7Qwg4VIr7CY9ia+S1jWwCKxs7d4WB+54toj8IelIwwJK/rGmJYw29ZvyjeQ+ELPB+CqrZ4hp6s9/N9yZdZUEaDYfPRW9i2+iOZTc5EZubrXOmvwjTanyCR+mCMmq7Q7jTXkq8NFvcFU7x6Y32U1A6B69fC9fouK2UcsGc0U11dAa7CB/Iv5oY+dG1I3OOpqNKlrKLYfaKvVvZ4btGsdZt+VfaemHVZGJsMJXs7hOsHWEOrapXOVJ/89u+tGGNbOQNbhwnuo58u8=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|23021999003|24021099003|15080799012|19110799012|8060799015|5072599009|39105399006|5040399003|22141099003|4140399003|40105399003|3430499035|18061999006|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gw2KReQNx7vVsMbTDoUwFogA7fUnvDzwZWojGpbE9mt7JDB3JIwHMlkiGcF2?=
 =?us-ascii?Q?Lh51JN3vuuOkHMS1Ozc9/THd4DVkFXtUV9hsP46V6YoC+a5A8ir9n5mT/FX0?=
 =?us-ascii?Q?X4v4//NYsvqj8awDrTsDIHU3B1G28+9n5SWkz94RBHFC0f4syV7VMSGk1nEI?=
 =?us-ascii?Q?+ps5YuSRQQET9AofFxfrr0EpMs+86Q8j2nq5a2IDA/tzU5Mgai/79nNquy4j?=
 =?us-ascii?Q?3blO0NaGJELcR6o86dYMkQCNEo0LYwVkBa28PhViYisxH5nLnf300UzvjSeR?=
 =?us-ascii?Q?xojbcZvSt4/2W9NFttFU/s7YV97kq59RJ9YFM7EujZoVfCudCOfIEJLHKKVc?=
 =?us-ascii?Q?2Oa/vgLn+SDXtYjCVAb3NF10i8RpTtl2RQm+d9CG2h22s1WTeei7vZoieFOT?=
 =?us-ascii?Q?P46Qb2mkf1aRbQgyyzq+tu+bruS8IigNrnlkNIRVdjMWvnNuPG0vD2a2GNAw?=
 =?us-ascii?Q?R+s6U67q0Wufu8eU9UcNgKufVgyG1OCi/lj3cEa8kwCgVk/KYebVWNBNkWti?=
 =?us-ascii?Q?aisQ2jXlugfvZcVSwftzofSUfSiO8DV1glFO5OK9OOLM/Hgpdt8MkxX5AHOU?=
 =?us-ascii?Q?xZDpYoDYL+MZN8VufHkBeADVzRgPuAcQpkxXL4nt41/X215UVHevZ6rGfLlj?=
 =?us-ascii?Q?Hl8RDPP1QWw0ToyjDspawg7JiC6qOU6UDdYfSp+kIvPQjEpYfWH+uGqGcROy?=
 =?us-ascii?Q?/R8I3ccmeDNw7ZcQKdt/M1cZkBGRP5rPvgfErxwcNCjPgnxIEJ8Ia1ZPkGbw?=
 =?us-ascii?Q?D/ixZWOBoCCVudCsEEYlmypyJzqzh3UWvOc3kHQ9eBAzisyaXrlXYWzXgTKh?=
 =?us-ascii?Q?9bNdGxpiVNHUlhmZxFti9V4ltmHnc8rXdMQWNsRIK+Tyi94QasdiPXBPgwJ1?=
 =?us-ascii?Q?zuF2qEFfNnmtO30WJYTzFaXsPmPGsU10HufeoHtaK+ol5SCZ0DRAobLZ8R1q?=
 =?us-ascii?Q?gJv+YoZqXiW1HbxtlfpS7u8lliyVhnVKbYGhE0l4scG7w0WhIcLHT+d+MvPX?=
 =?us-ascii?Q?AEr8QeJKAnLwIBjWfIxJ16U0wPNx+39MSEEYrW1dL5f/kTc/nDMlkfSJYKhN?=
 =?us-ascii?Q?GuGCA7+D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SMcz3GYZxfDkMrgnszqAhkH/KHx36qA2VYxfB/KAy9PmghgCtO06LD8y4pd7?=
 =?us-ascii?Q?S2n4RcXy4TdY1h9RGKIKnRhlsEwvu1UOWggiBpt6N/eBd/zI3lww02A01nLA?=
 =?us-ascii?Q?fMtpMb1st8zA4uXKHZF+jPnZpNyrMP8tvk2/NdhbU0cDYphnhQJHQ6bq0vgu?=
 =?us-ascii?Q?k0HT0Bvgc1MmyUQwog55Sj5kd6MobCmEiBnjWILY2qUX1XgHa5Vvp7eqkPX5?=
 =?us-ascii?Q?0JQ8MVjsm1hxz7IRCv0IMGWw+qYinvkgfZXSJB8j5RP282qyWTISJPz5RPe7?=
 =?us-ascii?Q?IVRGku2V954LUZ/m+S7hvSj4JspEOgOO6suL+4H5RJveUBKihwefNcAS8aMx?=
 =?us-ascii?Q?EN6SFjq9GcSxy+TvA5gYCYlIBptzfJx1CmixSj0HpSp7rmb0BErXyb1c9Lh+?=
 =?us-ascii?Q?E7wLvyQNJAkKnV1XyM5FsKxicEYQtXtgszI2tLvZljuVkeA5fpybvd8oJND9?=
 =?us-ascii?Q?keh+I8tBwrD8U3OaMNoSfXTvxJEa+Kw4QI/28siK/LqkPRHjvxZrJIDhOozp?=
 =?us-ascii?Q?u88HRIb2RD3ID6iSxYklOZHS6zD1urUjvV/HnJ1SsDplhzx57eZgNSkuckeF?=
 =?us-ascii?Q?aitsXcYEIbzDK9DAvvdB3GbhEnxiARL8zpjjZda2V/xExYZTdb+HbyTNnA5w?=
 =?us-ascii?Q?8PLUkNdRpOh86cl0MILrZunaDg1sHF3GL6ex3CqwOt25s+v4y0mSvbXTkjWU?=
 =?us-ascii?Q?Ig5kljVqaNsdwcDdFseykBCAyktry3fUHBeHp4ZVKtzcu21JrbjUXNWOyxfa?=
 =?us-ascii?Q?G8EiLQCNLYD6iQ6NLTw5KBuC+HUXJAdf6F/pu3WufhGIzn9/tfu8wjd57jvj?=
 =?us-ascii?Q?w4AszjvLVVcBE6uqKu7bWE4rWG/9Q826zMoD/ctAZ27ZjNWKRahx4PYe8bjz?=
 =?us-ascii?Q?jEY+H5oVzl2j5SP6Ewc8akPDZtESykjhTlzDMCxvVRwLm0bZ61DXvlOu9blL?=
 =?us-ascii?Q?f0LyxkECRDYkacyE2ImGeo8DhL9Vl29gy+c4mIUs29lnRo63dL3w8gxNGUxK?=
 =?us-ascii?Q?Hk2JFc3BnhCCr7gl1VNA7bnqRVo5rxTP9JEiyva356R7IOh5VQFhHvZHrqcE?=
 =?us-ascii?Q?mxDKX+lB0exnoBuXGHqrR201w7ND6P9lieqv4Qz27ssyCNR5L7TlwDv+oUrA?=
 =?us-ascii?Q?4TGjy5wuEvrWtw+xptY+DdhPCk+Fb3pJYRhv/UuGYRlc0RKZ1+xp6ysQwxyE?=
 =?us-ascii?Q?DgHaIgx6wphverPYLlchKfbEGJr0QLjjfxA6yqtzxXtZW63+b4eHgtmQxQri?=
 =?us-ascii?Q?yU+4cCzh/j4HrEuvvJscRNsTEg+GBzVuh6T56u01mH0dQZSyeQ50sngBcgpX?=
 =?us-ascii?Q?5KhI/jZT7yWeclPysnJXMgtDFw3Dy3+jPxO7miWQzKsZ/ltOCD6J7wobSX51?=
 =?us-ascii?Q?tPvGoVgHbrKFemxKF5PlrP33XPoH?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc997e2d-499e-4e4b-9299-08dedcc80c57
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6642.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 08:08:09.5185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9808

DAMOS_MIGRATE_{HOT,COLD} passes a target NUMA node to migrate_pages().
But alloc_migration_target() treats mtc->nid as a preferred node unless
__GFP_THISNODE is set.  Hence target allocation can fall back to another
node, and migrate_pages() can report success without placing the folio on
the requested target node.

Make DAMON migration target allocation strict by setting __GFP_THISNODE.
This is consistent with alloc_misplaced_dst_folio() and
alloc_demote_folio(), which also use __GFP_THISNODE for migrations to an
explicit destination node.

Signed-off-by: zjh <jiahuitry@outlook.com>
---
 mm/damon/ops-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 6bdd1cfd3863..d21b106b81ca 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -311,7 +311,7 @@ static unsigned int __damon_migrate_folio_list(
 		 * instead of migrated.
 		 */
 		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
-			__GFP_NOMEMALLOC | GFP_NOWAIT,
+			__GFP_NOMEMALLOC | GFP_NOWAIT | __GFP_THISNODE,
 		.nid = target_nid,
 	};
 

base-commit: 42db70db0bf4f1aa4eac4ddbe121143131b793df
-- 
2.53.0

