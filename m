Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8682282F3F;
	Tue, 14 Jul 2026 04:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784003685; cv=none; b=hnDWePTbMrG0P57Yq5pE9OP284EIEk4xnAGuth+LNOjgOmL2M7Qbc+wkurJvWEQYRv3bSvva1lwYkA0uQb86RdrfG86tz0MAU2zRqUbw0fmVyzEafTfBUWfN4iZvChX3n3ExgTKkRRWpS00BCwGm+CwMTtDPDH2A5rFT/l1Sfx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784003685; c=relaxed/simple;
	bh=0jpvCqL7eB2QWrQVfr7eucpCsgZNYXbbp9++ZbaE9zY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGw9VjY0f4qERj/mIPYaBWOMIv9WWzBnKt6kSDhiBYXaRPjz6kjH7hodjoYxDSNaP/9cVMd82Jmh1ymD14Ppytwciosa+r1kDWR/jpy8h4tZq7t+BcMcwC3PWcn6+JGqg6/WUPb6Pa6qhnbi70hmqNKLR4mAKOo/K+x5jATbahw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6rhddFD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6rhddFD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1E61F00A3E;
	Tue, 14 Jul 2026 04:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784003683;
	bh=t7iohU0bRHpxYfrt1uYJsO4LZsUO4rQ7qDj6JMCliOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H6rhddFDBSHl5rXZDmtp+PojItc9qKc77bnnk0cj/InyI6o4pze5UI2MghTcB65W7
	 Et626zfv5Sds66otGHGHRt5PmTkFfJUS5Yr2aRSKHlko/qLJlnI8j2MAW7OwPcBFsd
	 OscnW0Qn61K1JW+fcp8oUOvce76B1W+LS7Q6EDF/q68Bk9fmDzMde4qrYKnmYB0mDz
	 X3SPBBcz5k4vcdIh3c0bog/EVCbAq1YmDQxbGsDAUlqdH67jh7fTQG0JtNkBgSwOgu
	 4IwBMeTzU6C/cVMisbQJ/XtdVOGZwFrQngNC0/rACP2BD9wel8OljuswH2VOcfrN/D
	 1PdyFca7MfXiQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 04/10] mm/damon/core: hide private damos_quota fields
Date: Mon, 13 Jul 2026 21:34:30 -0700
Message-ID: <20260714043437.95811-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714043437.95811-1-sj@kernel.org>
References: <20260714043437.95811-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_quota->goals is intended to be used by only the DAMON core layer.
But it is mistakenly not marked as private.  Mark as private.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index d838cc27ee72a..bd024b89adfa3 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -228,7 +228,6 @@ enum damos_quota_goal_tuner {
  * @reset_interval:	Charge reset interval in milliseconds.
  * @ms:			Maximum milliseconds that the scheme can use.
  * @sz:			Maximum bytes of memory that the action can be applied.
- * @goals:		Head of quota tuning goals (&damos_quota_goal) list.
  * @goal_tuner:		Goal-based @esz tuning algorithm to use.
  * @esz:		Effective size quota in bytes.
  * @fail_charge_num:	Failed regions charge rate numerator.
@@ -255,7 +254,7 @@ enum damos_quota_goal_tuner {
  * the scheme's action.  DAMON then compares it against &sz and uses smaller
  * one as the effective quota.
  *
- * If @goals is not empty, DAMON calculates yet another size quota based on the
+ * If goals is not empty, DAMON calculates yet another size quota based on the
  * goals using its internal feedback loop algorithm, for every @reset_interval.
  * Then, if the new size quota is smaller than the effective quota, it uses the
  * new size quota as the effective quota.
@@ -276,7 +275,7 @@ struct damos_quota {
 	unsigned long reset_interval;
 	unsigned long ms;
 	unsigned long sz;
-	struct list_head goals;
+
 	enum damos_quota_goal_tuner goal_tuner;
 	unsigned long esz;
 
@@ -288,6 +287,8 @@ struct damos_quota {
 	unsigned int weight_age;
 
 /* private: */
+	/* Head of quota tuning goals (&damos_quota_goal) list. */
+	struct list_head goals;
 	/* For throughput estimation */
 	unsigned long total_charged_sz;
 	unsigned long total_charged_ns;
-- 
2.47.3
