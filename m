Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CCC279DCA;
	Fri, 10 Jul 2026 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691226; cv=none; b=QITq1aE5UQkNNxJPNhkb6jF8CvRwB6uMGa/K5qznUSz3XYVVVPWNHMmuxopps52pJtAA5oeuW3GkungPN5VBNkOjRCdgbOjePP9ED+Cth9fSc3mPF89pjFaGwwEn79uupDIPf+ZMYVMzG9yZtla6h7oYSscYMJBJ2YOI3zyDQWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691226; c=relaxed/simple;
	bh=wJvOYnu/IzvhhLERBhiEReHmfn6Ythxb4EzYa1WQKBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IpjOLyOSsyaRc1+d5V/JiuFPjScxXHPIEduj0Mm2IcIUidpyPv5g2168B0BafpycIDsd1yE3J2YPGXOb9JFOPP5/LYwvNXZxCapirPKPx9As3Fa/H/xl3o9CVmRCP0cFf1gx+zATGFxUurMI0s3vgaexTsauaGvir6rhNZ6aisQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dI4w4lHm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dI4w4lHm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133F31F00ADE;
	Fri, 10 Jul 2026 13:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783691225;
	bh=tjxwjzI1jDT7bs2h2B+hgVQdgy3iqBX4IuJ/qCYlBQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dI4w4lHmgMu6VOLTCkMjGUQXS8crc8cdSQLEeJwGqCUy3hS2Q3il4+Qy4WxAStp5J
	 qnpZzchpGDIN9XtcDI1eEMG4OcWw7AOU1h7AmMPwK0fb9Fq8XkpZeyGRszQW7x1xgM
	 XBP557HVSRfofWsxTSxk8gRkbiddJo0PBLgJ94VfvppqrACRYcQc5nil39dP/XFoNM
	 Cd19EkDaPDiU/u9udVHWsHLjcuNj6zo6de3HEq2nNxzGB+RAUKMIZH+Jm0bDrRvxeg
	 c9Lq57lLzO1ti0FSLiPagtgiRAenPhC5iF47c48RdqzDdAnfT9IBI8wgOPSV4CZL4O
	 vAtWC/T25Oh9w==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 15/19] mm/damon/core: implement damon_has_probe_weight()
Date: Fri, 10 Jul 2026 06:46:44 -0700
Message-ID: <20260710134651.18084-16-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710134651.18084-1-sj@kernel.org>
References: <20260710134651.18084-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON monitors only data attributes when probe weights are set.
However, the function for detecting it is intentionally returning false
always.  The intention was to make changes for complete support of the
mode in a safe and incremental way.  Now all the building blocks are
made.  Complete the mode detection function so that the mode can really
start working.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 91964336ce31e..806a67d02a6e9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -211,6 +211,12 @@ static struct damon_probe *damon_nth_probe(int n, struct damon_ctx *ctx)
 
 static bool damon_has_probe_weights(struct damon_ctx *c)
 {
+	struct damon_probe *p;
+
+	damon_for_each_probe(p, c) {
+		if (p->weight)
+			return true;
+	}
 	return false;
 }
 
-- 
2.47.3
