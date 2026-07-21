Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7DA171AF;
	Tue, 21 Jul 2026 01:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784597291; cv=none; b=jE0sSfzJaU2ZuTj6iABXZWRHx8da16gyJpPNEfcQe2ybsH2mIvJFPPcaL+z6Xq+CB5oRO7uvi6XZhK4VqyG9ELMl9Lq2JY9OVuRF5dLq3J5qcumm6xXtoRYDXbDBcY1V1xmoZSB0eMdBR6l6G62LQcKr9IYHQpIvcqM2FbuE2f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784597291; c=relaxed/simple;
	bh=vPdS2Z22EDkZ2eFP+iiA06m5ZQVYAZ7kGe/vz1p8Iko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TkdTjCU3T2QnLiQPAyIpoR82XWzccIf/3O4Jo7bWJmZ5zNETZE2CI7RWNUWeKR6YnqDS461vPpOKTDFVf5aaGm0CPK6SQAgb8WuIWX28+CZPTtHSsDmXfHzhVybj+lward4hbriiEc+X+4PKTHRq2m94y22xal/2/ApHHqv1PHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2uy+ueV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2uy+ueV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790F11F000E9;
	Tue, 21 Jul 2026 01:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784597289;
	bh=Ucliq96+aNI+vu1/RJUCbYuu0aOGb4J93fyO7SHloJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W2uy+ueVatRrqnXjFjpB7iTcWu41nwoyeH9AYoQojxN+yCSUCEL0ohoJP3L/+rM7Q
	 rJ8JwQwvWyLttL24bfjSxJSqbI1oJfHkZCmm8sFtykJ1iGDW1T5e0iHYB6SdnBgkS4
	 rJnN6snNiAEdr57Ozf1VNcitiBaOLSHmKTpXmFenZxjUznZRqG0tlrnptbvb7apJdJ
	 v1lA/w5SV2WMhP3PxfvpAU5KsVyBJRtgvEZicX4sdoYXAcd+dZgb8ecCmdhDUxVvr7
	 15uHQxSRxmU0tKvBolnM7bCoWzufyxXxRqoOlm+SAkm4W/4v8hIQgKgBIxDhhw/Uqc
	 vz8au05MMIB7A==
From: SJ Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	enze.li@gmx.com
Subject: Re: [PATCH v2] samples/damon/mtier: use damon_addr_range consistently
Date: Mon, 20 Jul 2026 18:28:00 -0700
Message-ID: <20260721012801.94223-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260720130642.508355-1-lienze@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Enze,

On Mon, 20 Jul 2026 21:06:42 +0800 Enze Li <lienze@kylinos.cn> wrote:

> The DAMON provides struct damon_addr_range for unified address range
> management.  However, the mtier sample still defines a local struct
> region_range and mixes its usage with struct damon_addr_range in
> damon_sample_mtier_build_ctx().

damon_addr_range is for DAMON core layer address system that uses 'unsigned
long' as the address type.  Because 'mtier' is dealing directly with physical
address, we use a dedicated struct for that purpose.  On 32bit systems having
more than 4 GiB memory, this may be necessary.

'mtier' doesn't really take care of the >4GiB 32bit system since it is simply
casting the 'phys_addr_t' addresses into 'unsigned long' addresses.  But it
might support it better in future, using the addr_unit parameter.

> 
> This patch removes the local struct region_range and changes the
> parameter type of nid_to_phys() to struct damon_addr_range.  It also
> gets rid of the now-redundant local variable and pass the address range
> directly to damon_set_regions().

So, I don't think this change is required as-is.  I don't really want to add
addr_unit support for >4GiB 32bit system, either, unless it turns out to be
really needed.  I'd like to keep sample modules as simple as possible.  If the
code was confusing you because it is anyway casting the types, adding a comment
explaining the rationale might be a better change, in my opinion.


Thanks,
SJ

[...]
