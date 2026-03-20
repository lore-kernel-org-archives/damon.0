Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9380B279DC8;
	Fri, 20 Mar 2026 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017417; cv=none; b=oson9Ew9By1UqKwEq5op8ijQth6S11oxQGcJiwlWD+74S8ibR202bxmu+2r7z1hozh19PGSX7k8WlK1KBhtewkeG6E8BuJRinBUF0Jso98zHm+jfNhIXSC/HijoXFi6zLTPYkmp632Nk7HBV0oE1kV+tVU3whTjV7C5y3x6n3Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017417; c=relaxed/simple;
	bh=57rJfUQAzyJc72kKvlo3Pe8XwVTNUIRzo2jHH5/276s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r2Ah1UD8GkXWAcNV2EJWQKoF6bU2uV/NPGDevHrOVBEduQfzeySsFfJDv+1P6ebmwkTb9lB6BsQh1C+cG0rcRH6j82Ew3Z/k/jDD8S7K0aBiTkFucQS+Fl9LWe/5DDQ3g5LL30k5cCctZ+QpaFMqer5TbXcpj6WeLGmv4X1rycY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKVTp6KA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKVTp6KA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B720C19425;
	Fri, 20 Mar 2026 14:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774017417;
	bh=57rJfUQAzyJc72kKvlo3Pe8XwVTNUIRzo2jHH5/276s=;
	h=From:To:Cc:Subject:Date:From;
	b=oKVTp6KAQCxqCCoKSLQzOOSP35j2OIp7iBzMm2hm2Pcd7chbFmWhl0eOFJn1ojRR2
	 as0eQmcmZk6Kc2mbV2yTAXZmd8qtl1UEfzZW6Eh9qh46HJFHrdscn7YkMXrnQfYb3A
	 v4pfhjFDR/jKcOU+DbNbDLa/sLuA2AHQQ9z33yZ2oGHeGoTQvMKZ8ibkHX2smSkLU8
	 /7p0PnQvO2VDEbrRs9Zrgm8KfiSoPPZeGAHoMY29yewq0WiwYzY5GXLaksDcuPkMxd
	 1hhn8+VCJY4LnOYHQD3rrQ5uvl4G8IRXw2+NqfOS1ADvgPeRkHuL/CEsp5y39BMyam
	 QWf1OkLYGZYdg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Josh Law <objecting@objecting.org>,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2] mm/damon/core: document damos_commit_dests() failure semantics
Date: Fri, 20 Mar 2026 07:36:45 -0700
Message-ID: <20260320143648.91673-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Josh Law <objecting@objecting.org>

Add a kernel-doc-like comment to damos_commit_dests() documenting its
allocation failure contract: on -ENOMEM, the destination structure is
left in a partially torn-down state that is safe to deallocate via
damon_destroy_scheme(), but must not be reused for further commits.

This was unclear from the code alone and led to a separate patch [1]
attempting to reset nr_dests on failure.  Make the intended usage
explicit so future readers do not repeat the confusion.

[1] https://lore.kernel.org/20260318214939.36100-1-objecting@objecting.org

Signed-off-by: Josh Law <objecting@objecting.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from v1
(https://lore.kernel.org/20260319071332.114595-1-objecting@objecting.org)
- Use kernel-doc like comment instead of kernel-doc for static function.
- Add a link to the previous discussion.
- Update description.
- Rebase to latest mm-new.
- Collect Reviewed-by: of SJ.

 mm/damon/core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4dae03a37f9ac..df9f5e94e0ddd 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1060,6 +1060,23 @@ static void damos_set_filters_default_reject(struct damos *s)
 		damos_filters_default_reject(&s->ops_filters);
 }
 
+/*
+ * damos_commit_dests() - Copy migration destinations from @src to @dst.
+ * @dst:	Destination structure to update.
+ * @src:	Source structure to copy from.
+ *
+ * If the number of destinations has changed, the old arrays in @dst are freed
+ * and new ones are allocated.  On success, @dst contains a full copy of
+ * @src's arrays and count.
+ *
+ * On allocation failure, @dst is left in a partially torn-down state: its
+ * arrays may be NULL and @nr_dests may not reflect the actual allocation
+ * sizes.  The structure remains safe to deallocate via damon_destroy_scheme(),
+ * but callers must not reuse @dst for further commits — it should be
+ * discarded.
+ *
+ * Return: 0 on success, -ENOMEM on allocation failure.
+ */
 static int damos_commit_dests(struct damos_migrate_dests *dst,
 		struct damos_migrate_dests *src)
 {

base-commit: 4fbbbf18fd43c2d7b692749b7c853157f901b709
-- 
2.47.3
