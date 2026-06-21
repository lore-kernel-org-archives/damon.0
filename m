Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4344A237180
	for <damon@lists.linux.dev>; Sun, 21 Jun 2026 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782065407; cv=none; b=V5NK12Q/3im57BMXKufbyRPkQYAc3Kenb2pFkz3HD/TCddPd178k5WaMHRXRW8wruFJ7kHSujbAdSuUgwtZCB1kLIELRM/Kkwff0/DL30Eh1G98QBLPUOuvuQnYAz3V3aGJhW7fQZ3X5X/Jg1BYesncjh2h3Vwmrqwg5K7J9UX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782065407; c=relaxed/simple;
	bh=v0zd61rhulWa12EY8wK8QozHyTZWnoorZZQRYDAGaKI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uyvcNWX8jqSQ/JLhCMQup1N5nWMlcZg5O14P/NZ9Eq57IAZWYF9y80Cu3/Tp6wz/s7sqeOz3W00DPk/EttW4CGfqfoIFRbN217geCIi4EsRnERdZRsws/Srog/815mkUCZqjzeS5RDW5rJODhfPmtKOgtJl9ZEtTBNS1lSvPZeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPhGva2P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPhGva2P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCD11F000E9;
	Sun, 21 Jun 2026 18:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782065406;
	bh=i3VEKxqZzYBk2ti1jNKykailcvVfX6TsbIPwsG9vMxs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fPhGva2Pew4aUPEgmYd3oi0j9eK5rQPWIlTKVWFUfwbXm4g/AxqiAPBXi3sQ5/7BU
	 06+TxFq8drxkG5qNWb5vaJa/oiiS49jtCQR/mh3MHvXrPJ83VXqdtj0nia5iQ5/1IF
	 bk65j6OpFWsYslQmxi916epbzTlC5Qjkz7qidpMYIHyfCup2NT5h9lUY71nHIOmvJp
	 E6p4oZGOZLajddbN8tDXrmQaq1IupnBLO9f6bhkv0B5xYmXmlvk/eHxxoxNpX+6r8U
	 YadrMhsZlc5ZXX/xwqrn7HdLT7mXb1Oh73pnwYdNSImPslq1DsswE+e0GKKCV3Ag2I
	 kabVlIPLxgmfg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 12/17] mm/damon/core: remove nr_accesses_bp
 setups and updates
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260621155715.87932-13-sj@kernel.org>
References: <20260621155715.87932-1-sj@kernel.org>
 <20260621155715.87932-13-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 18:10:05 +0000
Message-Id: <20260621181005.CBCD11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] 32-bit integer overflow in mult_frac() calculation for left_wind=
ow_bp.

Pre-existing issues:
- [High] Region merge operations do not size-weight average the last_nr_acc=
esses field, leading to inaccurate pseudo moving sum calculations.
--

commit f4a10131988cee7930aeb4f2c1a3598bf65f3936
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: remove nr_accesses_bp setups and updates
   =20
This patch removes the nr_accesses_bp field from struct damon_region and its
associated setups and updates. It states that the field is no longer used f=
or
any real purpose and has been replaced by a simpler function.

The commit message mentions the field is replaced by a simpler function,
which is damon_nr_accesses_mvsum().

Looking at damon_nr_accesses_mvsum(), the fraction of the remaining
aggregation window is calculated like this:

mm/damon/core.c:damon_nr_accesses_mvsum() {
    ...
	left_window_bp =3D mult_frac(left_window, 10000, window_len);
    ...
}

[Severity: Medium]
Could this result in a 32-bit integer overflow?

The mult_frac(x, n, d) macro safely computes (x / d) * n + (x % d) * n / d.
Since left_window and window_len are of type unsigned long, on 32-bit
architectures the remainder 'r' and the multiplication 'r * 10000' are
evaluated as 32-bit unsigned integers.

Because userspace can configure an arbitrarily large aggr_interval relative
to sample_interval, window_len can exceed 429,496. If left_window %
window_len is large enough, r * 10000 will overflow 2^32 - 1.

Can this overflow result in an incorrect left_window_bp value, corrupting
the pseudo moving sum access frequency score and misleading DAMON's memory
management decisions on 32-bit systems?

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 94d8ec2965451..be41601163e29 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -3103,7 +3099,6 @@ static void damon_merge_two_regions(struct damon_ta=
rget *t,
> =20
>  	l->nr_accesses =3D (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
>  			(sz_l + sz_r);
> -	l->nr_accesses_bp =3D l->nr_accesses * 10000;

[Severity: High]
This is a pre-existing issue, but its impact is amplified to a regression by
this patchset. When damon_merge_two_regions() merges two adjacent regions,
it correctly calculates the size-weighted average for nr_accesses and age,
but fails to merge last_nr_accesses.

Prior to this series, the access score was represented by nr_accesses_bp,
which was correctly size-weighted during a merge. By replacing
nr_accesses_bp with damon_nr_accesses_mvsum(), DAMON now actively relies on
last_nr_accesses to compute the moving sum score.

Because last_nr_accesses is not size-weighted during a merge, merging a
large hot region with a small cold region will entirely wipe out the hot
region's access history.

Could this omission cause inaccurate moving sum scores, leading to incorrect
and suboptimal DAMOS targeting decisions?

>  	l->age =3D (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
>  	l->ar.end =3D r->ar.end;
>  	/* todo: do this for only installed probes */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621155715.8793=
2-1-sj@kernel.org?part=3D12
