Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817BB378814;
	Thu,  2 Jul 2026 21:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783026378; cv=none; b=u5RDt07qSNiBvzqutpp1gKlJ5nwKhUZ2vFB2yAQr0ci2bnOjKaoga+D99KkcU4O/iMJneDtwBf/UmmyyjY5Z7tVLlUtNEIcPYhybSvtn9NtGW+e1/gxicxyKZb5MMfyL/kruBg/aFQhKU0Oqg/dcqQ7YrybD+4esuuPYo7796vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783026378; c=relaxed/simple;
	bh=GtNKjA/c2e4yX3uQ3qCAc7LQt2Zkhl6U4ONmEz+idT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rD4waLPrp0Ke1RYHfTvZ7OYSKp7KqdgVmJpGKPq+9Lg4mbvoyGy15sc7PaqCGIC+oYZSTbtTsFrgeFSrEY29y64icEz9TYzIWpwedkgyiUI8JfTeChdhBcZkkcRpal3WZK8t1HbJQaLBHO0gL+z0+Q8n6sKiI6ze7mTTPCjTnDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSA7olTX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSA7olTX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12941F00A3A;
	Thu,  2 Jul 2026 21:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783026376;
	bh=4VafhRbm8rnHMCZpEIBC3NAXIVyFpdQKn/cpt2JTi7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DSA7olTXiK45kxIsJ2zUsJjlHNjfe2YGVGHkKrxOn+m2Kvh7MW1DpHKwaoHSDtrZx
	 UYfI3QmQJroc/k3L6Qz1cnKLIbCYUBtrycelGNDd4aG8liuLE4VHj3oW4/KJOarXD2
	 ao2+jfYyKunNNtzGA85zeoLYGPZ2TxHsnUPNoS9dCEEwn7nqnLilHyzPQwomoUjGE2
	 EyFbHGRbw8NrUnBIWwB286euTRDLUdSG0vYBsWTruaFyVM6/i/1MkNYt/n2NsVIQwt
	 N/1KVzLtVQIv7i/ZqAyCxaKNxKzrj6RR7dRsAq/EcdHil4PGX1zu2tdA9X0AkX1gb7
	 GqhYboUbPoS3w==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 8/8] mm/damon/sysfs: remove region size validation
Date: Thu,  2 Jul 2026 14:05:50 -0700
Message-ID: <20260702210551.95167-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702210551.95167-1-sj@kernel.org>
References: <20260702210551.95167-1-sj@kernel.org>
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
