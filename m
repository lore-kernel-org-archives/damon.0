Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523BB32937A
	for <damon@lists.linux.dev>; Sun, 27 Sep 2026 07:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790494632; cv=none; b=htqBC5iQRHdYFzn6dfpn5j3adnvTRvBeF7KpVJBPvYlFzV3dBr+kL5MuOdaU9kyxrP3qdNQCYt6k13EyUUxpgsgaSQZNK/DoBMQlQLsVtv0V6gLWaa53tEX8Op7dCKCAScHn/uPftLK7P5704SBvToyVCD6uwpR15oXrO4PYrlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790494632; c=relaxed/simple;
	bh=Yttc/ZGaEiDLmaWoDak1SR9quCjOcfm0bUFAxarqEJM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EBn+/4VZm9F8qpq91VQRADjAUTthzweuAay7U1l5H7a1rvlLHKq+tYJJCxFj3ZTq2tjfOaNlOmmGgw0GvBlqIVnX4ZVpsZtmkYJ9EgjQPIOFFNAozW2mqezdsoQuEZmIrOpFyOUfKPTEn6JAIDWxJVDeCnbcyqUX+q/W9yhWjuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4UpFk2u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4UpFk2u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928031F00893;
	Sun, 27 Sep 2026 07:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790494630;
	bh=ba8kj5asYvqggc+lEB+ZUpeFYeJcMs89ZXCvKUriYK0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L4UpFk2uzoPT3nK4c5Xmc63bm3SuYjjM7qpPi0VinTGj/UxSStuva6GVvn9IbN4IH
	 NI5mVUL24geoAiuWLC6ig3BRN0cFPKJDmlze9L+EAdfKf5oUUNEcKmSyhZJ9ZksJwj
	 ZvRm/CmmXLGysFDb4+Oq8nLmHtXBtGFetOlAOPJDiFgPbLokL6DQIv5aD1YtrypJqB
	 ty6XhiUYDtRU99C2srn38BwPPmUwtaoudMjIwV8i0Zt4qCwdSKRRwdfgv3H4lrETy1
	 PP4E0fmzwdGX9JOuKzFsINLkA/sPTHZvAL2OaUh6ncnPcKtWXmFjvXw4ZI7mkEhB1K
	 yOf22niijy2jQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/4] samples/damon: add Rust sample for DAMON
 access-aware proactive reclamation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Enze Li" <lienze@kylinos.cn>
Cc: ojeda@kernel.org, damon@lists.linux.dev, gary@garyguo.net
In-Reply-To: <20260927072812.2393456-4-lienze@kylinos.cn>
References: <20260927072812.2393456-1-lienze@kylinos.cn>
 <20260927072812.2393456-4-lienze@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 07:37:10 +0000
Message-Id: <20260927073710.928031F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] damon/rust_prcl: concurrent writes to 'enabled' debugfs file leak =
threads
- [Low] damon/rust_prcl: custom boolean parsing rejects standard kernel boo=
l strings
--

commit 195de0b55eeb64d2bfdbc4cb35a867a97366c03f
Author: Enze Li <lienze@kylinos.cn>

samples/damon: add Rust sample for DAMON access-aware proactive reclamation

This commit adds a Rust implementation of the DAMON-based proactive
reclamation sample module. It allows monitoring a target process's virtual
address space and proactively reclaiming cold memory via debugfs endpoints.

> diff --git a/samples/damon/rust_prcl.rs b/samples/damon/rust_prcl.rs
> new file mode 100644
> index 0000000000000..1e6c820311e23
> --- /dev/null
> +++ b/samples/damon/rust_prcl.rs
[ ... ]
> +fn damon_sample_rust_prcl_start(target_pid: i32) -> Result {
> +    let ctx =3D damon::DamonCtx::damon_new_ctx()?;
[ ... ]
> +    let ret =3D ctx.damon_start();
> +    match ret {
> +        Ok(_) =3D> {
> +            CTX.store(ctx.into_raw(), Relaxed);
> +        }

[Severity: High]
Can this leak the original damon_ctx and its running thread if
damon_sample_rust_prcl_start() is called concurrently?

Concurrent callers to start() will overwrite the global CTX pointer here,
causing the first context to be permanently leaked along with its thread.

> +        Err(e) =3D> {
> +            pr_err!("damon_start failed, error: {:?}\n", e);
> +            return Err(e);
> +        }
> +    }
> +    Ok(())
> +}
> +
> +fn damon_sample_rust_prcl_stop() {
> +    pr_info!("stop\n");
> +    let raw =3D CTX.xchg(null_mut(), Relaxed);

[Severity: High]
If stop() is called in a race with start(), could it read null_mut() here
before start() has recorded the context?

A rapid start/stop sequence could result in stop() incorrectly finding a
null pointer and failing to terminate the newly-starting thread.

[ ... ]
> +fn damon_sample_rust_parse_bool(s: &str) -> Result<bool> {
> +    let s =3D s.trim();
> +    if s.eq_ignore_ascii_case("y") {
> +        Ok(true)
> +    } else if s.eq_ignore_ascii_case("n") {
> +        Ok(false)
> +    } else {
> +        Err(EINVAL)
> +    }
> +}

[Severity: Low]
Does this custom parsing reject standard boolean representations that the
kernel conventionally accepts?

This function only accepts 'y', 'Y', 'n', and 'N'. Standard kernel boolean
parsing typically supports inputs like '1', '0', 'on', and 'off' via
mechanisms similar to kstrtobool(). This might provide a confusing example
for future Rust modules.

[ ... ]
> +fn enabled_write(data: &ModuleData, reader: &mut UserSliceReader) -> Res=
ult {
[ ... ]
> +    let enabled =3D damon_sample_rust_parse_bool(s)?;
> +
> +    let is_enabled =3D data.enabled.load(Relaxed);
> +    if enabled =3D=3D is_enabled {
> +        return Ok(());
> +    }
> +
> +    if !damon::damon_initialized() {
> +        return Ok(());
> +    }
> +
> +    data.enabled.store(enabled, Relaxed);

[Severity: High]
Does this lockless read-and-update of the boolean flag allow multiple
concurrent writers to trigger complex state changes simultaneously?

Because the read-and-check of data.enabled lacks locking, a TOCTOU race
exists. Two processes writing 'y' concurrently will both bypass the
check and call damon_sample_rust_prcl_start(), which triggers the thread
and context leaks mentioned earlier.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927072812.2393=
456-1-lienze@kylinos.cn?part=3D3
