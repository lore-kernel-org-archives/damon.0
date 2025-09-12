Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152971D54E3;
	Fri, 12 Sep 2025 02:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757644797; cv=none; b=gOVr0N3Pz/Oz/cK/CDTY+tZgIX1L4wrmFxLvJ35uqYRXSlRaAZwM7Vbji+sDIf2A2rNZ8HSHvgYSnZjdl3htQB9aEYG6X3tOyxooEz2DiPlekKPrvvfcR/IUGv1okk7MOJ0olT22m/UaOr91FUyDOdgoTzsdUl6hH1EPGQBHCTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757644797; c=relaxed/simple;
	bh=jSyChxhp2q57cPUh41M0fEVHkYfztaaT3v+fVBcDkyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DNmJSbCJrta81Ci6WOXYp4TYhsMMzI3xweAX+uspMWdf9HQa6gzcDDkkVuaum6P8v1QeLMMCH5IjqUtdFs1RAJSmv54qPdvdcoLbCAxVQu3ePogiCDodLVQm54vr6bOp4PUaBuy3r2e+jVSgCZdGEF6Bm0B1QEv8orf3cJxrrHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIZejVwd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIZejVwd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C407EC4CEF5;
	Fri, 12 Sep 2025 02:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757644796;
	bh=jSyChxhp2q57cPUh41M0fEVHkYfztaaT3v+fVBcDkyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pIZejVwd7XS4Ox9Am4KGnyKBX3HhSNWV+MeIMCEHwd+JisNA8vBa+ZoK/xxPCS566
	 NtoaYCUPFFoYgYs7gkzrx4XBtTfEjQYdXf+O5Zj85rWQBJk2nnEmQAIV0qvmMS1NhW
	 YhYLy1w4PGuqxbyn1HyR2OA6DoKZdie75UduINMCXVwfpKZ6jh3vVBHWQkPcLFXJoS
	 exO532i/QkVnkBu/8B1xOeYqKqZFUiHlvfVzHQevIw5WSuFdinlIjwDDQsuclhYPgT
	 otf7PQvW9yeN4NGD6cCozpavPfP7/QLxd9OmlMIbPdq20xiMfsvoK14UxlfPRAysex
	 2PyMn7solWsag==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 4/7] mm/damon/lru_sort: use damon_initialized()
Date: Thu, 11 Sep 2025 19:39:43 -0700
Message-Id: <20250912023946.62337-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250912023946.62337-1-sj@kernel.org>
References: <20250912023946.62337-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_LRU_SORT is assuming DAMON is ready to use in module_init time,
and uses its own hack to see if it is the time.  Use
damon_initialized(), which is a way for seeing if DAMON is ready to be
used that is more reliable and better to maintain instead of the hack.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index ab6173a646bd..42b9a656f9de 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -345,7 +345,7 @@ static int damon_lru_sort_enabled_store(const char *val,
 		return 0;
 
 	/* Called before init function.  The function will handle this. */
-	if (!ctx)
+	if (!damon_initialized())
 		goto set_param_out;
 
 	err = damon_lru_sort_turn(enable);
@@ -368,8 +368,13 @@ MODULE_PARM_DESC(enabled,
 
 static int __init damon_lru_sort_init(void)
 {
-	int err = damon_modules_new_paddr_ctx_target(&ctx, &target);
+	int err;
 
+	if (!damon_initialized()) {
+		err = -ENOMEM;
+		goto out;
+	}
+	err = damon_modules_new_paddr_ctx_target(&ctx, &target);
 	if (err)
 		goto out;
 
-- 
2.39.5
