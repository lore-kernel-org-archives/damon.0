Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA99B255F57
	for <damon@lists.linux.dev>; Sun, 22 Mar 2026 21:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774215398; cv=pass; b=ZDC/G4zkjazpbAV6oYw+9BTSb7N5b64kgzW18j5rK8yG/BfIl+1Oe1JBP3g9mdrJZy4Yw/B8jzk5aLimo7MsRLf4KOEd5Hb9YcwEW18qe1k2VmP4fKHJTL4vRgXDElr7hy0O29Nh8rSpUYl2e60BjNEK0mRcvpYbcYExj8jpE7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774215398; c=relaxed/simple;
	bh=X5AIjSFjp/QzYkIZFdc9kk/aPXOQYSWpOwYgZAzTX5U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gy1WC8+V9zVPkgjg3rxAgxqKQf0p4kXlZ3oV0l6jy4Q2AtSb9QnHqKkcJG0vj6lDL8V7c3KnObrok7B6P+CpqhOx+XQli9uLMm1PA1Ahq4I9BWDLkseEG1V+Iu0u/8wDsOn8HXToPjXHGPy99014oaI2W69gh/xm4lpzx7wVGQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=WprjqEfD; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="WprjqEfD"
ARC-Seal: i=1; a=rsa-sha256; t=1774215394; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Frq4MVq7LewBDUo+utAfMV0FgkPK1sLpq+nb7tWCAcywFSOXD29P9tTvj2cA+t9LJBu6/ea4WZQu141rD433vkO68B+/Vs3eCs4vaiq9Gu/3fGd1vYdjPUY8Lj8J6h8xzctU/5okDhsge3WXGD7DtL3W22pVJsPVKYPjErGU2bw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774215394; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6Ka7Gj1ODMKls9HnubsAnQ4TlPWBOmVvJtfpyNbAIeM=; 
	b=EJHFZSbBVsbObuL3m5DE6CuGc9UMcL2DHBvolZQpIGHO7ipNRNIThat2/F43jI2Hev2L8E0jNL1dvXoSv90hd7Je2tp+3k72f8JxcvLK2ezXV7Qjg8seY/ixRsMzjYQ/YjD9cyfscJy2GWNsNY8WsA6rGzuVAzJnla3Dxcuaupw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774215394;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=6Ka7Gj1ODMKls9HnubsAnQ4TlPWBOmVvJtfpyNbAIeM=;
	b=WprjqEfDgLNmcUIbPhoGnlrQacL7kTG8GU72fybfi0cQCdYBQKb/eFT+isJ28Wr1
	w9+bu7hv1SPgD/VZTRqfvrWiawba1j+gaJYn10ZnAN8YPs8huqUKW3ZF/Jl5ZfOJxuF
	6CoGhU8YgWdb8fhQicKlkBG5I/I3OigT1FqZtV54=
Received: by mx.zoho.eu with SMTPS id 1774215392336839.8254076143065;
	Sun, 22 Mar 2026 22:36:32 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v2 0/2] mm/damon/core: Performance optimizations for the kdamond hot path
Date: Sun, 22 Mar 2026 21:36:29 +0000
Message-Id: <20260322213631.259212-1-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hello,

This patch series provides two performance optimizations for the DAMON
core, specifically targeting the hot paths in kdamond.

The first patch optimizes kdamond_apply_schemes() by inverting the loop
order. By iterating over schemes first and regions second, we can
evaluate scheme-level invariants (like activation status and quotas)
once per scheme rather than for every single region. This significantly
reduces CPU overhead when multiple schemes are present or when quotas
are reached.

The second patch eliminates a hardware integer division in
damon_max_nr_accesses() by using the pre-cached aggr_samples value.
Since this function is called once per region per sampling interval,
removing the division provides a measurable reduction in CPU cycles
spent in the access rate update path.

Changes from v1:
- Use min_t(unsigned long, ...) in damon_max_nr_accesses() to satisfy
  checkpatch warnings and improve readability.

Josh Law (2):
  mm/damon/core: optimize kdamond_apply_schemes() by inverting scheme
    and region loops
  mm/damon/core: eliminate hot-path integer division in
    damon_max_nr_accesses()

 include/linux/damon.h |  3 +-
 mm/damon/core.c       | 68 ++++++++++++++++++-------------------------
 2 files changed, 29 insertions(+), 42 deletions(-)

-- 
2.43.0
