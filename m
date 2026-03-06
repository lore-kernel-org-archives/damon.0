Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFAC3D3499;
	Fri,  6 Mar 2026 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772810962; cv=none; b=f+41mCjhByMXqDt4xVxNMQ1Bi9WC+M8FqX0pjPQ1VSKMXaLvwSx9QCtR2PINdG6innho6PUiYlJOpASbD34FTBFOzKlQLNabnQl7Of8q3pvdJa2TpALw2DDW5udfMdjmjn8ytFJ8VkYN/8+iWkSfX9ImJBWFe+vR0nXVxO7v820=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772810962; c=relaxed/simple;
	bh=h0Fe5csr3sldzD6TLO83VPiRoEMNSXNoD5pNU6aZzIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BtMbywfjXYn4ftGXNQrgZHRBKkUE1gylBpq0ds0Sz0IYDhMGiQ/hKB5YwqbxxRi09zRJSNEdUaUHH6oIzkczeuqMbeVifH29QVpYogEfdEf7WKRfDdMz2rv2h+NZoA2xMAQ22GPHrGOZYgQrzTfz2xFCLQqCRfFBv4dst/1K/ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i10Odjcx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i10Odjcx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA3CC4CEF7;
	Fri,  6 Mar 2026 15:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772810962;
	bh=h0Fe5csr3sldzD6TLO83VPiRoEMNSXNoD5pNU6aZzIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i10OdjcxbIIELF+N6tlSux0gYDg0CoQs9zRPvDBH7PxK3Pv5+MaS73hoMBgMR6UVj
	 UlbnKTr0kP2i7z+BwDMbJpSrnxIeK1Ddrk2QqZ97vlQw3ARgIgTDRGPRkHrHF5jTww
	 238+MOrpYZDHA80e9LktKDClyiA2A8n8LqVsQbm2vGiINhRlNrDokGl1lm3HYB7kn0
	 /cPj6g8pP26AyT+oOeAbw3OEb7FYJinyuDeGNEL1C7atJrjXJIZODMLX0Tp1FCVbLe
	 O4M56BR5HSjEnN12cWsdGEPnVTvDYlUZ30tjs3k0NHFZ8ridz1L/GkgBr7X5cX4BQR
	 WFvLOvKYldZag==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 03/10] mm/damon/core: add damon_del_region() debug_sanity check
Date: Fri,  6 Mar 2026 07:29:06 -0800
Message-ID: <20260306152914.86303-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306152914.86303-1-sj@kernel.org>
References: <20260306152914.86303-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_del_region() should be called for targets that have one or more
regions.  Add a sanity check for that under CONFIG_DAMON_DEBUG_SANITY.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0c1353164ec81..92eac5eb96026 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -152,8 +152,21 @@ void damon_add_region(struct damon_region *r, struct damon_target *t)
 	t->nr_regions++;
 }
 
+#ifdef CONFIG_DAMON_DEBUG_SANITY
+static void damon_verify_del_region(struct damon_target *t)
+{
+	WARN_ONCE(t->nr_regions == 0, "t->nr_regions == 0\n");
+}
+#else
+static void damon_verify_del_region(struct damon_target *t)
+{
+}
+#endif
+
 static void damon_del_region(struct damon_region *r, struct damon_target *t)
 {
+	damon_verify_del_region(t);
+
 	list_del(&r->list);
 	t->nr_regions--;
 }
-- 
2.47.3
