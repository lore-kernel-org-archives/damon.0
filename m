Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE86430CCE;
	Mon,  6 Jul 2026 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347565; cv=none; b=Xv5vs6BEAZDnOKWxOxT9B8RdJBMYC7Oog/IpWIX7vlUHMw/A6LgSfX/S/+xwGJM4gbf5uMsF9pY1A4WMG8JGQav1J6SykElE+aEnXqoBT3kA3/liJN1cGYSO4x6vAjG4fMv/yguFY8fDewmzpOcAOUmvlQs8m7c+TjVnNmqLF5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347565; c=relaxed/simple;
	bh=+c87Kb4PO3SSeDc5SMswAy4XK0/f8uJHUrh2uf9o+xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqUrHDwSYKEKqKpsu4B7FbeLSVYCWsJQfx5VFQ6NECCfOlFq8VBD8hs46FjxIODm9+bTOwrKIH8FUwRUT0e151jsjdrHyxJklUreyfB1ffPuQWRWYAfuPukyl8gc/tPMu4ovSrz2viDvusQR2UGn9/AQ7i7R9n5hD6807fBYbLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moIFmpYd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moIFmpYd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1359C1F00A3A;
	Mon,  6 Jul 2026 14:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783347564;
	bh=QnL6i0mbNzGqk7F6gIjbd/KMt9GZkHBDgTWFw34qqes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=moIFmpYdQxfGaHn7OLF+odDWAil4cqjkGlolP/WaQfkDAAFeUu1vic/Pr+zQ7SiMb
	 e+Tb4J5t3+lzG6F3Y4QA16qqQbWvTjGbUklFGo6Ms/wg982uJkSjo8Knu7yK3f8v05
	 uhjriyuzLPE80k5n+di14XMWJy3n69BY0WeoxmZSyCx6yXtrBaaEleh13QQ8Czc1yC
	 ml6FzkJzAuKo81R9volwUck1ODMOOOpgRHzSMD8CPl1+sAkAfMuHk0tzO67kIr5XRR
	 aEyyFxLFahmfvfcborl4yuEs6uPHxlofgUFNrd728kuKroWKbeP4qWZgwWsF4oaQOw
	 Pmrel2utWF4Gw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 12/16] mm/damon/core: implement damon_has_probe_weight()
Date: Mon,  6 Jul 2026 07:19:06 -0700
Message-ID: <20260706141912.88445-13-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706141912.88445-1-sj@kernel.org>
References: <20260706141912.88445-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON monitors only data attributes when probe weights are set.
However, the function for detecting it is intentionally returning false
always.  The intention was to make changes for complete support of the
mode in a safe and incremental way.  Now all the building blocks are
made.  Complete the mode detection function so that the mode can really
start working.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 83db073c74e2b..b44393ccaf6b1 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -211,6 +211,12 @@ static struct damon_probe *damon_nth_probe(int n, struct damon_ctx *ctx)
 
 static bool damon_has_probe_weights(struct damon_ctx *c)
 {
+	struct damon_probe *p;
+
+	damon_for_each_probe(p, c) {
+		if (p->weight)
+			return true;
+	}
 	return false;
 }
 
-- 
2.47.3
