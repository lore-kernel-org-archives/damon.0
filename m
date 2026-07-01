Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEB935F19A;
	Wed,  1 Jul 2026 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782917308; cv=none; b=P3bj7c+lx4Uc4R840M/NAp8s5OoFQED1CPcM9o0UOlSoMUAbCSQRZ1AOw7O9gBak5JImhCx/g57JLONAkNJNhlvGViDT82cWCTpX+oeCEWc8gHIFHApygPnUw+rvfleMmKnxXC97Qo5JuR9CTIFRf1dp9/y1JHD4PY7Dfe5W/nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782917308; c=relaxed/simple;
	bh=V8JO+A7dnrCg/1ncTzDlamr6P3PVW1soQkBnie7tpVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/Z1w/Y5Mw3LcrVtkud9bDf0l+EiCKs562zOjN0/0X759YHjyxWlx7822dOfVBcBKXCtGsHqkowkmwBOtR4+fb/KxEE3qbOUnQvuQd+fE4syrOnGzjZ1W8ARlXLIfAmscpG/t1csKD6VfaRHVlPc0uKudGmxub6eiLmRF4iiWWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cp8rKNoV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cp8rKNoV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC331F000E9;
	Wed,  1 Jul 2026 14:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782917306;
	bh=flGogPd+rUyChBMLRSMN0vLB2pILqw+V29hJNORLFwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cp8rKNoVLgzjt340u4lmpATVkCwZN2UhzASudaj52K9utOO2nv5jHMrqs8uZTVllq
	 IeR9klHMHZKB2wBBS4P+l59hUYEvVjrX0gcOQ4REol0ZdRVr0GC+BVoiJQpCkaLN+P
	 ZvDoBqZdwzX+b4+EB0IxpE0EeqG4HgKzbGEaxE4APquvNZ3rcad/CJkjFeV7kQvjj9
	 22O5aA2CV/QyIV5psd8e7Go+71SKwGdzgvkKvL0zU+OfTlkckZsExap3wJ/aAFwosk
	 2z2Wtj07HZMRZmW/PVIR2LaPaVyylHBpglxIV6wWCJ4u9Y+K6F0sA1gB9ygE76qG5+
	 gZCxdmC8/avlw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 5/8] mm/damon/lru_sort: remove duplicated min_region_sz power_of_2() check
Date: Wed,  1 Jul 2026 07:48:07 -0700
Message-ID: <20260701144815.113325-6-sj@kernel.org>
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

DAMON_LRU_SORT validates the user input for min_region_sz.  The same
validation is done inside damon_start() and damon_commit_ctx().  Remove
the unnecessary duplicate.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 32f41491b726b..2dd0cd0d26273 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -284,11 +284,6 @@ static int damon_lru_sort_apply_parameters(void)
 	param_ctx->addr_unit = addr_unit;
 	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
 
-	if (!is_power_of_2(param_ctx->min_region_sz)) {
-		err = -EINVAL;
-		goto out;
-	}
-
 	if (!damon_lru_sort_mon_attrs.sample_interval) {
 		err = -EINVAL;
 		goto out;
-- 
2.47.3
