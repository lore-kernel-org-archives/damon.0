Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12972DEA80;
	Sun, 23 Nov 2025 18:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763923427; cv=none; b=Bi/9NLcYYcJ/uNjBywN/klElv5Q8u139TfWI8Pe+0F6Fa6dgtjLgmcV/TnlzhfRhAN5ET94cFXGp1Oykn8OooV1O6ZeQZm44lRIAFqcBM3Qc6QH5sTvtuaS1Q6KuOzXtSnPj+77hXM3Q+wIfMJlo5pFIKq8bCxcllSR3aUPtzh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763923427; c=relaxed/simple;
	bh=dyfJoVaMw2se3otvFoArpX9pnB7yY+god8b9Qd1MKC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DtOj20pt8cKaSBhOiAAvVoK8hfYCFLyPIxOMgrSGtSDdr7zm8ouPAcafd6q2kZVgcUEzqsUms3TDqyh5Ina//gcCuE/dYFCApBVYZbD8jYxJJMcDOsq/vD6miqDMI7z0F3bvmRu+vJZrl6J4NO4zXFjZt+/dGtrg47OIFaRXKWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiKQJhBJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiKQJhBJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17735C19424;
	Sun, 23 Nov 2025 18:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763923426;
	bh=dyfJoVaMw2se3otvFoArpX9pnB7yY+god8b9Qd1MKC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CiKQJhBJnI5WYFJRAhLILwwpHsC9nhrMXkusYL+OVgcRmrizUjeyJdmMOV37IwAon
	 aCMGlTOGfdHzxBUSBbxFb3r0wSmZ5x1Zmt0tlKVzgvdnp+DaDOnVFhdMCFFL5isEXS
	 fXm1K1xHzKBdq4Aqp4t1YqKrCxwwBlLA3YfHO7VmYgoztMUjTIylVBpo3BRrkQXMjM
	 G7em5Y2hkq1DEKThsHpm+Dn/xjpUVhJtIe2AAFpeCl5+Unzojr76w80P11kbGtzYEZ
	 wWgr/UxhM2nmamCpje4o5ECAj8yYufVlOmtAnCdeRkY/AaF/XjVN9/X4xiUNqeo72x
	 +wPJIKCQY8YqQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 06/12] mm/damon: update damos kerneldoc for stat field
Date: Sun, 23 Nov 2025 10:43:20 -0800
Message-ID: <20251123184329.85287-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251123184329.85287-1-sj@kernel.org>
References: <20251123184329.85287-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 0e92c2ee9f45 ("mm/damon/schemes: account scheme actions that
successfully applied") has replaced ->stat_count and ->stat_sz of
'struct damos' with ->stat.  The commit mistakenly did not update the
related kernel doc comment, though.  Update the comment.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 1d8a1515e75a..43dfbfe2292f 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -532,9 +532,7 @@ struct damos_migrate_dests {
  * unsets @last_applied when each regions walking for applying the scheme is
  * finished.
  *
- * After applying the &action to each region, &stat_count and &stat_sz is
- * updated to reflect the number of regions and total size of regions that the
- * &action is applied.
+ * After applying the &action to each region, &stat is updated.
  */
 struct damos {
 	struct damos_access_pattern pattern;
-- 
2.47.3
