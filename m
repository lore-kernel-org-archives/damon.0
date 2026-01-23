Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DE33859D5
	for <damon@lists.linux.dev>; Fri, 23 Jan 2026 04:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769144275; cv=none; b=FP5dAu5vXh1NV49BPRY5O0NoCHh8tGmaNRxiTs3+pUHUgGQx2IfQIA0BsEl7T5EMbcGjLWC4EJOtIWTwbVTEfPOiGJ50Vi2W3FZ/MKXpWOVeg/wvswby4RRW2DEruh/NN2f8cLElh0lI4NS74j2fkS6jA5JzRMozNh0FyFAoOfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769144275; c=relaxed/simple;
	bh=REwnbFI5Ih419YIeGbeMhAV79Y8hP0BScdx6C3Cv9Aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICiF2t58CajXAlTH7225Nm8UTILapCiWuWniEAoOn9DDyjXYKTDfJSRo0wXx7+Sn2D4/CDg5AZYdYBjohIDeN+bkjmID/jS4PvTwN7+GN54qxeaziDDc1gqDIhr3zHuL4Tuv+S9TCCXwjcGt+9mPExduva8WBAufElRRnLdb3lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncaAgYsa; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncaAgYsa"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-7927b1620ddso26722257b3.0
        for <damon@lists.linux.dev>; Thu, 22 Jan 2026 20:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769144267; x=1769749067; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2Hj3YMXyp6jb16WaA5iRCtpYS8eji7c2VCvrHXWtMA=;
        b=ncaAgYsauOnj6N+waJP7eFg66fssha7GX+3lN2MPI7w8gbXdH4Wjq0QyNoe6MAT5i5
         mV7eRlJXDsi/lOnqs3GknvCiVtInAu4V5qcFFkIJ78xTWHR+6pHC2QZWOuFVjN9sTCp3
         K3T6uHVSNowsxBxp7RKh3uUZ7ub+EHxtL0gUs0CUGLTT7OaNj6rt1g4H5959htTmwW97
         ox/4N+OYzuDfz7pZuEInonYrVsuMV5c8KG4ROs6CAEFDBFR5yduOc+q8aijaq69TSw2h
         852fYYDKD9g22hyCLXzR3UNgynoAGIu5Sqp5VEmBC5m3E9lU3MoAP3QJNaEp1Mn2HN28
         zg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769144267; x=1769749067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W2Hj3YMXyp6jb16WaA5iRCtpYS8eji7c2VCvrHXWtMA=;
        b=YKEWpM69MYNZg/tQsjhInMxt2Ki0edYXMR5brQovsLoB80N6+kzLnqCqZdMi5MtFSf
         GwDVs6q/WlivvvJvQxlaF+Bx+C5uRB96bscmkcxwbQLr3CeXpYnWfAtfsDF0WeGMskEV
         OW2CIvK0d6cCqnP6mGi9URTKgBSs4g7uf1JtLuJxvKxSPFUy8wPIwCO3ImXeju8W5XyQ
         5KVbYVwiKEUr3ZFIC3PqPZzWGkrL0rY/ErHNle3z+NRErRNIrZ2zl+v1K20/PPFrlOXv
         gVAKuZbK/gMQV+txKnjzpOAkfk9sBkoOFHO1Y/XFcDrmOtrdSTkMV2Z06DKS5PFpPqyg
         eMvA==
X-Gm-Message-State: AOJu0Yyj3+nrPmnS8kAXiNfYdUw71g1Qn2brzBxa0FCUgspkh0ukPGEG
	fpZdZGYTIiiMpW+D6bQKYgIdPlRpB0JInAZHcoq3SkBl3N/6Ui1Y1hcN417ruk0=
X-Gm-Gg: AZuq6aJUn6Ao0OpkZ8EU2AgEOQUAZgY6xRPjulLMvrRhM/5P2SVeyFxc2emuurey/69
	yH5SsDLY8ML0nL4NV28y31n752NVMVnWmZgK6u4H7C+D4TYaRru6ulQYXMV/nMCcsegzvIr2N0/
	utFFveWYHffNw1mJJeSj/gWL5kEtECRsdWbYj25+w2uAoJMQtpAkwwC0RIRNOUdGEjh82NoyArl
	XuxGyNeOwkjj+t9Gb+4gTnFOvGVx92CaRHX0KzdWq59GXloEM+F5eSOY+imoAhC7DKD8jDvW1jo
	OfAsRlqOHWJ3ZWbH+HkXDxtd51JHZEP5tDffrq8roAiQY5eLjev43ryZLasT1ihI1XpqQj4wLnH
	PCVwnA9wUBi55rC9EgCLLxBkrUUiRsGIVCjbESxHmMqARybyv/qpyiZmzl8Xlwavb1jbIGohn2m
	yJyOzFkMZ0WtIwVsm9c9Fyhd36VEvPC+dmbdwZe0FsMcdnB8i80eyyaT0j38k/oA==
X-Received: by 2002:a05:690c:688f:b0:794:1f46:79eb with SMTP id 00721157ae682-7942a70b7dcmr45404977b3.5.1769144267450;
        Thu, 22 Jan 2026 20:57:47 -0800 (PST)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7943af14432sm6354717b3.8.2026.01.22.20.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 20:57:47 -0800 (PST)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Subject: [RFC PATCH 4/5] mm/damon/paddr: capacity clamp and directional early-exit for node_sys_bp
Date: Thu, 22 Jan 2026 20:57:27 -0800
Message-ID: <20260123045733.6954-5-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123045733.6954-1-ravis.opensrc@gmail.com>
References: <20260123045733.6954-1-ravis.opensrc@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clamp effective target to node capacity (bp) and skip in-migration if
the node already meets/exceeds it. This avoids oscillation and
unnecessary work in two-context DRAM/CXL setups when quota goals
(e.g., node_sys_bp) are met.

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 mm/damon/paddr.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 30e4e5663dcb..64dbdd2196a5 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -300,10 +300,54 @@ static unsigned long damon_pa_deactivate_pages(struct damon_region *r,
 			sz_filter_passed);
 }
 
+static unsigned long damon_pa_node_capacity_bp(int nid)
+{
+	struct pglist_data *pgdat;
+	unsigned long sys_total = damon_pa_totalram_bytes();
+	unsigned long node_pages, node_total;
+
+	if (nid < 0 || !sys_total)
+		return 0;
+	pgdat = NODE_DATA(nid);
+	if (!pgdat)
+		return 0;
+	node_pages = pgdat->node_spanned_pages;
+	node_total = node_pages << PAGE_SHIFT;
+	return div64_u64((u64)node_total * 10000ULL, sys_total);
+}
+
 static unsigned long damon_pa_migrate(struct damon_region *r,
 		unsigned long addr_unit, struct damos *s,
 		unsigned long *sz_filter_passed)
 {
+	/*
+	 * Capacity clamp + directional early-exit for node_sys_bp goals:
+	 * If we are migrating INTO g->nid and the current bp for that node is
+	 * already >= min(target_bp, capacity_bp), skip work this interval.
+	 */
+	{
+		struct damos_quota_goal *g;
+
+		list_for_each_entry(g, &s->quota.goals, list) {
+			unsigned long cap_bp, effective_target_bp;
+
+			if (g->metric != DAMOS_QUOTA_NODE_SYS_BP)
+				continue;
+			if (g->nid < 0)
+				continue;
+
+			cap_bp = damon_pa_node_capacity_bp(g->nid);
+			if (!cap_bp)
+				break;
+
+			effective_target_bp = min(g->target_value, cap_bp);
+			if (s->target_nid == g->nid &&
+			    g->current_value >= effective_target_bp)
+				return 0;
+			break;
+		}
+	}
+
 	phys_addr_t addr, applied;
 	LIST_HEAD(folio_list);
 	struct folio *folio;
-- 
2.43.0

