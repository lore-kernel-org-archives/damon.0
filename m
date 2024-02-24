Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413AD1E506
	for <damon@lists.linux.dev>; Sat, 24 Feb 2024 22:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708814034; cv=none; b=t1/fdSUMqkowoTCYoMPg/YnlhfACboBJ1+5Cg7N80D5+e82qs8oWjIS027yTP4qcUmUxC0hBbCFwEUwlJ8U6mMhlDNyO32GJItoBAV5CfslJtaTfk/jKCuBNgDCfQnuOwDH1aMfUIJyLfsEsxVte7h1gAboMzvHSjZpu24aYHPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708814034; c=relaxed/simple;
	bh=5cN6RyEs305wtcE1lbo5oKHKBFN5ZgQUw5ebMX49fcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dpkp4orUAT9Pe9hJaPMnArlhTOtUXeqZcI4pcl1Of/0+DALs2JLOgsXku12i2XpshLe+epV3impY7I3aEOtBihPwzkccjlDXwlt5D/XxydGAncVntjF34DPZdDZBPnVqIfbXjmdQzUCkjXa1a6ewXFXVuOIf8gv6IgKLDdwlW5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6GjUi82; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6GjUi82"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c18190000aso1821864b6e.0
        for <damon@lists.linux.dev>; Sat, 24 Feb 2024 14:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708814032; x=1709418832; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6gPHmRlLFFQMWkc4uxPzbDvlnlcPP+R+SMH5i+OHHA=;
        b=c6GjUi821fOg+jvdAQAwbCgzd9fccK0SMEZaVFUOV93gBh4yNUdAuU+CtqCqLOp6S5
         7Rs3IrMWPYToezhIFZ15ij3kWsakDzNDBjFrSdB3G5ClgnbDnWUDGDf7Xpc6NW9AJDGh
         5JckloINOfqRgv+PPhpN9u8/GR3J1CaXDO6Eb20tJdro/7+0RT/kaxmS1drSWOweA9xN
         fubCu+ndjDgNs4EK1bYnsrScNVZaX1xQWZ5f5xcGi6/crCCuBtAa0xn7CTsErteV9qFK
         YuZvH3A/6wpjzRTp53Te2vx4r8XTtvn8FB0gYTswyhF6BCH+QvXQvaZJxwkSAfQ1Ay61
         QQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708814032; x=1709418832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6gPHmRlLFFQMWkc4uxPzbDvlnlcPP+R+SMH5i+OHHA=;
        b=DH7rp6FN/21uXxulHLSbDq8+4csThvev/8NTeDdyzhX8Nw2cG9isZULVHPkl8+bOSL
         k5bjftah0LQeh7oEZtpEfgGN0Jx4gECEWgx6bWrxZZbGneZsTPdHE9t0qbN4sinv3hNe
         /2YUdmCQrQT47UfZkubH8jw7UmJrkmZ2LLKTz45GgpKyX+dhDR8t1CfnyoEiyzwk7pvA
         O4nprFddhfFFtT6KGHgx1t3ImhDHNMmeZRiSfZs1HPgJ//A2jQdGXvDAFMZpKhZIhzMg
         whFZ97edqrJY54RE4rqkg8GuoV/FmmZC/ZSMvOcuLELAcIhhiok0y4WSxtikKR/a0QcA
         TcOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgB5BEIufXRFwYuLXwonX/9nkbIBoRFOL/lCR6xZsI6Nf4waRMfZCp006e56JWeTj8BO8g/tsc8EKma6ebCAtBawxC08g=
X-Gm-Message-State: AOJu0YyVNzjDDpe+SmVx++eMzTada+Ybf/lwWlQ+gzMprNXiRahaW5Pd
	IWJEIoVsdoR5EtUiHcDhT5KIqHP1U0L6tMOErRDMR1Ln21NOYCvf1sZnJNemY8z7uQCw5qUdXol
	w9wFUEdisuIpUDuF6tCmjkqYE4f8=
X-Google-Smtp-Source: AGHT+IEixbNflSAfDemWTfeO2tzJy5oyppYUIZrtnSDDjXS2qZU3KwpIovwEEi3NVJMYFTxUs4wxrPGKGjadb4aHu9Q=
X-Received: by 2002:a05:6808:238b:b0:3be:a516:6ed5 with SMTP id
 bp11-20020a056808238b00b003bea5166ed5mr3578004oib.57.1708814032281; Sat, 24
 Feb 2024 14:33:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240224215023.5271-1-21cnbao@gmail.com> <20240224220819.49277-1-sj@kernel.org>
In-Reply-To: <20240224220819.49277-1-sj@kernel.org>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 25 Feb 2024 11:33:40 +1300
Message-ID: <CAGsJ_4wAx4fA3oR4=JogZ1HAj6fBFRH2c_KmvwSceuPiUWBYFQ@mail.gmail.com>
Subject: Re: [PATCH] Docs/mm/damon/design: describe the differences for
 pageout's virtual address and physcial address
To: SeongJae Park <sj@kernel.org>
Cc: corbet@lwn.net, linux-mm@kvack.org, akpm@linux-foundation.org, 
	damon@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 11:08=E2=80=AFAM SeongJae Park <sj@kernel.org> wrot=
e:
>
> Hi Barry,
>
> On Sun, 25 Feb 2024 10:50:23 +1300 Barry Song <21cnbao@gmail.com> wrote:
>
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > The doc needs update. As only in the case of virtual address, we are
> > calling madvise() with MADV_PAGEOUT; but in the case of physical
> > address, we are actually calling reclaim_pages() directly. And
> > madvise() with MADV_PAGEOUT is much more aggresive on reclamation
> > compared to reclaim_pages() on paddr.
>
> Thank you for this nice patch :)
>
> >
> > Cc: SeongJae Park <sj@kernel.org>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  Documentation/mm/damon/design.rst | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon=
/design.rst
> > index 8c89d26f0baa..6c50743552f5 100644
> > --- a/Documentation/mm/damon/design.rst
> > +++ b/Documentation/mm/damon/design.rst
> > @@ -315,7 +315,13 @@ that supports each action are as below.
> >     Supported by ``vaddr`` and ``fvaddr`` operations set.
> >   - ``cold``: Call ``madvise()`` for the region with ``MADV_COLD``.
> >     Supported by ``vaddr`` and ``fvaddr`` operations set.
> > - - ``pageout``: Call ``madvise()`` for the region with ``MADV_PAGEOUT`=
`.
> > + - ``pageout``: Call ``madvise()`` for the region with ``MADV_PAGEOUT`=
` if
> > +   the region is using virtual address; otherwise, call ``reclaim_page=
s()``
> > +   for the region if physical address is used.
> > +   ``madvise()``  with ``MADV_PAGEOUT``  is aggressively reclaiming me=
mory
> > +   when pages are not shared by multiple processes. Differently, paddr=
's
> > +   pageout  will do the best-effort reclamation by scanning PTEs to fi=
gure
> > +   out if pages are young, if not, pages are reclaimed.
>
> I think this might be too much details.  Especially, explanation of
> ``MADV_PAGEOUT`` might better to be done on it's document.  We wouldn't w=
ant to
> update two places for future changes to ``MADV_PAGEOUT``.  What do you th=
ink
> about making it simple and independent from the implementation detail?  F=
or
> example,
>
>     - - ``pageout``: Call ``madvise()`` for the region with ``MADV_PAGEOU=
T``.
>     + - ``pageout``: Reclaim the region.

make sense. as someday we might rename reclaim_pages to reclaim_folios or
something else. and we might not use madvise() for vaddr any more, who know=
s:-)
so it is more sensible to remove the details.
I will send v2 to follow your proposal.

>
> Thanks,
> SJ
>
> >     Supported by ``vaddr``, ``fvaddr`` and ``paddr`` operations set.
> >   - ``hugepage``: Call ``madvise()`` for the region with ``MADV_HUGEPAG=
E``.
> >     Supported by ``vaddr`` and ``fvaddr`` operations set.
> > --
> > 2.34.1

Thanks
Barry
