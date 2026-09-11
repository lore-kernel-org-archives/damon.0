Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624493DEFFA
	for <damon@lists.linux.dev>; Fri, 11 Sep 2026 15:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140753; cv=pass; b=P9zVo7ehW9vAyGXyRgqd7X3N5HRQKf3t5Iwy95i/U1OkTkTbynU7wsVqJNahxxYJyqvq4If6NGjVZ0E548ffVI+iCJclQeTQh3J1lfl7I2SEOn/6Nis4aAMQmBkkVtDXFSk5QRuoFfpseUI8dbHDG6yCZddm0tV7g39Uk5BgxaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140753; c=relaxed/simple;
	bh=YJKEvxdzim7aG0+3oO1LTxbSduJEi7uM2fNJ7/lxwYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QeCVw62UAitLzdwPNeL/fKj66Yv3oECsUf4coa4e/ptgkLmZs5v2LZ3O3osnmKsRBU4boF6AxNx8hR72j89doSzuCz8Mf5vo9Y3biClzV82JNWgLgRJ3mAfZShqS7ScOJioErAqMseSNiZ0HIuTz9uFiXqAm7C7CpQDHIvTFm0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLgprOD0; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLgprOD0"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ce364488dso155335e9.0
        for <damon@lists.linux.dev>; Fri, 11 Sep 2026 08:32:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789140749; cv=none;
        d=google.com; s=arc-20260327;
        b=YCEtyJmiPmDo4sQQC0eUhz8IOf4VlzFQCKXN8Zo1uhhlhE4HwWAac1/bHiuC3CrjgD
         zcTk+vBwQiylD331IwLVT9JV2pwQPas40sILkrg90do1jM5Xflo3NqqxJ8mCQz7C0mmh
         +VZz5NuXvqo/4C0uvJj5kbVxhT2vUP4QkiR/V0oIVObWzt7PJ+B40stXXc+4Cykz7BKP
         WXt8vYvdhtk+732cwMbnH7V+FzHYjVOIzWTseDfWtcbuepHCYw6oPVlquUJ73FuTVngr
         nVOaMQs7oxZzlXN+7KC75cmtnHf5z7d/YOWHPPCeflLCPYTY7lb1NvLGwejMHJi4Zosa
         +lmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tx5AyXZ3GvBAYCgk4osxeglSu6XXu49YTcUaOVz/aoc=;
        fh=5ABSJ25SrwQ67uWbyfi8EZrxT/PQwyMT6udGX/2WSaQ=;
        b=U3hHwwVqy/yjTK7oC8nC8X1JpzxEM2dfiOkzIszkYvLhli1yqeCLdcyzvSWOQhtbvN
         7nwmXvj9Nayj9AYAz7iLO2ZVoKr6VWzhVCBopHq8eQ/NV1i4KA5TFb1SEqZN/0Idg4a3
         T8w5wEGa3QFjMYceaSFmV6OO7E/nUpVupDjw4BHkEyKUidNk/8AOKy0wmzwZaVlthOJS
         QV5CgFcGpeYFTdy1sM09VGwYXNPR/TZK9RII+Q/8E60ybl0zfizfFeFwjko5g7WP7qis
         5yr2vk9Hv1JhUdwyg2BaitcEdM1nNfHdKp8+5C5WPcJO35fXYncORz5XUThlbLcSmvGq
         sORQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789140749; x=1789745549; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tx5AyXZ3GvBAYCgk4osxeglSu6XXu49YTcUaOVz/aoc=;
        b=gLgprOD0/NKErQhRw+lZincYM+1Ocjd+LWwDreySaYEukxrmIyKA33EKTF6MfJpuyQ
         DxFR62nw0n8+8OtaH9nyQmpZgB1pDcN7H+hC0ZQCQ8ax9U1bSAhapUcxFpyJzA/+GbSA
         dv3XPQYsSnDWybjG5wxiwjCuYBvwuWtmXyotks3USOST87X6AtTPpjvzUxBmG0XXRc5O
         Sd9Exb82bgVvLU5HlxX8HGRQAvfuTCDlRXnAK45C391W9FLn4WA849GnFwEebD+RaB9E
         2SmkL/KPYJhp6NFnr5BovFFLItK0w3gkMeZxBbe4syiSs/FG13PW8lTFsSkr/vfk7VT+
         jsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789140749; x=1789745549;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tx5AyXZ3GvBAYCgk4osxeglSu6XXu49YTcUaOVz/aoc=;
        b=pL4QXegygvCIk3vuw54N3z2ikAfjPUlLaStGFH02bQcg7Hh2n5I6qEge5VhMTXD+PJ
         J+THq1my7kqz9etLxUXz5jprdpW/Pmop8ONj3J5R7TOboN+QeuTf4zIDTxf37fJYSRog
         Vwy87m5gKDlwcmYpogdJtAqZZ1mbac4OfgUOZA/YoEM8WIN+LYGPK4MMyuXFOyNFMLEx
         uF7hIuXUfGXpGYmY8cN7Oe4ZTuRJTqU13XEYF7+g0PXD6M95naDh8Z+FHfIOTeURZGBv
         BFbNnxROhXBaRgUju6UWaEckL3Wwf3BBebiLikUB/P2dBgRCvKJCkKMzs9O3usoi1HzI
         pUDQ==
X-Forwarded-Encrypted: i=1; AKwUvBytrFCRcC2M5bDfRg+9koN4T37Zvubv99pWOjMt4jRbav9Z5NtEgWLy8Lh4IswlIOUNvlmKKw==@lists.linux.dev
X-Gm-Message-State: AFuF++mrwEUaSQVK05fcJWH7RuocfMirc5e/HsHtY10N6tb+8+z/iuhW
	3wSsuAMUT/G5ck5eMVAk44/V3ZKkOpLU7862F6aqZG8IorpicyDYJc4QS0jpoojyMVMmVQaXzgI
	xYn0THovRhiGEwEs9xMSyInK3qse+QfM=
X-Gm-Gg: AYBFou18atVM2b91Bp2Q4iqtWvXg0oZcAuv9lOIXs+cb5NMnwE+7ifAuxwK0Q5t9gtg
	KmWf9+rDXuRqdAW1KDByo0joJ6s/QBtLqz00Vt4qX+ea39K5iwEf2TrGGu3zNmybHPThd1w8ucM
	smo9vRtSa+EnrzY2LkLJONjWaGhSQ/KvZZMQPky2QAW9VwyQLS4ADxy18pgXBvytU4lneC/T7pO
	mxWYkD60GrU3xyO5wrhfpwrlpuAiz2UY+frBdiFdPV6lzaQd08sPxY/TH045+94jxywxzc3uFPH
	JjLj+uHLmjM9t98VnyFfMlFlzdWQNGXmv822wj8ojlCfNJCvLSvhOuhRsVyr/a4+L8vpL3WnDvK
	xOwpwBdGyoAfs
X-Received: by 2002:a05:600c:3f08:b0:49c:f13e:e50 with SMTP id
 5b1f17b1804b1-49e6108c75dmr59294085e9.13.1789140748568; Fri, 11 Sep 2026
 08:32:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260911100427.2804601-1-kunwu.chan@gmail.com> <20260911133232.91581-1-sj@kernel.org>
In-Reply-To: <20260911133232.91581-1-sj@kernel.org>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 11 Sep 2026 23:32:12 +0800
X-Gm-Features: AcwNN1UB2lLvhFoOalBtTq0xTCkHEalZbjYl1gPmEXSR-cXhuK4bJrIAZhw-nSE
Message-ID: <CAN_Opa95ePWNT6o2axVtvKNjC-1aNU09f_XMnUjcJFZAbYeUZA@mail.gmail.com>
Subject: Re: [PATCH REPOST 5/5] mm/damon/vaddr: support pgidle_unset probe
 filter type
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 9:32=E2=80=AFPM SJ Park <sj@kernel.org> wrote:
>
> Hi Kunwu,
>
> On Fri, 11 Sep 2026 18:04:26 +0800 Kunwu Chan <kunwu.chan@gmail.com> wrot=
e:
>
> > On Wed,  9 Sep 2026 07:04:07 -0700 SJ Park <sj@kernel.org> wrote:
> >
> > > DAMON virtual address space operation set (vaddr) does not support
> > > pgidle_unset probe filter type.  Add the support.
> > >
> > > Signed-off-by: SJ Park <sj@kernel.org>
> > > ---
> > >  mm/damon/vaddr.c | 55 ++++++++++++++++++++++++++++++++++++++++++----=
--
> > >  1 file changed, 48 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > > index 45239f05e113b..9a38dc89a156e 100644
> > > --- a/mm/damon/vaddr.c
> > > +++ b/mm/damon/vaddr.c
> > > @@ -522,13 +522,49 @@ static void damon_va_prep_probes(struct damon_c=
tx *ctx, bool set_samples)
> > >     }
> > >  }
> > >
> > > -static bool damon_va_filter_pass(struct folio *folio, struct damon_p=
robe *p)
> > > +static bool damon_va_young_addr(struct folio *folio, pte_t *pte, pmd=
_t *pmd,
> > > +           struct mm_struct *mm, unsigned long addr)
> > > +{
> > > +   bool young =3D false;
> > > +
> > > +   if (pte)
> > > +           young =3D pte_young(*pte);
> > > +   else if (pmd)
> > > +           young =3D pmd_young(*pmd);
> >
> > Hi SJ,
> > I see that all callers already check pte_present() / pmd_present()
> > before calling this helper, so I don't see a correctness issue here.
> >
> > However, the other DAMON young/accessed helpers, such as
> > damon_pte_young(), damon_hugetlb_young(), and the PMD path in
> > damon_folio_young_one(), keep the present check together with the
> > young check.
> >
> > Would it make sense to keep the same check here for consistency?
>
> In my humble opinion, it is already consistent as long as we didn't miss
> present check in callers.  If you concern a case that we call
> damon_va_young_addr() without present check in future, how about adding a
> comment noting that on damon_va_young_addr() as a followup work?
>

Thanks, SJ. That makes sense to me.

The current callers do provide the required =E2=80=98present=E2=80=99 check=
, so I agree
that documenting the assumption in a follow-up comment should be
sufficient.

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu

> Also, thank you for your reviews to this series!
>
>
> Thanks,
> SJ
>
> [...]
