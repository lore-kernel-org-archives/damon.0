Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795892442;
	b=vcnDzCa54vXaQresvELi4IPQ46NaBEovCxoM9eK/pXuyKlCmKxVmAReskRi1Awo7YFgG
	 hhA6TY7ZaHK0lYAZDS+nhoyQrDZE1hD6P4+sn7Ez4B7ls/IwyPWSaOTPE4aZA4+WNYLAb
	 TPYyp1M3RDuZUGkLTV+2Ja+rS8KZDceGGFcXPRkv9AhAnJZz076G2Znqcegz1Mtr48uk+
	 AErDrIMIBaNZXOBWen2aZyz3CsBJe2meccanE35JurBR5K8aFMzUExjj68CknieqyUin7
	 BHeyXUcUgk42zRa+WDqV42Cx8EU1S5s4Rhwmz8vs2Af4n7sjP8AKAkXYwxVEHTgkblA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795892442;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ACRfM9U2ztel2rfr1ksCVqjT/nvZz93T+KydwhCu9s8=;
	b=EclfZEgrut72PPE7wLnkh1NMPIl2wF51qluzd+YvqQVRJEKbvWhXok75OxNp0bXLEiCp
	 cMZSV6P3umlnjz0MIgb3p552jm2CEm650Yuf6fNqNUBRkmK+2msW/pBG5xSwQaGK+GXl3
	 Fa6fb+dXJ3F+1G1sY8Ll0Wa72U4pToQxll9GZdzT2J/H72wj400OJRToXt8ZV3+Yg5A11
	 FSvvJSu9CEW4f0xS26szohyPEP5bgTIMzJgqEExMSpCf+ApvEwzwkN+4lHEFKE2Ll8oFx
	 fZYa5Sk2l0kleb7U5MVO95fxA0t1U5ss5zenZjPW3JU0XG4IIYryvLoeyS9SE9P+zJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NpoUtUQU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB27606A31C
	for <damon@lists.linux.dev>; Sat, 28 Nov 2026 19:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NpoUtUQU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF1F1F00898;
	Sat, 28 Nov 2026 19:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795892442;
	bh=ACRfM9U2ztel2rfr1ksCVqjT/nvZz93T+KydwhCu9s8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NpoUtUQUtONK+0EqloPJhm0DOt7JDhjPzyu5bZElCzL/cc2rooz2HbeTebaazPcRO
	 w3zNyXKu6kqdHwj20sG0cXWX10qs+hL3hCZCGthhIxS5bP75LyzujHmyo8aMMRbMpj
	 4SLQPhxxtxkLPw7B2NpqOwWgGmz9+ZQ1AD1/sFMRaJb3S6cZkGJym7jVLgJjkxid2f
	 YQEYuNBf25H7iVSFRK3xm975aS+XSgIwQdlGHQBNjUwE1cgy7kx4OWQceBeUcan6Y7
	 dpLN+T/JPENlaWK4C4jEzu+ZFDFjKsv2q6X0txJbA10VEFUvC1gt3/XbfyiSmVrZ+1
	 Um/Alsh/vjH7A==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [RFC PATCH v4 4/7] mm/damon/sysfs-schemes: drop redundant and racy zero target_value check
Date: Sat, 28 Nov 2026 11:00:29 -0800
Message-ID: <20261128190033.164440-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261128190033.164440-1-sj@kernel.org>
References: <20261128190033.164440-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface disallowed zero target_value because it could
result in divide-by-zero in damos_quota_store().  Because similar checks
were duplicated to other DAMON API callers, a patch series that starts
with commit 610c4438fb66 ("mm/damon/core: error
damos_commit_quota_goal() for zero target_value") added a same check in
the core layer central parameters, and dropped redundant checks in
DAMON_LRU_SORT and DAMON_SAMPLIE_MTIER.  It forgot to drop that in the
DAMON sysfs interface.

Now the zero target_value check in DAMON sysfs interface is only
redundant.  Further, it has a time-of-check to time-of-use (toctou) race
with target_value_store().  It can confuse readers to believe [1] the
division-by-zero can still happen.  Drop the redundant and racy check.

[1] https://lore.kernel.org/20261021005234.94107-1-sj@kernel.org

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 750f70f0c31b..b0d07994f6c0 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2917,9 +2917,6 @@ static int damos_sysfs_add_quota_score(
 		struct damos_sysfs_quota_goal *sysfs_goal =
 			sysfs_goals->goals_arr[i];
 
-		if (!sysfs_goal->target_value)
-			continue;
-
 		goal = damos_new_quota_goal(sysfs_goal->metric,
 				sysfs_goal->complement,
 				sysfs_goal->target_value);
-- 
2.47.3
