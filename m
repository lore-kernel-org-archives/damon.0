Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B134319DF6A
	for <damon@lists.linux.dev>; Fri, 15 May 2026 00:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778806425; cv=none; b=masLw19oQ+OyJZ25m45T5SAYCubTZ7q6x8x7t0Y8SNzRoi8B/RuxQgRABojbcdZJs7k9cppvZBcXGPgAXXtCVO4qPclDV1T7X/TOAFDR9RtmuJFjO0L91q5et0AOOVg020aqUgv6pRw8sqMyOFjDHNWjTuB641P+mzOh3L/VGxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778806425; c=relaxed/simple;
	bh=hQGt+zWzJ0LA74nsQx5FGd72A6ac0i3CzXwK/3fCXME=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oZPp38vZifNRlsP4gfni79/EMqODioo2O08tMNvWqs3evqtLFx2KpAasGWjs6xVz5bam1Hp2LorrANem9+VFRNgBACTgmbRu+P2d98938cIVF7swpspD1rW+xgJDDOVAw98+Mx/kyPMVMtUJYi/151zQRYopsRc15wZy4vq0iA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/gFnoPY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/gFnoPY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A730C2BCB3;
	Fri, 15 May 2026 00:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778806425;
	bh=hQGt+zWzJ0LA74nsQx5FGd72A6ac0i3CzXwK/3fCXME=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=r/gFnoPYY5HW219sz895Ful03ySdLjr9TjdFqSMZEoxK0Bww1gHuDC7xQthGnqifE
	 RYtFe7FFInDjYT9OwFwh6qH+rI3LDXyrAwHXGz6Utvbb4LcEUXAIohUXomnq2EW1n/
	 fMtP2ydLKh1l1AHHyc/bwZaxPxgsAUU7EOgsWEPOWCRpl5d8ZEab+VnNmM4r3kIG8c
	 HSrzB2OkebSH9X5NIv3EwDqkWhF6ymow0Bl6WqN73dncw/kBLibRxPQyI0un+PnvPJ
	 6D4QRxFEfhz2BgN3w9phbIRoHmchTK2eGMrUyA95M2sQJerHO1oVo3p2fvk/suVI13
	 b4q1+GJSNX3Gw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.2 06/28] mm/damon/core: introduce
 damon_ops->apply_probes
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260515004433.128933-7-sj@kernel.org>
References: <20260515004433.128933-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 00:53:44 +0000
Message-Id: <20260515005345.4A730C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Missing detailed kernel-doc description and execution flow integrat=
ion for the new `apply_probes` callback.
- [Low] Mismatch between the callback name in the commit message and the ac=
tual code.
--

commit 3622281217bcbb69d269a9ab7a22730a743ca395
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: introduce damon_ops->apply_probes

This commit extends the damon_operations structure by adding a new
apply_probes callback. This callback will be used for monitoring data
attributes, applying damon_probe objects to regions, and updating counters.

> Extend damon_operations struct with a new callback, namely apply_probe.

This isn't a bug, but there is a slight mismatch in the callback name here.
The code implements it as apply_probes (plural), while the commit message
calls it apply_probe (singular).

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index bf78ad849a9be..36a1162b6185a 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -621,6 +621,7 @@ enum damon_ops_id {
>   * @update:			Update operations-related data structures.
>   * @prepare_access_checks:	Prepare next access check of target regions.
>   * @check_accesses:		Check the accesses to target regions.
> + * @apply_probes:		Apply probes for each region.
>   * @get_scheme_score:		Get the score of a region for a scheme.
>   * @apply_scheme:		Apply a DAMON-based operation scheme.
>   * @target_valid:		Determine if the target is valid.

Looking at the rest of the kernel-doc for struct damon_operations, there are
usually detailed explanation paragraphs for each callback, as well as a
paragraph describing the overall execution order in the monitoring thread.

Should this patch also include a detailed description paragraph for
apply_probes and update the execution flow documentation to clarify exactly
when this new callback is invoked during the monitoring loop?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515004433.1289=
33-1-sj@kernel.org?part=3D6
