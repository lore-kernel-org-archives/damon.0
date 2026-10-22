Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.72.0.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792651613;
	b=OKl9T2DeUOuSNB3T9WfvQ/+1mQhD2Al6tFSbkX8VvXy+1kR14OjXjLFnWtKT858WsQwX
	 mm2K7bI+IvwFDjhRzO6h4XrgEx7a8cYv5aTAzWiWgxEe5Rgf58nnephdthbofrbmFGYI7
	 CoqVjLVMbHe+7r5Gx1mccnh9LzO65evewCU3Yb5ok19K+BLu1B+pLPIJNMCq++jHx49Q8
	 26zCRUtAKqF5OE9xavU1kK8w0AyqQmyBRtkLZfSkQA6zW+LJuCdq06ucxjAUwU2SnNl9C
	 S6l/1gb8UnIa4WbKObEzetVaf+A1sanyc7LHksalh3K8poKR5ZMRa+6xkkI0cgqR78A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792651613;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=pLH6Qdvd1b3FuoOMzQUoR0sieayKiNlgZnbtx7OcG3Q=;
	b=X5/w1Fq1GIh55G/qcjor0sCspgjh0kMIYEyfNRV7uUVpXwqcI+IVfIdfPlvwPEV/uBhr
	 DO1W1uFI0i/rfYEDfRycebChTIni1qmGpmR0sPZmrDrg9s065YUQXfvg6WgFch/5cVcEY
	 85sBeyUIpmaH7TYGg02ZuDAPuQ4r0VRWFFH0VIXmqGkgR4NA98wYT7VdXQ1La6NyRVjsN
	 ioCYMSH690aCGfv9f7YBmVag33x03lnKOexehB3Hjk1/ez9zu5k+AO22fZpb80pTM1jdE
	 X7RwdUV0AQIcBpSR66tSZJ6isl6cMYrIugb4lSlYXG/rb2+ceIZy//QpZRiZTmvYOGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gentwo.org;
	spf=pass smtp.mailfrom=gentwo.org;
	dkim=pass header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=b2cnkebq;
	arc=none smtp.remote-ip=62.72.0.81
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5190606A333
	for <damon@lists.linux.dev>; Thu, 22 Oct 2026 06:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5190606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=b2cnkebq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1792650987;
	bh=fYjhazpEBlwVy5VKWAIlQqmd3ajCfxb+TAv31L0DTU8=;
	h=From:Date:Subject:To:Cc:From;
	b=b2cnkebqTtrGA61q++7aBVW98HIpNhjojmw2R8y4prNqHRHcQtWHnAB83q5b6wXva
	 TAXrDevp06k6JaLYdGBKq1OV33MBzEJbUUXcHgQjlGuC1LYGBoD2ID5cOsa//wPnOR
	 VZ/cAOIdNUOdORXFJ7S6D/7kTX8JJjf7DMA13YmY=
Received: from sut02sys-r112.scc-lab.amperecomputing.com (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTPS id 2861B4014B;
	Wed, 21 Oct 2026 23:36:27 -0700 (PDT)
From: "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
Date: Wed, 21 Oct 2026 23:36:19 -0700
Subject: [PATCH] mm/damon: align MMU notifier range when clearing PTE young
 bit
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-damon-align-pte-young-notifier-v1-1-d0365ac45b66@gentwo.org>
X-B4-Tracking: v=1; b=H4sIAOKu2WoC/x3NQQqDMBBG4avIrB1IQiu2Vykugv6JA3YiiZYW8
 e4NLr/NewcVZEGhZ3NQxkeKJK2wbUPj7DWCZaomZ1xnjbM8+XdS9otE5XUD/9KukTVtEgSZ0Qf
 7gEF/G+9UI2tGkO81eA3n+QfcHCE9cAAAAA==
X-Change-ID: 20261021-damon-align-pte-young-notifier-e8f19e0e84c5
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Fernand Sieber <sieberf@amazon.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
 SeongJae Park <sjpark@amazon.de>, Leonard Foerster <foersleo@amazon.de>, 
 Shubhang Kaushik <shubhang@os.amperecomputing.com>, 
 "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792650987; l=1929;
 i=sh@gentwo.org; s=20251010; h=from:subject:message-id;
 bh=fYjhazpEBlwVy5VKWAIlQqmd3ajCfxb+TAv31L0DTU8=;
 b=9AcM83hLd7/2h4L5Mf1b9QDePmOKX6eHev2pmDfbiGeFBEiRY8bhh6P8HWzNioPWEW7BE34m8
 jhZGCOqfAiMCn0Lqc/6udvqeaAZKUysZ2rKn/cvSY001uqNJXnPRgZ4
X-Developer-Key: i=sh@gentwo.org; a=ed25519;
 pk=jc8YIRvxPSyJaBRe5y+a4N0RXKBUEcAh8+OFhlROXPY=

DAMON selects a byte-granular sampling address.  damon_ptep_mkold()
clears the young bit of the PTE covering that address, but passes the
unaligned range [addr, addr + PAGE_SIZE) to MMU notifiers.

For an unaligned address, that range extends into the following page.
KVM ages every guest page intersecting the notifier range, so it can age
a secondary mapping for the following page although DAMON cleared only
the sampled page's primary PTE.

Align the address before both the primary PTE operation and the
MMU notifier call so that they cover the same page.

Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces")
Signed-off-by: Shubhang Kaushik (Ampere) <sh@gentwo.org>
---
 mm/damon/ops-common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 8fc61d06d358597c4b8eec9523865f43496298d1..848c327f231e722499b9aac2c041b3aa84061d56 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -46,6 +46,8 @@ void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr
 	bool young = false;
 	unsigned long pfn;
 
+	addr = PAGE_ALIGN_DOWN(addr);
+
 	if (likely(pte_present(pteval)))
 		pfn = pte_pfn(pteval);
 	else
@@ -65,8 +67,7 @@ void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr
 		 * Arch implementation of ptep_test_and_clear_young() may
 		 * require aligned @addr
 		 */
-		young |= ptep_test_and_clear_young(vma, PAGE_ALIGN_DOWN(addr),
-				pte);
+		young |= ptep_test_and_clear_young(vma, addr, pte);
 	young |= mmu_notifier_clear_young(vma->vm_mm, addr, addr + PAGE_SIZE);
 	if (young)
 		folio_set_young(folio);

---
base-commit: 4403278e4ea2f654f8130a5c03eb8b4516a0f201
change-id: 20261021-damon-align-pte-young-notifier-e8f19e0e84c5

Best regards,
-- 
Shubhang Kaushik (Ampere) <sh@gentwo.org>

