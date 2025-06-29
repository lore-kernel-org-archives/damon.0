Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246B023D2BB;
	Sun, 29 Jun 2025 20:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751228091; cv=none; b=hzxQq6GVSP/UxszuIz3vz5vhkstEvIo5XPWnHNaumJEodLowWhhWAwQf86HXzeJhgVrBLtgKheNS9ai59vgY73IptLy+u4XG/rwgAeYw98NL3pHjjzdv2r5Zeucw00WSfGb5CXhrgCS9JJJfqesCTD8J2vRYYHidc9FaIANiX2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751228091; c=relaxed/simple;
	bh=ChHDm1fhhH9qTucGJ/qQGn2czoRDZDNS8D5pXkMCn7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oFpgAQYtctzcGLMcLzq3LeXl4b6TxFpy0oJLBziO1DOlHGvu4J5cmgunTEa74eNefZ9z3Ym32lqgL4ybMQsKcsaUqHDiiR1uPrH/6q1rS9z8ZgJk9XcJ4tr3Ais7E/NtBFt4g8cIy+q0ySs0U0PS6SMGK8AAnS5Hto9+nTuKicI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqjPXFTW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqjPXFTW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A9DC4CEEB;
	Sun, 29 Jun 2025 20:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751228090;
	bh=ChHDm1fhhH9qTucGJ/qQGn2czoRDZDNS8D5pXkMCn7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZqjPXFTWPDbcblMOIE6Sgw4srJbWNmKY2Il9NivI2Tb8cpHUU4kevV6PPYG2gZXZj
	 iKnY3I38jvznAq/K6WkB1KEKsGwiSFiSe3afTclE7IUa6Xz/YZhgs/U/kRCY5zSKYw
	 3xz7vbdJFcrJNJaGLo/Y9/KmUP/ScbI5gmqcwGWjSiaXvBG3N7vjnFSXiR8HYoyu9I
	 f4ar1rWG5ov/UaTQCKlFQyjXXN6z5ND98qheqQZdJ9WlCpVqkt+gyRpB38RWWEPq01
	 Zj0FDQfsAaohsspYSZBq7cH5BCZQgwHChxCihwRLqVJr1yCUCDQc6+UGN42Nq7tI6x
	 mm/0Ys99QncmQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 4/6] mm/damon/vaddr: impleement eligible_report() callback
Date: Sun, 29 Jun 2025 13:14:41 -0700
Message-Id: <20250629201443.52569-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250629201443.52569-1-sj@kernel.org>
References: <20250629201443.52569-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For [f]vaddr DAMON ops, access reports for virtual address space of a
process that different from that for a given DAMON target shouldn't be
used.  Implement an eligible_report() callback for [f]vaddr that does
the check.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 46554e49a478..9970f95585ed 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -610,6 +610,12 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
 	return max_nr_accesses;
 }
 
+static bool damon_va_eligible_report(struct damon_access_report *report,
+		struct damon_target *t)
+{
+	return report->pid == t->pid;
+}
+
 /*
  * Functions for the target validity check and cleanup
  */
@@ -710,6 +716,7 @@ static int __init damon_va_initcall(void)
 		.update = damon_va_update,
 		.prepare_access_checks = damon_va_prepare_access_checks,
 		.check_accesses = damon_va_check_accesses,
+		.eligible_report = damon_va_eligible_report,
 		.target_valid = damon_va_target_valid,
 		.cleanup = NULL,
 		.apply_scheme = damon_va_apply_scheme,
-- 
2.39.5
