Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B739D3BC68E
	for <damon@lists.linux.dev>; Sun, 20 Sep 2026 02:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789871863; cv=none; b=es7iLBOT7tek5Q9jmzTHkoPlDdc/lhspYvhcxI1hN54FJdhkmvEvyK0Z9JG2XY0y8Cx2PQloA7flBNjUqUK9ghZrHX7A4ClE5w9/ES0tAPJ2t5lRH5lyAX761SBDQSINWw2qS022RQH2IAdcB4urj/iLF5+5dWHY/DA4/vgEbKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789871863; c=relaxed/simple;
	bh=okXre6j00i1YDziNvr4xvCqzfIaczrmT+5Z9AqH70Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RiAq/Ebgv9Yyid8IXJL07W+OIj4GMDUaWReN/3v80UMWBg4sjZAQdykENNyzCSqqdJQuW0hijJ2pupm2B1gpAVWJeVvvRyUpmxPWyxcCDYNhKd4ZgxswTtZC9e0xpJ062Iwi6db0rSOfKDuzhayTfvPMnTGMvDtTRFgJsaWHej4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYe1EVVK; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYe1EVVK"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso1506080a91.0
        for <damon@lists.linux.dev>; Sat, 19 Sep 2026 19:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789871861; x=1790476661; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UMPCKFMy0q8dOtTAgKNYN+tQZo2X2/BEgITns70uQG8=;
        b=eYe1EVVKoyb3yGvnVQUkDHcAPA4g3Ca67fIHLx7aHDxC8jvHRff0N3yukSpc/4QlyF
         19VZLznWmxs4qDUfgSsJJbYTXLdecethDDsVouS2htJLG9jxdry0DOcrq36fXSCKDBhT
         kGVIbKmtdHwMd5W0Swdn9Z2lsX3Qyw67LvHrI12jCk0KW2oV3v/IWl9yl068+U3IJgRU
         ufDl1wZtoiY5/kgYTrdr8apC4k2MaA3M6YVpPxm5jnwB0FgLTSnxzoOcSrvpI0zBLMlG
         wsXz5gvmKrnXRxwZEMdo0eIIF0URuROFqB+ACq2JabYdYRkl7AOEnM3wOFz58ZJdQj+u
         riSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789871861; x=1790476661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UMPCKFMy0q8dOtTAgKNYN+tQZo2X2/BEgITns70uQG8=;
        b=ZC6ax/s171Bx5mrjkhE0IaZOh+lUj/oaskSTqv4p7QdK5UYkeNiwbhvn/nJuyVzjqZ
         FfHJcM3kJtLJJgDhaComfl0kYNhhQ5zM27ANCIjl6lcqwULfZUUbdQ0XK5HyObQZO38r
         VaMKXMS9jU7DgTN/83pSV8GXz1MxR3qlsiCWzfn9DUARPZeS7mysuyezpdi1cBzWlIzF
         8FK6s15AZq9tyR+yniIRQuo25R9RyZEll/vgRFTiNeSOAJHqrBRuETtAybUecWYTyHOV
         V1BeqghJq7VhUzt64TxCkRd02TDsyWX+wZu5E94KJD1fyhcRcAaiDYgBbRDmTBBtFoAj
         IQDA==
X-Forwarded-Encrypted: i=1; AKwUvBzoboT5gat95gxhm1D7Us13zYhaN6w92hiFysyfaw2+h8eBQYyIOOw+1fZzLBrjhAhQOLyAzw==@lists.linux.dev
X-Gm-Message-State: AFuF++ky0ERYI5P1FVaexXVbZnS7iBw/haJz2fUE1Acaj7n2jlb9Km0/
	kqnS232V+16nsplR/mKCSxjmGkfhCnEyUYzcmu6qEQzm0Tq62eNw6R0=
X-Gm-Gg: AYBFou3KfUknIaGapjJqUCQLgzexzCaOMvKousLIFlgoLOykP8Z+sbpCwo/bBAw1dgg
	PKMywqDGkG6jSvu4nDq80AZH82apICROVfIK9cC4aGEvlx2Fcgpe13lYFKFU22f1RIYAGvoQ/WQ
	nRTQTe78DRp1+ZS0/SX+Pg8HqV2iv8NM9Y6mNhpMw6bayd9X8Skz4MyhbKD6TmGPYGGKH37lntu
	3zyPu+acY0KoJ2qUFm4NQII8CxxARXCiHuvLS6aqYzGnFmpsuNFxNuq66vs8hvLo6z7XOMt2OhS
	Ho3pf9yRCGUBHuXYdARCnnUwW1H9r0DucNei6dE29XKo902r1EVe3WB50K2tVdBfVtT4ZtHN4NA
	7kiNYQdA/XI8cf2E61prQibEf0vFBp6RtptLhHOSZHTgFIXETlNiQbZhNKSz1tqtgNkhJBHkFYo
	P1ClznDfV1dX1tOzevTGxKkJ05sMHYikbEj76c2SyUDcbecHKgdLRo41SivYroV5w4d8Uwjyidy
	1Q61DKssMHcg+jyzarzNVZX/I9eWgJ6smsX
X-Received: by 2002:a17:90b:554b:b0:39e:6c6a:6572 with SMTP id 98e67ed59e1d1-39e6c6a673fmr5097657a91.53.1789871860837;
        Sat, 19 Sep 2026 19:37:40 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:36d8:54a:e0bc:3e5e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c37c8e7sm6799764a91.9.2026.09.19.19.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 19:37:39 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] mm/damon/tests/core-kunit: test the temporal tuner's size quota conversion
Date: Sun, 20 Sep 2026 11:37:29 +0900
Message-ID: <20260920023730.2468388-2-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260919170154.86842-1-sj@kernel.org>
References: <20260919071324.1583280-3-donggeunyoo.kernel@gmail.com> <20260919170154.86842-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SJ,

Thank you.  All three applied in v2: damon_new_scheme() for the scheme,
damos_new_quota_goal() with damos_add_quota_goal() for the goal, and
ULONG_MAX / 10000 written out in place of max_sz -- the name really was
confusing.

  https://lore.kernel.org/damon/20260920023111.2466265-3-donggeunyoo.kernel@gmail.com/

Thanks,
Donggeun
