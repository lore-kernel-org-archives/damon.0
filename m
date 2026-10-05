Received: from mail-yx2-f1.google.com (mail-yx2-f1.google.com [74.125.224.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F1C3C2BB4
	for <damon@lists.linux.dev>; Mon,  5 Oct 2026 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190036; cv=none; b=c8R+ePlRRZx01iD17FkIFp5kKf5Df7AWt6V9CZmR5T/po0abef/Ie4yZWv7zftqSJfNarq8dXQgkC/fc5CDHBoq1llGgxpjknV0rR7Tx5vNIKGOsCDA4kWQpD5/MAkvvoVg+SRDXlaGIc7a/mgmCuKYbu5cOel5kG4r7cs4HeFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190036; c=relaxed/simple;
	bh=hlWXkLzfFKbZ3Rje739fg5OrVaMmBszukle3NRqBO/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lvXh0J7lp47kLO8MhgtvBf73/QIBBA0L8+fauXGJ7jb2nugr204pglMbMKMPNC9MjZGmfk8ysbhgGv9h2ieuBfkYRsII6wQaQE2mW6t2LkHoYvdZZ9fPdkN2i3kv2MMPhsBfXdA9yBi3oKWWLUmSlhz5s5/EYfAZKwIQPAEF8qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1eUVKNV; arc=none smtp.client-ip=74.125.224.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1eUVKNV"
Received: by mail-yx2-f1.google.com with SMTP id 956f58d0204a3-66d27631526so449470d50.1
        for <damon@lists.linux.dev>; Mon, 05 Oct 2026 01:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791190033; x=1791794833; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3lOJYATF5GzgxnR6rvCgXN1lfrW7Tn1J/cuI+kptyHw=;
        b=e1eUVKNV/qZ2YymDLo5IXVx+pdYrUWsRtTOVzwO0leAp605073/TLTCc5v2D8X7sWe
         2uAzKYwDBMFIYCdACmzXfuBwG8GlqFxrgm8FbXHFNFh7/DE4ZwhKrzYJbR3OcLnJbG6w
         eixkkvhpwihoRkkA2Go9nLRImHJLxcPIUClBrNE8FmO5aPTq+IyaqntZtRQiK0mF14y6
         ATIIhNvyL6xKX6AcigAF26Js6MZsA/m1gq6TzXXtZAvYjm1HAIwYq+wSgMhzR9+bOyng
         ApHlSJa1Qll26zrcNOvs6CphVzjAH/XxpGbdxI701VwMuAritRUSW5JCQDjAjAIEZjip
         QNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791190033; x=1791794833;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3lOJYATF5GzgxnR6rvCgXN1lfrW7Tn1J/cuI+kptyHw=;
        b=uGAVt95Zp0p4XDF+7jU4dR1Ui6JF0cCU6L8Nl1FMq6RxsBA+IvLf9pLpD3ulMfvP5s
         TemjjsX87kjf0ZpBF2HRCEtSkQyvX9RrKvD6DtWHzajghTkaUuYy0e4/fMcbvvAkazKm
         JHVuBEnUUUHY+5yLZ0LPZqoZJyIXc0yog2LY5P8i5oFe4sbJbJHwiqiPHtHzscA8t+kq
         mfs55vi01W61gW3lLNSgNEY3xOoCETc5Pv6YZ3Avlz3apMqZwbw68/Is1e0POHpAgIJc
         rXXTLEWBeyOrxMWOedHQGJpp3PikalowHmiCpFobtyDd4DQAntYoaonhFiPdMyYAc2Tc
         pjHA==
X-Gm-Message-State: AFq9FYLe2aj7GE79EVsG0odzgRPciWT/0bPEB7qIClI8Gbc8R1nzpkWe
	b7AQMwXC2sgzjIbKrAcmhs8oIDeqPONko/kRkOUpx/BJUYDlPyy92Kk=
X-Gm-Gg: AYBFou1cYTOk421bH0ecMzkgz2PGegnSSuQfGEcHIVzqabb2xSdVVR9fr9wOt2NYSk7
	ZvLDIjsoaT0DiQoAmlF1+2H/F40BIADQI1kHahjwyp5T+xEMacLOLdi/QkbmHsegYhKOBBA43P6
	W5wSsQiIx1ecC0mU/OgiaPdq5/vwNmWA3dG8hzh2qofTN2b9JKHCtK700h+VZXY/oOfgzXatin9
	pPdjXUDQrzdZkICagc8xtQBi33LEBGj6AOHRc0KL2xo3eQwbvM6C+SVJA6/JPIaPn6oUYJCISpC
	lLJNNCCKg7tT/+Sv3+GFmt8mkY4m636yl2sN4Kl6RGT52ruwO63Z9JWcalrT1F5Ou6E+Uk0nFnj
	vnw8el22oBiFO2Iy5EKpYiwpf4SQBF208BWLrtFvRrUZ1O1/GiukDzJH0MESjghTYAB56tZV8Ei
	PyphjNrw4t8RQMxZeAdJ2TU2FNQ7skL09ceID5iA05byQgxkAqhQzo3ii68LDkbNQuKgnsqU5l7
	8/KglSFYIu5BO4F9ojygfvzwNYwhiK/SmhBs0JD2cQIpJWzORtRDb+KXr9/APp6sUMJT+BWuBtz
	ZcxA35m/Lomon4Y8bcExR4842QH+qY0kzw==
X-Received: by 2002:a05:690e:12c2:b0:677:afe7:1f98 with SMTP id 956f58d0204a3-677bd3e2c84mr2661304d50.83.1791190033376;
        Mon, 05 Oct 2026 01:47:13 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:1700:4577:1050:1149:2fcd:c86b:8747])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-677c1b9c895sm2346306d50.13.2026.10.05.01.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 01:47:12 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Mon, 05 Oct 2026 01:46:52 -0700
Subject: [RFC PATCH v4 8/9] mm/damon/core: cap the region merge threshold
 per target
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-8-b03452e137f3@gmail.com>
References: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-0-b03452e137f3@gmail.com>
In-Reply-To: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-0-b03452e137f3@gmail.com>
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Gregory Price <gourry@gourry.net>, David Rientjes <rientjes@google.com>, 
 Wei Xu <weixugc@google.com>, Jonathan Corbet <corbet@lwn.net>, 
 Bijan Tabatabai <bijan311@gmail.com>, Ajay Joshi <ajayjoshi@micron.com>, 
 Honggyu Kim <honggyu.kim@sk.com>, Yunjeong Mun <yunjeong.mun@sk.com>, 
 Akinobu Mita <akinobu.mita@gmail.com>, Lian Wang <lianux.mm@gmail.com>, 
 Kunwu Chan <kunwu.chan@linux.dev>, 
 Ravi Jonnalagadda <ravis.opensrc@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.16.0

kdamond_merge_regions() applies one context-wide threshold, the highest
merge score across all targets divided by 10, to every target.  When a
high-traffic target and a low-traffic target share a context, the
high-traffic target sets a threshold permissive enough to erase the
hot/cold boundary in the low-traffic one: a region with nr_accesses=1
next to one with nr_accesses=0 merges because 1 <= threshold, even though
that difference is the only signal the cold scheme has to admit it.

On the regular merge pass, cap the threshold for each target by a tenth of
that target's own maximum merge score.  The score is the one
damon_merge_regions_of() compares, so a probe-weighted context is capped
by its weighted hit sums.

The passes that follow the regular one exist only to bring the region
count under max_nr_regions by escalating the threshold.  They keep using
the escalated threshold uncapped, so that bound still holds.

In a probe-weighted context the merge score is a weighted hit sum, which
can exceed max_thres, the samples-per-aggregation ceiling the escalating
passes stop at, when the probe weights sum above 1.  Raise max_thres to
ten times the initial threshold there, so those passes still run.

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 mm/damon/core.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index e3c29d7cff23..7c0df07f0a90 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -4167,12 +4167,40 @@ static noinline_for_stack void kdamond_merge_regions(struct damon_ctx *c,
 	unsigned int nr_regions;
 	unsigned int max_thres;
 	bool count_age = true;
+	bool use_probe_hits = damon_has_probe_weights(c);
 
 	max_thres = damon_nr_samples_per_aggr(&c->attrs);
+	/* weighted scores can exceed max_thres; threshold is max score / 10 */
+	if (use_probe_hits)
+		max_thres = max(threshold * 10, max_thres);
 	while (true) {
 		nr_regions = 0;
 		damon_for_each_target(t, c) {
-			damon_merge_regions_of(t, threshold, sz_limit, c,
+			struct damon_region *r;
+			unsigned int t_max = 0, t_thres = threshold;
+
+			/*
+			 * On the regular pass, cap the threshold at a tenth of
+			 * this target's maximum merge score.  A high-traffic
+			 * target in the same context must not set a threshold
+			 * so permissive that a low-traffic target's hot/cold
+			 * boundary merges away before the cold scheme can act
+			 * on it.  The score is the one damon_merge_regions_of()
+			 * compares, so probe-weighted contexts are capped by
+			 * their weighted hit sums.
+			 *
+			 * The passes that follow exist only to bring the region
+			 * count under max_nr_regions, so they use the escalated
+			 * threshold as is.
+			 */
+			if (count_age) {
+				damon_for_each_region(r, t)
+					t_max = max(t_max,
+						damon_merge_score(r, false, c,
+							use_probe_hits));
+				t_thres = min(threshold, t_max / 10);
+			}
+			damon_merge_regions_of(t, t_thres, sz_limit, c,
 					count_age);
 			nr_regions += damon_nr_regions(t);
 		}

-- 
Git-157)

