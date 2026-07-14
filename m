Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010020.outbound.protection.outlook.com [52.103.20.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D1E3655F6
	for <damon@lists.linux.dev>; Tue, 14 Jul 2026 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025516; cv=fail; b=p+CDsbOepYvVVYO91uQYcr2DG/MTCVWbjpIfwBrWENmVEQmfm8UG2BRmkaYFMRxUsNgHXeyYZ8N6Hmjq5zQ6NVVZPmplGJUcG1o9/aiY9Exh1kRGUR75KN5KAV1lYC/0+/B+iwm2RfdIedCKX+ED5E/lM5B1LV6tIgJ12S6jo30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025516; c=relaxed/simple;
	bh=KppsS1/vASPIYol5L+ZxF71QzgM89c4pASWCdpbRsLg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ol3Jjnphju6OD6w44lBYRvBsFCvmfxdSnVBrPmLCcele1DZqKsfd4T6ATS0w1lMioPtug9wWSXWIvHt3BmhV7joTb28jI2kBauPGgGliyxA3womXOkUpeaZvVv7fZSgsOxzx6GhJ4kejwK/6svDP7UvTXHrIfC+A8/s7NiAyA6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=UlJ1ynfF; arc=fail smtp.client-ip=52.103.20.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="UlJ1ynfF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pd5ebEufunjxOUKGwP2xfucVIc2kXTmY4E8yhrY0/NX8bMaKB9mVAwqM3kBf4B1+n5zlBLPF8u0oWqP3RQOfnGJF67dlb2wqEgeJ/tKWROZaFnYhNfZ7rIzaZ+DFgxA5NNAhorGLZcpZ6f1RNTyJX1PbXz4onVbhBgehVuNOjHOf9sr4ClbV116Zkq94T/TtzT7gVWjVc4gMbpvNSl0P1TlAwEtLjEkZAGRrIwUjmQr5IoqIbB/DEYG6cmW93Hivu6PvyqKg8pb27RpvZ5oe1F+4R/qlRFl6o6zBYE9Xk02BKFTDqyXPJK787eUHWBlYxQVkSI1vg5y+1Pysx2k+CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZecRdooQoYjT0RHRxZcXf8wdDg/u9kOsgNcQQ/EQofk=;
 b=JlQN8o2wioYh8amO78fzMoOZbis5Rd/KXaCabxRNrJMMP6RTufuudyzhqcmtgO9UNjjFJOyxtCBt/hFjtJSkMXmN5e3G3UCAo+ojsgGEYIHzzzNaUATfn4cPWF1cjLssBTSYdLx9ND4iAwCEqdKotVJ5USvgfeHXW6mIb/lzycsvk1Oz8wHcTzvfbnDeh5IiC1EYEXqhmGY1TU+fUUq14GPTmTM374cvUoBSTjf/FCjZKFwQS4BRZgD+yK+Lwqf8b4S2hGp7jUZaH4M/UGVrNeSSaeubry4x6eZVXTzvWhJozldbSjKvSDDz4IOfdDxBqYBICeGDu+vXCtZdRh4KVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZecRdooQoYjT0RHRxZcXf8wdDg/u9kOsgNcQQ/EQofk=;
 b=UlJ1ynfFVhHMntR/MvjR7vS2x5DNdxMjzrWq/d7vZEiK/sQmD357va/Asi34G6oNnsNmSsuYhjMOOBBsFseDMjdLagRBIUT+PPTKlzTH/zzLP+G0OpqE9/VxjTs/F28ZFUUwQwxYI4rmtRYxnCao377SSdkOWBj4Gns9iSXJ/O3t2RUdo29rrOc8sTo2yUIB2sRLOPMdbIrux22TFPzYKyXkkkrNIht6CTSEsFdN+aO2ux93TU2I7TYkMjzxHKQZCeGWM3xaIgt4/EmBkn7JCs03mP44v5hrHthAU+FLIuZW4b31weGlRM1mIN5YBvn7fGTJCuDeterLBh02PlpjJA==
Received: from MN2PR02MB6654.namprd02.prod.outlook.com (2603:10b6:208:1de::19)
 by DM6PR02MB6812.namprd02.prod.outlook.com (2603:10b6:5:213::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Tue, 14 Jul
 2026 10:38:32 +0000
Received: from MN2PR02MB6654.namprd02.prod.outlook.com
 ([fe80::a150:49b2:4042:3050]) by MN2PR02MB6654.namprd02.prod.outlook.com
 ([fe80::a150:49b2:4042:3050%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 10:38:32 +0000
From: Jiahui Zhang <jiahuitry@outlook.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Honggyu Kim <honggyu.kim@sk.com>,
	Jiahui Zhang <jiahuitry@outlook.com>
Subject: [PATCH v2] mm/damon/ops-common: prevent migration fallback to non-target nodes
Date: Tue, 14 Jul 2026 03:38:17 -0700
Message-ID:
 <MN2PR02MB665479119535A1235D69F125B5F92@MN2PR02MB6654.namprd02.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KUZPR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:d10:31::11) To MN2PR02MB6654.namprd02.prod.outlook.com
 (2603:10b6:208:1de::19)
X-Microsoft-Original-Message-ID:
 <20260714103817.68080-1-jiahuitry@outlook.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR02MB6654:EE_|DM6PR02MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: 213820b4-e7fc-4b2c-9515-08dee1940cab
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25010399006|23021999003|24021099003|5072599009|51005399006|8060799015|19110799012|5062599005|15080799012|18061999006|12091999003|4302099013|3412199025|440099028|10035399007|40105399003|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DQCrsa7fjP9BfoOO9/kDeiMx4MEid7fpEkymdBA93UMQMNLYeGtSpyOEVGIa?=
 =?us-ascii?Q?W4NeucdkJ0QHnIa8WHLeJ89FDf10LDUwLHCl46vddftfXBIXX/LDhjjzaD1V?=
 =?us-ascii?Q?MU+b4xjicc3SAoG5xEDfUemYq29t05XE3LIRV2f55zpzih2NEQ2Ww9JPFuhP?=
 =?us-ascii?Q?DVVxtveBtgjgf4XiSbXltf7Ji1uOOjpA4PGU0CPrg2iuVMtqy1EnpSn/20qB?=
 =?us-ascii?Q?IROQCyzs/7EkxYBaKVGCBP227bFDsNhY1S/jQYRip0oFl/pxPfkJbo33mx8q?=
 =?us-ascii?Q?F2795grCGMV4PM2Cmx89spDpYjBkencPbP5oBsilzdG2vuHiCnKVl/DnmuM9?=
 =?us-ascii?Q?NYEffvp82s+mUiRm3I/N/B2lr92hkueNFcE0qfLy/WPtmvlCRJ87FC2vACRS?=
 =?us-ascii?Q?Dgk5J3cAlMa1QHOrT/9ndhCF0y137v9Ypw3lw0KQjfuE+FqsuN4phlZoE5P4?=
 =?us-ascii?Q?kzI0zlnRFslPjTXPyZoo2t10fBsO+ugDSD7XqYTzj2SL2z6E9cc+7SH1XQwY?=
 =?us-ascii?Q?LbsS5Uv5Yt5NoCkJzKuT2svWWIrnjMlTtBJPCBtmQRRJ3MRGmujC8Gtm+Gmy?=
 =?us-ascii?Q?4da8MmzxDM0aR+kasGp4MEFRfHJkhveWEbngaBkA1gO+rd+JMS0eSZfUDVSM?=
 =?us-ascii?Q?BNpZvTaKztVdvL2xJ/bCok34gzbU9CpsOgUcv9j45Cdta5VPVu47RfkO2B+/?=
 =?us-ascii?Q?c+/Wsopqa4ExbOovOSVPREBj6Vgj4PtvD+0cev7Iqg+yGtATgq2JTB+B4myO?=
 =?us-ascii?Q?0XYFlOI+QpjK4BJZnf4IwByOBzQ/EpIAAQnKLmdnEABTje6xs7xPcElt3BfX?=
 =?us-ascii?Q?THrA4/IwxkhIEuftRgyYDqvcV5JFfhN2U9MoSsqLKar0Fpu5ov+2D6fr96fw?=
 =?us-ascii?Q?8aGGUK8k0MxdayjYEaIhqx2xGGtq8ZM5mBXqhHDEWjUPr++zJlWxdqMhIKjv?=
 =?us-ascii?Q?9NLubycAVX756EDsAgfFVWYhQq76hFUHxpcb0KP9Gev1dhr+6+cd7J9l0T/u?=
 =?us-ascii?Q?RNX5ngoKcPTcy5xxfdy737pcz0rvo1KedGNL9vd3b09ACjPATMaS7S8Os3rr?=
 =?us-ascii?Q?dSiRe6dg+uiaQBtZ3Qbs8OL6+pVmY0wePefFcYOS9Jov5i6kKqU=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z0c+v1BNJpSUBoBNrDoivXQz8A2yzyPDPsJBnuz2fsSXUMwLEHdPwJ560+dc?=
 =?us-ascii?Q?e+NGxBhhwC9dOrGtvBv+3Pxb+JOcWla8dRk5Wy8ksI4KLMFA0foGggfSg4M8?=
 =?us-ascii?Q?t+c54cPmyxJBqE2f5ZQKdwBeFLXRPzdjQwQDrQn6X0niXPmxw0825hbri8QW?=
 =?us-ascii?Q?UMVCLAHbjEjncRih6AExrFQ5cJjxAsd36cNmxzyOMSSLClat2QGrrz09t6UT?=
 =?us-ascii?Q?LOvg0JLT1TgnEhcRMXj7euhWTjbv07SdAd+XMKwk3kC8ufoK9SStTp8FfzWH?=
 =?us-ascii?Q?hXUFWYTNQ5BvRp2fCfj/GiZjKC/L/a9I+kfPK3X2GyrEOWBYWrjJKanwd98P?=
 =?us-ascii?Q?2bLo5wTcPlKDKptTBeo32k5VHtA/3nj+IFEM2Yt6qaa/mc90jcQ6vKDAPu3H?=
 =?us-ascii?Q?6V1heQcY0ph5Snw6hOGjClRyC7Hbk3jYKFJkuruZ4D1HUJvyaRtSsBPFi9zW?=
 =?us-ascii?Q?bAmIVG6w2WPJoP8IZxCNBdq81XBQazj/lcKjFokm4631utzP5NnoRVRsYYK8?=
 =?us-ascii?Q?+iLJJLmHQltqGk1fhoBARes09Qk1Dzq5kosxixgO2SieLRO0Wwywxv/MFiiK?=
 =?us-ascii?Q?K7rqD6g+/8lKDmj9LwtvjlUpo/UVfCUD75wz7ZsAz//PCMj2QeA4vFw4dCJp?=
 =?us-ascii?Q?kODnvFV/7ZX7+t+DgDuqvD8GMML3Hw+ImRfU/GgnMNI5eb6Q5mQBfqDO/QQz?=
 =?us-ascii?Q?jl/Z6yMY3TKz+fnCw19tdKO/GhTdnP0oRKAGaEaESpgDstX5p5dkey481AwG?=
 =?us-ascii?Q?54+fKKr9YbIpLtMjr7TEOOLHOY6kv/shI6BtJBnpaaJ7beEyt+f2Th1zT3Y/?=
 =?us-ascii?Q?AsV8nbxFSqYGu1eiSQZ2dJuMgZIDC+v8PSMvvuwhVtleGtMmgB6nRXYfpscI?=
 =?us-ascii?Q?353e59rrtw/M3ZwQbhnDnCEqA36J//qunjUr8R3J30XMr2EEg3t1urkw2FsH?=
 =?us-ascii?Q?UlLUqMiPN/AiyEUqlwBGQrWU4Ng9cTKIHYmt92EliCRKpiiQHGZ1AxtZdbhg?=
 =?us-ascii?Q?oKbQkWknaKV2/tSZbEwrQ10dpmah/GdifKwGYLSXO2pIMrAchTl1HH0vAKdZ?=
 =?us-ascii?Q?cfpTRtyoyaQ/EkNKCfWGDJrghlIFrCRuhgENkDS7mps8enfdMxlRjSrnPclP?=
 =?us-ascii?Q?NV37nVmfqkjSASyKiSzqVzJTtxL0DxJGNKvBtq5rgDblWN9cy94ra+nz1fwt?=
 =?us-ascii?Q?rxzHXPT/8CfwX1PtrIJVzDBgDLCsFRaUa02116giXxJLuR/CrLzgn88BR/NJ?=
 =?us-ascii?Q?DEriHqHXaJiTKAW+ZhbOYJApt9stcm0/MIJUTihwlzV1Ngyld38+frGUH1aE?=
 =?us-ascii?Q?OnSYEHti+NaBT4w2z/yl+IsNe3vJUARjwqCkSBoULYhq8E6cT240w4nMN7my?=
 =?us-ascii?Q?5UMk5QsDf4itc8MdpEEDjmIvlN6U?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 213820b4-e7fc-4b2c-9515-08dee1940cab
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB6654.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 10:38:32.8281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6812

DAMOS_MIGRATE_{HOT,COLD} passes a target NUMA node to migrate_pages().
But alloc_migration_target() only treats mtc->nid as a preferred node
unless __GFP_THISNODE is set.  Hence target allocation can fall back
to another node, and migrate_pages() can report success without placing
the folio on the requested target node.

Consider a two-node tiered system where node 0 is a fast tier and node 1
is a CPU-less slow tier such as CXL memory, and the user wants to promote
hot regions from node 1 to node 0 with a command like:

  sudo damo start --ops vaddr --target_pid ${workload_pid} \
      --damos_action migrate_hot 0 \
      --damos_access_rate 70% max

Without the __GFP_THISNODE flag, when the memory allocator finds that
node 0 is nearly full, it can fall back to node 1 without waking up
kswapd.  Then the pages allocated for migrate_pages() are still on node 1,
and the regions that are expected to be promoted to node 0 are only moved
to different physical pages on node 1.

Meanwhile, both the mm_migrate_pages tracepoint and DAMOS's own
sz_applied statistics (reported via the damos_stat_after_apply_interval
tracepoint) show the migrations as successful, which makes the failure
practically invisible and hard to investigate.

Running a demotion-purpose DAMOS scheme alongside the promotion scheme
does not fully avoid this either. If demotion cannot keep up with the
promotion rate, allocation can still fall back to node 1 during
promotion, and the same misleading statistics show up.

Make DAMON's migration target allocation strict by setting
__GFP_THISNODE, so that a failed allocation on the target node is
reported as a failure instead of silently landing on a different node.
This is consistent with alloc_misplaced_dst_folio(), alloc_demote_folio(),
and with do_move_pages_to_node(), which all use __GFP_THISNODE for
migrations to an explicit destination node.

Signed-off-by: Jiahui Zhang <jiahuitry@outlook.com>
---
Changes since v1:
- Use the mm/damon/ops-common subject prefix.
- Describe the observed misleading migration accounting and how strict
  target-node allocation resolves it.
- Use the formal author name.
- No functional/code change from v1
- Link to v1: https://lore.kernel.org/damon/BY5PR02MB6642F4D1A8BA92BFF3A034B4B5FF2@BY5PR02MB6642.namprd02.prod.outlook.com/

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
 
-- 
2.53.0

