Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECAF3C4169
	for <damon@lists.linux.dev>; Sun,  6 Sep 2026 21:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788729183; cv=none; b=fitNIv3+kTTO8IBQPaXCxyo40MPXTqou6uAkoEH+rPXQ6kc8lKXudT+m6u7cX0M9xBL8gVLqh4+fhx6dgWTzeNkGDM1Hq2ftXlN4oVnhpf2Ugpn6rTSE8TiTM1oCCUtwq1cgfjbhe61/zkiY2ro3zfzco3Dbe5/eN87xKMAo2kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788729183; c=relaxed/simple;
	bh=fspmHcU48Cln5FHGo9+bQ2MqrAzAA9KZcjpQIwnb3qY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rE7u+Q1qwvbXMPH3wIsAsexWicGGkoXDzEWI9+8SN59XJIU6mSaCNiyOM3pxWqZaX9ygJHg+Gben/8URKFY7oKgVq3RPQqgbrEKzSlpjIK9IjP53q0DSqigl7T9NzAlSyrgTls2M+aY/zS85nPgFcw3TPjMEpBOetDSOHItNbIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcab9fcg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcab9fcg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942AB1F00A3A;
	Sun,  6 Sep 2026 21:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788729181;
	bh=eWef+xDubwCgET3nZAW59JkUyaSMtdyWuhxAKvZ6TBQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bcab9fcgdPMC9epSpPkHWLl1ylX8Xxz1msAuxWnOoLq32qC4dcM4sp3dFYWyB8/ba
	 8ZmUhXX66Xff4sdVOmA9JVu7SYGa5EK/8Ca4r/8oj2o3QLcwZCMnUosaojhKQVotTO
	 RrMZuuNzgYL78K6ZjexcA1Hqw6+pexkDpfzOdNN9kbLWuKXHOB3TmOPun0zoN+7u3n
	 /49e1tRcnd+hCITPOt6QjpqcbwavJekZkbK8y2A8nu50Xlp2osCTN6DxVRLvbPg0f9
	 UBzJUX4jCD0BMnCuj0xJVlMEamtzqM4aTYekqjTYCLCuop9AoqnA9bwgDCgSN53oB4
	 peyWLSjNt5Leg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/6] mm/damon/api: introduce
 DAMOS_FILTER_TYPE_PROBE_HITS_WSUM
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260906210513.106895-2-sj@kernel.org>
References: <20260906210513.106895-1-sj@kernel.org>
 <20260906210513.106895-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 21:13:01 +0000
Message-Id: <20260906211301.942AB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Mismatch between kernel-doc comment and the actual struct field nam=
e for range_max.
--

commit 7d0758e3c3054c52a080a43553753f124a5933b1
Author: SJ Park <sj@kernel.org>

mm/damon/api: introduce DAMOS_FILTER_TYPE_PROBE_HITS_WSUM

Update DAMON kernel API to introduce new DAMOS core filter type,
PROBE_HITS_WSUM. It adds two type-dependent union fields to damos_filter
for describing the filtering target weighted sum range.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 871d26adf6ae5..59d57131d8327 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
[ ... ]
> @@ -434,6 +436,8 @@ enum damos_filter_type {
>   *		&damon_ctx->adaptive_targets if @type is
>   *		DAMOS_FILTER_TYPE_TARGET.
>   * @sz_range:	Size range if @type is DAMOS_FILTER_TYPE_HUGEPAGE_SIZE.
> + * @range_min:	Minimum value of range arguments.
> + * @range_mx:	Maximum value of range arguments.

[Severity: Low]
This isn't a bug, but there appears to be a typo in the kernel-doc comment
compared to the actual struct field. Should this be @range_max instead of
@range_mx to match the struct field defined below?

>   *
>   * Before applying the &damos->action to a memory region, DAMOS checks i=
f each
>   * byte of the region matches to this given condition and avoid applying=
 the
> @@ -450,6 +454,10 @@ struct damos_filter {
>  		struct damon_addr_range addr_range;
>  		int target_idx;
>  		struct damon_size_range sz_range;
> +		struct {
> +			unsigned long range_min;
> +			unsigned long range_max;
> +		};
>  	};
>  /* private: */
>  	/* List head for siblings. */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906210513.1068=
95-1-sj@kernel.org?part=3D1
