Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306503BADB7;
	Mon, 22 Jun 2026 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782138113; cv=none; b=lUjtNT55s4Qdqf0bkVEEx9Dmnd/Kjns2kX0g6bumEP/wzdmTEFRyea74pNBlP0Q0Lit6Bl3aZMpZzrm5YY3PEG58uHR8tFd7NBa+onvdxe91ZGn/EZzh4cysZrl83IzQIR7ahlN6IEFlFzPA3GCErYWJ/sZEaW8vph/EaOvzQgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782138113; c=relaxed/simple;
	bh=HvPJLmvRUDxCK1LU7PPkPseOZLauww/ECkLe0KIyfng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dkHo25Vt4mctd30vSRAiOnNx79lSccmfnFWpsrVisRcHWIkiUdTmj/JA5Z/IZZgy0zW6Q9ZLpDz0v3/5wEgBjcBylp6zP/NvOMiNozAJKq4Zu4XycQy2+qLud2d01i74JiM83P7rutZf4QRVRh3GkApSySetJ6hXi0chlRxDJmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/gsGAEn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/gsGAEn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7521F000E9;
	Mon, 22 Jun 2026 14:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782138111;
	bh=vYxKAARUNBtbGSRQbbixuaBWR8GWiG7hC3Axny9Vo6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O/gsGAEnXlSwNYVDUgTYyT2hdhwlfwt/Iv9ZnbcnNwYNjfkYlv+kvws666V2jPyq5
	 awGM7v/K6ob7qeo32zuOefsUakp3DX0sbyfiwzcRR084kFhnIwUMSsbHw+mElnoLzX
	 E+28v+qIrUCDwMCda/NMGGoTIm+ajE1EQxIbqFhOwJ4ZDNWb/yVxwn6d1AMp48Fn7r
	 ywyJI3WVLOtBoBzUcvYKzM+1uYqj3JGj2OA1CBUu/E9FGVw59fvAvygAQkfbyjiMDY
	 9ab7v8gNsWc9Lriv4ihnq1D047BGtaiR2tatzmfpemwpLcZVIc2nVWnk2A8kCKieDy
	 pgwxuVoYL+1iw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 04/18] mm/damon/core: handle unreset nr_accesses in damon_nr_accesses_mvsum()
Date: Mon, 22 Jun 2026 07:21:24 -0700
Message-ID: <20260622142139.30269-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622142139.30269-1-sj@kernel.org>
References: <20260622142139.30269-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_set_attrs() works like reverting aggregations that were made so
far for this aggregation window.  If this is the end of the aggregation,
however, kdamond_fn() will do the operations at the end of the
aggregation interval, using cached timestamps.  For such operations that
rely on damon_region->nr_accesses, damon_update_monitoring_results()
doesn't reset the nr_accesses if it is called at the end of the
aggregation window.

damon_nr_accesses_mvsum() works with fresh timestamps, though.  The
nr_accesses that are not reset in this case can make the logic to
unnecessarily count nr_accesses, resulting in returning
higher-than-expected pseudo moving sum nr_accesses.  No code is using
damon_nr_accesses_mvsum() yet, so this is not causing a real problem.
Following commits will add usage of the function, though.  For safe
usages, calculate the pseudo moving sum without nr_accesses if the
remaining window is full.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 191533685cf2f..9d501ad34f44c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -268,6 +268,9 @@ unsigned int damon_nr_accesses_mvsum(struct damon_region *r,
 			ctx->passed_sample_intervals;
 	left_window_bp = mult_frac(left_window, 10000, window_len);
 
+	if (left_window_bp == 10000)
+		return r->last_nr_accesses;
+
 	return damon_mvsum(r->nr_accesses, r->last_nr_accesses,
 			left_window_bp);
 }
-- 
2.47.3
