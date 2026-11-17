Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794882170;
	b=3vMkgIR9RR1Xxp94vJHIN2xVIaaBrSnGJA4P+1xWgzm5wA3i1dE6o17V1X12/H2+13WY
	 bG3OoY8bNhwBKDZPgaPIMCesdlx62N6dkO4GSqvDOdmwSV+YefCBiQ4gakE3UAzopDiyk
	 LbGB/jDO+K9wrevm/XiGPw92vDGbH1Jk3lxDRS6YGwhpr7irrKhJfUjRgM18TAoeMEsN5
	 ovFhX+hHptttkVzihWY+4u8Z7komHTQn5/6Aw6UuHA1s3G5PSxCogRjhwziYIHX7i72ds
	 eeAEg947LV3zF8obpRhj8Y3XovI344dPUYfWgqrTVb+0IXY9CPeoGE0/yYOeSQo9mXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794882170;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/3H1mpvRDxjYxRQV4+mRDY8Md93q+YJNHbYdI+GkXXs=;
	b=IChkSsx0zYrUj3EU0b82K4xeCW6zw3AtC9sQzs6PRyJKR1H8Ndb3D3Mte/qWDkwjDos/
	 S+5lODCte20fPv6ER3mxqxIYvRCKJShO0uIeR4HKxY0IhoB/J8rEFar9J6zyG51XBd5Ho
	 MBah9goyWya2NiQ6Yerwwd3wbXE6lsXdfnSF1pnK4HpnR/T5UJuONAFzhCBHoz2f3JM2k
	 UMrQFRbfcZDGu/2A1emfptFQ6WPPCTzfC08gjmRl26IcDYIogJ+Ta5zGz/IUgkT+VLcpQ
	 fiR40zhl8QuDVEG9JJjblzix81L53jaoNMX4iCK0Wncpn5T8cFwAg6lD1OV8on4RrRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="oV0pcpC/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28657606A31C;
	Tue, 17 Nov 2026 02:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oV0pcpC/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A391F000CC;
	Tue, 17 Nov 2026 02:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794882170;
	bh=/3H1mpvRDxjYxRQV4+mRDY8Md93q+YJNHbYdI+GkXXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oV0pcpC/ffQh4rYzlim2rjHX6x8pya+lJQW+QWen80nRL3PhybSB2Dju8jm5K/nQR
	 MGx2I2IQ/i5dlPw8fMOqfIf4Vhm/ETKoxUgNhjW5F16sRAYsyuWRIXy2Dp3qfRqAzf
	 Y8DxfYWDS1WTutcjkOR1czWMIX5y4t/WG67chhmR0/l23Bl1KBqq479/K2qPjJyhIW
	 r4HJypnvf7N7V6Hokp/vKvAdiaW8QU7sjUQFKTw51fMt2+OGI3kP4hHvtLISko815d
	 yBFFLEYp89wdkBS4GICSJVimhvFbZg9eo3YYm7STwI/hVGS+brGP7huF61E+dvLbCk
	 h1fm4nf2Jak1w==
From: SJ Park <sj@kernel.org>
To: Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Mattathias Pinchover <mattathias.pinchover@uber.com>
Subject: Re: [PATCH 3/6] mm/damon/tests/core-kunit: test sz_ops_filter_passed_last
Date: Mon, 16 Nov 2026 18:22:42 -0800
Message-ID: <20261117022242.110258-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116-damon-sz-ops-b4-v1-3-1cffe7227e6d@uber.com>
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

On Mon, 16 Nov 2026 19:10:06 +0000 Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org> wrote:

> From: Mattathias Pinchover <mattathias.pinchover@uber.com>
> 
> Add a kunit test for the sz_ops_filter_passed_last DAMOS
> stat.  The test runs kdamond_apply_schemes() for multiple apply intervals
> with a stub apply_scheme() operation that reports a given ops
> filter-passed size, and checks that the stat is set to the value of the
> last apply interval rather than the accumulated value, and that it is
> kept unchanged until the next apply interval is completed.
> 
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>
> ---
>  mm/damon/tests/core-kunit.h | 92 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
> 
> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index a5ca4bfe2f0d..ec83598fff0e 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
[...]
> +	s = damon_new_scheme(&pattern, DAMOS_STAT, 0, &quota, &wmarks,
> +			NUMA_NO_NODE);
> +	if (!s) {
> +		damon_destroy_ctx(c);
> +		kunit_skip(test, "scheme alloc fail");
> +	}
> +	damon_add_scheme(c, s);

Sashiko concerns [1] the fact s->core_filters_default_reject is unset.  How
about calling damos_set_filters_default_reject() just before
damon_add_scheme()?

[1] https://lore.kernel.org/sashiko-outbox-217563@kernel.org


Thanks,
SJ

[...]
