Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794957790;
	b=XmZQewsvePgAV1o3rn/O8a3CHLnou6vp0I8mAshTbuxFkwKZ7ZpXIrp8Af6G/RKySXIp
	 sc861IjedI2d1Lrl8upvxzKJ6Fhcro9QKejKEr4PnfITlW97zD6inM9+wDEGxaQ/RGWK7
	 9Hw0hSqWc2hH8ReQI/XRwVNZMpcDzBPRFHlqF2u6S1sqMpvEd4qHCs/pA81zHe9uPL0I1
	 4hF/H0ukjkYUgJ/cyIOhcL5slpghh85X/FqXbcDvW1ny6meQzyqG1coNyPmnS/ajMmGtO
	 tB+/EN1gcJo5M/854nVXifvt4uy3fZL/jwbG3YCkk+eP5zZDno0PZAl8r8tpBbNasGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794957790;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1JBagyXxECIQ4yhDUegePc/CqbsWLNLNpVx2YFp7Whg=;
	b=4rz94AvWcGqQwnc0HJZd8jSDxspTSWv9jcWJjdO2BI/I13V7ThCSZvqivlgLuSYSIz0u
	 THSsgtIbe5zGJm3h7gwVFe5vZsRtXM+EBMZfQC0h0Ntx1Vh3bEGWFCCCNqs5hy8av+dNM
	 9IZrxjn2iFzFeknfsmISRWT58jB+/sDNUj/RYZP+WhdzH/r4YJoSPs0VS4DehcMpB2w1z
	 g88lhtptBB0GLH5YTDuV1L44XSL5GNJpn4rfyY8JNhrCZwjl0kyayXsUzyJKxoHOi4EsA
	 LGVLndua7y+Xq311S7r0QNJY+IwuTKrucCU5cqZc/v7imwp+y+kty0E3A5sxjkKAqFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UOjGdaBm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30812606A881;
	Tue, 17 Nov 2026 23:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UOjGdaBm
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794957790;
	b=vfBerCRycTHxFKfN/0pumBYSq4j7o+cYUIcp0tB534h96w90GsEg4IkDam6tKkUCYdjY
	 8gVpvwBw7e1Pd0dL0Yrodonc6Es9DAt8HjS1Ng7tU9RmwjYgshSIlDPb7vSH/wE5eOR3T
	 dZn9QLW2H+wvBXZbHkDMo3plE9qH7tNWk6CG4qQCmT8/BW6aS/5n/qAOwNPpmN6MHVI2c
	 sSzHBLg5eXZMd0033TJCNjcS1VzCETLDuK/DAEje8BNrrKJ+x019knEzj8gnmlD+lD+Mb
	 I254xYi7bzIwCatzmH5euWlT2oxH4oosg9KJ1uLdtaiLVoAUEO8YlttH5u6henRTLgw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794957790;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1JBagyXxECIQ4yhDUegePc/CqbsWLNLNpVx2YFp7Whg=;
	b=wnuOuHyob9nadjW4I9twHDaPpruui2fhhY17/5GNU+9mVkbAImf2dhdGTZ/2hqdCnwcy
	 QDX/rlK9fzZkuKUO2PM4/ZoaF0U/IjTHHgJgXdE7nDCgMh0EfSxrF0yImmB7/8XqaAvxG
	 SXdhKfPulFiYmkxu0Vq6h+Fj/Wu5IjgKtPa6ADugDN6KDc0D7JrlcsCjKzFMqceIM4gje
	 84saTEKNhH20n/sTNpS3Cn9K4hRjSPvfy6y6MB726PyV7Sb5dx+WAlQKH5rBpx6AiRlLa
	 NqKtmOqRNr3mknDEQi6D2aSG5SIxFN25xjWUhLt1n30+zoPLSBcMidrsDuH3nc7n9cQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 427221F000C5;
	Tue, 17 Nov 2026 23:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794957789;
	bh=1JBagyXxECIQ4yhDUegePc/CqbsWLNLNpVx2YFp7Whg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=UOjGdaBmWkKDubE4UImOKArvPgd4DJKRCJJKYCj/tIZ7SPA/mfFVt+ZAYA1kOGkas
	 rZYJl4avTMnmQ92L8q4EUlW0hP20N8WVtESuCRExbvP82EMUM4/kVqihVH40AW0He4
	 N8SZ2uOGSu3MNlnkXnZEmPwvICV7NrId7AXm817LWH4+bjp/QP5UW2lFUb1Mui0uTS
	 Lig/3OifZ6DyReRtPlYhmfhSIO0S4mX1s1rM5PeZ5pye/mfRAXLbZyRvQY2byUipno
	 dTSh+eF0eOuRq/s0YztzetsapjU6b0URUQUBaAckTu1Pi89245lny4Glaif3ymtkxy
	 /lUWoLb5tVprQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AEB3D4AB1F;
	Tue, 17 Nov 2026 23:23:07 +0000 (UTC)
From: Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org>
Date: Tue, 17 Nov 2026 23:22:15 +0000
Subject: [PATCH v2 1/6] mm/damon/core: introduce sz_ops_filter_passed_last
 stat
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261117-damon-sz-ops-b4-v2-1-439888fa04ac@uber.com>
References: <20261117-damon-sz-ops-b4-v2-0-439888fa04ac@uber.com>
In-Reply-To: <20261117-damon-sz-ops-b4-v2-0-439888fa04ac@uber.com>
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Mattathias Pinchover <mattathias.pinchover@uber.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794957787; l=3175;
 i=mattathias.pinchover@uber.com; s=20261113; h=from:subject:message-id;
 bh=+LoR4vjeWULTWq1HaaBRt0DI5bIP4EpokrffEX6bIPk=;
 b=nBOXKM5iPHzAj1ILlavDb0aAPQuMN5r9fq6LxK9NPV9D0KILcoJdEjHVCvjtqFuCMeHpD2Iz3
 5fo28ZEQAffC0GPmCeQNqzhchoE13xkTJZ+AmSmLam4X2MVtIQhMIDL
X-Developer-Key: i=mattathias.pinchover@uber.com; a=ed25519;
 pk=6Bh6OEwWiU6dpON0CVcoipq8fXtEgvhsM1Tmm9CTmtY=
X-Endpoint-Received: by B4 Relay for mattathias.pinchover@uber.com/20261113
 with auth_id=1515
X-Original-From: Mattathias Pinchover <mattathias.pinchover@uber.com>
Reply-To: mattathias.pinchover@uber.com
Content-Transfer-Encoding: 7bit

From: Mattathias Pinchover <mattathias.pinchover@uber.com>

DAMOS stat sz_ops_filter_passed shows the total bytes that passed
operations layer-handled DAMOS filters, accumulated from the beginning of
the scheme's execution.  Users who want the amount for only the latest
apply interval, e.g., the size of a workload's anonymous memory that is
cold as of now, need to keep the previous values in user space and
compute the difference with the help of nr_snapshots.  Because
nr_snapshots is increased once per target per apply interval, the
computation is complicated and error-prone, especially for contexts
having multiple targets.

Introduce a new DAMOS stat, sz_ops_filter_passed_last.  It is
updated at the end of each apply interval of the scheme with the amount
of sz_ops_filter_passed increase in the interval.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>
---
 include/linux/damon.h | 6 ++++++
 mm/damon/core.c       | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 06bd92981af2..3aff5c525132 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -351,6 +351,9 @@ struct damos_watermarks {
  * @sz_applied:	Total size of regions that the scheme is applied.
  * @sz_ops_filter_passed:
  *		Total bytes that passed ops layer-handled DAMOS filters.
+ * @sz_ops_filter_passed_last:
+ *		Bytes that passed ops layer-handled DAMOS filters in the last
+ *		apply interval.
  * @qt_exceeds: Total number of times the quota of the scheme has exceeded.
  * @nr_snapshots:
  *		Total number of DAMON snapshots that the scheme is completely
@@ -379,6 +382,7 @@ struct damos_stat {
 	unsigned long nr_applied;
 	unsigned long sz_applied;
 	unsigned long sz_ops_filter_passed;
+	unsigned long sz_ops_filter_passed_last;
 	unsigned long qt_exceeds;
 	unsigned long nr_snapshots;
 };
@@ -578,6 +582,8 @@ struct damos {
 	 * @action
 	 */
 	unsigned long next_apply_sis;
+	/* @stat.sz_ops_filter_passed at the start of the current apply interval */
+	unsigned long sz_ops_filter_passed_at_start;
 	/* informs if ongoing DAMOS walk for this scheme is finished */
 	bool walk_completed;
 	/*
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0a056949604f..6af3309691d4 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -769,6 +769,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	 * or damon_attrs are updated.
 	 */
 	scheme->next_apply_sis = 0;
+	scheme->sz_ops_filter_passed_at_start = 0;
 	scheme->walk_completed = false;
 	INIT_LIST_HEAD(&scheme->core_filters);
 	INIT_LIST_HEAD(&scheme->ops_filters);
@@ -3533,6 +3534,10 @@ static noinline_for_stack void kdamond_apply_schemes(struct damon_ctx *c)
 		if (time_before(c->passed_sample_intervals, s->next_apply_sis))
 			continue;
 		damos_walk_complete(c, s);
+		s->stat.sz_ops_filter_passed_last =
+			s->stat.sz_ops_filter_passed -
+			s->sz_ops_filter_passed_at_start;
+		s->sz_ops_filter_passed_at_start = s->stat.sz_ops_filter_passed;
 		damos_set_next_apply_sis(s, c);
 		s->last_applied = NULL;
 		damos_trace_stat(c, s);

-- 
2.54.0-uber3


