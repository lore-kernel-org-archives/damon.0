Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDF7353A65;
	Thu,  2 Jul 2026 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012652; cv=none; b=HK2IvEG4un92uOgaIhTTBQfAq15OlPdAT6ihaFqCy1BTFI356TUu1fr4a6I6dBzGsM+6/S9xhGj3Ye21lHUm9WgcHxX1kCkVMvTBZGAbPxQ6NyeO8Pi5WG0Ehey1Q04Dt1+DayHygXaY88SYIqq0xKmVpWdZW8p/fft49Ms6LT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012652; c=relaxed/simple;
	bh=npR3s53VqU/knNxRjuMPifIX+g4J6zWNMvSfAmCzJoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2dvzmsupGCei7dy+Q0PwgArLZlD+qRghAuRU85aXVJU3OWuohoQe08Wxg1gaeb0Gmy3/6ardmrnfimazpQ1HfE3hd+3cvgspD/tqn/SNTpXnVlsRReJLOKUkucUDV64vMWCtrFH20j7B1komVZKPL+/G7Llf8ltnHuJAW2YTBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvsKJecz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvsKJecz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6D81F00A3A;
	Thu,  2 Jul 2026 17:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783012651;
	bh=PtgVIn45F2jyWQFHDav9RTyiur9MFQyJ2Q0LK1nrhNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LvsKJeczZhsyMy2+rheXejzfiSf/2HuZf6rkTeBbhXrQ7c7hwRZlTqdkXq7JF3m0g
	 tGCHD58OqvlC5nvpswa/fEJjcQx+ngi+RaBqPzMbPeE7z0vL0YFQ9D5vKJwWHql1VS
	 HIZ3QGTnryNhYGcAVGuJiUeZXgOn7dqydv6nBbEBQUUaszEayYxPO6cijTtzeb/Cp1
	 jzKTi9INBZXSnFNseeOLDbtMWD6RHnoWMIavBtmOzKELxCRuHynvzz63E3PJH1W/Al
	 mD2TfDvHmBrrhUnFloVE13qEFhDwjStsA9rcYnVc+HBHyxmMGpVyv6tDoT7WGTHMI0
	 lV2sXmu61o2Yg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 3/3] mm/damon/sysfs-schemes: set probe hits as pseudo moving sums
Date: Thu,  2 Jul 2026 10:17:11 -0700
Message-ID: <20260702171714.88278-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702171714.88278-1-sj@kernel.org>
References: <20260702171714.88278-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface exposes damon_region->probe_hits via probe hit
files.  Because the counters are completed only at the end of the
aggregation interval, users can show incomplete values if they requested
the file content update (update_schemes_tried_regions command) in the
middle of an aggregation interval.  Set the value as the pseudo moving
sum value of the counter, similar to that for nr_accesses.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index dbf2b0515d582..32f495a96b17a 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -110,7 +110,8 @@ static int damos_sysfs_probes_add_dirs(struct damos_sysfs_probes *probes,
 		struct damos_sysfs_probe *sys_probe;
 		int err;
 
-		sys_probe = damos_sysfs_probe_alloc(region->probe_hits[i]);
+		sys_probe = damos_sysfs_probe_alloc(
+				damon_probe_hits_mvsum(i, region, ctx));
 		if (!sys_probe) {
 			damos_sysfs_probes_rm_dirs(probes);
 			return -ENOMEM;
-- 
2.47.3
