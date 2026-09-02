Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22864A3F0B
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788359049; cv=none; b=Rj0pDZaf7ZVTDjNgdrgG7W/ATGjZq1xiHMscZCv24Tdml0NvSEQ7ocbi9vUn9yA7WB0qzaipUDqzBsUslCdbOhu1bVZpacJY00wPfJVSEpTVFxrPdT19Mg1lAw9X09tglZT2brFupAfeefWr0Kkd1oHizIDzI/2yXfGYHk4OIcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788359049; c=relaxed/simple;
	bh=bAaY0AnrMqOmM/AGd0K9gurzbcmOvGqf7x7E4knhQTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k6QKB4SevmNZoShrg6BxaB8HeKsrTvGRsUA+8S8FNx80+kPJg2rZxedvrFm5XbzmjhKPwEYk3QiJObNlDPkzy5C5HQgBpQk3wEKkGeih13TBKkU+C16ETMF+c0UF7H+ZXOpjBwTgN+d5vRvLj+L76GN6dY+8uH3AfZ9lYvQvzqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESAHmbyH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESAHmbyH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A881F00A3F;
	Wed,  2 Sep 2026 14:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788359047;
	bh=r5NfA9e3KgNv46cb9b8fBcqIzUbKp/g3/lfbNm+nW3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ESAHmbyHEEyudz+YbbTz4rnWZ78mBmFtKKTuZCZS8a76abg7xDBcAvanCYHC+s30e
	 t/jja8iJCfPIis74kLbxXKv76U3qEhyuEdAkB503+VZDfNJQDOuA0JsigHx7BddxWO
	 4sz3M+ruaJTPK11VKLGuq9VmK202ZP/JaYw2NSfuxwhHzaqT/OdY+TpNMTk47fHYuz
	 uMl2M5XrhuHUPAK1Ary+d38FFjCmuo98Q8N7Kz8Isw5O/xmR+rLJTRIkL0DtqVYYhR
	 +txGMHJSWr/xKlTrVoenH+bo89PlmYp0m7GOyNkcTN20rOIMvTYQrJ2leKtskPg65G
	 qK6AfGxeAjS5g==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 4/6] selftests/damon/drgn_dump_damon_status: dump probes
Date: Wed,  2 Sep 2026 07:23:57 -0700
Message-ID: <20260902142400.87740-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902141546.82FED1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 02 Sep 2026 14:15:46 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Missing dictionary mapping for DAMON_FILTER_TYPE_PGIDLE_UNSET causes a KeyError crash when dumping DAMON status.
> --
> 
> commit 331c442077c25bd4d245acf2c04de56eaa44e0db
> Author: SJ Park <sj@kernel.org>
> 
> selftests/damon/drgn_dump_damon_status: dump probes
> 
> This commit extends drgn_dump_damon_status.py to dump damon_ctx->probes. It is
> intended to monitor in-kernel DAMON status changes when the user sets probes
> via sysfs.
> 
> > diff --git a/tools/testing/selftests/damon/drgn_dump_damon_status.py b/tools/testing/selftests/damon/drgn_dump_damon_status.py
> > --- a/tools/testing/selftests/damon/drgn_dump_damon_status.py
> > +++ b/tools/testing/selftests/damon/drgn_dump_damon_status.py
> > @@ -48,6 +48,37 @@ def attrs_to_dict(attrs):
> >          ['max_nr_regions', int],
> >          ])
> >  
> > +def filter_to_dict(damon_filter):
> > +    filter_type_keyword = {
> > +            0: 'anon',
> > +            1: 'memcg',
> > +            }
> > +    dict_ = {
> > +            'type': filter_type_keyword[int(damon_filter.type)],
> 
> [Severity: Medium]
> Will filter_to_dict() crash with a KeyError if a user configures a DAMON probe
> with a filter of type pgidle_unset via sysfs?
> 
> If damon_filter.type is assigned the value 2 (DAMON_FILTER_TYPE_PGIDLE_UNSET),
> the filter_type_keyword dictionary does not have a mapping for it. This could
> cause the Python diagnostic script to crash, preventing the user from
> inspecting the internal DAMON state.

No issue.  This script is being used for in-tree tests, and no in-tree test is
using PGIDLE_UNSET at the moment.  We will extend this when we add such test.

> 
> > +            'matching': bool(damon_filter.matching),
> > +            'allow': bool(damon_filter.allow),
> > +            }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260902140313.85983-1-sj@kernel.org?part=4


Thanks,
SJ
