Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F74A55
	for <damon@lists.linux.dev>; Wed,  2 Jul 2025 00:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751414539; cv=none; b=K53kc0lQs+0O/Eq2pq7Hd8/SYtSJdJPIHFZkkh9ccvb62nBVaPppjyRkqdq9fKqObkqWvONNWmeRRpRe0dQbcH+u+G3plIwUzFlKEN3YJ3ZVs9dgTEzY1r7Mj3jpHyDZHAadlan27v0HY606Me/YeAGV6WaT0zl95H93w/EUQQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751414539; c=relaxed/simple;
	bh=kdSX08iCVA1J+J3zXVB7ofjNZ6cIC9SDcQ/VnRgXEu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BI6oI0ZY1T5wTyk+d9zts+zqH/ArATRaqJGTDuGjMn4GXiBJT3y1+6qKXo00qI6nmqE5DMjbUoE+SQXwDhG0mKISs2PcuboppgRTC2JCucM2vUjIotEsv/y3KAzn1J2MvbK5Nr3zvBREAlN+eCSrDtBVMEDsiQfCtJKn3SATbjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-a6-686477017b1c
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 3/4] samples/damon: fix damon sample mtier for start failure
Date: Wed,  2 Jul 2025 09:02:03 +0900
Message-ID: <20250702000205.1921-4-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250702000205.1921-1-honggyu.kim@sk.com>
References: <20250702000205.1921-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsXC9ZZnoS5TeUqGwUUHiznr17BZPPn/m9Xi
	3pr/rBaHv75hsliw8RGjA6vHplWdbB6bPk1i9zgx4zeLx4vNMxk9Pm+SC2CN4rJJSc3JLEst
	0rdL4MrYsr+qYAVHxa9HrxgbGF+wdTFyckgImEjM2j4Jzt7V94ERxGYTUJO48nISUxcjB4eI
	gJXEtB2xXYxcHMwCcxglvr3bxQwSFxbwlzi3KQKknEVAVWLytu1sIGFeATOJ/uvBEBM1JR5v
	/8kOYnMKmEt8bF4NtkkIqGTe4XdgcV4BQYmTM5+wgNjMAvISzVtnM4OskhCYwybx//sCJohB
	khIHV9xgmcDIPwtJzywkPQsYmVYxCmXmleUmZuaY6GVU5mVW6CXn525iBIbksto/0TsYP10I
	PsQowMGoxMN74kpyhhBrYllxZe4hRgkOZiURXj5ZoBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe
	o2/lKUIC6YklqdmpqQWpRTBZJg5OqQbGfral+yZsvT03TZYnmunao+xLMec7vnB3KVy20M1U
	O2+Rzh4TEWmneWIpP98NUfdbLZFSFwx7j613u8rlF6pp+eQ3++eEk87Vq4239N32CIrUa3ph
	tVv3WTZDvH1umdXuujvbplQzsl8ulKpZe9zb8WbZG6metU+ZFr/fsDNh4nNj4zQd1n1KLMUZ
	iYZazEXFiQBjxiXLRQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMLMWRmVeSWpSXmKPExsXCNUNLT5exPCXDYNkmY4s569ewWTz5/5vV
	4vOz18wWh+eeZLW4t+Y/q8Xhr2+YLBZsfMTowO6xaVUnm8emT5PYPU7M+M3i8WLzTEaPb7c9
	PBa/+MDk8XmTXAB7FJdNSmpOZllqkb5dAlfGlv1VBSs4Kn49esXYwPiCrYuRk0NCwERiV98H
	RhCbTUBN4srLSUxdjBwcIgJWEtN2xHYxcnEwC8xhlPj2bhczSFxYwF/i3KYIkHIWAVWJydu2
	s4GEeQXMJPqvB0NM1JR4vP0nO4jNKWAu8bF5NdgmIaCSeYffgcV5BQQlTs58wgJiMwvISzRv
	nc08gZFnFpLULCSpBYxMqxhFMvPKchMzc0z1irMzKvMyK/SS83M3MQKDblntn4k7GL9cdj/E
	KMDBqMTDe+BscoYQa2JZcWXuIUYJDmYlEV4+WaAQb0piZVVqUX58UWlOavEhRmkOFiVxXq/w
	1AQhgfTEktTs1NSC1CKYLBMHp1QDo/7lg+xvnmy68u5RTJBqYU5SUJ3+Mf+pGx96uevean/t
	8ONnUmKfoCfztf38T1c/cPwT9O/0pzkL/1/479E06wlHssIO4wUSq9Q27OloC9quKPCuxSh3
	V/bUtXumXjZZJvB1l8Lueh3X08vbeD89bftZ97BQcuPZC92HzstuX/DY6qW246+luxcqsRRn
	JBpqMRcVJwIAe7oD9jYCAAA=
X-CFilter-Loop: Reflected

The damon_sample_mtier_start() can fail so we must reset the "enable"
parameter to "false" again for proper rollback.

In such cases, setting Y to "enable" then N triggers the similar crash
with mtier because damon sample start failed but the "enable" stays as Y.

Fixes: 82a08bde3cf7 ("samples/damon: implement a DAMON module for memory tiering")
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Cc: stable@vger.kernel.org
---
 samples/damon/mtier.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index 36d2cd933f5a..c94254b77fc9 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -164,8 +164,12 @@ static int damon_sample_mtier_enable_store(
 	if (enable == enabled)
 		return 0;
 
-	if (enable)
-		return damon_sample_mtier_start();
+	if (enable) {
+		err = damon_sample_mtier_start();
+		if (err)
+			enable = false;
+		return err;
+	}
 	damon_sample_mtier_stop();
 	return 0;
 }
-- 
2.34.1

