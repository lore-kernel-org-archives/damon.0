Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85C83E9F66
	for <damon@lists.linux.dev>; Thu, 19 Mar 2026 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936990; cv=pass; b=ILV6ojcq+hue5PyrIXi6nuyk6JBfOsFFErNuUKOe1L9GSne1JgAabN9UmLJc29g+ZXwsVo9G5O5fpowWBw5mk+mB56xnwlCsmxeYJLEkXTPxQwlAGn51uqGxgQmH3wTkmrNxNKsmAOYeV2RFkN8DiJT9lJb8HVMn7B1WQsXMC/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936990; c=relaxed/simple;
	bh=TjQGvPEzhTOCN9RyKHPY5TpBAijbeTx8cY2Qoe07pEw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GK0oOXz18EEi/bfFz5J9wqTxBcQz2Rw67pht/viwsHlc4Q1301d+1rjZp+wg8T+xuT7dbO8JwDjE4d1KrnyH/aHrYmACm3/tskNbCifdj5oTBdw1okusC716cAMzZnyB2r66BHMCbbW4c9m06rS5nhQYHmFNAFpyEYlyFcZcoBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=DdSdJfUj; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="DdSdJfUj"
ARC-Seal: i=1; a=rsa-sha256; t=1773936985; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=amV9TiO2C9jeq2Cl0PtgI/iq6nSi8Ohbslo40WW1g+U9EsqsnklPGiq75D9NoCmoa3iliOXwwLapkeZ2wc7R5t5twe3P5yXKuaCCL5SgJgiWwEHQIslOO35WWlX2i1pIykIx/34WCtzIrcQITjJ6LYjzQtG4DNBA/0opKNbEZ88=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773936985; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dPrb+TYBDZVJbSRBjlvAnKVUGBeTBCp2VVxNmhYsqJ4=; 
	b=UG3jQmgH3LF32z+NV2QoW5arMVSA7jLSkcNa/Y1LSX0glTVxCXNPeJoF7iryOT68ABsep6yg3vg9CzFs5DmX4ShKC4g20UILJzYbPIwmAo/0DGHljEisk3Mf3yyFCMK7rh0VM3FpNwH987StfhIQvanWJNba2x1kwii3wLnmgzE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773936985;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=dPrb+TYBDZVJbSRBjlvAnKVUGBeTBCp2VVxNmhYsqJ4=;
	b=DdSdJfUjf5GMUpvKPRm5doYHYkX4ZRj+kam0m2FGyZfXjSrYaC/eVpFbx4xQVZWV
	I4/sbGOxnDbuz4SmSXUGGEZh38cu6xdB6u9228rxT5GH8+WNyT+15QK0+g2x8/PMXzH
	3DADWReK25IKX/p/hlPFCYI6X3eeKqAu4iY7yjY8=
Received: by mx.zoho.eu with SMTPS id 1773936981832341.19770997106184;
	Thu, 19 Mar 2026 17:16:21 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 0/2] mm/damon/reclaim: fix addr_unit validation and age truncation
Date: Thu, 19 Mar 2026 16:16:18 +0000
Message-Id: <20260319161620.189392-1-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Two small fixes for mm/damon/reclaim.c:

Patch 1 rejects non-power-of-2 addr_unit values in the store function.
Without this, DAMON_MIN_REGION_SZ / addr_unit produces a non-power-of-2
min_region_sz that causes undefined behavior in ALIGN() before
damon_commit_ctx() gets a chance to reject it.  Note that
mm/damon/lru_sort.c has the same pattern and likely needs a similar fix.

Patch 2 clamps the min_age / aggr_interval result to UINT_MAX to prevent
silent truncation when assigning to the unsigned int min_age_region field.

Josh Law (2):
  mm/damon/reclaim: reject non-power-of-2 addr_unit
  mm/damon/reclaim: fix min_age_region truncation from unsigned long to
    unsigned int

 mm/damon/reclaim.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.34.1

