Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7737A3E3175;
	Tue, 14 Jul 2026 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039757; cv=none; b=uZHB71Livz2GDeeeYt6tdSyWRmdPNego7XRIutCQvu65EYlUaEiNVZB1uPlnJOYFJahYvPBvPhwqvIJgmusIWjzl1TitJcAlMdC1Ka69c1UNRftWuhPeIB757YaLlz+GnoSCv1nfCE0pPyMBcIl7/MfmAjUcsQ89EK1tlZwUUg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039757; c=relaxed/simple;
	bh=auZweVBylLMjI8FT8RIyh3Wuk64AJNNXS7HdDEMxPKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TE7wxeFjyVfk8CpJrfpfH34gJzrUaTkrKiOoHzp9BjKtSxEeKestrbYkCfwZvRBbz6PLHHWfDF89gcD4IpZJAF91Ekrw73xUac0KswddG+8yA261Vr8corA8hwfwsGV/U5kx/4CG22aOLjxvAhkBjuFFp0ArmOMrQ7uRevIMjNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcUt+/VJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcUt+/VJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2B61F00A3F;
	Tue, 14 Jul 2026 14:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784039756;
	bh=0BZxDJkFvulRjFQmRcUYV8xQhtaa1R3auddZnH6jsbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZcUt+/VJ6EFj791Y85ZWUIaN/TtFMaBjSqNrKxGBZ2RFMCvoXiFbqPTSQx/zBXGfP
	 FPQXGyGYFEYIcNEIKIX0f/Vu8XzUZl6mBdUcLkv0hw8ykxH4ISTxBEP/1Hbl0nm8uw
	 BKJM0EfS9z+7MHCanvB0Eo+cyrgbcPXzbLvuSCdAGpxxBhjgfK6hyDeCWUrG3TlVH1
	 mPlvfa1qSvJyM6VpFxs4+4c3/KR8aHtEdhYEfHk8VMQfSEC5RU75tIHxIwEMmi6utG
	 yJxZ/qpKznAJccN/t/SprI3hpJLXH92yAv+6jDdkbVRzGjDx1oN3Bz71ch4Ug9BEiI
	 A7KDvRIE6fU2w==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 03/10] mm/damon/core: hide private damos_quota_goal fields
Date: Tue, 14 Jul 2026 07:35:36 -0700
Message-ID: <20260714143544.101305-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714143544.101305-1-sj@kernel.org>
References: <20260714143544.101305-1-sj@kernel.org>
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
