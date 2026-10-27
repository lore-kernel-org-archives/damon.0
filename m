Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109242;
	b=REJrztXyu2wOVLiuCk3gAxaLaK4LKjkWypRpU8JZ9+t1eH1rYMZ0S1CXHJ1+aOww4sSK
	 hAMTFowHxbd2NeLtxckNUQZUNXF4OsRDJBa3dP4I1bL47n6V7wX8QUXaWDGUc7YM77kfu
	 5aBNvRSwAh5G25tIgnoJBRLt66pjfOmRGNHTXPpY4D/lNGyX+WiGD7sIBbeY+FlC3wYEy
	 YF3Koij2y9HzU7gm559K144WWXzTEPprIn+g7NMXgDfm6IJYyTTeJ8bhaUSZRYQNWgklK
	 iVb82zfkZBO8Sku9BhNEhzGPQNT9i/IBIbHU3u3VzHfjl19BFDfi8Ns2ih2WReiVagQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109242;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=O0HlFL9/QqurHonrWKlExnX7Q+xujC/2o87bXkVMAlo=;
	b=pVEMGP14gtckx2ItN8X2557VzyVrEi1mpKI6rMM8rReUmR2R2FBxgf6RS8iFXyggc2Z/
	 DfsN/tm4VZ5ifrUGnESm82izittsZsadhzvBwzdvUPT3n1V6lDhcutWtnKhX9t7WSyRh+
	 vqtw/zREgsQ9cdWVaLo3L6tb9hmA2i6DH+t83s4TdlifWxRv4WN/WQ6cPJNSbNgakM6CL
	 +a7LS0Mn7KZfKVy4TWAFkhiugJMtVZXxXLdgGuAbQ/we0kIvcwXJDkzaV6ZvZntsnLNwz
	 1VZZRICS3xtLKnngrFDyGwk9USAwsqZlJQLlPqDbOuDT6K7A7j8ykVRuhfO8E65Welw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AMqKHFdb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909A360A2639
	for <damon@lists.linux.dev>; Tue, 27 Oct 2026 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AMqKHFdb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D962F1F031ED;
	Tue, 27 Oct 2026 13:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793109242;
	bh=O0HlFL9/QqurHonrWKlExnX7Q+xujC/2o87bXkVMAlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AMqKHFdbqByiISt7gdsCumYhawhuE9fwriGzjlE0yAjkYNrIZC6K2R0bMvHm3GizW
	 sAr5XUXUJNX8HBY/ybbp/jOIg5RlwlZKFKKpi5901ZDK5p+2Byo8TRKA4yC3LKS2AC
	 NMmzxJr3YefLqAEhLts6DW3A9bvzrJ0UHWcmRm61qYPXoYzyiql1+PgeDYnUE5I3Zi
	 04R5if/6KKbW7kzm4nr3AFj4kE5m+Zt+IJqrCIfYFnWdPEwTGOm4X+SxA9NtAXRumJ
	 6x6AyjgE9ddCd5dqS73hvfvQXHxdXlryLFx1ySNZZO8tgDnkT29Z9RyK9zzdD/muFf
	 3G2B2xqGCKexw==
From: SJ Park <sj@kernel.org>
To: Daemyung Kang <charsyam@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	bijantabatab@micron.com,
	ravis.opensrc@micron.com
Subject: Re: [PATCH] mm/damon/vaddr: preserve migration weights above UINT_MAX
Date: Tue, 27 Oct 2026 06:53:54 -0700
Message-ID: <20261027135354.149948-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261027035431.1007584-1-charsyam@gmail.com>
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

Hello Daemyung,

On Tue, 27 Oct 2026 12:54:31 +0900 Daemyung Kang <charsyam@gmail.com> wrote:

> DAMOS migration accepts an unsigned int weight for each destination,
> but sums the weights into an unsigned int.  If the total wraps to zero,
> no folio is migrated.  Other wrapped totals select the wrong node.

Thank you for finding the issue.

But, is it realistic to have the weight_total overflow?  Have you found the
issue on real usage?  Or, theoretical?

> 
> Sum weights into a u64 once per migration walk.  Keep the existing
> 32-bit divisor path for totals up to UINT_MAX and use a 64-bit remainder
> for larger totals.  Add KUnit coverage for the actual summing path and
> for destination selection at the overflow boundary.

Do we really need to support that user inputs?  Unless we have a very real use
case that require such huge weight values, I'd prefer not.

How about just clearly notify users those are invalid parameters?  We could do
so by adding weight_total overflow check to the central parameters validation
path: damos_commit_dests().

> 
> Fixes: 19c1dc15c859 ("mm/damon/vaddr: use damos->migrate_dests in migrate_{hot,cold}")

Should we Cc: stable?


Thanks,
SJ

[...]
