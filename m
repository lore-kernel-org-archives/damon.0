Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794856222;
	b=c2e2UsbsCjLMx2Q7bHUU3oaKvuhQntZb1gA9tyXnzcJzagEfl5OkaDOR+zY0o04SGZ47
	 C53XE9n9rSN2Py8aj5Cm1vR+ctlCLFm6zMmTe98hoLv6j4uUnZv767LPvUyGEb/kF6nbQ
	 kvNdQpM/XK6L1tMov9Qzwfx4TOXO2/4h7vnKa5vS3U+1ccwFaEKl14ZkbnAweQTR4KIMN
	 WoKaL9Bh5NkG2mtYxWz/q4bTw4N+4QTB7tMVN3RMA5D8USTmF81O1SS9cz7ClHsey8YA+
	 XKn2NCEDCPCmlrU1U8fQafW30NGj8xcqkoFbeFYg9tA2hQEJFikRLyaOg5V+HjeMZ/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794856222;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1JBagyXxECIQ4yhDUegePc/CqbsWLNLNpVx2YFp7Whg=;
	b=el9qxRctSXd1Y0N81vv2NvKzVaMgY/RatfrgLlvBSrN0AQEuuL8VpmqSSXQc3fG/Xnzb
	 VH+Sx23JD/6mk0F+tq2fdktPMQelXI1dYeGIQQm7oY/JZM2VRfwE7SNNOfaLpb1y6aLZy
	 Z1aLaEbZNQlkZpes1qkGzto4XEa15hRA8+6aFXs7wBkBUAL0zc+xjxfreJLsdIALZw8Ca
	 gE06eN7vPVuvmOX8o92TM15EHzF+cqVooeQY1v3GD2cC2b+hl1L/KT9DQ6LF5mTgbY20P
	 46yTqidXLhHgBoD+Yf8303ORk8t+9r/TtNEc5aTiM59Vjieag5MuXHUNrXc58MouM9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="j/ZYHIQJ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BF8606A336;
	Mon, 16 Nov 2026 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j/ZYHIQJ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794856222;
	b=04+VEBHZ2mQ2DcIgAH/Szfnk+D/fK9E8Jt2+iDnZfFsnzy3OC5pdBkYRCa0KuOgflajk
	 fRxYBihRsCEutNRtJCDK/0hmuU0xR3gfkU8KsnbTMWz0n40R1yX++wAELUUD9yCt70Bl5
	 YBsMhTksBwrnou3kiOtPrSyNOg5rfvSK9a5MDjUqIBnlCk2i9tMF2yU87g6Ic2r4TIep/
	 yKPTtw0YjxnWww+nbtV6+DTQrdgAdlZ1zr4ec9yyQpFXchBaLdWAGB6EU8u3fxEc3XCOt
	 PA6xzEWYgKUIGoIuMzP8vhdWm8eP2jwI2KxNIi9gLktY4cgHbhH9w8Gny4krPvbJfhQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794856222;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1JBagyXxECIQ4yhDUegePc/CqbsWLNLNpVx2YFp7Whg=;
	b=aMVLKAl4Vw1ZflzR+vdcSsCzgaAhb3Q9DhD2tO7fiDbozCNmtRjuDktzSlTl8NmVoA+3
	 TmhRzV46oL3S6/4bS+XI7XEXrfSA4nwtLpICQ1YG4cXyEx+jWLa65u6MjAUBZ08RmXhMZ
	 eIkxysZpCF5XWkK5Zp+lyB1zh6Njs4IocCKt61ISCUekWO/cNODefngjjdNO7yrG1utjF
	 4f7hmhzIhiFySV2o9v8VkDyet22Kjpo78gi410uqRm67qzCQcH5jIYy7uDLNREFk9przb
	 ET16G9LnggBcOZG1f9Cwvag4yMHu0V1DrUC2ARH8b9IrOUHU1ZWp3jA8Xp3DQ7lgSNQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DB1771F000C6;
	Mon, 16 Nov 2026 19:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794856222;
	bh=1JBagyXxECIQ4yhDUegePc/CqbsWLNLNpVx2YFp7Whg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=j/ZYHIQJpplTAx6rKU57hXc6CDboNrxyxYGnUAnX8E3eWaVBZfdIPS6kHHL2qhx7y
	 o2riqRtiWKsNRik6lJcpqZs0zvniAUNxoQgRVzx3wllpg+KnZP3oTC/u6JBtxNG2PJ
	 JtS+15kNDmYAe2MnTCgiMEXANS4a0cUFCkQax7GOC7HrWj3NlrBkTKdI5dP3JMb8aK
	 FIMw0f+8Hjwz0Z03urGbvsgufwOnQWYV+IfIGU8zPYgnKoM8pXj+FYwqncGBPiJRzG
	 0kg8kyB/D43/GzDng6EZDS+enJe0+H7eJWP+Eg/1zdFUo7YOOSddVD5+Nh5856M+b8
	 VWKKHWZRMOX9w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 52DA34A582;
	Mon, 16 Nov 2026 19:10:20 +0000 (UTC)
From: Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org>
Date: Mon, 16 Nov 2026 19:10:04 +0000
Subject: [PATCH 1/6] mm/damon/core: introduce sz_ops_filter_passed_last
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
Message-Id: <20261116-damon-sz-ops-b4-v1-1-1cffe7227e6d@uber.com>
References: <20261116-damon-sz-ops-b4-v1-0-1cffe7227e6d@uber.com>
In-Reply-To: <20261116-damon-sz-ops-b4-v1-0-1cffe7227e6d@uber.com>
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Mattathias Pinchover <mattathias.pinchover@uber.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794856219; l=3175;
 i=mattathias.pinchover@uber.com; s=20261113; h=from:subject:message-id;
 bh=+LoR4vjeWULTWq1HaaBRt0DI5bIP4EpokrffEX6bIPk=;
 b=LTou6WHMxnLQienM9yJ0jomHPbYxEh+IIwzgRJywMRzgdUp/Z50xpB4I7QiEoZhPibPGUxjZW
 4n90urIrykDDGR9PBUYhJ6jgH1FvfwjvLCsfiw5Gn6rhgTj4JjBUkUo
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


