Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6612472AA
	for <damon@lists.linux.dev>; Sat,  1 Aug 2026 19:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785611492; cv=none; b=IHKvXG7oW4NqeC8omHz6jJ56uAjXupaKHl4oUUHNJ4e+e42lemR/J0vUwIm14sepIwtRqEAzBbY1d0jOgdp3RSkzeCVY9j00FKlTyo2rvZ5OU5FBZ/Ek5JFjwpRLfMB1carWcXBxAzkEevRxiJsHP6JlQVPu+ldealMeruWpS9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785611492; c=relaxed/simple;
	bh=9d4loH8mCvf9ex+7Ltnw+l0qZheTOmt9CwXaNc6xoXg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YjtILiirvAlfne5GI82Wu4eBnUiiN8SnX2EA7SyM75Hxbfjb7vQPj1iqnaf2q9s8GgqEylLTViU93Ga6j9UOInGUWDXuIfbnnlvlCP3oDCRd4+joMvIEFSQvI4j2wMf8r07rt+BZemM4NXhAUVGgScNGuQ3Z8J2NkdU6V15ikVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OL70dV56; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OL70dV56"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56091F00AC4;
	Sat,  1 Aug 2026 19:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785611491;
	bh=Xsx7Y087tpdXB840Px4sQP2KIgB4CNZ0YeQAD2wAh8A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OL70dV56J5A9ImQcYoQDgZ/7+sf/kp/SPUl/BNs/Hd+i+B96ItgUfv4Qe6jqmNYgU
	 cNAv01Cvpelb8dx//GNXCDXOkP1MX7Fm9CkVGFTmBiXBZOyp/4DppMg+0eL0qqLM73
	 Hd2lkHx7UB1w4V4OFbcw4XQJYfjxulkFNOp8RKc4wPOHOKEtsoVIJ1M2PtdHuToXux
	 IUNH/B9YUXrnKjIC11LmP6lGfj1wo+6eZHGFOJQh+lUJtOBB1pAaW4MV6Il67HmOe9
	 mBG+4Rllea9HT8f9nMKdxZuvcRrZNSJMDACfj44IdMZlxtKigrvX1PVkSg+SfCke4E
	 zYtXjTRL3jssA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 7/9] mm/damon/core: handle extreme memory state in
 damon_get_node_mem_bp()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260801173554.94710-8-sj@kernel.org>
References: <20260801173554.94710-1-sj@kernel.org>
 <20260801173554.94710-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 19:11:30 +0000
Message-Id: <20260801191130.D56091F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Medium] Falsely reporting 100% memory utilization for an empty node due =
to a flawed division-by-zero fix.

Pre-existing issues:
- [High] Potential integer underflow when evaluating `i.totalram - i.freera=
m` due to lockless vmstat reads.
- [High] The patch fixes a potential divide-by-zero in `damos_get_node_mem_=
bp()`, but fails to apply the same fix to `damos_get_node_memcg_used_bp()`.
- [High] Multiplication overflow in basis-point calculation on 32-bit archi=
tectures.
- [High] Potential divide by zero in `damos_get_in_active_mem_bp()` if the =
system has no active or inactive LRU pages.
--

--- Patch [7]: [RFC PATCH 7/9] mm/damon/core: handle extreme memory state i=
n damon_get_node_mem_bp() ---
commit 0e2bb1b3ade5000769644aa674efbcfec5b43152
Author: SJ Park <sj@kernel.org>
Subject: mm/damon/core: handle extreme memory state in damon_get_node_mem_b=
p()

In an extreme and unlikely situation, si_meminfo_node() might let the caller
show zero total ram. That could cause a divide by zero in
damon_get_node_mem_bp(). Fix it by setting the totalram one byte in the cas=
e.

Link: https://lore.kernel.org/20260328133216.9697-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2816,6 +2816,8 @@ static __kernel_ulong_t damos_get_node_mem_bp(
>  	}
> =20
>  	si_meminfo_node(&i, goal->nid);
> +	if (!i.totalram)
> +		i.totalram =3D 1;
> +	if (goal->metric =3D=3D DAMOS_QUOTA_NODE_MEM_USED_BP)
> +		numerator =3D i.totalram - i.freeram;

[Severity: Medium]
Does setting totalram to 1 artificially inflate the utilization for an empty
node?

If si_meminfo_node() returns 0 for both totalram and freeram, numerator
becomes 1 - 0 =3D 1. This would result in 100 percent used memory (10000 ba=
sis
points), which contradicts the fallback logic that reports 0 percent for an
empty node. Will this trigger DAMOS quota actions erroneously?

[Severity: High]
This is a pre-existing issue, but can this subtraction underflow?

Because si_meminfo_node() computes freeram via lockless zone stats, per-CPU
stat lag can temporarily cause freeram to exceed totalram. If freeram >
totalram, the unsigned long numerator will underflow to a massive value.

If we force totalram to 1 here and freeram is greater than 0, doesn't it
guarantee this underflow will occur?

> +	else	/* DAMOS_QUOTA_NODE_MEM_FREE_BP */

[ ... ]

[Severity: High]
This is a pre-existing issue, but does the same divide-by-zero happen in the
adjacent damos_get_node_memcg_used_bp() function?

mm/damon/core.c:damos_get_node_memcg_used_bp() {
        ...
        si_meminfo_node(&i, goal->nid);
        ...
        return mult_frac(numerator, 10000, i.totalram);
}

Since si_meminfo_node() can return 0 for totalram, wouldn't this also cause
a divide-by-zero here if i.totalram isn't validated?

[Severity: High]
This is a pre-existing issue, but can the basis-point calculation overflow
on 32-bit architectures?

mm/damon/core.c:damos_get_node_mem_bp() {
        ...
        return mult_frac(numerator, 10000, i.totalram);
}

Since mult_frac(numerator, 10000, denom) computes the remainder times 10000,
if the remainder exceeds roughly 429,496, won't this overflow a 32-bit
unsigned long and produce an incorrect result?

[Severity: High]
This is a pre-existing issue, but is there a potential divide-by-zero here
if the system has no active or inactive LRU pages?

mm/damon/core.c:damos_get_in_active_mem_bp() {
        ...
        total =3D active + inactive;
        if (active_ratio)
                return mult_frac(active, 10000, total);
        return mult_frac(inactive, 10000, total);
}

If all memory is mlocked or purely kernel-allocated, both active and
inactive could be 0, making total 0. Will mult_frac() panic when dividing
by total?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801173554.9471=
0-1-sj@kernel.org?part=3D7
