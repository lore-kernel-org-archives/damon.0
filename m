Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510D9392831
	for <damon@lists.linux.dev>; Fri, 27 Mar 2026 12:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774613414; cv=none; b=CJ9g+ylPIDnIDTv1uhAQtDStm5L35TtHIZ5b+H4PNdatcusOn597Z/EOPWpobMuKzJe5D1Qt8jDUP7r4irkLMKamenVxUaAczg9mXvlDbkEUKvjGPgadJ0fDv+s1Ly6HOTqYhUYNf8x+p7tyspLJoDAkDl0V8uU9HNg0TKOBga4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774613414; c=relaxed/simple;
	bh=P5V/1Wbu9XfRyN3Day1/4i0275Wd9nGLuW+cphxmC8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCNpRFl/WXCbVOSsmcmk9WI8ax9/5/4b/mUSgYH8imlouYfdN8blDTEk1ukGm+b9XD/pjlrjledq5s/bqSvSLEUaCqcgw0zWV4tlGKanDu8po7Q4MTNZMdbJn6RkslJtXlLR3lUdbOzmA8cyR3/MghUb/kEstb0PX5HvQv8g+a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkjnuNrY; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkjnuNrY"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35a04d6aeb0so1846801a91.0
        for <damon@lists.linux.dev>; Fri, 27 Mar 2026 05:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774613413; x=1775218213; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5V/1Wbu9XfRyN3Day1/4i0275Wd9nGLuW+cphxmC8E=;
        b=QkjnuNrYepNjItjxxpKRRx+chXTpFQPrAJHGsTxo6zPIeQdZOan6ql5tg3l6HhNV25
         Mj+FuBBTv/N67UHPpxzguptoy7bV8G55tfr1fP9u3J5sB6CYw7X4PGkUsVbWZJlaG+yC
         szcL1s1cW9HZx7JTuxTeBxSBkJ6Fv8Z9plaQJIeddt8v15rVqAnUiMrOjWrwUwlnIWea
         3l15FOGquA7aN5Mc8FA378gWbNmn6xWN7ribgqZv4zej434I09aKnnKvm/4B8yRnYrCO
         epRASpo3oNSqf1dCjEFUJXGJmON/pU3sJHAQVwMcPW7qkZOkUoJwoCVd5nNVfFPHXtWF
         5YsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774613413; x=1775218213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P5V/1Wbu9XfRyN3Day1/4i0275Wd9nGLuW+cphxmC8E=;
        b=mqxl4O4PyM1Q8FdC+LWXyGlcYwVNk7DVJvIQYQq2oFKAwdKEGCt7jyTIH1xciFVSrP
         0IHDfDRvJWhoEztNXuKqmyyTVaFnv5GB/y1Ua9+9gx1TKOXEnJtE89UGOgzFilAyEjq9
         00LklGyks4IlWDWxJuq7h2zJ8h9O6eqTeVPxyjbJSsfPl8Myr0MGd1fqCK4hSze8+04H
         M1pLtYgQPFGMKDW2UqH9oKZFMs2V57fiTr47PMJPN2jtclLARdJHeK++ksCF/QiEIARP
         GsRllpoJ1zkiCMV6OvBG2hzAuSVjyBgPYYaYPM/x/jMgeiNCu3oX6UTksDUEantj+FAn
         F5aA==
X-Gm-Message-State: AOJu0YxKG0PC93iWBIOO0UNF2l+D5MIC6aUp8Sd2RKUvWXdPsgAhZado
	8UShEX8Ft0JchwcPg/m670bHjTlcL9AvDMMd1FFT5fBICX7G8hIh+Fcz9NsK9Q==
X-Gm-Gg: ATEYQzyR78XjzobGLctWP7v7DJOAIHAz4fBeN8kMmfFHSXI4j+rT1yV8+EIpW0C9JAM
	aoCmkm0z/k7UDs9n+t3MPEH9fERSK7E4PP8DFtF9UZdmGrbR2OwxDxdDDq5vP0Q9PlPM/1RgBnL
	d9oWoMeSmH1/57O41KUvGPUVdJREVWSODv2dluzWgFRc+JtOC4DJGNvyufOYB+SJWpoo06JfBqF
	k6iSoDsCdEEQeAG8qGDzhhdcYqBN9nDCp1mPiZvhqFUmbCBfX96wd13+ISRSmB2U3SxxIeKibd5
	xlhOzubAaeVKa4rkAsrBIxbKL9xclPNFugf4mUaakhqblOKbja+Ba2TDluD+1KgI13KUiwMp5hl
	mndmsMoyIiHqNBOORzUgr9aWM4L1wvIdwxr/9LARc0Qi8T91BH2kUXGltCZA5M8SBR8Bi/vJPhq
	tPqPeCOUDm4/guGhftEzGy+BASUJ5A7ouu0spzwvWym6nRcNmZxF0=
X-Received: by 2002:a17:902:f607:b0:2b0:6829:9414 with SMTP id d9443c01a7336-2b0cdbe9dddmr27888725ad.8.1774613412558;
        Fri, 27 Mar 2026 05:10:12 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc786b7fsm80852155ad.20.2026.03.27.05.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 05:10:12 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: aethernet65535@gmail.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	sj@kernel.org
Subject: Re: [PATCH] mm/damon: validate addr_unit to be power of 2
Date: Fri, 27 Mar 2026 20:10:08 +0800
Message-ID: <20260327121009.38374-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327064517.68131-1-aethernet65535@gmail.com>
References: <20260327064517.68131-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SeongJae,

Regarding the kdamond termination, I have an idea:
Should we avoid terminating kdamond just because of invalid parameters
from user input (e.g., non-power-of-2 'min_region_sz' or 'addr_unit')?

Since a terminated kdamond cannot be easily restarted currently (if it
is not terminated by 'echo N > enabled'), we should probably try to
reduce the probability of such unexpected exits caused by user input.

I'm thinking of validating these parameters early in damon_commit_ctx().
If they are invalid, we could reset 'dst->maybe_corrupted' to 'false'
and return -EINVAL.

This way, since no actual modifications to 'dst' were made before the
check, we can safely clear the 'maybe_corrupted' flag. User will then
receive the error but kdamond should be able to keep running with its
existing configuration instead of exiting.

Does this approach make sense to you?

Best regards,
Rui Yan
