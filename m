Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD73D3587BE
	for <damon@lists.linux.dev>; Wed, 14 Jan 2026 06:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768372094; cv=none; b=mkp5fpfbII/62xDN4HJSVojibngEb/fHHWKT/2V7bnJq/ljJRtzlUqeShtDlBYHnT1lu145uZ/eN3qEBbXJPXpM8w6hDagUYwmyqrbnPU5LDAOtareuXc7nb3hbQX71f016IYerRkmavPbU3nBMe61iQpZRX/cr7J/Gy5T2ggSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768372094; c=relaxed/simple;
	bh=3FKF3ICkFnyr3plBjkQXZh19bCTUt2sqHFw3t8LKT4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnFvnCVx89+XSRfUBJruCr+yDOfMvu+JrRu3gx+iU4MfVMcnqRXYApTpWi0UVKyXiR8b9xP9NHk35fOxjtRXR2Cbk1bztKgmOYD6LfDFKBWnNeCYq7OLkuVVVxBuu/I18a19zWSgrN/lI1m2W4QWClHqmVCG6YSzkLAbiHBTpaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axRRpGln; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axRRpGln"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2ae2eb49b4bso11591448eec.0
        for <damon@lists.linux.dev>; Tue, 13 Jan 2026 22:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768372086; x=1768976886; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wiYiHrNDixSxXYp6RTyIy2kKNtBFyrMlCzB+T+XzHow=;
        b=axRRpGlnGNQZgB9EV3c409xvnNzE4ZSd9fBvcA+k2BVVsOLwrOCg7ycQUe9WBgEScI
         FeJIyLL+bGmsXfWl4sjueqxlvIbN1l2DtRMkGi2hxp71YVS4CLhKFw4mfW/u+c16u+tj
         UbvXpYe1YbHrL/3d1LhSbMI/bWGCXPHULRw/QxDLnCwoRR/D5/3HroL21u0NtbILQFAj
         HvVYuMJPfhMULmf9p1TEWWiLBq2ee+97GQ4jNisHfNeKh4SHJDZT8bkXfuJj4k80DayS
         YQxGL6fnGvLNgH+4ys8JvHdjWfUsZsDElz2PHgi4HxHF0Zb1SqouDdyUVLU1LsplkRLd
         QklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768372086; x=1768976886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wiYiHrNDixSxXYp6RTyIy2kKNtBFyrMlCzB+T+XzHow=;
        b=jH6SgyfKZCyuVzRv7KAhM6mUMCYE62pTdjIJTgvnk9u5Jsa62KoMlNRVaNKWV9r4PN
         O1prKtNtyPsI+Gt3UhwbQ/jPalT9Y/89q7LvoJ8K0IIRjymO61rVycRigjsH+Zyx/Kvr
         gAvaVe3zx+2IGHFSmUKiONWs5EgMdpBJfM4+suXQJlCsvhE2K9WRObwDoz5Jfu4fe0u2
         6X7+mLhC0AJWfiBxQU4v3bvHud/7001pHj8Z6+6IjdT1t5b+5mmAz/s4nLyk7a3q+X/C
         +x0JcCrm9VEx4MiKTWVtIHWWyQL1ckZRH6Zq46TZKQAhB5g4ptPXYqRjvAYStOFmwboF
         2Nnw==
X-Forwarded-Encrypted: i=1; AJvYcCX0bSUOSL60004inFKfLiJaM2h2KPvfrpq3Fdu/heAl96HOanB4aAzwr+8DOHTa448lzvItzg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy52TBbyoJWRZT7JNMH6clufBSwzyZCPuoWaLJr3LgOcEJGz5OS
	saGLRm4Kq4uklUh5U98Xk0KV8b7oqqXw3m941VEwUWT6EYvgtHs1Mu+W
X-Gm-Gg: AY/fxX5K+YGshl6/gbUlhiZOWndB4AL9E5R3mhvYzETk2ecxEl7oKYse1xUtWtqAsj5
	Amnej+qzFJl8e7dJLv9YvxFEzsVyKPGnbhSX3YilkP4dFjscNdOR/zSDNCm3WSbrnNOBWOahg1r
	MICMsKMpFSTBa708c+UvR6qLpG6tMp7IdvFC1hNIbTi3u+4Bc9nE8bgAdO4Ov9QiW45ZLTi1dYI
	1FT3RGEh3r3xVqeoxX1bdkXDsaU1A/UQD0Q5Gx7Gei2fBQIPciqgcm7UxguAswTr5mSaQ4FM2T3
	yVEyyPFYVhkDGFUEbp09t/oJaee2DOK4UsdBX3TxUCKOSnF1zTStPQf8c64vsPuf8WP2OUsNK0G
	azTRd4xIlPaQqK6CBUsqYVhPfLKX9tz/51Lgr24U2VXW8SjVSvvmLnqHVuj+VM+hVj3wCY2pOKt
	2N
X-Received: by 2002:a05:693c:3948:b0:2ae:5dc2:3b08 with SMTP id 5a478bee46e88-2b486cb6438mr2174383eec.18.1768372086378;
        Tue, 13 Jan 2026 22:28:06 -0800 (PST)
Received: from localhost.localdomain ([2607:f130:0:11a::31])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f24984a3sm30586990c88.13.2026.01.13.22.28.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Jan 2026 22:28:06 -0800 (PST)
From: wang lian <lianux.mm@gmail.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wang lian <lianux.mm@gmail.com>
Subject: Re: [PATCH 10/11] mm/damon/lru_sort: add monitoring intervals auto-tuning parameter
Date: Wed, 14 Jan 2026 14:27:53 +0800
Message-ID: <20260114062753.88080-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260113152717.70459-11-sj@kernel.org>
References: <20260113152717.70459-11-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


> DAMON monitoring intervals tuning was crucial for every DAMON use case.
> Now there are a tuning guideline and an automated intervals tuning
> feature.  DAMON_LRU_SORT is still using manual control of intervals.
> Add a module parameter for utilizing the auto-tuning feature with a
> suggested auto-tuning parameters.

> Signed-off-by: SeongJae Park <sj@kernel.org>

Acked-by: wang lian <lianux.mm@gmail.com>
--
Best Regards,
wang lian
