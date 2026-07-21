Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0073837FF4D;
	Tue, 21 Jul 2026 14:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784642420; cv=none; b=Ltn9qf55qDR8btoj1qolOtdahN99F4Wlivn8FkrbIw55XIhnPFZytouh+q2+tcavA8xiM+IEclslRG5yPdMIaCOV1Kjp1wNGnh5jXicz1YA8rRMvjwnXdBH3Z8jJ7JqgKCBaTK+Y2St42LV1zCyE81fu2mVzrkWnglsWIpohlZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784642420; c=relaxed/simple;
	bh=eL5R4YB4LCq1ily5WOK40fam4AzGckf3CIltPbXbFyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Im2kUddZOQUEX6AtejW7X6f6bEYn63W+TfdqKEbB1nb/R3mA8OJ+UTPvsrDw/39lBR8PW/g/doq3w/CU3b+qs+6x+jb/FQ2vHTKf3xirroXNtegKAgJRc2EHpZNYWEV+jCGXJp6KPfq/OIORuYQcbuHh84tIvty3ixLTn0Jk4KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmnZeN6C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmnZeN6C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC94C1F000E9;
	Tue, 21 Jul 2026 14:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784642418;
	bh=5kvsTALewnJop1SQtBJM/PtaPw7n/wsahc/oz32/CFo=;
	h=From:To:Cc:Subject:Date;
	b=cmnZeN6CSbqRir7FX072q6EIxo4sdd8KK04/wt2lC1r8iIc5SyY5U418lfkkn9Rne
	 m9nPJbyv/l64Zb/B1W2Dt8st6QX/AnuROpyeyQZC1YLdHeV0flX5hz7JTTrCBTGsgj
	 5HZfTq6KChBQfOXcTg/6JwuoxX4BS3vjRYbX3pgh1o+PamGyPssK3BeYTbFCjT9W9P
	 /WK25fmnEXFeZCMp94af628rY4Y2El7Kij0yJRS05U2oNHSAC51sMS8BmIPpU8IZdV
	 F/DB/DC+FMVkoAClJgstTIfcb1F14XQC6EV8y0NMcIFrBZ1usbam0EPZ2hAPydowwj
	 ohceOVmK8KVRg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Song Hu <husong@kylinos.cn>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2] mm/damon: update outdated comment about DAMOS filter handling
Date: Tue, 21 Jul 2026 07:00:08 -0700
Message-ID: <20260721140011.269802-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Song Hu <husong@kylinos.cn>

The kernel-doc comment above enum damos_filter_type states that only the
anon and memcg type filters are handled by damon_operations (and therefore
accounted as 'tried'), and that DAMON_OPS_VADDR and DAMON_OPS_FVADDR do
not support those two filter types.

Neither is accurate anymore.  damos_filter_for_ops() routes every filter
type except ADDR and TARGET to the operations layer, and the VADDR and
FVADDR operations (the latter being a copy of the former) handle all of
those types through damos_folio_filter_match() / damos_va_filter_out().
Update the comment to match the code.

Signed-off-by: Song Hu <husong@kylinos.cn>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20260715092634.1450702-1-husong@kylinos.cn
- Collect R-b: from SJ.
- Rebase to the latest mm-new.
- Update subject prefix.

 include/linux/damon.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 327f534696aa8..0c8b7ddef9abb 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -398,16 +398,15 @@ struct damos_stat {
  * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
  * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
  *
- * The anon pages type and memcg type filters are handled by underlying
- * &struct damon_operations as a part of scheme action trying, and therefore
- * accounted as 'tried'.  In contrast, other types are handled by core layer
- * before trying of the action and therefore not accounted as 'tried'.
+ * All types except &DAMOS_FILTER_TYPE_ADDR and &DAMOS_FILTER_TYPE_TARGET
+ * are handled by the underlying &struct damon_operations as a part of scheme
+ * action trying, and therefore accounted as 'tried'.  In contrast,
+ * &DAMOS_FILTER_TYPE_ADDR and &DAMOS_FILTER_TYPE_TARGET filters are handled
+ * by the core layer before trying of the action, and therefore not accounted
+ * as 'tried'.
  *
- * The support of the filters that handled by &struct damon_operations depend
- * on the running &struct damon_operations.
- * &enum DAMON_OPS_PADDR supports both anon pages type and memcg type filters,
- * while &enum DAMON_OPS_VADDR and &enum DAMON_OPS_FVADDR don't support any of
- * the two types.
+ * Support for the operations-handled filters depends on the running
+ * &struct damon_operations.
  */
 enum damos_filter_type {
 	DAMOS_FILTER_TYPE_ANON,

base-commit: 74f0a09e6f09bba55182c3a64bace164ecc0cc6b
-- 
2.47.3
