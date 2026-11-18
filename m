Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794966400;
	b=BpkRZoOChdB2wQ2nHJdvR1+rUfkAShBwz5lKCyqQ2AheCvUEu6DZINJKU4sB8USFoGqJ
	 /J9CvR4YJsW/Z13mIUmy9jUgmLEgYBqt6j2N3FiCI0e3xhIE70n5pyMGkxo5n6N1SkSs9
	 oghMSodZ3zYnOwc1Yso0u0ajHBCUKVIR7ZpO1jdUe5d8Lx7ubLJJ5lwRwHkuTZfVuPHt+
	 CaeAoYHE2dIto+7fIakVYEDI/UyspnyziUdbprH/iNwxKZS3H4DBIx8/uIs8nkZiWm1uw
	 TWI6KzKH5xIhRvsIU4UZUM+BvMMsqj7TuVFbx9cuw1iPxc+OFj0xGuA9bgggwfrDG5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794966400;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ij7QL2lC6iO/EW2eXzqD3vptmXnm8iDoR9KY7vOdFJY=;
	b=5FEoBDna5XqgJFZN1mVmb3vl7wmSdjha3hR8MCuT4pjV88/q6sSK86tTbndIU/w0euiY
	 YMuTX/YN11MuYqZUULxBhEBMdCKznglJVJKCGCfv1H677qwEeG8q3ZqV6w/zw9jrTM27t
	 ZJidtyPOKtg8MNn0Kw8RVHjso6Q0VWt5tu1YjvYcjw6CqQwyWk+4mQJtYQCPyHcOSsrCL
	 aiRXYd74Z8rjiWPZByTIVluRJcPafttsCIarM9X15jWATeFdyaIZF5uRYy/cJAvoniMbL
	 lokgfEApgEB8XdPqpi4kxCkmqKKLL/KNgwhJd82Xr8+S8maxkocDun3E36v5awBEuIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WxxJ1P99;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8A7606A31C;
	Wed, 18 Nov 2026 01:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WxxJ1P99
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43A61F000C4;
	Wed, 18 Nov 2026 01:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794966400;
	bh=ij7QL2lC6iO/EW2eXzqD3vptmXnm8iDoR9KY7vOdFJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WxxJ1P993x7np9WHlyZJ4QJntFW0aBEG9e0LFkNzS+Ag7AgczfP4SLgMUHol5bhFg
	 R2cX2gN5ZjYSlHwz8zC0Ya8f5gn0BQYbZL/iLJL0YifGiEUXvNSAHKRxxw96TpTDJk
	 /LwfilYnjusNIVO64EIDYbwpSuSILhDF7TsFvA6Ra+3TzLLtJ6NXv0vgrK3hVGj7nt
	 5lkx/wJyGbuHnPgWX2sx2soW4S9SzHWlheKFh9Pkk9XWlaQRIhxlR5kp6ZfJsWa22/
	 nsdaFKst/ck4eF0aGQHwJwCbIF9DhUsvk8GjRncWi6UjecYLqmkCi+y1v1iDgLhP6V
	 Dfg/fDTCjWnDg==
From: SJ Park <sj@kernel.org>
To: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/damon/tests/core-kunit: add test for damon_call() with repeat control
Date: Tue, 17 Nov 2026 17:46:32 -0800
Message-ID: <20261118014632.95656-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261117174834.29182-1-saileshnandanavanam@gmail.com>
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

On Tue, 17 Nov 2026 23:18:34 +0530 Sailesh Nandanavanam <saileshnandanavanam@gmail.com> wrote:

> When call_controls_obsolete is unset and damon_call_control->repeat is
> set, damon_call() should queue the request and return 0 immediately
> without waiting for kdamond to handle it.  Add a kunit test for that.

Apparently this patch was meant to be sent as a part of a series with another
patch [1] but individually sent by a setup failure.  As a result, this patch is
not reviewed by Sashiko.  Could you please repost as the series?

> 
> Signed-off-by: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
> ---
>  mm/damon/tests/core-kunit.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 13315291f69f..bc93677487b5 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -2499,6 +2499,30 @@ static void damon_test_call_controls_obsolete(struct kunit *test)
>  	damon_destroy_ctx(ctx);
>  }
>  
> +static void damon_test_call_repeat(struct kunit *test)
> +{
> +	struct damon_ctx *ctx;
> +	struct damon_call_control control = {};
> +	int ret;
> +
> +	ctx = damon_new_ctx();
> +
> +	if (!ctx)
> +		kunit_skip(test, "ctx alloc fail");
> +
> +	ctx->call_controls_obsolete = false;
> +	control.repeat = true;
> +
> +	ret = damon_call(ctx, &control);
> +
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +	KUNIT_EXPECT_FALSE(test, list_empty(&ctx->call_controls));
> +	KUNIT_EXPECT_PTR_EQ(test, ctx->call_controls.next, &control.list);

I think the above last two expects are somewhat too much implementation detail.
I don't think we are promising those list status.  I'd prefer dropping those.

> +
> +	list_del(&control.list);

Can anything leak or corrupted if we don't call list_del() here?

> +	damon_destroy_ctx(ctx);
> +}
> +
>  static struct kunit_case damon_test_cases[] = {
>  	KUNIT_CASE(damon_test_target),
>  	KUNIT_CASE(damon_test_regions),
> @@ -2544,6 +2568,7 @@ static struct kunit_case damon_test_cases[] = {
>  	KUNIT_CASE(damos_test_esz_goal_temporal),
>  	KUNIT_CASE(damon_test_last_region_quota_reset),
>  	KUNIT_CASE(damon_test_call_controls_obsolete),
> +	KUNIT_CASE(damon_test_call_repeat),

Could we merge the above two tests into one, say, damon_test_call()?

[1] https://lore.kernel.org/20261117172219.26725-1-saileshnandanavanam@gmail.com


Thanks,
SJ

[...]
