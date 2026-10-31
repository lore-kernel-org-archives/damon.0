Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793478383;
	b=jfg+u3ZzqYeRGuJXF+N5zltpA2ATc5TDTzo4Cs35jX5zC46cQw007flnO0UEa1UZoeCs
	 kGo337091smwhh4EYSeiSN+riOYjIGPi/z+cm0+3MUFlskYtuzLltSyBFIsqJsVuU/Ssw
	 rY72YuLz4D3ov/s8HZKwtzKDYx9t34/RDCVKOJHpdpRWuMLEv284+kY4YlB1/+jmzz0SH
	 GFZwa/t+Wx0jQIV2Jskcdm8qi28361+BwTxendfXSzUmygIbS7JfvoryDv96FBkBsnPio
	 m54aBILh5jlYwrajwPTPsaN9HuC2YqBofgH8YuutWK3SKBxb78cRZqHIRlwmVebLfYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793478383;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qzYWdZOqtsRFb3ngZK/C1CAHvUR8f0Jk0wMaxETN/S8=;
	b=V3SPDe1G2pOTcwYfy/iNqaErr9fgnJdY9V25qNliMrKW/B9yBFc4a0FdZOsdHPTDSmsT
	 qLRQ2hQEbkYcvp1CHlHg0f9Ir2fOTq3NlSUwUq+xdAlbeKJVtD/z0QJGib0d7nsZF4/Xn
	 ERgiQEu8TtPQVwL//zey+38OjuJSWWUhsSJLDaR/O0kj7smCmOC9EY/IvOqX0VFKPtZb5
	 DE5JIiL8l2cUNq/eYAYuZeLA2OfuUJbRpPUyV7yeTLK9AdOKClYJepmWekgqWEpxTfAUf
	 k5q4hZs3j2ZU1imz/WtCZkfHienkERmhCzLMN8Fe3emY/g1h3VcJIRTVKgQqGRZ3hNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dXuiWQid;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFF6606A31D;
	Sat, 31 Oct 2026 20:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dXuiWQid
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745481F0093A;
	Sat, 31 Oct 2026 20:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793478382;
	bh=qzYWdZOqtsRFb3ngZK/C1CAHvUR8f0Jk0wMaxETN/S8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dXuiWQidxV4GKs1te2r8gQmqYhcV1FaR1jedExIalifCzD4YoA7zD4x7ducE94Zbx
	 VSXw9pzJ0MtbNE57AWdEBBEm8j/4qxd9wLxHgBMsq4y4TVvwXgvCBMyLTztCngesZv
	 xGmqDr6Z36wN5ZxnpHhCmCK5Tgwhlr4RB9izoTQCYt5RMEGFAQh3IU4Kv6SQn1Fw7c
	 mA9n/ivt7TW+YNqdRqEY7YNIJq5KXI+I/o7/UF9fRxEc+oXkJnmvshRnGrlDSXAIRc
	 /Jd15eCnt6ozjqwsV9gLsRfKGG3SwX2f4cZL6hWZ41zm6/SYuXfvFkWeKN88R2q1/S
	 RRtvmySP98taQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/6] mm/damon/core: handle invalid target in damos_fix_stale_charge_pointers()
Date: Sat, 31 Oct 2026 13:26:08 -0700
Message-ID: <20261031202614.96036-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261031202614.96036-1-sj@kernel.org>
References: <20261031202614.96036-1-sj@kernel.org>
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

The fixup of DAMOS quota charge pointers
(damos->charge_{target,addr}_from) for removed targets and regions is
done in damos_fix_stale_charge_pointers().  A similar fixup for invalid
(terminated pid) targets is done in kdamond_apply_schemes().  Having
similar fixups in different places only make it confusing to read the
code.  Consolidate the fixups into damos_fix_stale_charge_pointers().

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 73b571b429cb3..ce75db510a9d3 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3394,7 +3394,11 @@ static void damos_fix_stale_charge_pointers(struct damon_ctx *c,
 		return;
 	damon_for_each_target(t, c) {
 		if (t == quota->charge_target_from) {
-			if (damon_nr_regions(t) > 0)
+			bool valid_target = true;
+
+			if (c->ops.target_valid && !c->ops.target_valid(t))
+				valid_target = false;
+			if (valid_target && damon_nr_regions(t) > 0)
 				return;
 			break;
 		}
@@ -3513,15 +3517,8 @@ static noinline_for_stack void kdamond_apply_schemes(struct damon_ctx *c)
 	max_region_sz = damon_region_sz_limit(c);
 	mutex_lock(&c->walk_control_lock);
 	damon_for_each_target(t, c) {
-		if (c->ops.target_valid && c->ops.target_valid(t) == false) {
-			damon_for_each_scheme(s, c) {
-				if (s->quota.charge_target_from != t)
-					continue;
-				s->quota.charge_target_from = NULL;
-				s->quota.charge_addr_from = 0;
-			}
+		if (c->ops.target_valid && c->ops.target_valid(t) == false)
 			continue;
-		}
 		damos_apply_target(c, t, max_region_sz);
 	}
 
-- 
2.47.3
