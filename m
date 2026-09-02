Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564284A13AF;
	Wed,  2 Sep 2026 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357821; cv=none; b=btpKzmzcJEPnwlP6o6PQjZhWwILKLrwQmRHHbAD3MeWYrnZtdZJ34Rf5iE17DS1OdVQEj+sZaE82VTwLVJq/vFB88UZXFsoGAaq0bOm42mI9fL0qCCN/YPn/ch4oiAwnzow1wLsVut1QRbeekKakcJ8H8Bvy1o5bvLXkIoGNSiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357821; c=relaxed/simple;
	bh=fxU+kl/M3exfDLzFkdNJVMJXwSy1c6L92KGmpdS7j5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ts6vsmD4z7zINEfaNK9u7TvVak7smBlxiApop5xOfbatXVyBt98w1K2dBULA9QyBs0pQoghyHBYBkRu+dwT6iPmNElaY/mIn1hXVT2IWn31QVpaJ1x3x4oMvYXIz/um5ZGKU7xMHIzil7WrACBzGFKvWXJnJe4ecqBj8ZvLOYKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgwqaSXI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgwqaSXI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C021F00A3D;
	Wed,  2 Sep 2026 14:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788357820;
	bh=PRRcJRQPR3buBmMaDcVwulWeVM6qSbo735r2+CfQnW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RgwqaSXIkQEz1vhxnOdulppt/3ZaMvLIuJSzXNSWE/ZfH967bovgdPQb/0nZnVAG4
	 cfTdVa1PDTrmh1cSX7ZjjiPQ0096HP07TeGLh8/ly6NFcy2N9q/AvlV3H4i7UvVfon
	 /AWvQwkrn+fNg2fSDniyehiKIXpdKiPrpcQ0hQx1FbRcX1ArfliGyazuyQSJXOTbXF
	 I2xcXb3UYH3FGJ7TzxEXEmR3za8dhbaNTrdZYs+E8K/J3OQ1x/nDd84LdqGtOMJM7I
	 BZLtNaIb0ArjuSoJx4HbPtj9H3KG3iyHU4ZC/oWaVz03bmklD+zoMWSVjOGmDAUoFu
	 +27Dy6+sQ87vw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6/6] selftests/damon/sysfs.py: test damon probes
Date: Wed,  2 Sep 2026 07:03:12 -0700
Message-ID: <20260902140313.85983-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902140313.85983-1-sj@kernel.org>
References: <20260902140313.85983-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend sysfs.py to commit DAMON probes via sysfs, and see if it changed
in-kernel DAMON status as expected using drgn.

Signed-off-by: SJ Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.py | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index 159cbeac067f8..66c826189320d 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -319,7 +319,21 @@ def main():
                 intervals_goal=_damon_sysfs.IntervalsGoal(
                     access_bp=400, aggrs=3, min_sample_us=5000,
                     max_sample_us=10000000),
-                update_us=2000000),
+                update_us=2000000,
+                probes=_damon_sysfs.DamonProbes(
+                    probes=[_damon_sysfs.DamonProbe(
+                        weight=42,
+                        filters=_damon_sysfs.DamonFilters(
+                            filters=[
+                                _damon_sysfs.DamonFilter(
+                                    type_='anon',
+                                    matching=True,
+                                    allow=True,
+                                    ),
+                                ]),
+                            ),
+                            ]),
+                    ),
             schemes=[_damon_sysfs.Damos(
                 action='pageout',
                 access_pattern=_damon_sysfs.DamosAccessPattern(
-- 
2.47.3
