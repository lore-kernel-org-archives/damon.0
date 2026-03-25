Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BBF371D02
	for <damon@lists.linux.dev>; Wed, 25 Mar 2026 07:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774424294; cv=pass; b=Lc0kHCJTR75y1HQ+rULwajlOdCX0VgI1tads5MF7Ci5H39o0W0YzoRDTHvuc5bGFnDGNw7amfPFX+eXW/eX8W3sR9KPh9V4eJS0FV71m/wi9cHBcbYbCRUTER/Z6/1gbAfVKu6h5orh4LkryO/d2MReoaciY2dQwf+ypWhAsE30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774424294; c=relaxed/simple;
	bh=RT26WtQYSxHeUyNCQMNLzhn5HklKdgg5lis4ZBtdW5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Syj5HCkAVfE8AXUehogJGYSCQb4BE6XrolCJW57pnRmLJzuNG0M96TSSrcHy9TtrUCtLK+WZaFCjzf3LplkwLEu1Hr0LdSAQvHTgQwkTk1G+RiawI8QgGJFf0IsZ8jUOfxl8qWxoUbMVaszipepI+6l+99U3HpAF24exPVf5u5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=jzrXLtt4; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="jzrXLtt4"
ARC-Seal: i=1; a=rsa-sha256; t=1774424286; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=PU+fmdve85QzTNEQtdk1LW3R84NoQHbynext5PvuzY2NocmffcS4kg0/HDQIf9iYlueM73SUzbpEndp21M6z2ZbE5M02ofyYK8dtWtzL8UTe0ieaxvuxrAw/vztyGLcBTsqZYaQ/Z/P4aHk7PCXVvgu6I7i4i0O/8Qlw5IujHh8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774424286; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tfsen0gLvtXHaCR+ZdiNVDmc40Ve97E4q2t/q4WxGfc=; 
	b=gMo1eQxduiJH6BgxCkkPj0rXLqguv59IAvmwUXIX05+9SHJXku+KRzwW9NOAmcf/w3Bki9KOaAamDvQowmY8QNzHk+XXiOlQ550xPBHWd6qkL9XRgghFsaarI2/cLadn8+e6j1bhNrELGxIWSBMSajbvJOSIC55JSUzUEZUAPQM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774424286;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=tfsen0gLvtXHaCR+ZdiNVDmc40Ve97E4q2t/q4WxGfc=;
	b=jzrXLtt4DNgzDl3UVvlGzVzgOfbyJNaUyDhOgaWC1p1rj+E5v35hGzvqP2mqNgb9
	NIEwOcb4JzHTjArQ3m5tTLJddd9xAwhY/+T/YTEVyFVw4JqMF+jHwr7eoUUMUvWlQ87
	gj2N/ini0dllgt+XWQTHYIr10L6c241483PcYTUY=
Received: by mx.zoho.eu with SMTPS id 1774424283087612.4270641961702;
	Wed, 25 Mar 2026 08:38:03 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 2/3] mm/damon/core: use damon_nr_regions() in damon_commit_target_regions()
Date: Wed, 25 Mar 2026 07:37:59 +0000
Message-Id: <20260325073800.141756-3-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325073800.141756-1-objecting@objecting.org>
References: <20260325073800.141756-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

damon_commit_target_regions() walks the source region list twice: once
to count regions and again to copy their address ranges.  Use the
already-maintained damon_nr_regions() instead of the counting traversal.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 mm/damon/core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 56372e577931..6c1f738e265c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1217,17 +1217,15 @@ static int damon_commit_target_regions(struct damon_target *dst,
 {
 	struct damon_region *src_region;
 	struct damon_addr_range *ranges;
+	unsigned int nr = damon_nr_regions(src);
 	int i = 0, err;
 
-	damon_for_each_region(src_region, src)
-		i++;
-	if (!i)
+	if (!nr)
 		return 0;
 
-	ranges = kmalloc_objs(*ranges, i, GFP_KERNEL | __GFP_NOWARN);
+	ranges = kmalloc_objs(*ranges, nr, GFP_KERNEL | __GFP_NOWARN);
 	if (!ranges)
 		return -ENOMEM;
-	i = 0;
 	damon_for_each_region(src_region, src)
 		ranges[i++] = src_region->ar;
 	err = damon_set_regions(dst, ranges, i, src_min_region_sz);
-- 
2.34.1

