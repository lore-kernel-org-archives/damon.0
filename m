Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE933A961B
	for <damon@lists.linux.dev>; Mon, 23 Mar 2026 19:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774294917; cv=pass; b=oTDE6ZXkZvXoyfPtfGwgjC4ootwOu7m+Z2l+KERfxuXcxoOF8ywAUr4+fS08TFpeg6Uin+eh/Y7/99w2OSqOQ8BwaFVq0myaupadxPBqnQ8KzyFmIH8op/SFpGfCMYaWSh6EojQrxDrgOYvs56fikNn17bRjDHB6EiDvei7t8L4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774294917; c=relaxed/simple;
	bh=K8JhU7lUaBhmEPxP3JMLXEXJ9A7xlBu0wXvdeeBvNL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l76JhTnst0rPDJ1epRD4LW2yVrBWpkYKdlpoaNTvEW01J/pKAQonXlYnI4gSz0gzl/xA79e/atZGyJ9hfsnQCmx6CV1sNI1fvQUXn6LwZCQDL6tFom9btw65sygNw0ot1QAKam9Rmn2/eaujTTPr6DfAiFQfn3Be6UP8r2ilxDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jS6dzXyS; arc=pass smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jS6dzXyS"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-12732e6a123so6715626c88.1
        for <damon@lists.linux.dev>; Mon, 23 Mar 2026 12:41:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774294914; cv=none;
        d=google.com; s=arc-20240605;
        b=Gg0GoKxO+KCTD2dih3stjwPEEJUNgxpwh7x3FK3spQ7oZ5TMHebWv/ean0fqHemySg
         atQHkzi850idq87R6GipUm5klkFPg0KFS8/cY0YHjNHeAsqCL3qCu3OKg5Y+pnadEduV
         bppE3S3Aot3XHDUbH7Bdj/xdFxppWJJj3hdV7g/deO9/SKYAdi9xBeVflLKW9uaThlpI
         CUBLNgS0/PYusytHX0GIYggxMWRsMVW4q8w5NptK44H40WPJBPTK17nMO0YZVD7piiDV
         nODuJRuytVsniHbbgxfGcEK7hJww/lPO4cKMElqlVnm7/W2zi6AbVdgkyWW3bc9HymXl
         xi7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VhD/x6CWko7H2rTbKhY13VQ01meQMOQRBoD9zfMqn1I=;
        fh=g3VMvJQux/HSLIVicncr24svuVPzuNK+KAx5AQfJAks=;
        b=EvnteZSVh8IAfGJWrovjT7+fJY4VeMnzR12snDnLf8XNoFqAbylXCmfkt0EffQ4PrB
         nV+3yeRoJU6kvghkQH5H6mxeX7vUnWKUn0B01aLTabRND58gzaa1bpLMiw1uNAJNAQnT
         iqKtvBkY7r6Q9Ikyw0fTD7Mk44yyHFB0jKOUQeco+yuhBNNc2FzwDdIIguymdvU1PapB
         XMVR4dDKpJJhPoHeoHa6vf6QDn78cRgQGxw0AObm4PLo3BwUo/Uzi/mwmi5FL+j1wPnY
         fyHWDf0t7GlaE8cr83gzbE6nmq6Yt2hBN4Ej3YmiwfLlU+XXV6Rbww/AZqquoE3AShjl
         nh5g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774294914; x=1774899714; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhD/x6CWko7H2rTbKhY13VQ01meQMOQRBoD9zfMqn1I=;
        b=jS6dzXySr6qnpsLq9jrwgOkaoKqpOera6A+DIjsscJJ9RC7XmrlBTpvzgbVuCXz8xv
         95yiuFufSiSAfEf4dNPCSg5kMFc9j/AdAI6HbkQFNak2wqOD126kk04Da8Cy6uaErAae
         bwjAXYlb7fIT/VbmVfQC1QPpCoJoVzDgAsBHLgq2MqcyqNOMQL/1np1ZQxyO0PhF4lY0
         3RqZiGGie4DdJKN/2Wen86T0oV7ardEOyDLYCrOTEmid31NHjo+0h3BIC7hOT7SQjdZj
         vuX4VGiTKRzWhEpMjx9p5+Ut7D3WFlK1G1gvJx6XNmfM5/Jj+fWL6QJwzscjLNwb9b57
         U+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774294914; x=1774899714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VhD/x6CWko7H2rTbKhY13VQ01meQMOQRBoD9zfMqn1I=;
        b=ruzGf4SZKGPlsu4TTM4Ru+JdoUwAUJ+kRF1m/JyVuSiaSrjFkAUgsY2cOOYCMVYgyI
         XS/OdkcE69mt+nr9L5TAvmvF4dU44arn8gj0GfohDr0D4buyrY1I8PofUKdoon6xMKMI
         9T6WDSmsaeCfWTWUaFn11LZf5xzQEDRTlQ9Ap41vyuHcPHLEtsVl8iuK//kz6U9HHC3u
         5+NkHAOfeIgCDWBPXiCKwEmBY+xfFUUphprLYfTOFhRtA64hQTih1gROvfHXWvV9Ymcq
         TsbMuz0GEHUgX/SwqSsWbcNGw71V1cQP9nLfRo99sNVtGewj58+J6a93Guq/NDz48NzF
         FNaw==
X-Gm-Message-State: AOJu0YyxTItSz/ryPNGsemCAezQ/BM825XpOd8LBYuGTX1IvL7KKG8ft
	ZMoq/6lYTMRo4nNVehR3/ERj8z2LWYpdmOR13oKG0Qgun//ATDJ/2pzR7F/+7Nk3ytCbNQc++Rt
	8l3E2etJftFQ21ABwI8v9p4Keww4tsg==
X-Gm-Gg: ATEYQzyathbjpfF6sH97xXQVMPvFemmubHZUgdyvNiSDQbXgZTfJFSSfqYRWy3tOzxM
	nVpJioV6SHujNkx3m0pk648ADHlT4zO6ghAf8rHyZYp6Qk/6kKc90IiEa/rC0dqIBnBhnM67lEM
	Z/I6j4XXFmzNb3kX1fTNQjYa2gwIVHCV0llY/+aAnCbMSqvpPXJ10V2iEN1C0a3Jyfsjwssa2da
	kH4jktXuYmx01LR/+i7Syu/RTeWNXmNvjXSeNoR1BFtOvUcFs34yP7x5fI6gafs8+V8e/cDEe45
	6fUbkHs=
X-Received: by 2002:a05:7022:eac8:b0:128:d39a:b124 with SMTP id
 a92af1059eb24-12a726d95a7mr6584836c88.19.1774294913893; Mon, 23 Mar 2026
 12:41:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260320190453.1430-2-ravis.opensrc@gmail.com> <20260321165425.84273-1-sj@kernel.org>
In-Reply-To: <20260321165425.84273-1-sj@kernel.org>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Mon, 23 Mar 2026 12:41:42 -0700
X-Gm-Features: AaiRm50_X3MTqd7TbETXCV-fpp-iatrBJyNolNtz9qo9eeLJuyZ9kt7eVE9VXlM
Message-ID: <CALa+Y16i0f5D_ZTVcfVa1DgeZL1btvUJxjOvoyFEYNkT7K-grg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/1] mm/damon: add node_eligible_mem_bp and
 node_ineligible_mem_bp goal metrics
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, akpm@linux-foundation.org, corbet@lwn.net, 
	bijan311@gmail.com, ajayjoshi@micron.com, honggyu.kim@sk.com, 
	yunjeong.mun@sk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 9:54=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Fri, 20 Mar 2026 12:04:53 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail=
.com> wrote:
>
> > Add new quota goal metrics for memory tiering that track scheme-eligibl=
e
> > memory distribution across NUMA nodes:
> >
> > - DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP: ratio of eligible memory on a node
> > - DAMOS_QUOTA_NODE_INELIGIBLE_MEM_BP: ratio of eligible memory NOT on
> >   a node
>
> The description for the second metric should be "ratio of ineligible memo=
ry on
> a node".
>

Got it. Will fix the commit message.

> >
> > These complementary metrics enable push-pull migration schemes that
> > maintain a target memory distribution across different NUMA nodes
> > representing different memory tiers, based on access patterns defined
> > by each scheme.
> >
> > The metrics iterate scheme-eligible regions and use damon_get_folio()
> > to determine NUMA node placement of each folio, calculating the ratio
> > of eligible memory on the specified node versus total eligible memory.
> >
> > Suggested-by: SeongJae Park <sj@kernel.org>
> > Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
> > ---
> >  include/linux/damon.h    |   6 ++
> >  mm/damon/core.c          | 158 ++++++++++++++++++++++++++++++++++++---
> >  mm/damon/sysfs-schemes.c |  12 +++
> >  3 files changed, 164 insertions(+), 12 deletions(-)
> >
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index b1d8fd88a0fc..490918804f85 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -193,6 +193,10 @@ enum damos_action {
> >   * @DAMOS_QUOTA_NODE_MEMCG_FREE_BP:  MemFree ratio of a node for a cgr=
oup.
> >   * @DAMOS_QUOTA_ACTIVE_MEM_BP:               Active to total LRU memor=
y ratio.
> >   * @DAMOS_QUOTA_INACTIVE_MEM_BP:     Inactive to total LRU memory rati=
o.
> > + * @DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:        Scheme-eligible memory ra=
tio of a
> > + *                                   node.
> > + * @DAMOS_QUOTA_NODE_INELIGIBLE_MEM_BP:      Scheme-ineligible memory =
ratio of a
> > + *                                   node.
> >   * @NR_DAMOS_QUOTA_GOAL_METRICS:     Number of DAMOS quota goal metric=
s.
> >   *
> >   * Metrics equal to larger than @NR_DAMOS_QUOTA_GOAL_METRICS are unsup=
ported.
> > @@ -206,6 +210,8 @@ enum damos_quota_goal_metric {
> >       DAMOS_QUOTA_NODE_MEMCG_FREE_BP,
> >       DAMOS_QUOTA_ACTIVE_MEM_BP,
> >       DAMOS_QUOTA_INACTIVE_MEM_BP,
> > +     DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
> > +     DAMOS_QUOTA_NODE_INELIGIBLE_MEM_BP,
> >       NR_DAMOS_QUOTA_GOAL_METRICS,
> >  };
> >
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index b9e12865622c..3e0ac65e34a0 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -17,6 +17,8 @@
> >  #include <linux/string.h>
> >  #include <linux/string_choices.h>
> >
> > +#include "ops-common.h"
> > +
>
> I don't find a reason to include this, and I'd like to avoid including th=
at in
> core.c unless it is really necessary.  Could you please remove this?
>

The include was added because the implementation uses damon_get_folio() to
determine NUMA node placement of folios when iterating eligible regions.
Would you prefer that I move the damon_get_folio() declaration to
include/linux/damon.h, or would you suggest a different approach such as
adding an ops callback for the node calculation?

> Below looks all good for RFC level code to move on to the next stage (dro=
pping
> RFC tag). :)
>

Thank you, SJ! Will send v5 with fixes once I hear back on the above.

Best Regards,
Ravi.

>
> Thanks,
> SJ
>
> [...]
