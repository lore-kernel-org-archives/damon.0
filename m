Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534230;
	b=yfa6lenbFOrW9a23O2F9WduVZD2e+jIAeWb2w3fZIffMBGdF+WxmT6f+DYSI+OXzps4a
	 J2blxSRb/TRJobPG6DM173Wt5eqUFvYU4O5TBkj6PNupi5EZqpcR3mViuS3xgjA2J5Arq
	 jwLYzBANE5/UDtkCZiL9c919K8T/GYPNpg5FdwRWtvsFQHPSYl8HCh0g6Ylp5MOjFLakl
	 rk4OQox+cnAJ6n0oEAovdTmY/Lgv+/DifTYV2VB5CNC/0NiAptwi5XzaVAAM0QvqBwEVI
	 0SdmT+3vkQGVHdM+fbphf114WGt8Q9rX0YfgCykXYq0a8o/GmU9ekSvkO2/iYcvaPxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534230;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vtGnH1j+k8K1i0C8+rWDE5CfsWDYKesCWpGj2PsQngk=;
	b=D6qMDbf/8sp1iRLu3bvaT101yob6A9DxsPHXnrMBwJ5C1ImkZhQfd9rCk6dLQEu1RM9m
	 1Vj8AOl/g/zStW53t8r/8BbcpQl81JKqWSxDKiaoSPSQVyN1VLHxvRhm7a7FkecxjjQZS
	 XflaFrVpNgeN7QrLqqOHtnhd5OjNjIiHRjq3OgNKIRQjCNVf/mgxUKXr73N0yYQKJ7a01
	 pSsCkIs0V6EeRAI55BEG0sdmoHX2YqVXHUij1ZXhChLd4px8cZtDWbFql6RbVSPTOQvxw
	 k449WEIllh46Y4s4GEHITLC4SP2r7iXB0BflaBncSqjykuvXCWt0htNCSCePpbBcRLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A4kiSoWN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692C2606A331
	for <damon@lists.linux.dev>; Tue, 24 Nov 2026 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A4kiSoWN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116CB1F000EE;
	Tue, 24 Nov 2026 15:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534230;
	bh=vtGnH1j+k8K1i0C8+rWDE5CfsWDYKesCWpGj2PsQngk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A4kiSoWNXQe9RE7ah6INVKCZhCr9v/oYj+yH5c+YKcRFU4Q5Hl20XtdjchLw2Wpwg
	 lFurLsHrl2ZlsERTDsrTXbKfb+7FSUA/Jl6KmQImydd6LRowqNBpwnbxAMls6k2c+R
	 ieJrolvXUXnk9lWsr1AM06JgHExkq0/iq7IQePjZYS8HJLXIWXozi0EXAyTjHmkbp9
	 QCXQRtOUevM/Wip6RzkYg+sJV2EM4WFgpCIRO8cnBBvcu9/nSLf53C/c+prihMKCKT
	 jSb17tZVK4gKfnyBcDu4iM9mYoS1H5zJ3ITe9e+NJffmuPCZQwAYmlruCM4ZExfLGD
	 ggDlLNXGTwc1g==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Aveline Noir <jm5905938@gmail.com>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Enze Li <lienze@kylinos.cn>
Subject: [PATCH 1/4] mm/damon/paddr: skip non-LRU folios as a whole in pageout
Date: Tue, 24 Nov 2026 07:30:17 -0800
Message-ID: <20261124153021.90142-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124153021.90142-1-sj@kernel.org>
References: <20261124153021.90142-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aveline Noir <jm5905938@gmail.com>

damon_pa_pageout() uses damon_get_folio(), which rejects folios that are
not on the LRU.  For a large non-LRU folio such as a hugetlb folio, the
loop then looks up the same folio once per base page even though
pageout cannot reclaim it.

Use damon_get_monitor_folio() and skip any returned non-LRU folio as a
whole by advancing to its end.  Do this before the filters, the
accounting and the last_applied check, so that adjacent regions within
the same non-LRU folio are not walked by base page either.

In an x86-64 KVM pageout microbenchmark, traversal time dropped by
about 99.7% for regions covering whole 2 MiB hugetlb folios. For
4 KiB regions within hugetlb folios, traversal took about 1 ns more
per region.

Signed-off-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: Enze Li <lienze@kylinos.cn>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v2
- v2: https://lore.kernel.org/20261118-fix-damon-hugetlb-pageout-20261117-v2-1-547a65a3206e@gmail.com
- Collect R-b: from Enze and SJ.
- Rebase to the latest mm-new.
Changes in v2:
- v1: https://lore.kernel.org/20261117-fix-damon-hugetlb-pageout-20261117-v1-1-054ef8760a92@gmail.com
- Drop the redundant hugetlb check and update the subject and
  description as suggested by SJ.

 mm/damon/paddr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 411e1d557ba3f..83bc173c30504 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -268,7 +268,9 @@ static unsigned long damon_pa_pageout(struct damon_region *r,
 
 	addr = damon_pa_phys_addr(r->ar.start, addr_unit);
 	while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
-		folio = damon_get_folio(PHYS_PFN(addr));
+		folio = damon_get_monitor_folio(PHYS_PFN(addr));
+		if (folio && !folio_test_lru(folio))
+			goto put_folio;
 		if (damon_pa_invalid_damos_folio(folio, s)) {
 			addr += PAGE_SIZE;
 			continue;
-- 
2.47.3
