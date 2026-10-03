Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DBC37186A
	for <damon@lists.linux.dev>; Sat,  3 Oct 2026 21:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791061726; cv=none; b=ZtZcU1jGOXee0R698OBebM76WQ5sN07YncFldevmvN4x4d8AWZFV7IYcSvcQYrGrlijb0wAgsoKQA/X+zKZgIK6sH9sZgDOUDYiuh/XG9wdkPyy0nCNhkzkGXXjUOjb3aALmb3GkhhrUt6SgaKGVtFJXpqUUKt/kmohZulONwa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791061726; c=relaxed/simple;
	bh=Gd6F6ON3yGTMjzqcwtixnePOI3psQQHWcRSQ9XoLHxE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dy+2soxbJwvsMDpwjFRXneV1IUM7KwtfRJR28eOs0gLesIuqW/rh0cxTWl5f3pddfVAmtMx4OCxUdsaIiIJv+CiKvBlGy5wE4dV0Ei9KXDKJ3pWlD7ZhkEc/bBf3LqlcGsg0nDgKizQ13PxHqyqNqQt9vw7hIheDKYLZ0VjCdGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhQ69tFV; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhQ69tFV"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-8ab43af5e97so3420017b3.1
        for <damon@lists.linux.dev>; Sat, 03 Oct 2026 14:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791061722; x=1791666522; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7WdQn6f6AsaloNtXz63r2rYU9L2euT0e0WgByXQq7Q8=;
        b=NhQ69tFVn040HTcNNcprhBSpU1nfk6aaT+K2YghKBgAsY/8Aj0+sWPGAhJzSfQLZc+
         BgKlCyB7Fj6/1Q2v4E+jKBokkstvoLY2YkhfeGrKUwyCh8Y81Zo9NedUEU6uxnrT10bq
         p+jIN8SYIBmFwj9pq8zZeYXKItbWnEi1HH9JDyeckAnt6/IQxXH3GLjHmkRKPmvjtf6H
         xUJRO/Ng/KivABA8RiIDVdXd1mjHt6fR7KAK2PJTyc8L0+SldnjtLqELsPwsMpwRaav1
         sdDooYi97PGLUWaN6jKiB8IJP0vi7o6+Z7z0TTn/GPpUpPSeYDSFImf3XDMVubFFw5ph
         9ltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791061722; x=1791666522;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7WdQn6f6AsaloNtXz63r2rYU9L2euT0e0WgByXQq7Q8=;
        b=SgenyzRJ/79bfLAALxrgyue9PPkrqhkKwB5DqC59imDJBa1U3bajiCJPWGXQ7Mky9s
         u6UzgNwd9R8Oymb56Xc1wBd9em6ZBP/bI3O0Kmv3C57Tn0VI5cW2UsAGATecwyRmhAKm
         4UqLZN9DgZWvYuhpehcLnCag0W4iWoqRinylyoMeZOsZ/YH2JLYAC/iN7Pw00t9obo82
         qekLJQu3iP5WS7YQfl8qg5Gr3wF3kDA0PB6CIvZSHXDUpte6+Hr06+792/0PPDT019mQ
         SxBSYwy74jyPdgzlE6e6DSRrggK5iyDzEKrhoESuIwRSfOvBhvZHYmeNxGFRj26LEVlf
         MvgQ==
X-Gm-Message-State: AFq9FYKC9ZvDePsRRSLIL+u6pkDa83dKNzo6ee6S3Fl6mfWFnAikGURx
	XQqVnrBori1H4f9GSdZPnCZ8Ayt/SwOvC5ERdV9jDhdugO1RXeXmUqc=
X-Gm-Gg: AYBFou24fU6l0bYUJKx3cB6HXs4WcTEFj4q5vqbRbFiQyeGx9CIU7rWskjCiIWcOHLR
	vai2lbtWqQgXF+giCz7t3nRGXnRu6H5l+GLV9qFiujY5v7avWAq/1HcSSk8V5iCL9FZAuObMgKV
	ax8atHEeJXFsXxTfJpzP32q1A50OB3X4tyPqDknstsrxhu9uKCqZUzWU8rg4vz6MY2Xgr0X+Ime
	mLGscOGiiAyQgVUl6YtawUyUlPAKZfrYShDRHjhx9ssCmIqB7OV7JMi9vlvuJW4m1cn6JwSuabv
	8J23hOn7xdcdqyCKAAw3waZQLZDtukT5GDVFlbAWtd0XFXc/rxcswINH+vmf0pmJ5buChYgMk3/
	7500Ozy98iWdkH4I6B/k3v3LTVoqBIHnjtpB5NHcduhdUh3D4kJsuVXk/IJz/R1qGajZjRCEAuZ
	dB18/PjCkcBJejocVUXUrufMUJEvjScABvfwKEbmQKi3fl3mzzbQ/bFgnVSoJDW8X5P0LzU4vR0
	4AaDA99wRet+G84EN6NrWe1I3elMiQzjr0s9dKV2oJ1X9NVp4KvG00zctg89pNs6ChgXdM7XNeJ
	9N/itoYkuJwYRTBdBcTU48lfBV6o2npGmw==
X-Received: by 2002:a05:690c:3181:b0:8ae:98ce:5497 with SMTP id 00721157ae682-8ae98ce7efemr12330927b3.0.1791061722002;
        Sat, 03 Oct 2026 14:08:42 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:1700:4577:1050:550f:9551:5468:60f1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8af0d179d3bsm743537b3.40.2026.10.03.14.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 14:08:41 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Sat, 03 Oct 2026 14:08:01 -0700
Subject: [RFC PATCH v3 8/9] mm/damon/core: cap the region merge threshold
 per target
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-8-0f00417b41bc@gmail.com>
References: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-0-0f00417b41bc@gmail.com>
In-Reply-To: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-0-0f00417b41bc@gmail.com>
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
by its weighted hit sums rather than by nr_accesses, which stays near zero
when access checks are off.

The passes that follow the regular one exist only to bring the region
count under max_nr_regions by escalating the threshold.  They keep using
the escalated threshold uncapped, so that bound still holds.

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 mm/damon/core.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 1d25f820e3f9..c2c74d0daf95 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -4175,12 +4175,36 @@ static noinline_for_stack void kdamond_merge_regions(struct damon_ctx *c,
 	unsigned int nr_regions;
 	unsigned int max_thres;
 	bool count_age = true;
+	bool use_probe_hits = damon_has_probe_weights(c);
 
 	max_thres = damon_nr_samples_per_aggr(&c->attrs);
 	while (true) {
 		nr_regions = 0;
 		damon_for_each_target(t, c) {
-			damon_merge_regions_of(t, threshold, sz_limit, c,
+			struct damon_region *r;
+			unsigned int t_max = 0, t_thres = threshold;
+
+			/*
+			 * On the regular pass, cap the threshold by this
+			 * target's own maximum merge score.  A high-traffic
+			 * target in the same context must not set a threshold so
+			 * permissive that a low-traffic target's hot/cold
+			 * boundary merges away before the cold scheme can act on
+			 * it.  The score is the one damon_merge_regions_of()
+			 * compares, so probe-weighted contexts are capped by
+			 * their weighted hit sums rather than by nr_accesses.
+			 *
+			 * The passes that follow exist only to bring the region
+			 * count under max_nr_regions, so they use the escalated
+			 * threshold as is.
+			 */
+			if (count_age) {
+				damon_for_each_region(r, t)
+					t_max = max(t_max, damon_merge_score(r,
+							false, c, use_probe_hits));
+				t_thres = min(threshold, t_max / 10);
+			}
+			damon_merge_regions_of(t, t_thres, sz_limit, c,
 					count_age);
 			nr_regions += damon_nr_regions(t);
 		}

-- 
Git-157)

