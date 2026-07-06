Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD132236E0
	for <damon@lists.linux.dev>; Mon,  6 Jul 2026 23:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783381679; cv=none; b=EhIgTqS8RaOgqw+YyrZeWyfpdBoX9xmzzy2Dp30KDeeDgIr7BsSVDogMSrxyV0ryyyeZN3crQaYQqyJK3BxwIwT+Q1+ERdbUTX2UvntOB/5p0IXHtaQewEuayKBkoz6lF9XO+TPowj9RJjy7VhguDtqNyDYEPfrHIG90yKc/DCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783381679; c=relaxed/simple;
	bh=FCsWQ2vwYcjkcANBjNK5i3PoUE2m1Ee32YiejqjHi04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kCaTaNqwQdVuZm2iKoKrCytfv+e3y9l9yslkGQREiAUCtmzH/Go6x1C3XbIciNUvrvnSAVTlh26n2EUBYPEHSP1EFnxaKbIMi3DV205dzFf51RIcw8eaMqjZfLVktr+P61Bvkk/Yqq86IcUj8FEMEMNmigbhz1MVMG0bStOk4wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ny74QBai; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ny74QBai"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345C41F000E9;
	Mon,  6 Jul 2026 23:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783381678;
	bh=fdkGN9AvwKnek/3sfhinYBN1yovoUcZKmaUOMkQp4Zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ny74QBaivEWV6Bj0tWvcMU/y2/3FMwgx+YP2W942FmmhqITFfMZtwbUAFxFpnY/8t
	 mRmNY3euzS+irE8oWui0eykEYjdfmkRRYJ4NdLyFp3Tk6wDMsJ7+XTN7nF7Lh94/yj
	 qADOy/mmhs+JWWgFTjpNYoxfmmAhFbRzaD0/jJchiTk1QK8K0mBtiYIA94V2ededsy
	 nNzlVrQp4byesBR7aNGsHBYyswfiv/0LwdKEzpuVszIgE9s7Rg1iVnBgytwm/iK+L3
	 vADGDlkeEcbYtCNPdsdh8iU+MXHzJcs94gZYq2lv7IUIwRxoXRmOhKMvHiBUZ9HBzU
	 cJW6eDQ2Cdf8w==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 06/16] mm/damon/paddr: respect return_max_wsum
Date: Mon,  6 Jul 2026 16:47:52 -0700
Message-ID: <20260706234754.96945-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706144426.157E61F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 06 Jul 2026 14:44:25 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The `probe_hits` array in `struct damon_region` is of type `unsigned char`, causing silent wrap-around if the number of sampling intervals in an aggregation interval (`aggr_samples`) exceeds 255.
> --
> 
> commit d141f3812ddd7e9395e9f362f8ddc5918e7ab555
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/paddr: respect return_max_wsum
> 
> apply_probes() ops implementation in DAMON_PADDR is ignoring
> return_max_wsum.  Respect it.
> 
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index 3eba3564a31fc..b85f88a7a38f4 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> 
> [ ... ]
> 
> > @@ -193,9 +193,12 @@ static unsigned int damon_pa_apply_probes(struct damon_ctx *ctx,
> >  			}
> >  			if (folio)
> >  				folio_put(folio);
> > +			if (return_max_wsum)
> > +				max_wsum = max(damon_probe_hits_wsum(r, false,
> > +							ctx), max_wsum);
> >  		}
> >  	}
> > -	return 0;
> > +	return max_wsum;
> >  }
> 
> [Severity: High]
> This is a pre-existing issue, but I noticed something about the probe_hits
> array while reviewing this area. Does this code silently wrap around if the
> number of samples in an aggregation interval exceeds 255?
> 
> Looking at the damon_region structure in include/linux/damon.h, probe_hits
> is defined as an unsigned char array:
> 
> include/linux/damon.h:struct damon_region {
>     ...
>     unsigned char probe_hits[DAMON_MAX_PROBES];
>     ...
> };
> 
> In mm/damon/paddr.c:damon_pa_apply_probes(), this value is incremented on
> every sampling interval without bounds checking:
> 
> mm/damon/paddr.c:damon_pa_apply_probes() {
>     ...
>     damon_for_each_probe(p, ctx) {
>         if (damon_pa_filter_pass(pa, folio, p))
>             r->probe_hits[i]++;
>         i++;
>     }
>     ...
> }
> 
> If a user configures the sysfs settings such that the aggregation interval
> is significantly larger than the sample interval (for example, a 1ms
> sample interval and a 1s aggregation interval yields 1000 samples), will
> r->probe_hits[i] wrap around and start over from zero?
> 
> If so, it appears this might break DAMON region merging and monitoring
> statistics by operating on incorrect, wrapped-around numbers.

Known low priority issue.  No blocker.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260706141912.88445-1-sj@kernel.org?part=6


Thanks,
SJ
