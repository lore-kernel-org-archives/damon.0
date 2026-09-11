Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A83B3BCD05
	for <damon@lists.linux.dev>; Fri, 11 Sep 2026 02:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789092025; cv=none; b=VStcz3YRvDK5WOKUgRVnfnu4eH+LeYK54jZYUvFlXPluydlbx5mbS+owAQWtybJOohd4ZVsM9G3f0gPT7pmp54Gyl13VWCl145xRSzHUZQgeR3f11f0iybbyCyvFhO9pKQLLpn80YllweZgE6ce4lnz6NFIWq1wSF1oJO9jbQ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789092025; c=relaxed/simple;
	bh=eMcNxywo4P22GAl1/QRj+gOPAB3bl1kko11WHwQr9l0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=puXlxehSO+Xp0bwLj/0qkj6QBEwfF0jKq9Rj4mwJ+lVeDt0Nt00g1wahR0O8J7xUXswqduam6E5Xt0dzbIEaZDfyJ2jh5NH0gLvDYLuPmUZnrf2NJzTB8UtN84p6kQ4OnqySjy74qnd4uEqVyzyNVk6vlmlMQgQluIPLv0sk+uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJp8s0mx; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJp8s0mx"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d58efc7356so5164315ad.1
        for <damon@lists.linux.dev>; Thu, 10 Sep 2026 19:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789092024; x=1789696824; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g2mR6Y35CkB0Sm25OWNIh+4C9SYin4d4S4zqnM9oCeA=;
        b=LJp8s0mxfBhVDv81ciC7vO3Mprcu/0SQP2+LOOIlQvrYv4eAYWWFUbORNpaGDOHS+N
         yHttTZ7wA1aTYGFDItEXGEtGsMfDR2fGDHXCSkeGqPgJHV212k6676CiDVwU8o/ghwiX
         laMMOge2a7bFqzt8HRMcVD21LDlKwQB1Cdos6a0p3n7V6mCGIPu0K/2bb2/kM61lvyO8
         5/dD/71/nezgicCDoN9DSM4/Is66YE138ShIkPHNr01AR5nmkRdpZuSreuUNcj55Bgqo
         rXtDySw8tuYiKglk7aRn1fc+dnRjeHKutaYeVnFxgSy0DGb4eQRvx8Mq99oEYjr93RoA
         tu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789092024; x=1789696824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g2mR6Y35CkB0Sm25OWNIh+4C9SYin4d4S4zqnM9oCeA=;
        b=FpBu4tBlh3InCB2bZ+YSUlpnSYYaRPbRYjNYwBqwRNTd8vte/TaRMqol6iGMKZ0yi1
         MXlBTi1E/d0IkO2AmecLs5Ji9JOJaKmQKrSAdo9oFr9bdlJQNFtfT5O+vBx7UzAsgwwI
         BmeLY8oj4B+0L1TbCCiwg/LCO+ZLG9Qve3+qAP8sP5QNIX5Ch71p810k/02Pxg+3vACz
         3CCJyfZbhxAYCmEympRcLtVD23f8TrgkD/65gKUM8NKjKXgHFj6jjQI2/aziC9+NILDV
         Wo24XNdgI8apRXLzKP+XonFKN1d99WUKNJMzKRKDZhqIl4K7AyQQSJ9Lv5ZFdlfnwQwP
         HheA==
X-Forwarded-Encrypted: i=1; AKwUvBx4ZbxvFL1Gp8B2XD7QoWoNlH3W5oREzDarTqyykY+unDGOgvkAKYGNyy0Au+OG+5GNkSiF5g==@lists.linux.dev
X-Gm-Message-State: AFuF++nJL0S5OenliTQ/kbuKPMQ1jwsCDtc2Z7t2Jpwi138Fv5av6Ug4
	PwP41ayZVivYk6cR2GeDI6HFcVKdelExqoZu+rZhroi2EiZd0w0cl6Pa
X-Gm-Gg: AYBFou2Lw8RIuRSZIrbQrZXN+nUxAD+lP/BpB0MJdo5xzUwTwObJM06iMWKCc310Tsq
	bPWZcxktC3HTxZS0O7W+HtDKOJohG84DEBV0ILVSEi4sSKvREqKaDXA4epVkw+0K2WMZsCHnnVD
	ZarYkwVPjKblP/skcjdL38nAX6ho7i3N9Il9aYzvKvPq5mQyWOZoOwDSN5bF/VBB41dO98gHONf
	exIMyUlVht1tBXz7KHZPJQb1O12mrpZ0ydHcF6hPStyiEUyjqaBEQNxRq1HjgS16axV/bILl7fO
	C1RTEu4hYubqve+A2vSuj/a3frtXe9p8qZkOdX1I+qsNFsrQ8M69QXmAhxanteuCxrMa3mYVSyK
	K2VIoqgJU8zFTayJBUEV9oNYWt2Vnhf0DZR8TzJvae1CWGxIdLDoiAsJ/OHBzlV4ImKS1HAYCqE
	iLTJUbbX1NuqYOytVVuFSvNuEVmXt/t+Utt6uGCWa4jV5Cnlbs2nJXG50ilIlPAAwK3nxTg/Jpe
	TPjClzuVBSRKW6pj5FLmKQpraId952Nt/VDsFkw
X-Received: by 2002:a17:90b:384d:b0:398:c315:fa6f with SMTP id 98e67ed59e1d1-39d9c1db3c9mr2574336a91.14.1789092023699;
        Thu, 10 Sep 2026 19:00:23 -0700 (PDT)
Received: from localhost.localdomain (vmi2317697.contaboserver.net. [85.239.239.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d94bb0119sm2263927a91.2.2026.09.10.19.00.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 19:00:23 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH REPOST 2/5] mm/damon/paddr: move probe filter handling to ops-common
Date: Fri, 11 Sep 2026 10:00:01 +0800
Message-ID: <20260911020009.37475-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909140408.104699-3-sj@kernel.org>
References: <20260909140408.104699-1-sj@kernel.org> <20260909140408.104699-3-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 9 Sep 2026 07:04:04 -0700, SJ Park wrote:
> Probe filter matching logic for anon and memcg type filters in DAMON's
> physical address space operation set (paddr) can be reused by virtual
> address space operation set (vaddr) in future.  Prepare the future by
> moving the code to ops-common.c

Nice cleanup.  Moving the common anon and memcg matching to ops-common
preserves the existing paddr behavior and makes the logic reusable by
vaddr.

Reviewed-by: Lian Wang <lianux.mm@gmail.com>

Thanks,
Lian
