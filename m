Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792771367;
	b=wzig1MgUKcPOLb0v59KQCAP+9RXq6EZuYlDB2AMKhvX8e0nGYmrWJ7B5sJRYCezq465u
	 qAzhYC57hiV6sC5+sAhGiw7Au8Y5l5mgsojtymqk5W/WAp9kZEDfM1U6A1BE+khTpOugA
	 +JkdnZulzsunSW7OHY2zjVCmLDQ4J/Lg+DYNx3shG/fMiSLMo844E0nv56JHpZhNpGVYZ
	 H4s3pCJcgNPG3srcnsOSkKoUcYdyurvAM2Jsvveukd9hD+W9aLg97w8KVSqowFfdeM25Q
	 WqaYz/0CiFBaG1DgMHhzZsYDkZw5C78hyCOEL3prmXow6Q0Oh9X4BGn0oKb/2MVmiNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792771367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Date:Message-ID;
	bh=bA0Hsp5XXumXBy4rVBwW8fxcNqmGHi/YDDxKz56CdE0=;
	b=jlkfxtXwSPVYnKJ9trA9oCeAuWeLqdKfSDtjXknsRjAjnEVWHGZ7ed+IPIKNzBy3udHu
	 Pw3UY9lBy06l/9FcsQz2QglO59oBMQA+W1yt3T8O74stEUWB96chd0lA3DKSoGleoWXrn
	 HtRMQOUbOHd5eB0hfcMIoNIh1/FirDG9Lnel7rsXdenbhw9lFgQuqQrrZrwAYNEJG0WQD
	 3X1Bp08xUbcGgboOIVSPM8KBbc1FleXaHp1VViUc0OPyS4gk64VztoRgalBc8lNdjZiCO
	 6slhkypNx0wpBC6/4OMFNqM254QrQyw/50fttzYpM1gshw3SZMm5nfxfYudmnp5wrLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O+5l+EMF;
	arc=none smtp.remote-ip=74.125.228.9
Received: from mail-pz2-f9.google.com (mail-pz2-f9.google.com [74.125.228.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FDD606A31A
	for <damon@lists.linux.dev>; Fri, 23 Oct 2026 16:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13FDD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O+5l+EMF
Received: by mail-pz2-f9.google.com with SMTP id 41be03b00d2f7-cd68485005eso405835a12.0
        for <damon@lists.linux.dev>; Fri, 23 Oct 2026 09:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792771366; x=1793376166; darn=lists.linux.dev;
        h=message-id:date:content-transfer-encoding:content-type:mime-version
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bA0Hsp5XXumXBy4rVBwW8fxcNqmGHi/YDDxKz56CdE0=;
        b=O+5l+EMFCS2lBD0L6GzKotMOtreKfkIeL//ayPSAKQ6Vnze4RzeZtmKv/a0OFWSS9e
         KUcQnkEfDDfv46USUXdEwa152x11bk1bzVz1qDDKDkNE3Cime3oLgiwov23pvWCWN8Z+
         sHDeQZ4/IvJmDcV4c7YhZoxmD+n0t39448p3akZtn+ylJG/ZFzr5K7pZ5CDpl/rFbb0z
         /xU/rCFftFeX5ZguVl3zbigJg7cbDrHyBU5ESQT1U9BB059k8v+K+4jK9AT/HNopC9tC
         Fc3Ba4g5xvMayXsDHx62SeQm7bwggrbA1gUGYf04tBOAAXHNCSSom01AWlGeEXrBgkkE
         6bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792771366; x=1793376166;
        h=message-id:date:content-transfer-encoding:content-type:mime-version
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bA0Hsp5XXumXBy4rVBwW8fxcNqmGHi/YDDxKz56CdE0=;
        b=tT88+QlLraBgBWGoyVqfnRf1Nb2a8R26U4QsdvfvOlYth1ouDgUnfjIzWYhZc8sAhF
         OKPBR0SCF3bXb2VutvjN5LxKbEJgjFiYPbC7cUl1bgLv5Er4tf0Huu9yx566+seO5Ady
         CprNFJ69zNJa3nLK+sX9fQReX00RWaYAsIfo+ARC/MHkxZZhJf9wAbrQ8I+dPgNr1jiL
         v53jbTn8LybpfJzaZ1zGxD+yc2KodApMVVvv1vgkXpOX+9wChYiZTVGgTZu5/u670ZxJ
         JelmLSqPF0nMANxKGSTEcbQ+IW9iZ1xyNNBBUiqf3XXQMwCk6FcFq+mKNdgWBfGoH4TW
         9gAA==
X-Forwarded-Encrypted: i=1; AKwUvBw1fpJM1kaFA439P11p5ZWYBo6ERCeVf6mOi3xZ9s5dsntQvxyzs5XEOjfgf1vrd1JCld9a/g==@lists.linux.dev
X-Gm-Message-State: AFq9FYKdYO/bOEkETbXNXm6CsSWXLGi/Ps1fodWEWCFuitiLqIkuwk2F
	E4OO4F3mciJdCoW4UR8+XFYn34zgyAeZ82cWzuFAHgztKpZlRZPyJ4Tg
X-Gm-Gg: AYBFou3bzfiS0CIjJIVMuvu62zLWWGawdx0yJ7yPrs0NmUicPudO44kJZXOMxu/HvAy
	G9eOEKzrkP5wEjCNR1aKCEtwVIKQrVPH32AUYRf5+4jmj7SUz2SCAYuUfwNm25RtFFaBBclR0S/
	/cZGbiT+TZLQtx+lR3mYdL2zkyEtV0aQhdyTHirRks/9jQJYZa4tjK6NEiedsuRcO3NrJ/tUa3g
	h5prrJa938rWG85KCXWAZ46hKavQY1wRKIyABO1I1gQYr+F1mZkiHQSeZaocVQ+db/uHtiJ60+K
	el4QCODHbc20pXexIDjQYgu7ye2wc3IcynIZLLq4k7Zv75fleewjPuFR21+BDV/7kOz5nKRdmX1
	qLwPdfeTfsNiBTaIcVsqCAvPXt6hT6yjgvKsq7WOs8PWq8TyuhjW5ZYQp+A2oH68B9thxqZbC2d
	yHMGsUNTABnTlu7OcynJ4VINsussI+3PzIc8b0r9k/udT8VJAs/AVx07GrplYPL+LI7PShW4biP
	JWKfgcHuGw2CahEXgnR7IEvDrdSXySRl7oRkAng7IGc1wFtCVNXELQolKK6qbZTJPp5qRQ0++X5
	D72EsozSJ5xqRHMjT2gKHs6a5JMCdDOVvVOmfg/PMItdRI3N1aRGwQ==
X-Received: by 2002:a05:6a00:4c94:b0:89d:faf6:c69d with SMTP id d2e1a72fcca58-8a2c66893d8mr2481398b3a.58.1792771366283;
        Fri, 23 Oct 2026 09:02:46 -0700 (PDT)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a336e586f0sm165409b3a.7.2026.10.23.09.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:02:46 -0700 (PDT)
From: Aveline Noir <jm5905938@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
    damon@lists.linux.dev,
    linux-mm@kvack.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon/core: reset watermark wait state on each iteration
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Sat, 24 Oct 2026 00:01:31 +0800
Message-ID: <179277129124.2.16132047926074873101.damon-empty-schemes@gmail.com>

Found while reviewing the DAMON source code that if an online commit 
removes all schemes while kdamond is waiting for watermark activation,
the scheme loop becomes empty but min_wait_time keeps the previous 
positive value.  kdamond then keeps sleeping instead of resuming 
monitoring without schemes.

Initialize min_wait_time and init_wait_time on each loop iteration so
the wait is calculated from the current schemes and an empty scheme
list resumes monitoring.

Fixes: 6e74d2bf5a26 ("mm/damon/core: add a new callback for watermarks checks")
Assisted-by: LLM
Signed-off-by: Aveline Noir <jm5905938@gmail.com>
---
An x86-64 KVM test using free-memory watermarks reproduced the stall
with nr_schemes=0 followed by commit.  The same test resumed monitoring
with this fix.  DAMON KUnit and selftests all passed.

 mm/damon/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index eb1fcdabc007..f61ff763d4de 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3976,10 +3976,11 @@ static int kdamond_wait_activation(struct damon_ctx *ctx)
 {
 	struct damos *s;
 	unsigned long wait_time;
-	unsigned long min_wait_time = 0;
-	bool init_wait_time = false;
 
 	while (!kdamond_need_stop(ctx)) {
+		unsigned long min_wait_time = 0;
+		bool init_wait_time = false;
+
 		damon_for_each_scheme(s, ctx) {
 			wait_time = damos_wmark_wait_us(s);
 			if (!init_wait_time || wait_time < min_wait_time) {
