Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29545303C8E;
	Wed, 13 Aug 2025 17:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755105324; cv=none; b=j4hhAHABUshtH9UVbPC2bvf3ONX9yUodWfB89PKu0yRC7ArIxzXKLqr1fGhs4zwHDuHiaSmA0WDDAq3uQmEWnVzMrNDaXIbRKyJO+lB5CSYl+MOwCUCiUyppBB89uAEYJwfJCrQTyKYXAq7ExYTz4XiVSKUxxoxBTgg9yCZtzIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755105324; c=relaxed/simple;
	bh=haP9OHMAMhQFyfWQmk2C/oxDgQ10LKbcB3P5wQvSL/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lPiqVMMYoi5oWuMfg9FslVn5iUdVzSiX0XeRnMKAeQfDjXLIejegjiKnZnFS0XH9Gn9PZd89PjCyImp+w+D0IPkKGZdBDv7qBNmi7vKsw3Sg7rPmLLE7heNULqo6VlJl7ymmbg5q23lh3sMC/8666RCVmtj88RvN4qTX92sOFbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVRSsYTR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVRSsYTR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6A1C4CEEB;
	Wed, 13 Aug 2025 17:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755105323;
	bh=haP9OHMAMhQFyfWQmk2C/oxDgQ10LKbcB3P5wQvSL/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LVRSsYTRdX2VYRvvtiefw8TtFiUqluqdhX4D1x/IfKGW18QxA/MT80uUtDrTDXmwP
	 odgWGA6ydkOLcK+k0wYoy+CoxXhcimEBLnEWT4YvZ+Y4yuQWxrvlouRwaPQ6dV/d/3
	 GKpz0muIKNZ6L9RPpM8Z+YcTxHFxwvvrip5WYSOuSRzhxtkkbG4MQDRxu0Re4SXOMZ
	 Hp+favwPOR1ejoNm2xv8VxlHDB85zP3sVmpcJsm+rIlVaWQHSu6Vsf7N3qlooxmHxr
	 cXzBiJOjQes8yXqgPYkiWM+eM4Qg8r4VK12OEW5MFK1Osmpc3MOOvQASCGtRzIDqcg
	 8GnusH16avy/g==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [RFC PATCH -next 16/16] mm/damon/core: handle quota->esz overflow issues
Date: Wed, 13 Aug 2025 10:15:21 -0700
Message-Id: <20250813171521.6482-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813050706.1564229-17-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 13 Aug 2025 13:07:06 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> In the original quota enforcement implementation, the traffic
> calculation multiplied A by 1000000 due to time unit conversion,
> making it highly prone to overflow on 32-bit systems:
> 
> damos_set_effective_quota
>   if (quota->total_charged_ns)
>     throughput = quota->total_charged_sz * 1000000 /
> 		quota->total_charged_ns;
> 
> Requiring total_charged_sz to be less than 4GB/1000000 is unreasonable.
> Additionally, when overflow occurs and causes quota->esz to become
> extremely small, the subsequent damos_apply_scheme logic permanently
> sets sz to 0, while quota stop updating, ultimately leading to complete
> functional failure:
> 
> damos_apply_scheme
>   if (quota->esz && quota->charged_sz + sz > quota->esz)
>     sz = ALIGN_DOWN(quota->esz - quota->charged_sz, DAMON_MIN_REGION);
> 
> Total charged stats use the unsigned long long data type to reduce
> overflow risk, with data reset capability after overflow occurs.

Thank you for finding this issue!  I don't want to change the data type if
possible, though.  Could replacing the easily-overflowing throughput
calculation with mult_frac() fix the issue?


Thanks,
SJ

[...]
