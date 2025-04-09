Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6B6250EC;
	Wed,  9 Apr 2025 02:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744167039; cv=none; b=qgpyYilzz1fDuOO7KmJwGBhFHhfafMd5mRqdUuFj5HAuqjgn2NUidy6I3Vb406kbB4WTpoS9i1elFjdFM1NqD+mLVfy7SSmuDiQvr84up7wSqDDq6jUbJl4kOfoFWryzS+PPIpH3ft4XK55D34/n7Lz+REpYxxnK1ZetreYqrms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744167039; c=relaxed/simple;
	bh=1vyMQj7G0bbnlgmsq19xl83Td1ymxWFwpTojbnZNiFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BE2uUMZgUd7z5yT4JBv76gTJrITvKdf/jZ9n2NDdzQ4BSLSbWAytptIWQaA8unUIVDpKB8b1MML0WocaPulG1dsBvL4g7FZ0OviHzkgipXK3+zcgNrrO+8OxFx0rmo0wSt4Qp0nGMsz+97UhtO2VyOMqh64relTihcSR/xaYki4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/05zKN0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/05zKN0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA4BC4CEE5;
	Wed,  9 Apr 2025 02:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744167038;
	bh=1vyMQj7G0bbnlgmsq19xl83Td1ymxWFwpTojbnZNiFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p/05zKN0Z5ms9qbA/u4dubP7wCDMrwWlKM2JCSpb4M8Gsf/hMeXkgjQFG1Jo5SEJ9
	 HaW07bFjALlsDI4mj3OWn6tHpmhf4quF/BiQCoTgu4CuFA0/qnenKp++viiEt2xCQK
	 bh5qLg4xVmQ1ZoIFJsCl1jhcbUOcgEAAO7EcHtwv8HwfLZuDkjF2M/VCmZUbiE6C2o
	 l393zMAZIhnPqi/lGOAx8e+8HFmClUN/FUbeFewPlL/LRvR+TRTz2WBZhee6wAF97I
	 fZlJR1q1WikcO13H7E3kxXNZoyQ8iMqLihBV44Cf0cY0BHYMQK4njrXKV7nWtEc5IE
	 22qxyyhyhMXxA==
From: SeongJae Park <sj@kernel.org>
To: Ze Zuo <zuoze1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com
Subject: Re: [RFC PATCH] mm/damon: add full LPAE support for memory monitoring above 4GB
Date: Tue,  8 Apr 2025 19:50:36 -0700
Message-Id: <20250409025036.70633-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250408075553.959388-1-zuoze1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ze,

On Tue, 8 Apr 2025 15:55:53 +0800 Ze Zuo <zuoze1@huawei.com> wrote:

> Previously, DAMON's physical address space monitoring only supported
> memory ranges below 4GB on LPAE-enabled systems. This was due to
> the use of 'unsigned long' in 'struct damon_addr_range', which is
> 32-bit on ARM32 even with LPAE enabled.

Nice finding!

> 
> This patch modifies the data types to properly support >4GB physical
> address spaces:
> 1. Changes 'start' and 'end' in 'struct damon_addr_range' from
>    'unsigned long' to 'unsigned long long' (u64)
> 2. Updates all related arithmetic operations and comparisons
> 3. Adjusts print formats from %lu to %llu where needed
> 4. Maintains backward compatibility for non-LPAE systems
> 
> Since the overhead of always using u64 is negligible on 32-bit systems,
> should we prefer this simplified approach over the conditional typedef?
> 
> Alternative implementation approaches to consider:
> 
> 1. Introduce damon_addr_t that adapts to CONFIG_PHYS_ADDR_T_64BIT
> 2. Convert all DAMON address operations to use this type
> 
> Just like implementation:
>  #ifdef CONFIG_PHYS_ADDR_T_64BIT
>     typedef unsigned long long damon_addr_t;
>  #else
>     typedef unsigned long damon_addr_t;
>  #endif
> 
> This method could potentially cause minor issues with print formatting
> and division operations. We'd appreciate any suggestions for better
> approaches. Thank you for your input.
> 
> The patch change allows DAMON to work with:
> - 32-bit ARM with LPAE (40-bit physical addresses)
> - 64-bit ARM systems
> - x86_64 physical address monitoring
> while preserving existing behavior on 32-bit systems without LPAE.

Again, nice finding and good improvement.  Thank you so much for sharing this
nice patch.

But, this doesn't seem like a very small and simple change.  I think we can
find the best approach together, by understanding impact of this change for
short term and long term.  For that, could you please also share how prevalent
32-bit ARM machines with LPAE are, and what would be your expected usage of
physical address space monitoring on such machines, in both short term and long
term?


Thanks,
SJ

[...]
