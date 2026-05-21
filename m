Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7CE32B115;
	Thu, 21 May 2026 03:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779335641; cv=none; b=uA1Xp6GkPt8D2kGHEgf60GsMb6ZE0z5XYEosrxirti1XFEYvDU0IGp9AD1cRXBmIWrEHDuIoyQOdNn2vqCG1HBlAXlGEzDPAu+NCyupoycMxF8DQhrMdDus7Ij64+XkygM68rND5BlmAUIwTPs20TJlDWq6ENjWl4QeATQLuwOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779335641; c=relaxed/simple;
	bh=8B9IiCSCXwYFGO3g7QwEtxLcmC3JtXQgAOF4um9StEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tR5bxzAHHhrIEUlFWpvkxy1OuYaZcM2ArS4ayjuhTEB8f2QF5F+NzsOHZFIjCiMH/HgsPatCnN/EBKrhsA+3D8wFBhNhoAf8sq0Y6pCYelqok1jBH7ejS2S2+UZPNPvh1JIxCAtyUl7OmR015YIHJuH/MKdn7BpIgraKeF5bl6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5iXL/C1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5iXL/C1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5621F00A3C;
	Thu, 21 May 2026 03:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779335640;
	bh=5i2WVbg2PjBsmn2NfpjKEh0VGjqNajgL/l9BFto2EhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S5iXL/C1blLg/GyK2CQmNtbMwDPo3AXZFESdgEudrFXr0+gB4eLnW/2CoeEHiVVg/
	 CgaueD1eASKKsZ7KwUpa2CtfZAQDOc8zkPdwxVaKguWFWFXjaTv0uaCKWN3pSnW7O+
	 bDJLwVwwIv6EmwrNXqa6feOMeC5OE3lVNUmzwR18x6lHQl1NhFuNDIBEGVi/f7O9/Y
	 w+gDlv5V418PkQ5CYft9a9NKngoHUJjmjL9qoSTcDB383HBoZDD9sP+3Mh9UHuyFq9
	 E0S7nHA4yfQZAaM6YMdVdxPiB9BmfzwprER6t42CCeZK6TLj0rDPrQaoc4futrNIbY
	 dyaxOhRY6+J2Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 01/14] mm/damon/core: safely handle no region case in damon_set_regions()
Date: Wed, 20 May 2026 20:53:35 -0700
Message-ID: <20260521035349.87565-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521035349.87565-1-sj@kernel.org>
References: <20260521035349.87565-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_set_regions() calls damon_first_region() regardless of the number
of DAMON regions in a given DAMON target.  damon_first_region()
internally uses list_first_entry(), which clearly documents the list is
expected to be not empty.  Due to the internal implementation of the
macro, damon_set_regions() is safe for now.  But the internal
implementation of the macro can be changed in future.  Refactor the
function to explicitly and safely handle the empty region list case
without depending on the internal implementation.

No behavioral change is intended.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0267faf216b95..40946a7f6f549 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -356,6 +356,19 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 			damon_destroy_region(r, t);
 	}
 
+	if (!damon_nr_regions(t)) {
+		for (i = 0; i < nr_ranges; i++) {
+			r = damon_new_region(
+					ALIGN_DOWN(ranges[i].start,
+						min_region_sz),
+					ALIGN(ranges[i].end, min_region_sz));
+			if (!r)
+				return -ENOMEM;
+			damon_add_region(r, t);
+		}
+		return 0;
+	}
+
 	r = damon_first_region(t);
 	/* Add new regions or resize existing regions to fit in the ranges */
 	for (i = 0; i < nr_ranges; i++) {
-- 
2.47.3
