Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704658;
	b=DCAynrIdURX3ex0MM3jf6NeLc15dPlCSvjuUgAgWQ0n8qX1RrF904x94Mfu3IWLu6A4y
	 +Y+aXmAsauV8XuRl+7N/oGJ90DysIvG1mzZ8iN3GVFhbJNKW5kOqdvR3ywVZhiJzzvZh0
	 EIaNVFpuqq1O8df40cI4PkOoAVql7zvWPIXEMsFj9fd38f6kFXszOe5a3l6k+yx/8tN2L
	 u4uVdNxhtDz38/wnhvkQD9lv95i4crbz5WHN5dWzO3+NBo6v8Qul4fV7Lpxh7koowYF0s
	 i4RvMWo5cClXH0zfpaeeTvDfFMhBdJ/G3CDcWLEIsc8U/3CEgtFgHtE2b4paCjz7T2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704658;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=rO8PyIeQTJjW9jZC3eDavQXhSeNQrxCH5KHGWPFOq/g=;
	b=zQQuqr88dc8Lni0Fzpcz3ICJ8LqcmveEVMLlbiyarHOG/9xPqNsX1E4AxRb18I/lCSo+
	 bBqVPp42BOwvnETB0Jgt5UojmezH9Ys9gCz1UF8sfaQdquZ/oDkRlVXb5DEczuki9D5YK
	 jvXAkAMZpGeOhH7KrBsjcwtRVAbzmMJyh+clylTV1RtmHN4Ry3xvgtF2q50uH3LCtp6su
	 fpI/48p3zx+l6mUy/ROpuR7fVCg0bOoDnhRFQprkm9ecZqMuPd/k1SyjzwIMLcpjmDzEC
	 pWAWBgr+qt0bdJ+bPJLOUYguGif52ufYGMxkwvgf80FqEn7fcojc3oDOP6b7K+DFxSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dt8JJdkR;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC40606C5A6
	for <damon@lists.linux.dev>; Tue,  3 Nov 2026 11:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CC40606C5A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dt8JJdkR
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cdab938dc83so1541060a12.3
        for <damon@lists.linux.dev>; Tue, 03 Nov 2026 03:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793704657; x=1794309457; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rO8PyIeQTJjW9jZC3eDavQXhSeNQrxCH5KHGWPFOq/g=;
        b=dt8JJdkR8wsbXoY0NbK9cur3UaDS8M4n6U+/p6vK/oLnoyIA3QLEDhYBduBBfxsd4Q
         BzAp+kMJ0pQEdRMMEcu/fDoe//B6cWdaX7Ah+QAzQg2ldBOhQr6Dz0tk56asoQLN7gMV
         ahG5Li162GYpKeODozZ6PCOsnZt2BlRKI8LuGwqttXU0Wxl7foDWYzkoNB/yiZMBjwWT
         KieODjdANBU0xdnwhYyM//aIN1TSHdb37fxtNP9zfbY8sjAgsHmsDGuU9onDWn6em8L+
         0D5mMqiUM6WAmbSH28mNA+QR7V7o5MGd3ZRImGhzyYzY7cpoLDflVY+I5Az8r/9uQXvY
         1qlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793704657; x=1794309457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rO8PyIeQTJjW9jZC3eDavQXhSeNQrxCH5KHGWPFOq/g=;
        b=DI0dHX6/1bfwOglh9JOU2qGZadPFti8ccxxfEz2aODAh6G9xcX+i41CyEIeCHAzLP4
         EcH0TGJMZGcVFJRwUsrEdrhyRGUCEtO35gsJKCu5lEUSNowTc7wvOJDYzT3dESfLxNOV
         sM5666Fd2HSjwgZ0D9ni/tzIuVRE3HXwM9wVyo1AhV/xaPRym+6HH5kqDn+tf7btUrIP
         TfFL3qM/wtmWrrJmIJloSBz4kDyMjpV9OnAF7HmZaSm2qCew0DIFnmydd+umoNSLYabn
         PGgcCQTa3RIGmrMzJwHOCRiN+X0sYPyIvUV9HmFj4c+aG3QwwxWE29sX6FkEJAXPO9Ev
         y39A==
X-Gm-Message-State: APuU4Z/04Rcm7cvrGNkrOQT2/Kuqp8GkeGbgNPEgqBjsShwRq99C7r0R
	ITaGR50siKPZCxXAQBlo3ne7bcVocVXWAOKHjNIRSKOccaqkgxy0e7AP
X-Gm-Gg: AYBFou1qOK1vhLRUsqvVqIKU3krFg6NvUfHsUPUSkVhVyE4e2Y0CGig9dwRRLe63Z45
	ONYhm68AtAvwfOtuaU+sKQcg/cuoY2O9SLx6xKOAPrD9fl299sgpTZmEl18WUMcmQlKb42/vMpQ
	2jzRRMJzXn1eCdgtiyugJzmcvc/DdL1vGiy/U5OT22pWPTmpVVNTU5t6zbwDNtIaPuRKgNQcWDf
	vAzN2VaSxVAwpXv8nfxAVHrHsqztkZ2ra5ojXVRSpXgcYal8YFx9kr6RgN9N/w9n6pBMn+0rSQa
	ZXhIzJeyBgLkAt4lidc2vjHxRMEU6HwXGQkJXVzutQyg0aKzMZBKKPw07uRgk1n4wcvz6lw38Q+
	p+quGuqBxoZ5RkhJdnVi1e3S+lU/x9XAVijlwcnWV2U0aT2XbvXScTT8JiY/GtycNn8uzVxStA0
	CLWNyxKb6JPI3klcYUgr5dsM8kzjDkkJLLxFGZ2W68zYheVvHsqfovuz1UGcYRilKyMIzz+RIdN
	xYVrrdYTprGoTrf+FROfXvrNXuRhGWjq/m/eXeH5C+0NVQMgHBDedJ1D4n753XVRT5DJAwNUrgP
	TRNDTX6MQ3QgRzAjRl7ArWntvttXJQ4jFosiTiZMXS0DaAZ6oW5LnEaKrC2EOrjPLSZh
X-Received: by 2002:a05:6a21:3216:b0:3e2:ad49:b24f with SMTP id adf61e73a8af0-3e928e47524mr11186434637.68.1793704656472;
        Tue, 03 Nov 2026 03:17:36 -0800 (PST)
Received: from xiaolei-VMware-Virtual-Platform ([219.142.21.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aadaf82a66sm3065147b3a.56.2026.11.03.03.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 03:17:36 -0800 (PST)
From: "Xiaolei Wang (Kaihong)" <xiaoleiwangxiaolei@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	error27@gmail.com,
	xiaoleiwangxiaolei@gmail.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"Liam R. Howlett" <liam@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>
Subject: [PATCH] mm/damon/core: reject empty access pattern intervals on scheme commit
Date: Tue,  3 Nov 2026 18:54:18 +0800
Message-ID: <20261103105418.362459-1-xiaoleiwangxiaolei@gmail.com>
X-Mailer: git-send-email 2.53.0
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

DAMOS schemes accept access pattern bounds with min > max (e.g.
min_sz_region > max_sz_region).  No input path validates the bounds:
damon_new_scheme() stores the pattern as is, and the sysfs ul_range
stores are plain kstrtoul().

At runtime __damos_valid_target() evaluates "min <= x <= max" for each
of the three pattern dimensions.  A reversed interval is an empty set,
so every region fails the check and the scheme silently never matches
anything: nr_tried stays zero forever while the kdamond keeps running
normally.

With such a reversed interval, damo starts normally (rc=0, kdamond
state=on), but nr_tried and nr_applied stay zero forever and the target
RSS does not drop.

The same holds for the watermarks thresholds, which must be monotonic
(low <= mid <= high).

Validate the access pattern and watermarks at the beginning of
damos_commit(), through which both new schemes (damo start) and online
updates (damo tune) pass.

Fixes: 1f366e421c8f ("mm/damon/core: implement DAMON-based Operation Schemes (DAMOS)")
Cc: stable@vger.kernel.org
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Signed-off-by: Xiaolei Wang (Kaihong) <xiaoleiwangxiaolei@gmail.com>
---
 mm/damon/core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index eb1fcdabc007..865627bda240 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1566,10 +1566,29 @@ static struct damos *damon_nth_scheme(int n, struct damon_ctx *ctx)
 	return NULL;
 }
 
+static int damos_validate_scheme(struct damos *s)
+{
+	struct damos_access_pattern *p = &s->pattern;
+	struct damos_watermarks *wmarks = &s->wmarks;
+
+	if (p->min_sz_region > p->max_sz_region ||
+	    p->min_nr_accesses > p->max_nr_accesses ||
+	    p->min_age_region > p->max_age_region)
+		return -EINVAL;
+	if (wmarks->metric != DAMOS_WMARK_NONE &&
+	    (wmarks->low > wmarks->mid || wmarks->mid > wmarks->high))
+		return -EINVAL;
+	return 0;
+}
+
 static int damos_commit(struct damos *dst, struct damos *src)
 {
 	int err;
 
+	err = damos_validate_scheme(src);
+	if (err)
+		return err;
+
 	dst->pattern = src->pattern;
 	dst->action = src->action;
 	dst->apply_interval_us = src->apply_interval_us;
-- 
2.53.0

