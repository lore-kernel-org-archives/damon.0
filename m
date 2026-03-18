Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8016D3148C9
	for <damon@lists.linux.dev>; Wed, 18 Mar 2026 21:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773870590; cv=pass; b=aB2c44u/Re6pjIzeobh5MWtN5Ua1st//OlndOVqLYBSLB4ycyMEwY8D0OJFRtOhVKZz62m+TSwmPQvSopbAl/CLk22yQaXftaKDRCcsY16EdVSoLZp2/aQ4RRCSW5k4i0aLv1YPxEil8UnO1aXtinRGgKI92XYH+C9KZUrHF558=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773870590; c=relaxed/simple;
	bh=kSJK7LNpiMsxHIeej1ElBIaYyQ2mBrPUPqAbZGllKL0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VwO98q1nb+HEbzFoYaQ6JK5blw9kMmFnqBPk7RIKSfGaCm8qOQ3nK6GfWusiFw5E47676H8N+ku9UI3elETVRBz580SHPAA3q8IwTLkmlGgGAJ6n9nHKLWENB6AKPntP6IYO+quc6xj1lx/4wS70mGRy1KN4suuuOklkMoTX/xA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=P3LP2R+C; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="P3LP2R+C"
ARC-Seal: i=1; a=rsa-sha256; t=1773870584; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=HrJwqVY5dwgyq045PYiPDEOoZOHbORtlX1PYH0rUqi9kDIAPMDqbHwaI1tKrFs+CV5/WfKwdR+uqxsueBeukg5W4JR7Lmpxe01kbQpePTVsQd+ziHoTfGRodI270VlJA4UUukgAAP/IjNzyNhfOTMyX/dUTeGChjkGp/hBFu05E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773870584; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9jwp39IT0m7ca3TWbCgZnTUx5QN4wqMGTxV1PauNuS4=; 
	b=FfhKJDq/IaXY/ecz2idVjrHhnwpQCQTE0zbCqsRtEr8OAF07GJjV1aXMtf3Y+5T8Tc8s7IA4eEm5b+E4E5ZVwLdtwiF+Rt4a7vVdg/xoZi2vKPt0VtEmuPvxzHS7nRdTkSciJF6ePHfmBAwa4WdX94/ejo5n5UB09Xmd8u+wwMY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773870584;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=9jwp39IT0m7ca3TWbCgZnTUx5QN4wqMGTxV1PauNuS4=;
	b=P3LP2R+Co4T2iUGaFs4ThwDzAV736wCwhycmy1FwrQ2b5xkh+1qPf33PZfTq36mC
	Q7a8cXaj4/L/Vo+tkDb1IJ+9iU0FvSLKKK0ELDmRVNWKq8Cvh2XYfBHAGDgHYLJrBLv
	JQ5G//CuEaWcMnlSAr9Ply0zWDgMkTzC8Vj6Dr/U=
Received: by mx.zoho.eu with SMTPS id 1773870581029691.3995812871057;
	Wed, 18 Mar 2026 22:49:41 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH] mm/damon/core: reset nr_dests on allocation failure in damos_commit_dests()
Date: Wed, 18 Mar 2026 21:49:39 +0000
Message-Id: <20260318214939.36100-1-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

damos_commit_dests() frees the old node_id_arr and weight_arr before
reallocating.  If kmalloc_array() fails, the function returns -ENOMEM but
leaves dst->nr_dests at its previous value.  A subsequent call with the
same nr_dests will skip the reallocation (the sizes match), and the loop
at the end will dereference the now-NULL array pointers.

Fix this by resetting dst->nr_dests to 0 immediately after freeing the
old arrays, so any later call always enters the reallocation path.

Fixes: cbc4eea4ffb5 ("mm/damon/core: commit damos->migrate_dests")
Signed-off-by: Josh Law <objecting@objecting.org>
---
 mm/damon/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7f74982535ac..e233eb84a2d5 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1060,6 +1060,7 @@ static int damos_commit_dests(struct damos_migrate_dests *dst,
 	if (dst->nr_dests != src->nr_dests) {
 		kfree(dst->node_id_arr);
 		kfree(dst->weight_arr);
+		dst->nr_dests = 0;
 
 		dst->node_id_arr = kmalloc_array(src->nr_dests,
 			sizeof(*dst->node_id_arr), GFP_KERNEL);
-- 
2.34.1

