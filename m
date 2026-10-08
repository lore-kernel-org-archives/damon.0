Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C3A44A403;
	Thu,  8 Oct 2026 11:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791457391; cv=none; b=O5lPFAlfTqbUP5PDcNLlVAx8dtiR03LuVNwGNYenrj71fUabNbWqf8pY5WpbR5auZr45gLNRorhS1zCN4mzU3q+6cjXmDzAUSmJkjqBjlPc3ZoNvpeSRQBHhTc6U+v0s9XIiuriTEXoCKT34cKoXXbmPEi+finawvWV0EA6DitA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791457391; c=relaxed/simple;
	bh=Hb5flAxEG0Nr43NRgMToqCwprX/ILvuX2etiDQldxQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mXYa9CdLPLo6iJd7ToVGTyfd9JMGoaPbDn7FmV44VS+mGEmSxcDNztdPTdPPBOewk0iT7T+fHoiM3GchYiAd4F3FzMH7NBlAkqnifNK0fogNax53erABXjNuQS4d7udsOikre51s3PQsbwX6V5L0x7Wy+dZ75Q3A96dow/5ps/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAVmJjBI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAVmJjBI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D0B1F000FF;
	Thu,  8 Oct 2026 11:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791457389;
	bh=gNz03hoQuLTPLmODe4X22Nqc2wYePi16QvJhZl3Ebqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eAVmJjBI8cvnQku+ApaPK1GU9jP5riZ4R1FzJs98f59m9C76SLWmBxbPZ6XwBO4mg
	 aozhZJbItKm3nDk7GreN8xj9OmnxWQW/er+sYb1ZgZ+hkO01B+RAaejwnGuQ+iiJmD
	 MruMd5LJhnV2qIrPSyH+1mQY6NyLou6dcAu6meVb1lqudko1eDamV/BhxZXxB8XAWZ
	 BCqzU0PEek2oNz2XW8RAoHcmp67j7eGhvlwyt1ad7Smud3qmEWFmywfBwZWGDPJ62Q
	 DiSC7veZwPhKDu8TLK00WmmuhwxcQoeNewyakyr4RGLHygmE+NIwl9qxx4M4wEk6AP
	 mcERGONh1poUg==
From: SJ Park <sj@kernel.org>
To: Suhaas Joshi <suhaas@s-joshi.in>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/damon/core: Copy only installed probe in damon_split_region_at()
Date: Thu,  8 Oct 2026 04:03:04 -0700
Message-ID: <20261008110304.41485-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261007154851.45368-3-suhaas@s-joshi.in>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Suhaas,


From the next time, please send a patch series as a single thread, with a cover
letter.

On Wed,  7 Oct 2026 21:18:46 +0530 Suhaas Joshi <suhaas@s-joshi.in> wrote:

> In damon_split_region_at(), we copy the entire probe_hits[] and
> last_probe_hits[] arrays of DAMON_MAX_PROBES size. However it is possible
> that the number of probes installed is less than DAMON_MAX_PROBES, in which
> case one or more iterations is/are redundant. To remedy this, iterate over
> only as many times as the number of installed probes. To do so, accept a
> struct damon_ctx pointer in damon_split_region_at(), and update all
> invocations of the function to pass the new argument.
> 
> Also update damon_test_split_at() and damos_test_filter_out() in
> core-kunit.h to supply a context to function paths that call
> damon_split_region_at().
> 
> Signed-off-by: Suhaas Joshi <suhaas@s-joshi.in>
> ---
>  mm/damon/core.c             | 42 +++++++++++++++++---------------
>  mm/damon/tests/core-kunit.h | 48 ++++++++++++++++++++++++++++++-------
>  2 files changed, 63 insertions(+), 27 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index a3af5ee685e1..025df4d19e20 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2049,8 +2049,8 @@ static unsigned long damon_region_sz_limit(struct damon_ctx *ctx)
>  	return sz;
>  }
>  
> -static int damon_split_region_at(struct damon_target *t,
> -				  struct damon_region *r, unsigned long sz_r);
> +static int damon_split_region_at(struct damon_ctx *ctx, struct damon_target *t,
> +				 struct damon_region *r, unsigned long sz_r);

Please wrap lines for 80 columns [1] limit per line.  Same for below.

[...]
> @@ -2494,9 +2494,9 @@ static bool damos_valid_target(struct damon_ctx *c, struct damon_region *r,
>   *
>   * Return: true if the region should be skipped, false otherwise.
>   */
> -static bool damos_skip_charged_region(struct damon_target *t,
> -		struct damon_region *r, struct damos *s,
> -		unsigned long min_region_sz)
> +static bool damos_skip_charged_region(struct damon_ctx *ctx, struct damon_target *t,
> +				      struct damon_region *r, struct damos *s,
> +				      unsigned long min_region_sz)

Please update the comment above to document the new parameter.

[...]
> @@ -3643,10 +3643,12 @@ static void damon_verify_split_region_at(struct damon_region *r,
>   *
>   * Return: 0 on success, negative error code otherwise.
>   */
> -static int damon_split_region_at(struct damon_target *t,
> -				  struct damon_region *r, unsigned long sz_r)
> +static int damon_split_region_at(struct damon_ctx *ctx, struct damon_target *t,
> +				 struct damon_region *r, unsigned long sz_r)

Ditto.

[...]

[1] https://docs.kernel.org/process/coding-style.html#breaking-long-lines-and-strings


Thanks,
SJ
