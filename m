Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD31363C53;
	Wed,  1 Jul 2026 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782917310; cv=none; b=H9uUrdpsyGw9fZsvNDjlAJuFE6h+QdWQV/u5ecwWel1PjdCPYNW5y36MdQkyZtl0pKau+7e+zMVYflpXp19pTrfvQ7O3dZNWsy7SBmzdnAwXWbG2O0CibuH4i1erF7IjL2ojevlc6VAdO1CfwFeTL1uaFEfjCM1EwQlOHSarG/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782917310; c=relaxed/simple;
	bh=GtNKjA/c2e4yX3uQ3qCAc7LQt2Zkhl6U4ONmEz+idT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sk8TVVL9PgbQ4iSJJy/Sr2UbNwKf81+2BXS0KIJJiYo1WDVG83IuswgPiVVkiAT1knOkaEOeDrlHNy+OfH4HAYM7MDETcTFl8aVNuZmFpK8cIPQ3vEmsrquFTPMEjwsELeZ0A/MoXUqpYXXZd+Z9beLXISsFEXrGJSGTO2z4ico=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfHMA57v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfHMA57v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAB61F00A3E;
	Wed,  1 Jul 2026 14:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782917308;
	bh=4VafhRbm8rnHMCZpEIBC3NAXIVyFpdQKn/cpt2JTi7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CfHMA57v/es7Bf6Eh48NbQYpsR1IkkJ+j14HygB2KVFBx6o7mM+KtPXG1lZWxmN/U
	 Pf9ZN9c7Q+WV7pcelUlpmQi/cTf/Ywfou7qiOMVwvTkubK3loe8DSiSbxUkhK1X2/S
	 ZAekMOpzQbN3Zs8yVaYlXa2rRmDhcDGtm6h3Jdr4o28FjuaM4hui82zuh4/Ku+mNxB
	 nKiGXJCmjDdIqlxQwQW07DDL/JMlXQqhZRhgvnvxVHMABM6X4yUYUcew8/IbX8DnNn
	 +v0pze6gHtm+vn6PgwLlhAaAs8IyeftrqVHqkg2g2ekt3IcLXmMidl2J3PMf3RO6IW
	 D3e3G/1JnLSRQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 8/8] mm/damon/sysfs: remove region size validation
Date: Wed,  1 Jul 2026 07:48:10 -0700
Message-ID: <20260701144815.113325-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260701144815.113325-1-sj@kernel.org>
References: <20260701144815.113325-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_SYSFS validates user inputs for monitoring target regions to
disallow negative size regions.  DAMON core assumes only positive size
regions, though.  The validation is incomplete.  Fortunately
damon_set_regions(), which is eventually used by DAMON_SYSFS, does the
complete validation.  Remove the incomplete and unnecessary validation.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index e666dddf1feba..b65651498e0d1 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1987,9 +1987,6 @@ static int damon_sysfs_set_regions(struct damon_target *t,
 		struct damon_sysfs_region *sys_region =
 			sysfs_regions->regions_arr[i];
 
-		if (sys_region->ar.start > sys_region->ar.end)
-			goto out;
-
 		ranges[i].start = sys_region->ar.start;
 		ranges[i].end = sys_region->ar.end;
 		if (i == 0)
-- 
2.47.3
