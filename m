Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F0426E62F;
	Wed, 26 Feb 2025 06:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740551823; cv=none; b=NfSljTLGzQR1G+F/UZDx8SXFe5yGSURC4G6tDUPDcDS4xxtq3Nc2IxUYpgNb7iNnbM1cyn/S0PvaKgxcOQVqLobEBr+QHuK3+C3cNDyxPLc/Nj81uHO+1l3ZCEUxnoGioz/n/UF+G+5cuU967kmxrla7Bo6GIFPaB/oAB3X2V08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740551823; c=relaxed/simple;
	bh=4J5vWHiHbtHqjwMC+hRbiipl4h9liEs0+TfNTGi8OuM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WUh9AMjqt9hnVtNuW8/ajGbKpZr7lyyrfOqUzovzFK5OncCYdrzUaxe7i8oinJK5FXh+132fH4irp/RtCOs51pShlCJWgpNouWhOIS//QXc7xadwN4YW+mGf4/azcZPWB92r+ZhfZTQWEC7992JD8+XjzobrQj1k+sxqXm6VjmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IY35+2jS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IY35+2jS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40BBC4CEEA;
	Wed, 26 Feb 2025 06:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740551822;
	bh=4J5vWHiHbtHqjwMC+hRbiipl4h9liEs0+TfNTGi8OuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IY35+2jSTR0fwPWqE0pDaF10P37LWFVbjA8i0aglA/xKkrkdRBuW0AFLyuSa9KeHM
	 pL7QeBCioMTspDME/Oi5tgLtMj3Ww5A1LPrqqmL+8dn/I3P/H+2ATvr7HkujdVpKi+
	 kHsu0DgCV4rIYvS/nH7GWwA5/FyIk/sNfWnIPacPHqL0MUoFtHZ4yCGO0syynawauK
	 o6NDT1eHtNQSJhVYcRQ8EP8uA+lKkSVaQWO6RUtD4CnGHJnBTN6fPLTNtOzqrfcU3k
	 V9DFeIAiANVX3zwg0kvelgpgrf764O4s+SgKVbqY4L3lCILw+abR5640X7UDPvdUnp
	 MicgMxBby5e1g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 07/13] mm/damon/sysfs: remove damon_sysfs_cmd_request and its readers
Date: Tue, 25 Feb 2025 22:36:45 -0800
Message-Id: <20250226063651.513178-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226063651.513178-1-sj@kernel.org>
References: <20250226063651.513178-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sysfs_cmd_request is DAMON sysfs interface's own synchronization
mechanism for accessing DAMON internal data via damon_callback hooks.
All the users are now migrated to damon_call() and damos_walk(), so
nobody really uses it.  No one writes to the data structure but reading
code is remained.  Remove the reading code and the entire data
structure.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index e5bcf019086f..1af6aff35d84 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1238,25 +1238,6 @@ static const char * const damon_sysfs_cmd_strs[] = {
 	"update_tuned_intervals",
 };
 
-/*
- * struct damon_sysfs_cmd_request - A request to the DAMON callback.
- * @cmd:	The command that needs to be handled by the callback.
- * @kdamond:	The kobject wrapper that associated to the kdamond thread.
- *
- * This structure represents a sysfs command request that need to access some
- * DAMON context-internal data.  Because DAMON context-internal data can be
- * safely accessed from DAMON callbacks without additional synchronization, the
- * request will be handled by the DAMON callback.  None-``NULL`` @kdamond means
- * the request is valid.
- */
-struct damon_sysfs_cmd_request {
-	enum damon_sysfs_cmd cmd;
-	struct damon_sysfs_kdamond *kdamond;
-};
-
-/* Current DAMON callback request.  Protected by damon_sysfs_lock. */
-static struct damon_sysfs_cmd_request damon_sysfs_cmd_request;
-
 static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
 		char *buf)
 {
@@ -1555,8 +1536,6 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
 
 	if (damon_sysfs_kdamond_running(kdamond))
 		return -EBUSY;
-	if (damon_sysfs_cmd_request.kdamond == kdamond)
-		return -EBUSY;
 	/* TODO: support multiple contexts per kdamond */
 	if (kdamond->contexts->nr != 1)
 		return -EINVAL;
@@ -1796,8 +1775,7 @@ static bool damon_sysfs_kdamonds_busy(struct damon_sysfs_kdamond **kdamonds,
 	int i;
 
 	for (i = 0; i < nr_kdamonds; i++) {
-		if (damon_sysfs_kdamond_running(kdamonds[i]) ||
-		    damon_sysfs_cmd_request.kdamond == kdamonds[i])
+		if (damon_sysfs_kdamond_running(kdamonds[i]))
 			return true;
 	}
 
-- 
2.39.5
