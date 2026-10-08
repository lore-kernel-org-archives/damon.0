Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E31384232
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 05:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792041692; cv=none; b=Tu8xFAIcGAgYboB3WHd5UTPF2vYz2RfjL+OFYg1RYuIGuGi6qcWgUBG0pxJG77bsBwrP+nXGEE1ISwhalXlp57OUEXXCpli2ZgQ3xcn4W+egHp4zJF0S9v6PuhjDIA498HDUt7eXfe6PDWVPEUu4jv+bVDI72qo9jM62vINYq/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792041692; c=relaxed/simple;
	bh=5syrNj/JLgLqlg7IRGXpYcJyk/HNi/mWCL7GsaEOynw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rAXCX5wRwBZkOAYyovJiNVE+tmQHTbP9O2H7gQ1FV14+KKwui9Ut7Ix5pIxnC88Io6f2niefxPu0LrQ6AHD8bJ5ApSHW/ySqlQugLA3AJK3fd/uQwJzzvt5ho46YGielEgLr7DgXYzn9pnVGyNV3HKP+9JHTNXyVmt4IsF2Adow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=s-joshi.in; spf=pass smtp.mailfrom=s-joshi.in; dkim=pass (2048-bit key) header.d=s-joshi.in header.i=@s-joshi.in header.b=xCFK7NVg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XV0h6kJy; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=s-joshi.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=s-joshi.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=s-joshi.in header.i=@s-joshi.in header.b="xCFK7NVg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XV0h6kJy"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 73418EC02A0
	for <damon@lists.linux.dev>; Thu,  8 Oct 2026 11:20:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 08 Oct 2026 11:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=s-joshi.in; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1791472805; x=1792336805; bh=plxy+DrT8Ze0nim79TR1y
	OEuPaMxj6VH3O713CTbSuw=; b=xCFK7NVgs12YR5Os+1qjKUQTdSiWxqgeaTR7+
	HdLBT2ynFVEJm65+tI5UpZUl6J0JMt6zSveTLT3+beQyDHidKSONCVRIB6X66D6e
	nBisnKjkG+93qLtbVqS5f4PGuG50zhsBZx0wpewxgNYRa9A49UOwu4ZTgChOjBWt
	eQwzyfjuRJUtAdbtFPWSwvOVwR+q8nkxiZLtmTwbmTLMlsNo8oK1JczusEyfiOvC
	Nu94JXVh1cMHyT/Lfnq6geg9XdG9CAvtE1Cg6i8e0WDhc5x/5htdB4L3d6C9ewKp
	xP7zCM+x743Aci9qlludrOMWnnYlkf1D8peD3C6PSkKoZvOnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791472805; x=1792336805; bh=plxy+DrT8Ze0nim79TR1yOEuPaMxj6VH3O7
	13CTbSuw=; b=XV0h6kJyywuq4uTCPPT+vlRvFV2CWZJfS5hUIci9ETpt/Inwfoh
	JdyoUH+orjCvLwrd9cOr+roDiYqw6AYuexLOJ47Enyc8OFbnMI4xbJubSQQ12YYC
	8EQgHYj/Q1tyY88DGZOawPirgcOfCcuQLyUnz30qooL+d0/PVXJF9nCGKnf2sbnc
	6fU6aAA4DTuLDKg6Y2d5T3eBsWqVUA4P9mE2YrkA5zoifdFaLGM3wAap8mvvn6JY
	NIiZM6hGl/J0UspWfU/f+25+I7EqT7b6HUqmiriGIX81h/kP9WPJxBmuhyJp4bQv
	qXZ7sWRZ4gz2+C6PrZX/0V3nr0hxZzqh0uQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=s-joshi.in a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791472805; d=s-joshi.in;
	mf=PHN1aGFhc0BzLWpvc2hpLmluPg==;
	rt=PGRhbW9uQGxpc3RzLmxpbnV4LmRldj4=;
	s=fm1:rsa-sha256:RDp2lNKaFEoAPwYpBlO4+3Rl7Q12HLQWjKKcbx0NkQ+49j6
	zzoxECCYH9OLJhFPD1KyFBEvqv9fFmjOrO6Mve9ksY8jAl7oAWVhKSNyUBvehXZR
	AoIkR/EanwKYBcsXuM2YYH+mS19YngBvkcOIxuqAu0q0Kh17geSJ3WvSf65rhzgs
	QCPaT5MZdtxhIN8P8ba06PxVRi2wqVsUa9VT4PHHGYzaId0MBP5wmCIhEUB6iUUL
	VisQdJ6VuggHsMZXyIGrcK345QviGk3j1aUaeUZ8nvR/WNYKovyoHHSfzHJKY0gV
	/ItmIVG1b5JXfaXjYmVjL2TcOw1uNFEyV7O0D4Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:rf6ufOzkNZa7QhG4kTdpPLLyHMZLstPqQjFG7FSWTOc=:5syrNj/JLgLqlg7IRGXpYcJyk/HNi/mWCL7GsaEOynw=;
X-ME-Sender: <xms:pLTHakvaYYI-n9-yyKB9pcZ3LPqDNpK-FwMA3RjbVNyLmkWVnnIQ5w>
    <xme:pLTHaiLCnEOZoJ84DPrAJGjAF_N6eQn-KTPOCozUCoe8rakKYLMJVMcLmZOj6eijV
    KCWrq4_XSB_JRMSXc828gbEbd5D_9H2RftZPkLWVKCkMNVH_H3iFRs_>
X-ME-Received: <xmr:pLTHat8INlt6X0w19517Mx6gm20tn60O6Cbfw8JSQFy14iighyFvBdvl0g>
X-ME-Proxy-Cause: dmFkZTGqxKJltKcxARJadtVktDBjtkTJW7gorgTB8Ld7pXgguWgs5hqg6/YGAbmf+3ndY6
    LjqKDAI3EvH46oJqR0tWDuKjWnqcBAK55NEqWzEvzSxNjp+D3hNoffq1DonGlE89pCLzx7
    fXzqKf8HtHttmd8QNutoRFIK6OEt2nz179BXmfB08wXw5RFnw+OX7Fuxqses2X8N7pM0MR
    uix+e515sIDeirVi9i5sd9lgyNmtEz7/zoYfcBs4tM+ZskmEUvRGl4U1QHO9XkLYCMamWm
    3NYpzIgBUJjx0iK2KXMvacFbQo+WueYCOphdPLzMH6GbuCPBxPTTQWkkPdp7XlpaUmN+Kg
    fZmb6MQvaBT2/j3ANqZQpG7bX3bzTAz+HR674FVqrCnNETt7/fTIYJa6R2bmOeMn3xK86J
    sNYywAhEtrC+AikraNY+CpaxZ7swDj4/y6WXHCfvw0IeAGAazvJ/krqsF/UlegqMvxZkCI
    KB+WnPfo5WGXtdz/x/M80prHyqfZNxEuAy8aSCJlavWKyLvFqO5KU4Q7aYxSDmpzFaLF/m
    qIuSNaP5vgZ+lygJWy5PY6YYKVreeTw8rQJv9fJvMDENRDnemN8OWF5jyduYZV4jf+SrN3
    /24ZqrMN7P0km3ZBvU7n/ml8VJ5yRUd4TOwE5BChMTU4ral69GdY/sTnijEA
X-ME-Proxy: <xmx:pLTHaryA20PcyxVoVyL1vFpbYtAlPaHyVAkXsfAhV0AIjiVWDGjIyw>
    <xmx:pLTHaq4TSUMvs15Vy7RS-tkpV0k6gyPpshHqwnSQcNPruuw2gC9IrQ>
    <xmx:pLTHai-wnORkuU6EUKfcDIWUbkOXXM7cI4rxXrHBSJQpkkpxgz1GUQ>
    <xmx:pLTHavr74d05gvSYM-VsZ1efHAM_ybRZ2_lrBScrHQ-PMhOZF1Oe1Q>
    <xmx:pbTHahihQO3qK4uVQ4gX6QAwMwfKoLQe4WrIpPZ9vOU_EzIwmY1xOOpA>
Feedback-ID: ia9504abf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 11:20:03 -0400 (EDT)
From: Suhaas Joshi <suhaas@s-joshi.in>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	aethernet65535@gmail.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] mm/damon/core: Iterate over installed probes instead of DAMON_MAX_PROBES
Date: Thu,  8 Oct 2026 20:49:24 +0530
Message-ID: <20261008151944.113714-1-suhaas@s-joshi.in>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is v2 of a series [0] I sent earlier. Please find changelog below.

There were two "todo: " items of the same nature in mm/damon/core.c. Both
of these suggested that we should iterate over only installed probes while
updating (last_)probe_hits[] during merging/splitting regions, instead of
iterating over the entire array, which may have empty/unused indices.

So this patch series does exactly that. It replaces the for-loop over
[0, DAMON_MAX_PROBES) with a damon_for_each_probe() over the probe list of
the context.

These patches are based off mm-new. They pass all KUnit tests related to
damon. I have boot tested (but nothing beyond) on qemu-x86_64. Please do
let me know if I should do any specific tests and link the logs here.

Changes v1 -> v2:
1. simplified commit message of patch 1 (on Liew's suggestion)
2. wrapped all lines at 80 characters (on SJ's suggestion)
3. added comments for new argument in function (on SJ's suggestion)
4. added damon_ctx_destroy() in r2 failure case in damon_test_merge_two()
   (on SJ/Sashiko/Liew suggestion)
[0] https://lore.kernel.org/damon/20261007154851.45368-1-suhaas@s-joshi.in/

Regards
Suhaas Joshi

Suhaas Joshi (2):
  mm/damon/core: Use only installed probe in damon_merge_two_regions()
  mm/damon/core: Copy only installed probe in damon_split_region_at()

 mm/damon/core.c             | 61 ++++++++++++++++++++-------------
 mm/damon/tests/core-kunit.h | 68 +++++++++++++++++++++++++++++++------
 2 files changed, 95 insertions(+), 34 deletions(-)


base-commit: de3c5f0e6ebc5e0885d99043e071320cbb6ffbde
-- 
2.55.0

