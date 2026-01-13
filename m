Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64DF38E5FC
	for <damon@lists.linux.dev>; Tue, 13 Jan 2026 12:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768306671; cv=none; b=TX2+v7doQqtvE7MXidRYxJLrGfkCIJ0eLqjM1sjyLaFmIMUxt+r2rEC9LG8ZNsA1USiHQK5uOzKC51rQNJ63aQlrrR6mk4VYVvPdnibuasT6o4xrZN6kJhzbOoS89WhlQMyqJfHAcdmnKv8Tcvw3BbsdfJJt0bq3ZAFT98uHpKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768306671; c=relaxed/simple;
	bh=a9lunGFCDgBSiPLEKxIXWl6UVZRm4/B1Q/JM/QG68T0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g9WjX+kv4WVUYfpGeu5cS/EUk4SIiF/lW2r7afHsHsVEqteWjaI3UDaBMJsP+IzJMjHjrxfmHR3KyBGUbFQjnZSQySz/KgkbAn3pcOumFzoG2l50GXUEb0BXO2xBVIYu+B3TvoH6g1HwuXdPT7zIIpCrWhXgYZHc7KgtCUKVxCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nxxb/CX0; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nxxb/CX0"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-bd1ce1b35e7so4894195a12.0
        for <damon@lists.linux.dev>; Tue, 13 Jan 2026 04:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768306669; x=1768911469; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z1BJ19WpqYD1cGrRNJBkGK7rANN3Ll2fyIgG6DV0n9k=;
        b=Nxxb/CX0mO4JO+sIsp+qjAw4FvGlXfbHo/A14n4zN1qHCaCXYkMv5dmiTR5sl08mCN
         1qrgXCtjmTDO85J5UH4wqZ9u8JYNJ845NIgg5lEHEqh6ZVPz1oWWDv/xdUpf+WPpFpZS
         WUxyfaxsWcnyxefy1Tc9qWY7MPloeAiuTHsgOSPmTH39O06R6l2i6wcKF2SCXBBKGuEk
         8Nww9Hu4i2WZ8cphljCIdYFENHllc2mC6sRNpr5oBYJsjsGO/2cU1FyAiaAaSLk9feHR
         IlXhCQONCeF2uoqSP3fGHto0MWlYvxA5ePcnotI32+LoNwXFKfir1pgp1Ice2HdrnFk1
         CM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768306669; x=1768911469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1BJ19WpqYD1cGrRNJBkGK7rANN3Ll2fyIgG6DV0n9k=;
        b=k/+wgQuWSBscyMVLIOJXMhV97U7jDijfsELXEuCmYUh7ilytFcNcjPjsmJ/ZmDT6gz
         R8iLHRMqoy6JzNU+OnMDXLurNGkKfEqqa5x7TN1strtAS2Jbuc75QH4gymmyf+EhFSWY
         gN0ikflBiUg+EXEuqJ4dyPqIZaVw0/za8r4cZOhj8U05qCe28+/SX3HpUZYN/Z6weGsX
         3n6Xhwjj323obGesOuSR3VdUAl47yxRqoFMSK0vhiY3MllsWxkfUmfDmrOonll4f6L6d
         wDvqei1MW9UFryk/ox9hvJoZpfzTTut3M0pXASyTGoigaK+hFksu9H3itWxhSHygsJip
         h7Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVraUE329UG89XVtAc8m42ptCbOzatVAUAH+TcHF8NzM1tw1h14i7CTwZdFcuVU8YwRuXXGUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwSo0E9lhvh7ZM6wzvP32c1loOU2kPRz80Pu1gXjMD34ALizB7Z
	KgjbgWan8Qp5LEEgZsCeFeGmkGCZi+gxNnyIdAr92mIMC8TufFBUm2Qm
X-Gm-Gg: AY/fxX6HZ0B5nSu/RszR+jY/+T0tcS1/JoWXypUYqZJu7mI6IMXviZtF9tWzP495DAu
	fz2KW90L1mnkS+OKCnd2JoqgqS4jA3OfZv9RrGSddcEhD62Vg6pza5s1fFuSxMniCuCUHnS4Zdm
	WfNflfc9Qdf0SeKuUC3cbn/kFEvrI7J1qYIpQeGWTO5RoGODz91J5+MvE2uAbMF7H6bRt1z6geV
	ZH4LnlxaJSfB7JLTcyveionn4FtAPK1Nh788ftgI64K9+6x8LRBkInz7wsKgQjP2D6llOifYtdA
	+FuwyqVtv5PdLHn8A7bnYcsJu6+qGccGahERI/XYZFrrHV5KV877QVE6uyZ3+CGS++u3xTu8m65
	K6JqSMsG2l5LBQQmXi5QdRtQZJpsXcp3jujjnt3yI2wqPvkoYvmezeH4pZQK65wy3AoBlDZnvjn
	yOUsaSitqXTMay
X-Google-Smtp-Source: AGHT+IFDGHuU1rsktMeitRsEmdv6U9Stp+W9ykpOAe+ucIUMOfFbW5X58S530CoeThhNa7Kz/23a7A==
X-Received: by 2002:a17:902:f652:b0:2a0:7fa0:7b5c with SMTP id d9443c01a7336-2a3ee4b8e3amr213100705ad.55.1768306668961;
        Tue, 13 Jan 2026 04:17:48 -0800 (PST)
Received: from HP-Note-Host.. ([222.234.91.137])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a3e3c48be5sm202341695ad.30.2026.01.13.04.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 04:17:48 -0800 (PST)
From: JaeJoon Jung <rgbi3307@gmail.com>
To: sj@kernel.org
Cc: JaeJoon Jung <rgbi3307@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	rgbi3307@nate.com
Subject: [PATCH 2/2] mm/damon/core: tunning nr_subregions at the kdamond_split_regions()
Date: Tue, 13 Jan 2026 21:17:30 +0900
Message-ID: <20260113121731.31468-1-rgbi3307@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, DAMON is designed to allow the number of nr_subregions to be
set from minimum of 10 to maximum of 1000.  kdamond_split_regions() splits
the region by setting nr_subregions to 2 or 3.  This splits the region too
narrowly, resulting in an overly wide address sampling range and increased
access determination failures.

Below are the test results for a case where address access determination
succeeded only in the first half of the address region, while failure
occurred in the latter half, when the address region was set to the
[1G, 4G] range.

When there are few nr_regions: (8)

    |--------|--------|---------|-------|-------|-------|-------|
    0        1        2         3       4       5       6       7

   target, nr_regions, addr region [1G, (sample_addr), 4G] nr  age
 --------------------- ----------------------------------- --- ---
TRACE [ 1] t=0, nr=8, [1073741824,(1073742349),1075138560] 20   0
TRACE [ 2] t=0, nr=8, [1075138560,(1075142341),1233899520]  0   0
TRACE [ 3] t=0, nr=8, [1233899520,(1360224040),1515687936]  0   0
TRACE [ 4] t=0, nr=8, [1515687936,(1872615549),2246262784]  0   0
TRACE [ 5] t=0, nr=8, [2246262784,(2294436960),2536173568]  0   0
TRACE [ 6] t=0, nr=8, [2536173568,(2577497080),2748776448]  0   0
TRACE [ 7] t=0, nr=8, [2748776448,(2818332252),3328598016]  0   0
TRACE [ 8] t=0, nr=8, [3328598016,(3553053181),4294967296]  0   0

When determining nr_subregions in kdamond_split_regions(), the number of
nr_subregions is not fixed at 2 or 3, but can be adjusted based on the
number of nr_regions and the sample_interval.

If the number of nr_regions is small, the number of nr_subregions is
increased, and conversely, if the number of nr_regions is large, the
number of nr_subregions is decreased. (Reducing access failures)

As the sample_interval increases, the number of nr_subregions is
increased.  As the sample_interval decreases, the number of
nr_subregions is also reduced. (Reducing system load)

Below is a test result showing that increasing nr_subregions increases
the access determination success rate when the address range is set to
[1G, 4G].

When there are many nr_regions: (16)

    |----|---|----|---|----|----|---|---|---|---|---|---|---|---|
    0    1   2    3   4    5    6   7   8   9                   15

   target, nr_regions, addr region [1G, (sample_addr), 4G] nr  age
 --------------------- ----------------------------------- --- ---
TRACE [ 1] t=0, nr=16, [1073741824,(1073742496),1074819072] 20   4
TRACE [ 2] t=0, nr=16, [1074819072,(1086087568),1396940800]  0   2
TRACE [ 3] t=0, nr=16, [1396940800,(1408406119),1709060096]  0   0
TRACE [ 4] t=0, nr=16, [1709060096,(1718634828),2029752320]  0   0
TRACE [ 5] t=0, nr=16, [2029752320,(2033076942),2147844096]  0   0
TRACE [ 6] t=0, nr=16, [2147844096,(2147870592),2148532224] 20   5
TRACE [ 7] t=0, nr=16, [2148532224,(2163851851),2466242560]  0   0
TRACE [ 8] t=0, nr=16, [2466242560,(2466983182),2786467840]  0   1
TRACE [ 9] t=0, nr=16, [2786467840,(2794755756),3105136640]  0   0
TRACE [10] t=0, nr=16, [3105136640,(3108065434),3221405696]  0   0
TRACE [11] t=0, nr=16, [3221405696,(3221424712),3222261760] 20   4
TRACE [12] t=0, nr=16, [3222261760,(3222269016),3222290432] 13   0
TRACE [13] t=0, nr=16, [3222290432,(3234589365),3542605824]  0   0
TRACE [14] t=0, nr=16, [3542605824,(3551138058),3859030016]  0   0
TRACE [15] t=0, nr=16, [3859030016,(3866123754),4178018304]  0   1
TRACE [16] t=0, nr=16, [4178018304,(4179564176),4294967296]  0   0

Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
---
 mm/damon/core.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index ff9af9d6a788..4bc44c6545a2 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2423,24 +2423,30 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
 {
 	struct damon_target *t;
 	unsigned int nr_regions = 0;
-	static unsigned int last_nr_regions;
-	int nr_subregions = 2;
+	const unsigned int nr_min = ctx->attrs.min_nr_regions;	/*   10 */
+	const unsigned int nr_max = ctx->attrs.max_nr_regions;	/* 1000 */
+	const unsigned long si_min = ctx->attrs.intervals_goal.min_sample_us;
+	unsigned long si = ctx->attrs.sample_interval;
+	int nr_subregions;

 	damon_for_each_target(t, ctx)
 		nr_regions += damon_nr_regions(t);

-	if (nr_regions > ctx->attrs.max_nr_regions / 2)
-		return;
-
-	/* Maybe the middle of the region has different access frequency */
-	if (last_nr_regions == nr_regions &&
-			nr_regions < ctx->attrs.max_nr_regions / 3)
-		nr_subregions = 3;
+	nr_subregions = (nr_regions > nr_min) ?
+			((si > si_min * 100) ? nr_max / 10 : nr_max / 20)
+			: nr_max;
+	/*
+	 * nr_subregions is maximized within the range not exceeding nr_max.
+	 * Increasing nr_subregions minimizes missed address detection.
+	 */
+	while (nr_subregions * nr_regions > nr_max) {
+		nr_subregions -= 4;
+		if (nr_subregions < 2)
+			return;
+	}

 	damon_for_each_target(t, ctx)
 		damon_split_regions_of(t, nr_subregions, ctx->min_sz_region);
-
-	last_nr_regions = nr_regions;
 }

 /*
--
2.43.0

