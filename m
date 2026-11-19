Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795077684;
	b=IfANCvfSImHPPWVqkIVy/SRd8DIJ2LFylfFBlXSwLtRiwZ7OSI9Rs7d8OyuQ0K+Tnt+1
	 hX656NUKh4UqDJuCx9XZ16cSJHV8Yh3XozzPF6pVnUbOjWhyQQBm2ee1xvcT5e5LAznHt
	 cgbWOjX+Ev05SnSNecEPfJQs8sEUbC1hYhLFfm+ROLsPRcNr29HTFmi+UBzLbPzVmKKVz
	 E0W8f2ma81NgNLC5b2c2qz3d2fGt0cCX5HUV2SnPlodVi4ex+3V+Ul5KEedVqNqlXkOk1
	 Lqqn6/HDxRsItgc0GUiICD+WNql+twYXUsVhGq/LjIA35Cs7LaK4aFoXAg6VmEjzUGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795077684;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=6nZw4QgVcRxFqgBQwwralrt/ynUXiZOfhv4EehzkIqE=;
	b=Lv+VAijN291lb2hWRwbOAG/uf2/4E1b3omfkbJLpa9QlsD+diAGE+VaRI+RgjiENCXTa
	 Ic0w23oIQ4Z2J53aqjt0LDoU25RGy3ybIcU4wxhQ0bOYJseiOecXgaWHscv2xvmh0sgdG
	 LwIUa0TAmJ9UyhZib8OaintpYfdrZiP3DSHC3afgENtA6Z7VpaUuojNENFvC1b5z+UGr8
	 572HcktNWfcfC4gQNTP9te2mXsRvMynkKjCx57aJhOcVR/bd+LopFd2HhoFvtlVUv5nCe
	 Alntzgk5mbI6SrE6wrWJo+fqbUBgRRPpzm/8Qjsp8X+WZxWoLypATFGIFE5h4l+b+fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ab3cfgDK;
	arc=none smtp.remote-ip=74.125.227.138
Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F35606AEE3
	for <damon@lists.linux.dev>; Thu, 19 Nov 2026 08:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37F35606AEE3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ab3cfgDK
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-3b3bbd46625so505694a91.1
        for <damon@lists.linux.dev>; Thu, 19 Nov 2026 00:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795077683; x=1795682483; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6nZw4QgVcRxFqgBQwwralrt/ynUXiZOfhv4EehzkIqE=;
        b=Ab3cfgDK0A/6PJSxUnKcWOglicJYgs8FwlczjO2TE6GTBZykgbHuxKGFjaYoA8wxuC
         6jKs21VSfDCnHY+iGfq3PqYX+nSFjKZCiXsq1/eeIhKG4dD4zEetQV0hK3f+GmQduhHa
         mpBnB+m4cnNdsqG47wikgmyhUPXj26Apl7f/MCWaLoe3cHKD7tpci3h31ZkxLBSNI/tZ
         SH1lnR/Jxi3OegB6YB6wgvHMEtq69qCHqXe6/IpsjEfHeu2MEMj2pnErIJHwztgBXqjl
         CjzcyG0c9Pnvuru+HnX4s9akliH7W4MAnggur/zBNQWZraGjOFn4CBvqzA82EigUZ/QC
         CtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795077683; x=1795682483;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6nZw4QgVcRxFqgBQwwralrt/ynUXiZOfhv4EehzkIqE=;
        b=S0YFzAXRZSubvcgREPyoPW25AZukK8YZCjd9wtYq2uyJmJrdU4doHUcCn2Z3eFX+8n
         rF5Jqf2HoEivBwmgi3rz8rKVH+zv2e3huhiwqGuWJcqOi1X/1oITak6dOiE4sgpkAfhO
         /pONfo6LCpt2kOgFPrbfU4+rI+niht4603kbGLaU1fYGzAcOKQJ6wnl4/grK9n9mq2Bp
         nt12E1ncULm2/8aHMOu7xZJPGbBL2hPR0JVQ50r81WIxqpdZqnuKOlvp9KfIS+HaE3jp
         JaU4APqW0ePfnJi1DbIilnPmRsQg6KOiGGUaUYjIpz14qwM3FvMgE8wF12Oh6grdLTMx
         NLiA==
X-Gm-Message-State: APuU4Z8NvD+9iQKuK9elYBdA/GAwagYcZX7NsPxapO4T46RI/bkUxRhj
	qL1/frx/cL9eLubD+Wk2/BADSvYdAMO53lDB0XQRXCTyPSD7IF21wuIu
X-Gm-Gg: AZFdTZe7pX2+GeqQlQKrCZCnn0De0AfFzThtI+JADkYFRd3iOXxdgcVFJ8kdlWyyKL7
	mYZG5/0tFupyIUN5Fj87xElVOkjtmnzYKFVH8X0wVPRhYrpEqnt6eyNUkJ/AZn8BdxHlgV8fFGQ
	eMl4cfS1RvQV/KjCC1Z+wniH+F7zBwZP7gkQ318xv7C1K8wE5dAlbBuYWLQslKunixT7KjKVGCF
	g8ZrsRWoKoPeSslA/KUfDHPkheY2LAs8UHaj1/6Eg1f1RuqdM+wEzFby6aB5Iajvco3oMPJL7SB
	zsespiIv/ZZc4aUkvzyXC+z5epC8Pi83Zo6xgURWjEP06VtGIryEsscGVPkDdQNVNWkj6GeBoB4
	2PwZ+RIjp4eUcAbQZ0xuBhYFzpRsYzyiBGQzrC2QxERgJtTHY6MGlMgFzIna98YMiOTofPAxAon
	hQEi5UOzPdUmTU8Fp2vvpFo4/k1zAs4DVaDcU3DZj87DjGaKS+m+ef5Y/estMzdGLv7pTl/yUzr
	sO4mARBHE10fE8BSSIeiuPC1HDPozhziSQ7LmG361TG3MoGJHatLlJzigTdezqWxGL+FgFGGeXn
	nLIY4Bvyp4HwKZuIrCEgUkF8xcqM9EiEnZE+HznR64KzIwzt4ulG7nG3onA7bKIbqDtAQv8S3I7
	qieJp2b4xwU4bYwKm1vggabm0vQQSeiZl8NNBtvMgH/cEor12iODfyCQlONjxqqo=
X-Received: by 2002:a17:90b:4a8d:b0:3b3:b417:607e with SMTP id 98e67ed59e1d1-3b3d07a4c86mr5491576a91.44.1795077683292;
        Thu, 19 Nov 2026 00:41:23 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b402aa8555sm933646a91.3.2026.11.19.00.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 00:41:23 -0800 (PST)
From: Aveline Noir <jm5905938@gmail.com>
Date: Thu, 19 Nov 2026 19:39:24 +1100
Subject: [PATCH] mm/damon/core: skip apply_probes() when no probes are
 installed
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-damon-skip-empty-probes-20261119-v1-1-ec3e81c1f26b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBBFf4XM2kkohoL+imHRxyjVtDQdfIXw7
 7aasHN5bm7OWYApOWI4Vgskejh2U8ggdhWYUYULobOZoakbKYQ4oFV+Csg3F5F8nN8Y06SJcTu
 0vbSdFF3f7mvImpjo7F7fxGn4Md/1lcxcvOWhFRPqpIIZy/Sv4D0Gem4hWNcPn/85qL4AAAA=
X-Change-ID: 20261119-damon-skip-empty-probes-20261119-586d76178530
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org
X-Mailer: b4 0.16.0

While measuring vaddr monitoring overhead, I noticed that kdamond calls
apply_probes() every sampling interval even if no probes are installed.
The vaddr callback walks the page tables for each region's sample, and
paddr looks up a folio and takes a reference if it can. There are no
probe hits to count in either case.

Skip the callback when the probe list is empty. Ordinary access checks
still run, and installed probes with zero weight are still applied.

Signed-off-by: Aveline Noir <jm5905938@gmail.com>
---
Tested in x86-64 KVM on 067c5c24cef2. All fvaddr probe checks passed.
---
 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 986404b547eb..df711b6a8d03 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -4089,7 +4089,7 @@ static int kdamond_fn(void *data)
 
 		if (!access_check_disabled && ctx->ops.check_accesses)
 			max_merge_score = ctx->ops.check_accesses(ctx);
-		if (ctx->ops.apply_probes) {
+		if (ctx->ops.apply_probes && !list_empty(&ctx->probes)) {
 			if (time_after_eq(ctx->passed_sample_intervals,
 						next_aggregation_sis) &&
 					access_check_disabled)

---
base-commit: 9f004372ebeb18fdeb699f9880a0e472df90135b
change-id: 20261119-damon-skip-empty-probes-20261119-586d76178530

-- 
Thanks,
Aveline Noir

