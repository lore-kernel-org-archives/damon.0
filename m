Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B473FC5C9
	for <damon@lists.linux.dev>; Thu,  3 Sep 2026 08:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424413; cv=none; b=hD90oFRkxlavNjDvaPKDsfsArK6eKUsbNT8a7ETxDq1de/2JTYQtxUB+oOa35KVNMcYiIdTXf9gnuW2TuRZoEHEFDZxnUavRpZIFvSopVWDDh9FIeQ9sgopE2yYoFF8JvMv9u5HBj7+3wWtZLgMTMinke+RHgmytXbaC5nf3bP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424413; c=relaxed/simple;
	bh=D6LEF5qrYz6DbFwcjMxDSZY/iZagbFXt2muTMD4vUes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2VthcJ2nwORhhtvVrNPbys1vjA8V89oQuunHxphhbGGA+7j5F8CfCxhMAk6R30fyt6J/hZqXSrHXusZ2RTks1ACEhWhnbSwk4xpiqsvtvvuKv/CvQzCnl1es5NwswSAe+ZT6cUHMRTDwzk3H3bkQ3Swd7lnsbt+ck240A5V+DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyPreM+f; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyPreM+f"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-395cf2535acso845089a91.1
        for <damon@lists.linux.dev>; Thu, 03 Sep 2026 01:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788424411; x=1789029211; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OociqrsBmV/E6a5jpk0qDALr4bKhrSE+A8mgKI0tJ1g=;
        b=NyPreM+fT7v2cW1q/uTP0dIgIlmFKOu2kpinE/YxnF64byGP8uLON4ONMYPYzVY4Bv
         lSSfQfnsFvngq9Di1cjzs3j6/NB6PsJ8dg5v3tuulU5orZOjU3zKbPjzyZY4xljWJuGF
         bHnC0CCIEjh/EBmvreXTsfN+t8P4loEQgIRwld+TAf5UEHm7ZjA5+4j1TUvT003iueG0
         d665JPW+/50LkBkGR/d+jLv9QXrqnIcOC6rYpKx+DQHxfVmuHpXOueAlAEiwqReQoPbT
         a1vGIUkA/lYN5XVGqwwCyNXr8CpGtpBa3R8s0OIrMKYAALEk1uP0SDrVz8xKOLYgCdY3
         IDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788424411; x=1789029211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OociqrsBmV/E6a5jpk0qDALr4bKhrSE+A8mgKI0tJ1g=;
        b=L4Lo2xU/hYaaSFcXhF/5Sak17BRnkjZxx/QoIF50zEDBARRNjh7Z6OWkbQZetTv1yb
         /8AL09OAmuSXZOTe93Sjm3w48cy0N6gsHSDHbQ65zVJkp76o/zFUjyzytjuQfPS3E6Wz
         FGyK8hgkE5760ZsV+6Srj+f2fqAy0BsmAJ9fUEM92ZWpFnnrb68D5yx8Wuj16MyK5tIP
         DghVdng9Y7H9KWexm5htY53mAq1mHYQoveIJ7xdOY0NPqrTNKlGgVURCrlfQ4wwTVR9i
         /RU+j78jARO2YN8PyH7DN2O61KWrJ6x/TrmaZhGMEyfCR/BlO6GpT5N8MAb516gMVaaJ
         /MyQ==
X-Forwarded-Encrypted: i=1; AKwUvBzHDyXqjn0xJDL74iIiJZcDqwVNBuWFSXpMcMQvLM86RMKY5BgIAfvSgRQN/c88i1ySrEMuJg==@lists.linux.dev
X-Gm-Message-State: AFuF++mpdqJBG+gjaAjtEqv/EDi4u+KdQLY+bR9pozki1BLhNF6VurJK
	FxInfArlQC8wbqpgmJp9Q+EezGW+V4jwxFIvsqtw3Qp5ErxyOKNj6en6
X-Gm-Gg: AYBFou3Ve3f/uBarw6RUIdc/VbwU+LC/FoHBco4lfAyWfIgaz013hNxdFnnthsMvyr6
	04DkEWZodk2dZargEWaSa8+gZPkGujXg09K1CFCPhwu8k0iCcKb30D/Ewb8b5M9sTSBXca27u4A
	4K4Vy3kIqwnSJyll4bThQB3cF2X1dShX4AjfANSi1bk+mYNwGl9l5EPCHmkCQQWbAQtOnEJqjif
	cfAi0Lbf/+cRr7hRwa9aLpxcvvjMgmO4m+cxw/8uTLN5INu0Y4ZoHsna1qTFWZ+MTczCdF+Ly9p
	gxm3r9jfxMkPRbMnyYQbKbn/9NFEM29iYkdpyHFigdUHT7H8S/SZyHhjfzH+k31yV4X9yh34eqF
	imDaRW0S7tQDr5vl6bZHKbudS+I6/r+lignBaQ/bM9o+7XrzBXfUEIF/jdoMvLr3GFoIwt5AtvD
	+9yI3CkQCDhW3eDhpg567O4bHZkhf95xYU58Z7mznXFv+gO7oJ1M7oBvS/JXOybptSjfYfrqca
X-Received: by 2002:a17:90b:3cc3:b0:398:9bd3:d6d4 with SMTP id 98e67ed59e1d1-39b132d819emr1843780a91.14.1788424410133;
        Thu, 03 Sep 2026 01:33:30 -0700 (PDT)
Received: from gmail.com ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm4001175a91.1.2026.09.03.01.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 01:33:29 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: SJ Park <sj@kernel.org>
Cc: Kunwu Chan <kunwu.chan@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [PATCH 1/4] mm/damon/tests/core-kunit: test committing psi goal to psi goal
Date: Thu,  3 Sep 2026 16:33:18 +0800
Message-ID: <20260903083319.451754-1-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902002725.108635-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  1 Sep 2026 17:27:20 -0700 SJ Park <sj@kernel.org> wrote:

> damon_test_commit_quota_goal_for() is set to test committing a new psi
> goal on an existing psi goal.  However, damon_test_commit_quota_goal()
> is mistakenly not covering the test case.  Add the test case.
> 
> Fixes: 99f89debafc5 ("mm/damon/tests/core-kunit: add damos_commit_quota_goal() test")
> Cc: <stable@vger.kernel.org> # 6.19.x
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  mm/damon/tests/core-kunit.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 7071ec277b007..f1e11548c771b 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -793,6 +793,13 @@ static void damos_test_commit_quota_goal(struct kunit *test)
>  		.last_psi_total = 456,
>  	};
>  
> +	damos_test_commit_quota_goal_for(test, &dst,
> +			&(struct damos_quota_goal) {
> +			.metric = DAMOS_QUOTA_SOME_MEM_PSI_US,
> +			.target_value = 234,
> +			.current_value = 345,
> +			.last_psi_total = 567,
> +			});
>  	damos_test_commit_quota_goal_for(test, &dst,
>  			&(struct damos_quota_goal){
>  			.metric = DAMOS_QUOTA_USER_INPUT,
> -- 
> 2.47.3
> 

Thanks SJ. The added case correctly exercises the PSI -> PSI commit 
path before the existing tests change the destination metric.

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu


Sent using hkml (https://github.com/sjp38/hackermail)
