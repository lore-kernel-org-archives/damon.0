Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AF133438F;
	Sat,  7 Mar 2026 19:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772912963; cv=none; b=KbRqhPLPi8QdIP6LyIjg9hOcAAtS45O+qd2MNXgTNQBcIAoQ8cUFsndijW5rJmLXWfj+Sxj/QQsjZjFcJ1WHoK3qXoW/uYw1F0bQA8tL+lYc7/YkiR8kkHG0w3MChKEHmPrehab81nRhRdpx+/jlcP+p+SSBw6qf5t/tB/SOJYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772912963; c=relaxed/simple;
	bh=OtrKrhHbMS6GUq0Sgqh0AHIPZbCzyKkgoS3Ue4fyc6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ghka41twAzWIzv0domCXPzKSd+4IVYw918CeCnftdLH+NBs4qSc1RxG4BYQok+glUu40nk89ovYpU4TP3mxpAR6yqm3KJAq9ULx2mfrl7CbP6adS0dHfpRiyAsdlXIXg0sS6aOyzWkm8sXFMzC///+/p2/5At8jKUIeDkQ+QKp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PskDigiN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PskDigiN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CDDC2BCAF;
	Sat,  7 Mar 2026 19:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772912963;
	bh=OtrKrhHbMS6GUq0Sgqh0AHIPZbCzyKkgoS3Ue4fyc6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PskDigiNybIdsVjKPIaaT46RjG8CG/QpBCHY83fnwV4RI2agMJJLQNVxw5B70ZI/p
	 Hdgh90iIOArfgAFCwLU359T/DsTiFFZC52miEsz+JlE1RYpjtZA6guHv24fWB8B0Vd
	 PlRln5R3CxwV99oGaI1VVJg6mLxgtsDg6nIdK9I3ATBivnKX/P6F3hJ0n9m1XAzdgW
	 ByUAmaJ4/xKt3G1aivavVwZAZvol/JgwKP1qkphm0dQdxPJXVXrswYLHf8MS64OTZg
	 NfDXIocfEBPXBwB9bgN35T0cYXlBBa4T4HItwC7q2KTlRoFfJj6F4NAjP8tfblxCBI
	 oDqkN6aUhW72g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/3] mm/damon/core: use time_before() for next_apply_sis
Date: Sat,  7 Mar 2026 11:49:13 -0800
Message-ID: <20260307194915.203169-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260307194915.203169-1-sj@kernel.org>
References: <20260307194915.203169-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_ctx->passed_sample_intervals and damos->next_apply_sis are
unsigned long, and compared via normal comparison operators.  It is
unsafe from overflow.  Use time_before(), which is safe from overflow
when correctly used, instead.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index c4c30824465ee..4ede733a94cc0 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2095,7 +2095,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 	damon_for_each_scheme(s, c) {
 		struct damos_quota *quota = &s->quota;
 
-		if (c->passed_sample_intervals < s->next_apply_sis)
+		if (time_before(c->passed_sample_intervals, s->next_apply_sis))
 			continue;
 
 		if (!s->wmarks.activated)
@@ -2453,7 +2453,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 	bool has_schemes_to_apply = false;
 
 	damon_for_each_scheme(s, c) {
-		if (c->passed_sample_intervals < s->next_apply_sis)
+		if (time_before(c->passed_sample_intervals, s->next_apply_sis))
 			continue;
 
 		if (!s->wmarks.activated)
@@ -2477,7 +2477,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 	}
 
 	damon_for_each_scheme(s, c) {
-		if (c->passed_sample_intervals < s->next_apply_sis)
+		if (time_before(c->passed_sample_intervals, s->next_apply_sis))
 			continue;
 		damos_walk_complete(c, s);
 		damos_set_next_apply_sis(s, c);
-- 
2.47.3
