Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B884350D7D;
	Wed,  2 Sep 2026 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358835; cv=none; b=uq8F0WxE6UcfFnsTptTPJu/BSJ7xyVlXjtwz0mHn+pD3OSXkpM+2xushG4eWXMiJha3hGjt335XZXP4F2mmLPItHxpnEmurKBe6+a9L3RaxZt6N6pYGQKMCPMLbO7ivUQDCIbGycRLJZCVDPrHwCENGjhOqx1oMn+pdzbFmZ3XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358835; c=relaxed/simple;
	bh=UyKjCelDYtezPkDnos3X4N2GgcmviN9Wdt8wkQBUrgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szOlfNeZeZaPCdIeG8QazSyusl49aH/069VBVYrRgXAdnN/QkHdYkQoAXMH2IfXH+1qo72JbX/eqyTAsXkusktQxQaLdj3YYHWi1pXRlkM0gR40GdyeRlF/0ELwF8goy0jy1o1e6fAId+pdp4fQRGpv8AS5628Rw449CAKRixpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lS56OM1A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lS56OM1A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F0C1F000E9;
	Wed,  2 Sep 2026 14:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788358833;
	bh=G9agrdnFdQejK6PBezRLA9LFhJ3vTbvnbf3qpO1t0YQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lS56OM1ArhNGYcnivIJ8y42C+SAeW77H8php2AuzL42mkwz9TFZniacvAzL758sgx
	 lDlgchQzzPNr3kkx1QTQ+BCRnRhx23dSzcBvQXGriZiw8npVqxHCZOHCbIJVLWIGW/
	 QyO+k/IV6rx1dCwvdbtTdoMVOtJbPa7eDMyinxxxkx2QrFeyyG6ROfOoGcJ5Zlw8P+
	 qumyhIVJ7wM9PZHhx31G3ZlbGXMWAvG0xIsdfMIXzXbzkmuSRFruqYC5ZchHsobk1Q
	 /YhyP4WDLEQIzcKr8OrQiPHB7QpI4Y4nE3dbQXg+c/Fly0MBzu7casTiEuzSnlW9Jq
	 NFNuUuWzCgn7w==
From: SJ Park <sj@kernel.org>
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] Docs/mm/damon/design: fix broken :ref: usage and a typo
Date: Wed,  2 Sep 2026 07:20:25 -0700
Message-ID: <20260902142026.87554-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902124550.31175-1-zenghui.yu@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'get_maintainer.pl --nogit --nogit-fallback' suggests adding below recipients.
I added them.  Please consier using get_maintainer.pl from the next time.

- David Hildenbrand <david@kernel.org>
- Lorenzo Stoakes <ljs@kernel.org>
- "Liam R. Howlett" <liam@infradead.org>
- Vlastimil Babka <vbabka@kernel.org>
- Mike Rapoport <rppt@kernel.org>
- Suren Baghdasaryan <surenb@google.com>
- Michal Hocko <mhocko@suse.com>
- Jonathan Corbet <corbet@lwn.net>
- Shuah Khan <skhan@linuxfoundation.org>
- Randy Dunlap <rdunlap@infradead.org>
- linux-doc@vger.kernel.org


Hello Zenghui,

On Wed,  2 Sep 2026 20:45:50 +0800 Zenghui Yu <zenghui.yu@linux.dev> wrote:

> From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
> 
> The Statistics section refers readers to the DAMON sysfs interface
> documentation for how to read the statistics, using a ':ref:' role.
> However, the role name has a superfluous 's' appended (':ref:s' instead of
> ':ref:').  Moreover, its target label 'sysfs_stats' does not exist; the
> correct label is 'sysfs_schemes_stats'.  Fix both.
> 
> Also fix a typo, 'frequenceis' -> 'frequencies', in the Adaptive Regions
> Adjustment section.

Good eyes, thank you for finding and fixing these!

> 
> Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>

Reviewed-by: SJ Park <sj@kernel.org>

This patch is applied to damon/next [1] tree.  If this patch is not added to
mm.git in short term (~1 week?), I will ask mm.git maintainer (Andrew Morton)
to pick this.  So, no action from your side is needed for now.  If it seems I
also forgot doing that or you cannot wait for my action, please feel free to
directly ask that to Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
