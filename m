Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325160;
	b=OSMKpCKLRyigE2olNUlC2CyYF41pV7c6QQJLNBMdamkKAEjMQYRr3h+hbJegqWhD0QoV
	 Ihdl6Hq/zWX8zSzeYadltphlEAoWKbbpNVRuFFrRpXdw+SCMlWzGLNg2pOKcecIiUZy9s
	 hF/JDUvBgYR0kFPLBnyYtaxFK3FSTD09wg8f4CVHXBzr/I9loPf/iJBE3JQe7bhpdXtLP
	 Qh2jzOrnbJbZFmgcrGNflicEop5CSI2y9m/Xi9GQXG0ghyurMvytCk/oy8jXj7HQLGl6k
	 rF5JDYrvEGVViePrRy3jKRRWzkGCevGeWsILR5a0erjl+RK+2cqWIAxlrKw/1MpzayA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325160;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fxFIcL8AVsaeZE4IFp9DhoZHiAUFlATqoX61kjAFAEY=;
	b=1Dzo9EcpFER5PTMOFo/kEgwUTFSueR/w0KuZhmQYGxB8iWASNVbiMQjB95AgVHjOI+c9
	 vzQv+aQr9kOaNSFCsVJ18VhfIH+qRH2IzsgeiIOGT5JIUCdX8IFKh8whahVgR1w5mGp31
	 h24+K0jOUP+Ty4SQG0SX5zYJvVrcOim1jc2lCSxDY2+Smr8k1/21KfpjM0iLdN9O+Tod/
	 gx73M03RI6z9QT2VzJeFWdqaTJ+b9QA0OUlw8AXzU2IMASbLNs7asynkMhU6LziWXQYG+
	 ihFVuQ24LOquTKMK5/m2drYSore9xT5+nmiHfdb970G6z/x99+G81wXJRIeU3q2El5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b8RNwxrC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A86606A31C;
	Tue, 10 Nov 2026 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b8RNwxrC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AC11F0089F;
	Tue, 10 Nov 2026 15:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794325159;
	bh=fxFIcL8AVsaeZE4IFp9DhoZHiAUFlATqoX61kjAFAEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b8RNwxrCoval3cj7VaO5A2ekKiYwrG6m4fB1V1beYqHCJFlZdt063QAGd6toVBr83
	 etntU9CFZEUgPMcYVHZYJ3UhlXaIH0XTgMdZnJP+k/BDfMMK/VhvuOaAwCV+zDwBLQ
	 ml2wpf8Zr6aaSjwttXo5aCMFtc6+9ht+prziUkDAvgsllki2tEiwMc0LOrxnsO/Yrx
	 /HczPATqi9To/i5RdnbPeA9DVAEBjTllfSyTjBI01XNDiQrtCIs1Im5iCgvxW/YBVZ
	 dfAhqJfxR9HrEqTQPEq28TlwGujAWv+9D0qI/gethfpu71Tb08V2WRj6J2l/Xg+wa5
	 qJQPkO9w8jPMA==
From: SJ Park <sj@kernel.org>
To: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ahuang12@lenovo.com
Subject: Re: [PATCH 1/1] mm/damon/core: simplify minimum watermark wait time calculation
Date: Tue, 10 Nov 2026 07:39:06 -0800
Message-ID: <20261110153907.158338-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261110085132.1023-1-adrianhuang0701@gmail.com>
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

Hello Adrian,

On Tue, 10 Nov 2026 16:51:32 +0800 "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com> wrote:

> The minimum watermark wait time calculation uses an additional boolean
> variable, init_wait_time, to determine whether min_wait_time has been
> initialized.
> 
> Simplify the logic by using list_is_first() to identify the first
> scheme and initialize min_wait_time accordingly. Subsequent schemes
> update min_wait_time only when their waiting intervals are shorter.
> 
> This removes the unnecessary boolean variable while preserving the
> existing behavior, including the case where no schemes are configured.
> 
> Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
> ---
>  mm/damon/core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index d36823f4d092..93ec684a113c 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3985,14 +3985,12 @@ static int kdamond_wait_activation(struct damon_ctx *ctx)
>  
>  	while (!kdamond_need_stop(ctx)) {
>  		unsigned long min_wait_time = 0;
> -		bool init_wait_time = false;
>  
>  		damon_for_each_scheme(s, ctx) {
>  			wait_time = damos_wmark_wait_us(s);
> -			if (!init_wait_time || wait_time < min_wait_time) {
> -				init_wait_time = true;
> +			if (list_is_first(&s->list, &ctx->schemes) ||
> +			    wait_time < min_wait_time)
>  				min_wait_time = wait_time;
> -			}

I implemented and used list handling wrappers like damon_for_each_scheme(), to
hide implementation details of data structures.  This change exposes some of
such details.  If we agree we have to remove init_wait_time, I'd prefer adding
a sort of damon_first_scheme() like wrapper.

But, init_wait_time really need to be removed?  I cannot show clear benefit of
removing it that justifies adding a new wrapper.  To someone or on some
evironments, init_wait_time might making the code too difficult to read or
inefficient (system having so small amount of memory?), though.  If not, I'd
suggest dropping this.

What do you think, Adrian?


Thanks,
SJ

[...]
