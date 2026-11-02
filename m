Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793629536;
	b=KwFN6xRHADznBq9wgwaQkMrEuYLLIxqrEwse6Nzly0w0nfbyNcnxHMi0kWoX/WloXVYM
	 VFYC1pXLfYlTc5L70KpgVf2Hj/l5e69iIwRbGKy4jDiptUmSAl6j3Ct6Rik8l4SLblTkg
	 xTWFoWJh5BjUTHYWUcthepJop/yorA4S0Vcg4xfC0oA3UMrF5D3fJp9hgYV/fOSuwOChh
	 tTg2s5teZY9qQ43lsEVvZz4DMXth9FMvznMW2LcZQW31+26+UF7FuVKO78bL8nbBp1eOK
	 mZCxoJz4KWP65l5YwSpETCBnyhlBnH781iVCWoMppx5iBF5FpEU1iwrXE8hxgiU9BEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793629536;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sRCWFpBz7FUgfB3FARLk2m5vQjODJMmPqdZnqL3DW4o=;
	b=eEpjGxI6eIuQA3xzqOFsv6SjfoUEauCYaPr9+1ej/eDiRTmfVdDRMnMj29P39RcTaYrH
	 bapd1UJwE5ys+kcY5bhQ91AJJlQe+V8IwhMWeSHANW4hnMGAbrS6hpbyLY5EuT3Cu7MxG
	 AP5Vtv6Nvv+ET5DjgFv0xjBq0Wvzb5jTqk14ZnyFPhN6N445NMQGnO4GYGzlnXTGuFmLl
	 Glw9wWj8rYkmBZ7vhU0SNCiInq8fzXmGp+zHQmsE6ZDYUNq5LEROzw1ss0gmLW0AZfOBy
	 yy8PqosLUoQMlZBDEv8dHeb1VAmK2jsMVoN2A01x2PLdNYfMQG6PYsh2wrHurFxb1lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qnp4nuoE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A560606B1CF;
	Mon,  2 Nov 2026 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qnp4nuoE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9356E1F00A18;
	Mon,  2 Nov 2026 14:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793629535;
	bh=sRCWFpBz7FUgfB3FARLk2m5vQjODJMmPqdZnqL3DW4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qnp4nuoEfk8SdEnmrUkDHhXQUJXar6SX8Pi/DJVfadKNXU+/ctRAHnZp8dZaCRxAw
	 fcYb6hZd1zRLPUMakrEKVr0sOc7ajeDE5Izdae3NY1zvrzLlN761lH3e4+fPxdsTRU
	 CxkjDup95CmCwWKMw0/+xp3bICK8mdacJAN6HZJZCAVzm7Rc4vbgGBDPZagaqjZooQ
	 nieDQzA6NqrKQXFK4LIprqJKLKd4AcDQn3nuLVlLQ0CjQFRJblDxFCxTP+eQ7meUWj
	 zlD+6ugLz8L6ZAbPh5zuzDxjfOSL1v2LPhUQRMozZ7TzLTeP71yNW9B831St1pJ0na
	 9Wiu5/7EtuXlg==
From: SJ Park <sj@kernel.org>
To: Wang Guangke <gkwang@linx-info.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/stat: avoid overflow in estimated_memory_bandwidth calculation
Date: Mon,  2 Nov 2026 06:25:28 -0800
Message-ID: <20261102142528.27792-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <auhgJ74TeQOIvTtO@DiGouShu>
References: 
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

On Mon, 2 Nov 2026 18:04:23 +0800 Wang Guangke <gkwang@linx-info.com> wrote:

> Hi SJ,
> Thanks for your review.
> 
> On Sun, Nov 01, 2026 at 11:13:43AM -0800, SJ Park wrote:
> > Hello Wang,
> > 
> > On Mon,  2 Nov 2026 02:00:01 +0800 Wang Guangke <gkwang@linx-info.com> wrote:
> > 
> > > The calculation of estimated_memory_bandwidth computes
> > > access_bytes * USEC_PER_MSEC * MSEC_PER_SEC / aggr_interval directly.
> > > On 32-bit systems, the intermediate product
> > > access_bytes * USEC_PER_MSEC * MSEC_PER_SEC may overflow before the
> > > division is performed.
> > 
> > Do you find this issue from real usage?  Or, jsut theoretical?  Could you
> > please clarify it, and user impacts of the issue?
> 
> I found it by code inspection, not from real usage on a 32-bit system.

Thank you for clarifying.

[...]
> > > +	estimated_memory_bandwidth =
> > > +		bytes_per_interval * USEC_PER_MSEC * MSEC_PER_SEC +
> > > +		div64_u64(remainder * USEC_PER_MSEC * MSEC_PER_SEC,
> > > +				c->attrs.aggr_interval);
> > 
> > Let's use USEC_PER_SEC instead of 'USEC_PER_MSEC * MSEC_PER_SEC'.
> 
> Thanks, I will rename the variable to bytes_per_us, and use USEC_PER_SEC
> instead of 'USEC_PER_MSEC * MSEC_PER_SEC'.

Thank you for accepting my humble suggestions.  Looking forward to v2.


Thanks,
SJ

[...]
