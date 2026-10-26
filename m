Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013478;
	b=xkrsQqB+9hNfTJt7d7/2p2MxUrVXYq5gqJrHvFu2CAG91iLZitACESiAaUf5BZyGD6q3
	 udcjrsMEgg6UhAWFxwO8f7rXL7GIvrTbCj8WAW+2R6+ma+rXyEWntd3VSf+JrbTZQYvp4
	 4ba9GDWsNIsWAUpajJ7vRvfSFxBJju+V3lOkUDaOPinNWYctBAgJ6WV2eGo9qAa/f5p/J
	 XyHIa0sjcLnhqwOlqsGYUDQMtfYBLvqz9mBmZy+P2s5KULhGLXZ9y6bJIlbbTu7Cqmcu4
	 G1Epg0u0ey/okgAsVh/sH5fX6gR43kcrhNP0yPmAixOO3JDY1QNPSgzO+Psn1GwfxvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Date:Message-ID:In-Reply-To:References;
	bh=NRIkuKUZUAgjI71v50t8xrAuxWFu9ma5GeG76B0scz8=;
	b=DPjWV1rDKPVXFoe3JjIbJ1Wm5wnL/a1Ee1ywbKtDrOs4z2hi74yCBX7CIgTRrc3Iu8q+
	 e44rdqwTph2rHyPP6TqkJQVN7wARDN215t8vT/EHf9Y15v0n4dbdWgB4NMnG0m1s8FHZE
	 4A/umufZhXbVcu8x+e5s+LpAA//cljWYn4GWfDSC6ly/bg8rT5OQ3IX5RmMGXMuLEYDbs
	 xNbQzSobGXo4+6+T6xqVPO2OgKmixDwkq8o8uGSPQSCoBMh9wdCRPumPHPh6+vgQL0SVj
	 cbqlESTNHw0zhiPjJM7MEyvshMCbGjaf+EDKnQWtk/NSNxSvRHjtfqzXdT+VjATpk6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SFHUbE0M;
	arc=none smtp.remote-ip=74.125.228.6
Received: from mail-pz2-f6.google.com (mail-pz2-f6.google.com [74.125.228.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC82606A336
	for <damon@lists.linux.dev>; Mon, 26 Oct 2026 11:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBC82606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SFHUbE0M
Received: by mail-pz2-f6.google.com with SMTP id 41be03b00d2f7-cd613507bd1so265689a12.0
        for <damon@lists.linux.dev>; Mon, 26 Oct 2026 04:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013477; x=1793618277; darn=lists.linux.dev;
        h=references:in-reply-to:message-id:date:content-transfer-encoding
         :content-type:mime-version:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NRIkuKUZUAgjI71v50t8xrAuxWFu9ma5GeG76B0scz8=;
        b=SFHUbE0Mq+xQ10FGBqXpNZbXjk1SiaRhdIZEHrSa/3Kq0hfZj9P8T+Isvm+CwZ2oMV
         wpDMPmatiumoDC15l7NX3LAGygzQmW7jDD/AW0VfDhbqdZpUlSTT3VVbXuylbf6MeOUV
         oe6Y4gVvX95JUELzxwd9I5LZ/tLXUAzUXzxgWTqkEgOlfMnnhSMuD8cXF6aj+0dOQi6D
         oAclXhC3hiVIubz2hMZHLTr24KNfh+KCuYt9XXD0P0ts+6u6fLuqnaRZCSQEuxlyOQYH
         dAQ1LoP2OA0AfO/3LSgyO5O3SRF7Wx3iDcg145620jxD2zZMRuyHoG6S0UdvgJayyWFE
         Ty4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013477; x=1793618277;
        h=references:in-reply-to:message-id:date:content-transfer-encoding
         :content-type:mime-version:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NRIkuKUZUAgjI71v50t8xrAuxWFu9ma5GeG76B0scz8=;
        b=IUObkB8ZQgEYEVHgiRsRH5vrGd1U+UxdRDpOwdP6Lh/rVH/8ghtOVwQwn4/u0ToFqH
         fB49gdQ60QrbLfSTP7wWORLxImiUU2VZBg6gYqZcXeQGDtYIo5gdSslz63mc8yyTf4fY
         kcHA7EQNif5BqDn2/PLZJU7a6RT0L/PfABRqGxloIpQ7vlfewGWJ4Efu4AFcS5feSdn5
         SFI62t6PNj6XQnutXk+GdSnEpH8lLVX9fMQAx/c8cNe+YqygmoOTRoDhpw3yLDuW5fU3
         hNVYC7Eo+klxivdxYwvHtA+9I8FBpGmbWOMuIyzx9pYUQXtDxH0yZZscP0nhwEQtxWaK
         bCjw==
X-Forwarded-Encrypted: i=1; AKwUvBxhyT5JFSELJio2srPrJDEfM8AFKGlHDXFVSFclyvJA1DA//9c8yDcjTzlSvMF12TvdZKiPRw==@lists.linux.dev
X-Gm-Message-State: AFq9FYIKRowxC9nM/tnwHX6wGsUyeTYH3OK9FJhRfTcPJCOELcq+gw52
	VbGIAKpXIJz1V0D7QrYpsMW14oV2s7cbM7Kurhrcni0rXfG9lCEJTjM4
X-Gm-Gg: AYBFou3PifAEfmYZa6bEtx9huYqn9Sa+A9QANNXnLF294wEem4r+bw8Ls8IBuUBRrxi
	mHi4Lv1RudI6hc/WtuW8HyYuyZDHXOpcGqM/Pg9EfXw7yIQbu4FoOeKllvFRNWG1iHFY96zHnvE
	9KnYeoRgb1y4SnLcBdFtQSPzV8328I+1Xiv3A0gTdPxqvxyApx4u7GvX9IJavJQ4v91pL9PhVPk
	wxfQPHSyhrcooIEWzMtSYfVQ4iPeFSRHwgtoRc0kzAS9i71+6F/gEcsi0VFG8bt48bIvs2mN4Ph
	2+CD988TywjsfvDSpDOmG8kV+/cce/uZKq7SmYFgfL7KFWJznl2cCgokIKwBXSUYc2oFu2NLGQX
	66u0NZxcHXuzbU0A9egWPEtfJcc2bh6X3e916hy6ljn4G9zZGF6lk+cglpLs+5OIVLLuDzdUxeQ
	nx0uQjuhwMESzBshq5kyjzAmjqhpKO0lCpxdStwrDkJWKgT5V7TIWtDr9iF38/H18Lja7DB7Kpz
	a+30BeUjgo53ii9px3gNBN9y1xNldccJpBbk69AOl+d+0dcz1MgdNcYBA9w6skTTge6m7w7VjLZ
	CEg806rd2N9eKh4DaBtIYH5D4kGJL7fNKNyRC4Vfl9LPJTEG8PyI+6jOcEalSw9p8IHMuff8Cn0
	=
X-Received: by 2002:a05:6a00:4005:b0:8a0:2914:5d27 with SMTP id d2e1a72fcca58-8a369168952mr5053901b3a.44.1793013477084;
        Mon, 26 Oct 2026 04:17:57 -0700 (PDT)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36acadefesm1240756b3a.19.2026.10.26.04.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:17:56 -0700 (PDT)
From: Aveline Noir <jm5905938@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Manuel Ebner <manuelebnerli@mailbox.org>,
 damon@lists.linux.dev,
 linux-mm@kvack.org,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] Docs/admin-guide/mm/damon/stat: fix pronoun agreement
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
Date: Mon, 26 Oct 2026 22:14:34 +1100
Message-ID: <179301327249.2.17530814278215474568.damon-docs-grammar-2@gmail.com>
In-Reply-To: <179301327249.2.4690198998605536207.damon-docs-grammar-0@gmail.com>
References: <179301327249.2.4690198998605536207.damon-docs-grammar-0@gmail.com>

"converts it" refers to the access events, so I think it should be
"them".  Rewrap the paragraph while at it.

Signed-off-by: Aveline Noir <jm5905938@gmail.com>
---
 Documentation/admin-guide/mm/damon/stat.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/stat.rst b/Documentation/admin-guide/mm/damon/stat.rst
index 4a9db755a526..a93609649a5f 100644
--- a/Documentation/admin-guide/mm/damon/stat.rst
+++ b/Documentation/admin-guide/mm/damon/stat.rst
@@ -68,10 +68,10 @@ estimated_memory_bandwidth
 Estimated memory bandwidth consumption (bytes per second) of the system.
 
 DAMON_STAT reads observed access events on the current DAMON results snapshot
-and converts it to memory bandwidth consumption estimation in bytes per second.
-The resulting metric is exposed to user via this read-only parameter.  Because
-DAMON uses sampling, this is only an estimation of the access intensity rather
-than accurate memory bandwidth.
+and converts them to memory bandwidth consumption estimation in bytes per
+second.  The resulting metric is exposed to user via this read-only parameter.
+Because DAMON uses sampling, this is only an estimation of the access intensity
+rather than accurate memory bandwidth.
 
 memory_idle_ms_percentiles
 --------------------------
