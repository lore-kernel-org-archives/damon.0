Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888F438C2D8;
	Sun,  5 Jul 2026 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783266968; cv=none; b=PqVDgEkZVyLYYQVstkKiSLdPvxO7bx6IRYkYi/hlP04TQFRhBkl++LLyqaUKbTGinNASA40Al9Qrd1jg7jsv1GvmkBrfo/2lpMLZS21GyYIE7lzjLyz3U8e0gcsrMth98i9okKqebnlvDihKw9CRKmYEdIQgnJe4peBw9vZ1bcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783266968; c=relaxed/simple;
	bh=GtNKjA/c2e4yX3uQ3qCAc7LQt2Zkhl6U4ONmEz+idT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfvUqqkT+yvvncimfXtmy6TbV07116gfDn6jD8G3/9FmJ+VILwj6MT7LY0l6WBmlp8SH4JT8BVdbePUOQV+wY9fHgUJDSYzPKUrjb4IXToAlMJE64jcRKq3EknAe741/Eipb9gtgaMOISAom3fQ+Z0eZovVsFk1/1WD49osYBUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6MmsbUS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6MmsbUS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397F51F000E9;
	Sun,  5 Jul 2026 15:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783266967;
	bh=4VafhRbm8rnHMCZpEIBC3NAXIVyFpdQKn/cpt2JTi7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C6MmsbUSMWJyRvF1mGdO+EmcCiAWgxvSYbcLNiXa/aQBbPxCPiH5jb6aQG4UZ4aB2
	 VXRPOXGSkMdGrhLaFI2ofZdahjG898Ul/o5lPQac1Ba7lqSsBlljglDhmewAhNRH6B
	 3IJeJT/9cVpZ9mVWkh9cZjWo2Iy/WwrBAZt6GtM6r0hRLINZokrlPnF6+93ldahHpa
	 LdK0rwG1a6HRIEXnS8ClAbje3Hwaafe6ANBnTRlMppQpf/6HWEigDnthf8I0Oq+lT3
	 7Q4X1S8ESLtOTW8fJaLPlpjF3ztNgl6eqK09j99JIQRKOpoFE/3PirGD/YZUuPrHb+
	 HKJbhuBfjXH8Q==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 8/8] mm/damon/sysfs: remove region size validation
Date: Sun,  5 Jul 2026 08:55:59 -0700
Message-ID: <20260705155600.96555-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705155600.96555-1-sj@kernel.org>
References: <20260705155600.96555-1-sj@kernel.org>
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
