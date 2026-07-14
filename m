Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34802737F8;
	Tue, 14 Jul 2026 04:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784003684; cv=none; b=IZwyoNtotW0IzFT13Z8KD1p8JUB8S8e1GHrB87V3G+gdVVo/wVAq1zWuWbE2iv3qnEayB0eS74VCgjfAVpeyY5VX2KlYZzIpRIvqtpf7H27ZW5fVBpTXm0CQ15TM9OZTvoO/6uqad3Zu/QZQDmMbSMVFS5Y8xMUGCkGyqsHzKO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784003684; c=relaxed/simple;
	bh=auZweVBylLMjI8FT8RIyh3Wuk64AJNNXS7HdDEMxPKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rs1m03MXt+DouUJpLt2ZKD9TWzGJ6xdu1oOiS7f71bRHWfDujA/jpQzPaFZX5XWEcOUrVULsrZ07HHqTNBPATGE8RSi3MJJtBBzHJXs6jmpUQGGoIBHG2mgN9A1gbY1ERkrtrWTV56WvJ+UugnQQXr3uryLj6FTFF6sgp+I9KD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUYkN1dy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUYkN1dy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D2E1F00A3F;
	Tue, 14 Jul 2026 04:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784003683;
	bh=0BZxDJkFvulRjFQmRcUYV8xQhtaa1R3auddZnH6jsbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YUYkN1dyAZZVX7GlyawUhpPuUYcxjJtD7mNDEzExlsgDd4Lzuh00cSJ+ITsVT/eQB
	 6jPW6zrcsJ4xnAnhUlxGkI7jSZDm2eJNk6T8EGMom1fxQMpKMfjFUlbThFWHc+yC2k
	 ybl+0eRpOf/YZhEAcqPsXgjhXqYP1Yk65xjc3ThZElPr1qw8ZoJod2ngN2laAtKNWe
	 GaiX450u37uI+T8dCKsgQjKQ4G1oZAjlFQygK57rOODlYtwlPSTJeOuhVYrDpeViab
	 QsqEzegoO8dlsrEVtXuTO4jsBiDMCdpoh9IZvZImOzpVEe7wrrylv5e83j5BEkHayz
	 VYoy9D59OoWHg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 03/10] mm/damon/core: hide private damos_quota_goal fields
Date: Mon, 13 Jul 2026 21:34:29 -0700
Message-ID: <20260714043437.95811-4-sj@kernel.org>
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

'last_psi_total' and 'list' of damos_quota_goal are intended to be used
by only the DAMON core layer.  Those are mistakenly not marked as
private, though.  Mark as private.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 6e160557a0014..d838cc27ee72a 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -175,10 +175,8 @@ enum damos_quota_goal_metric {
  * @metric:		Metric to be used for representing the goal.
  * @target_value:	Target value of @metric to achieve with the tuning.
  * @current_value:	Current value of @metric.
- * @last_psi_total:	Last measured total PSI
  * @nid:		Node id.
  * @memcg_id:		Memcg id.
- * @list:		List head for siblings.
  *
  * Data structure for getting the current score of the quota tuning goal.  The
  * score is calculated by how close @current_value and @target_value are.  Then
@@ -201,12 +199,17 @@ struct damos_quota_goal {
 	unsigned long current_value;
 	/* metric-dependent fields */
 	union {
-		u64 last_psi_total;
 		struct {
 			int nid;
 			u64 memcg_id;
 		};
+/* private: */
+		/* Last measured total PSI */
+		u64 last_psi_total;
+
 	};
+/* private: */
+	/* List head for siblings. */
 	struct list_head list;
 };
 
-- 
2.47.3
