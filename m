Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795307377;
	b=y9rExIBWxLDmM330ydJaAv1wgNfnIWB6mdW4LHbcunR1CdAq/jAgmucRUrRLOGbK86JO
	 DCo/vqDyvMATdD+eURsBB5wMyWtt7Yd2/j5N6+sra+TLQIOFixvxtZvay67NoM3usgmCe
	 xLuwGEj+cmL2Ihw0CD5ufSH1B/aDyABI13A08/AjuQ8qcbliwEUwb3jKts8Pm+dlq/hAA
	 U4MlFRHTZfGJRQT/rV/bUlX8m1ByGpKLikE2sBSrHgKl4M78B2gtwrty6WG9tSnfXmqkS
	 UqDmYRdtqEme+497aZHZ/mX4ySJ2cikxUZvDEC9wP/4zkltvWZyzr3O+qIF1NcRy7qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795307377;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=/d2B1uiOt5351Wc+V4rdkTylekRqoHBMFthy3xK3VRY=;
	b=IdCvQYitfcfqvq6JtTqj5fhBlMDHy8/Rn1TQvU7/VX9ppN7OzO9VLlmb8GA3Ne/u9JVj
	 4BNvt8BNcXPREpmGa6nQtzJ6fSqAPIh6gV6StNPJohs24K8XcJiU4BZXrC11gPxFkEa6K
	 w1IbBwkybgtJ7OFo3YNysgIwCPb9ZKTCG37MKK/6z1cnAD0MAPeAZJUTwgkdY5Dw2k+dT
	 53vtn/SXRfXsyU4IaP+EgGspdc07FKbV0RzuWXR/cPnKYhQ5FFY6Q9jQDy0FLKwzuc84Y
	 bVFhwzOT9O93UsZXbgwcEm5/le0X0DEZPRDUyevYTOlwXORGuQSJ/DTZkWiSP3mZicg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gbjz8tlS;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56803606A330
	for <damon@lists.linux.dev>; Sun, 22 Nov 2026 00:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56803606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gbjz8tlS
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-92134c4592dso20714046d6.0
        for <damon@lists.linux.dev>; Sat, 21 Nov 2026 16:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795307376; x=1795912176; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/d2B1uiOt5351Wc+V4rdkTylekRqoHBMFthy3xK3VRY=;
        b=Gbjz8tlSPAk/GxK2U67HjzmPC3NT9qvL8KH9+rBBDoP4gC+XsaWfk+9PcGS+zniD7J
         6o4tl32g3EuP1tVja8p2xhmALEPGwELjLGMEEBkHUcW+oHvZyGdCjMBwq1/i+EnUfgAf
         p0R46srPi6rELgH1fhjhOFP5Mk3bQipJycR0tWcZyEJqun0b1MQl76GkTTEtPlSPWFEo
         AOKUz7vQgNd3Bn4zgkd3LqGEhPT7HBG8NlMcjRMY4Wi7hBQVLfIOMqcmoWVDPHzktU1J
         SOkVTSKybEy9kjKuxh7dULpttM3yUr5jIs4vLO2m28pvSFz7uIEs2+Q+IRN0K/J0BPbr
         jcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795307376; x=1795912176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/d2B1uiOt5351Wc+V4rdkTylekRqoHBMFthy3xK3VRY=;
        b=2oeuh441j7h+XhZq6bd+m9izZfWjsa8qNfKawGOCRbDS8ObQVrnTYyNkomtONue2fP
         /TF94X1le7wIkJsTwlDfW3EiXB2uQvr6K6fEMElwI7kSM/Z6QCYXVfO7BhVvrII6f3XZ
         1ne0hRBJEclQvri0tAHFW5qr1HFgf/vmhDx5qDO6RAw+NI3ZEfjpvZJAfASVwBZyORRl
         LvD0s3kdH8ZqERzXPvVkegcQUAwRoN/zvzQmmcmwevcASWLs6f1WI6A9Yc9nMmMdY5Wx
         ZZrlMpO4/SzXousLHiML/lU+sFunmpJPODavEdwzSgUbtNY76wzDgcJgy92Y1c2DYeq9
         MSqA==
X-Gm-Message-State: APuU4Z8SnLP7ANXVOwV4Lxk94O+wl5lyRVcF22eMbRycDbPYFZ4RdRl7
	SmKUo/tHD1KpkcjR0pXyDHxQca9RwKqsasJR110tPbgVa1h7mkDgRq9j
X-Gm-Gg: AZFdTZchJgEqpUxh3JqIhG/oophyt7DJ1ZxIIunKWsHOsIQLjhgriA9G9BFBJDIM3gX
	njb/wbDR6YPMrgOtngHNYfKnqvt6O6pc/lxt/9Nt3y8I+KUsPCoqFa3QzkLMEiULd1rC0s1RYr+
	GK958bZUC7g/oHE2CbWgv/AslMigd4zL+HoFXSyfEKHbi4tdJSeROi0uLazUatZKEgS60MhYeee
	73ihtyWRrnTJ4IVBRZG0b3a23vh5DsCTNy78M6tiBv3BARjnDFmh7PogFyjmLI5GeXoT2YjEzQD
	IKJFqFM5EgVYc6d1iThnJSaNRI5q25y4k039aDCt1zAthYhTMF8aVuWcKo2sQYtDPMrskqFwoy2
	lpgLXVbzlmpYlipBIfOWkzsiXClAMIyIOusGi5Dye6TMHz1TyRv2sLTisRRf2LJrwB6Sw+SzENt
	IH7CclkyCbL0RLs3wTEV/CSTxleiTklzpsTMCh7gKIMGT03bcmuDIg1Lpcp75VncQwe2kjAZ0fn
	zd7o2rLM8QNT78aifwyou3ko/RZt+uBpeg4vuWWT6SdOYEbHETXBUM0oDQ4R/kTS7GxKJkAWIoF
	YDt6pPbyYzuQqFBrM04dsj6KMCehSy9dfcL70Vjnqkowt/nphtKy5+yeD73MXpXtgbdA2BD83nU
	8iLQWfR3y+Oa24Ci/idrq50OipTDB
X-Received: by 2002:a05:6214:411c:b0:91e:97a9:cf02 with SMTP id 6a1803df08f44-92134a38ed6mr129326736d6.11.1795307375814;
        Sat, 21 Nov 2026 16:29:35 -0800 (PST)
Received: from localhost.localdomain ([71.18.96.10])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a0a454sm64752766d6.35.2026.11.21.16.29.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Nov 2026 16:29:35 -0800 (PST)
From: Yifan Feng <evanfengff@gmail.com>
To: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yifan Feng <evanfengff@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/damon/core: do not overwrite wmarks.activated in damos_commit()
Date: Sat, 21 Nov 2026 16:29:30 -0800
Message-Id: <20261122002930.98401-1-evanfengff@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
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

damos_commit() copies the whole wmarks struct from the source scheme,
including the private 'activated' field.  The source scheme is a new
one, so the field is always true there.

As a result, a commit turns on a scheme that the watermarks turned off.
If the metric is between mid and high at that time, the scheme keeps
running, though it should stay off until the metric goes below mid.
DAMON_RECLAIM and DAMON_LRU_SORT use the same path for commit_inputs.

Save 'activated' before the copy and restore it after.  Do not restore
it for DAMOS_WMARK_NONE, because nothing sets it again in that case and
the scheme would stay off.

Fixes: 9cb3d0b9dfce ("mm/damon/core: implement DAMON context commit function")
Cc: <stable@vger.kernel.org> # 6.11.x
Signed-off-by: Yifan Feng <evanfengff@gmail.com>
---
Tested in QEMU: without the fix a commit turns the scheme on, with the fix it stays off. kunit and selftests results do not change (13 pass, 2 need drgn).
Found and written with the help of an AI coding assistant.

 mm/damon/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index b8678a53b0a9..9ae77e4d6e57 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1567,6 +1567,7 @@ static struct damos *damon_nth_scheme(int n, struct damon_ctx *ctx)
 
 static int damos_commit(struct damos *dst, struct damos *src)
 {
+	bool activated = dst->wmarks.activated;
 	int err;
 
 	dst->pattern = src->pattern;
@@ -1578,6 +1579,8 @@ static int damos_commit(struct damos *dst, struct damos *src)
 		return err;
 
 	dst->wmarks = src->wmarks;
+	if (dst->wmarks.metric != DAMOS_WMARK_NONE)
+		dst->wmarks.activated = activated;
 	dst->target_nid = src->target_nid;
 
 	err = damos_commit_dests(&dst->migrate_dests, &src->migrate_dests);

base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
-- 
2.39.3 (Apple Git-146)

