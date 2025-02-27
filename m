Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E9B187FEC;
	Thu, 27 Feb 2025 01:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740621490; cv=none; b=FQ6mCaIJ/DuKwcjSaqEa3OPUhXMpYPWgXiXEcqc+Dd5xrRJp2vMOjzn6Xdc2uN3wJkPqJjulkilCDO0cIa+gbVyIbGcYeqlfpOd1VKMOQgONbPUZeKbSKwXxFuo4WFADctKDdyTLgRtZFlIRM6/WBV4TI/cYh2drxwUj7/Y7rE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740621490; c=relaxed/simple;
	bh=5EkDSCqQcPc4o5HB4towhIerpdJDJgqyUQWBno/4/Pc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VY7mfMfz+nuerfKgE/XQnXXjnp8udOXul4x6yyW2XsdPWBMnAVP3e14GOSZ9rx2cYIovEGzxI5BpBAuA5D9lbz/U8fdXv7Wlc5/0Sa5BqlslALi0g1u2qW85DqiPSl1LaO51gC6fGFNxnpzf3MW2gwxDw7pL5jk6eRvDoHwJBHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDxU2T+f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDxU2T+f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DEDC4CEE8;
	Thu, 27 Feb 2025 01:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740621490;
	bh=5EkDSCqQcPc4o5HB4towhIerpdJDJgqyUQWBno/4/Pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TDxU2T+fb1Lu8ku+Akhya8vo641/KoP0MnyQgPo0COrZXXJxSODx8ZPMPT/8/JWiY
	 Qw5nEETyG1lvk2ANCOBqu0EPYsqsxFVnrL1JefU78M75Jtdkb5ySvMkEJxQzs2xAEl
	 erL9Cnz1H+8q9AAe14/LG5wJDr7YqcVIctO4HIUD1rq0wl4fNrHocT41y9XIHnYnrL
	 LsO/TA49RXhUn+jCEMyE5iE7B6JM4VDwmODLUy9xF9vqoKJl+qztmcgo9Hywnq5auD
	 6W4m0xhWcIZ0G5zYqHY61r9bC1FBzJBtnln8ZRdvDGUd16d1yCuP9/nMdpY6RU8i/6
	 VDt8wh5DSc79w==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 8/9] mm/damon/paddr: respect ops_filters_default_reject
Date: Wed, 26 Feb 2025 17:57:53 -0800
Message-Id: <20250227015754.38789-9-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250227015754.38789-1-sj@kernel.org>
References: <20250227015754.38789-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use damos->ops_filters_default_reject, which is set based on the
installed filters' behaviors, from physical address space DAMON
operations set.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 432ea4efdc4b..fee66a3cc82b 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -257,7 +257,7 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
 		if (damos_pa_filter_match(filter, folio))
 			return !filter->allow;
 	}
-	return false;
+	return scheme->ops_filters_default_reject;
 }
 
 static bool damon_pa_invalid_damos_folio(struct folio *folio, struct damos *s)
-- 
2.39.5
