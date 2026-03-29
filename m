Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD6C296BCD
	for <damon@lists.linux.dev>; Sun, 29 Mar 2026 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774797309; cv=none; b=LC0beM4nRKsudO+XCOzqJXg6niD9KbLIQablh3jYb0ZZXLX9Iewze5iec9OWExaKif0V12UCCtZp24AUIqHQ6eTjxIFL3gXHqmzvoqW5iBvLB2m31lzc8cZF6Rt8M+QdAp9WOcTzsHxI6EYKRPZTmcaMNtnjxs1DPTYWoL/0KIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774797309; c=relaxed/simple;
	bh=CVh9eQJNAnqOlDZKN8KfEisM9pB/qcp/6vZJUm8Xpec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UofEgAP5kPNwPLOtX9HDedMSnfcCcq+8Fd6zh7TfItGu6dPbeqN7YOZEik5Izmz/RUSVFeMFOBBywjzVmmWScFO1htwN9QSkBWnmkDcy3l9gS3em+K2733H2YlyhmZm6uTO4I5nVPhn97U+F2SB2YvZEkEfzLppJIhabk7c5xJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/Ff42A4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/Ff42A4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083D5C116C6;
	Sun, 29 Mar 2026 15:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774797309;
	bh=CVh9eQJNAnqOlDZKN8KfEisM9pB/qcp/6vZJUm8Xpec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B/Ff42A4ZIKPJcEGjqNUtDKRVpWjFBvFHSSM3PBCLgaaGPNwYTKDNhya8aZ6n80Pf
	 pSiACfyMDrzeVpADIU8G78RnbLIH+2iX6+QRR6oBzgB+Wwv/jPj5c6l6n/dLnm8yxw
	 zktRv3IErzR7BR/rzRzJc0lx0KMvrQNuWUo1IuVE96Evh1zCw8XnHFzWooV0SYDEKq
	 KLDWPu+HD1g8nI2JQVuq7yMZKNfQqGu3dgMUcwLp4KODArkKL2TuB4lvwx59iWF7X7
	 4VMuDXkOWFMkE192gWif5VBibx1j/7UoHSdgO24nGF3giPEy/y+qoBHppmloGioAFj
	 oEoGxFHSYLoSw==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: validate addr_unit to be power of 2
Date: Sun, 29 Mar 2026 08:15:07 -0700
Message-ID: <20260329151507.44171-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260329075107.36402-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 29 Mar 2026 15:51:07 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
[...]
> Thank you for the clarification! I may understand your point now.
> 
> So, you prefer to keep the fix local to the modules that have the issue
> (addr_unit_store()), rather than changing the CORE damon_commit_ctx()?
> 
> To confirm, are you suggesting something like the first approach [1]?
> 
>     if (input_addr_unit < PAGE_SIZE && !is_power_of_2(input_addr_unit))
>         return -EINVAL;

Yes.  But the real constraint is min_region_sz, so testing it would be more
simple and effective.  E.g.,

	if (!is_power_of_2(param_ctx->min_region_sz))
		return -EINVAL;
> 
> [1] https://lore.kernel.org/20260325071709.9699-1-aethernet65535@gmail.com


Thanks,
SJ

[...]
