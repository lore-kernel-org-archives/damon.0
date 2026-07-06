Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BF73783BE
	for <damon@lists.linux.dev>; Mon,  6 Jul 2026 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349067; cv=none; b=Amm3EEwHqNU+WSyGKGDcxBr8LF5TlCyt2Gkw53duVq2js91XIeZN61WAH9aS0y/Rb882EljKXZLWFh7ZjIM9ToXySm3W1qTpt71R4GlZzHOLJOJG3zlPlh772kIjVE2iz56Sa7LulviOLc9Jk048GLhPqEAgvRxpJK0UVeIjZYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349067; c=relaxed/simple;
	bh=Q5CvUNUbd9Dt5VyyyP57qZlYlUKsOKyWHSAxFuUvP9o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=avfdpLv41zjPODCLnaPFBfUWXgYnQ+bbVHejD40prsA0Xp88OcXtoFtpCVR7Ib1G2Xv+mKthivSTum6onJfJw8OBtg6RFmQkrhTsrja4tN83iWW4vjt+eUHpZWo0Mbd55YpD6N6WqdkpQTc0uQJ/kbgMRb2WvayluOBwsHbqoQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ztq2knpk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ztq2knpk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157E61F000E9;
	Mon,  6 Jul 2026 14:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783349066;
	bh=vMZsXmFt8BAzStu5PmgT6PGKmsX2FDXKIWoiauWWIHE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ztq2knpk2VArdtVugZzOGbj+ILwgmeTdb5wE7E97iRwv3JeKOfM1PEv6KL9CORPl4
	 Ozp7qOK8OKGTMnPkx9AZRwSYebUBMd4hf2SCVF01JLZGb0tYw7KWzHhsK+BTaYGd0e
	 JC8qReeKVa0QGAKmbYzKcMv9cHo7BSxxN2YDuFEnNciWKB3/zxfz0vrcxHn7JFxaUa
	 W1RSIuJveG6mS6J4TewBgWeJos4BEJ82R9lRXwrhb8KId3nWUD03PIesQjQvLL0lFj
	 A0GgV3Y3tQs8sFFauDpEmbbDbg/avHVEv6TgTUhGSS+QGnIGpTVwY+D3tLci5kpLQU
	 dwYmTzAQktVkQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 06/16] mm/damon/paddr: respect return_max_wsum
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260706141912.88445-7-sj@kernel.org>
References: <20260706141912.88445-1-sj@kernel.org>
 <20260706141912.88445-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 14:44:25 +0000
Message-Id: <20260706144426.157E61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `probe_hits` array in `struct damon_region` is of type `unsign=
ed char`, causing silent wrap-around if the number of sampling intervals in=
 an aggregation interval (`aggr_samples`) exceeds 255.
--

commit d141f3812ddd7e9395e9f362f8ddc5918e7ab555
Author: SJ Park <sj@kernel.org>

mm/damon/paddr: respect return_max_wsum

apply_probes() ops implementation in DAMON_PADDR is ignoring
return_max_wsum.  Respect it.

> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 3eba3564a31fc..b85f88a7a38f4 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c

[ ... ]

> @@ -193,9 +193,12 @@ static unsigned int damon_pa_apply_probes(struct dam=
on_ctx *ctx,
>  			}
>  			if (folio)
>  				folio_put(folio);
> +			if (return_max_wsum)
> +				max_wsum =3D max(damon_probe_hits_wsum(r, false,
> +							ctx), max_wsum);
>  		}
>  	}
> -	return 0;
> +	return max_wsum;
>  }

[Severity: High]
This is a pre-existing issue, but I noticed something about the probe_hits
array while reviewing this area. Does this code silently wrap around if the
number of samples in an aggregation interval exceeds 255?

Looking at the damon_region structure in include/linux/damon.h, probe_hits
is defined as an unsigned char array:

include/linux/damon.h:struct damon_region {
    ...
    unsigned char probe_hits[DAMON_MAX_PROBES];
    ...
};

In mm/damon/paddr.c:damon_pa_apply_probes(), this value is incremented on
every sampling interval without bounds checking:

mm/damon/paddr.c:damon_pa_apply_probes() {
    ...
    damon_for_each_probe(p, ctx) {
        if (damon_pa_filter_pass(pa, folio, p))
            r->probe_hits[i]++;
        i++;
    }
    ...
}

If a user configures the sysfs settings such that the aggregation interval
is significantly larger than the sample interval (for example, a 1ms
sample interval and a 1s aggregation interval yields 1000 samples), will
r->probe_hits[i] wrap around and start over from zero?

If so, it appears this might break DAMON region merging and monitoring
statistics by operating on incorrect, wrapped-around numbers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706141912.8844=
5-1-sj@kernel.org?part=3D6
