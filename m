Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF5C3EA951
	for <damon@lists.linux.dev>; Tue,  9 Jun 2026 08:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992705; cv=pass; b=VR5/1+qA1aY4POCP6c2H3nqJzrwebWNQPqJJn8StW4YGAJCOXtTHdL2qRyrrKpVfqNOc3lpZiMxC4cP1WbYw3sxCP3Yc6TdSMn7jioQHqNAFekaCVN9BlGYyOADaahiWAmeuGYsGoM5iJk0tz8E0kwPDrFmEjupRuoQVBo6X9EI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992705; c=relaxed/simple;
	bh=+f25u6xmkKCLRHSUbmb93c62xTKsVOaMCDh/yapAjVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kfh3jJ6BVa2PO2/2A3hbNYf4KhEBLBtw+zHeN6i+ETTtiHgrlAfBhPDffwOMXiLIa89HPdAKHP9pIx6LZX47hXZ4H9zMpgnT9XXchfaJ0SaR55OZ0D8hwg8+107HLbo9s8bIrU6ySxjp7LDNbFdfR36TZeoGqvuLFRVjXsGLBwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mq4u47N5; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mq4u47N5"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b211ee6aso40411575e9.3
        for <damon@lists.linux.dev>; Tue, 09 Jun 2026 01:11:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780992702; cv=none;
        d=google.com; s=arc-20240605;
        b=ZuuyUU8P6cOxMLuB+iOS42nBpOVcdzoD/90hpf8rBYyizWEisbqWrLrJD+ejrKjP7A
         NqEFib7JufJtDhm42Yq82TV12qbCg3mD8zCiUl4uP8m9V1AwcMiFaZeN6EavVCuwnCek
         yzAHWdkcUixLPcntZHYnXw8/nzJ/P/3yE7IfRhQxt4G3/l1T7DEfA7g1PrHAROj29hGP
         eNX9P4uKO5YL0o1dmiD4hbFVRGpn1Ya/NhQKJJ6Et4Jm+4rbVj4VKS4m27LYWOT7jHtJ
         hbFBgLvoALZDHSBPa9TTTxoZF1i3GUAP3LrHR9ealqOZaVWp1WlP3ifgOeRMLY4ItJX5
         fSjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8QsY1n5N4iqtdC4BlDMhKaWRGC0gk3S4nMtz5szdAAI=;
        fh=eRrEMjd+JHNyqQeSoowzqMq3sgXlRtb4kA1A8sXzvD8=;
        b=ZPuvBUm0cCbov9hUuoerzRNs00pjal8cNfTrpBeP1dWgjXCG5NZZ5qqgAb7Laj96zZ
         ca+S9WBbN4NuUh1XOPTxOLkqxnXSzRwLaOOEJj8/ep5fVo0mG6urFJEE1ry9Ajcv9HOE
         bOHj0XV0HUlG0CNzJnJWI1k2Dvm505XISEfS+TpVsDP2H4GYEFhZzbCIiGrMzNkfmAic
         FreokOdSMN8iPQ/woAcFO6CVGtlPmNeIbbd05uetSCn5aTy545OKccelQRaj61tFQXDV
         IbCJ/d8pPKRRHHd/KOv6pQIXGTj0XzpmFojQmvsjTz2T3oZw35qbud+U7YS+alA1TLKq
         HLEw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780992702; x=1781597502; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QsY1n5N4iqtdC4BlDMhKaWRGC0gk3S4nMtz5szdAAI=;
        b=mq4u47N56RsI8bU3pPdQatKNgWUJCL94hgpluZ8xhzBsG+mhtqdEzXi5KbJpiTFpbn
         QEbhyt+vWHsoi2eDVmBkxi9iC2heBaCHytvUWyjCVlYqM2hLxOesaGk2sUdlnNJJ6fGZ
         PjD2HnDXgaPwJiK0HaxDH6kPeum6Kpt4sPzm0rVVAuHKMzoGZeuAetpJlzn0Gt1lGtqq
         sRkWMcq2dPzt2j2F5P2OBPTa/vuNrfam4bfMjw4FEVVwTj6uXM5ALlHYwaK32aGQsiC2
         306Wjw7k9PgyG5xQ1pJTZUWNRgmkDPc+8xzTkLEJXCcl2u+gDqu8MZswVhQVDkmjlfsy
         EyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780992702; x=1781597502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8QsY1n5N4iqtdC4BlDMhKaWRGC0gk3S4nMtz5szdAAI=;
        b=Epj/hXb6hc1o/9+NKIsALE+WRhkGK9bM4sdzc/I3fu32Q15pG+2uRyzFL2ZYOF4QaD
         OIVf4rVpVEt8cFcIHASVBV2a/zYk2j5pGRoH/e6PIap2uEZITaGGalxXysYrW2R62Q57
         7s6udaYHdJOwIVghIVCD6fedmztLXqsnNkve4aKKw51BA1BWzgwumH/jIgWjIF13HNTm
         tNoNAuOXKZO6LCCPDBUGXl+YUz65klt5DzXPFTwFbZ91nInP0ADPXIaXmmvJj3mQmnu3
         uKR1I0EHH5jMQt82+7YkWJWAmxDICnm6ZUg5/AxuQYzy7mONRyz02gJG2CC1T3fYnT84
         1Yzg==
X-Forwarded-Encrypted: i=1; AFNElJ93kCkzbZ3b4eaGMbFpI85KWRK95gR+3oMuruUHdNelZooHVJnzos9bQ5/Sh5SItk+5l0byjw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+1FckOd4nSAH7jCEGRWFW0R5s5MZakFiYrNyQ/GIA6EmBXhQB
	tV5OlFlrpgQSs3Tsme/zHZ4NoJkes3uqqZIGFcjIJQwahKeKUq1TI3RAeJlDzL0tYO/ezYLyCMn
	03QZuhRnuZk4LewsDyNnP0ko/Rt8YgYw=
X-Gm-Gg: Acq92OH5LwnO7osLMAxHKSb2wNrG7mDpqFEgwm4vYCWMiZ0JjmoZP+Z8/0OAtf7FbYl
	+RD0EXjymF1rFWVVOSLn5439Vm9EsZOPzv0IJro1Pw6W2vY2PNzQH/cHkGQwRkowt41tO1/EIoS
	1qXBv5u9CYRLpINdcyT7tkKZIkGpDdqYfHRoQ20EnztwTzWrivddXdCDQo4ClIbrznq5ZdEJxcA
	0EzwiMvGhB5u+jG6UimSUpqFvgrXup3683I17WAFRN46F5si2cK3EbGsMboL90dPX1EHEruKQfk
	T7/mg0t7t9hFVG3wMxuvikNJO7cEUy9H/nM5BDZXAYBUkaGXuA+NaCDZunjXhlw=
X-Received: by 2002:a05:600c:34cb:b0:48e:6db3:ff3a with SMTP id
 5b1f17b1804b1-490c25b09a2mr318277935e9.16.1780992702020; Tue, 09 Jun 2026
 01:11:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260605031008.397328-1-kunwu.chan@linux.dev> <20260606005431.89186-1-sj@kernel.org>
In-Reply-To: <20260606005431.89186-1-sj@kernel.org>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Tue, 9 Jun 2026 16:11:30 +0800
X-Gm-Features: AVVi8CdH0juoNThKREsErMsXdOM9cAvNHpugD-3PSlQpcq7Fci8WlqM2nwe8H74
Message-ID: <CAN_Opa8sqs-V-jFrGZa6jwJKdHqT=7JPeLKcU8E-cCM74ON4DA@mail.gmail.com>
Subject: Re: [PATCH] Docs/damon: add TLB flush policy document
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	damon@lists.linux.dev, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Wang Lian <lianux.mm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 6, 2026 at 8:54=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote:
>
> Hi Kunwu and Lian,
>
> On Fri,  5 Jun 2026 11:10:08 +0800 Kunwu Chan <kunwu.chan@gmail.com> wrot=
e:
>
> > From: Kunwu Chan <kunwu.chan@gmail.com>
> >
> > DAMON avoids TLB flushes after clearing PTE Accessed bits for sampling.
> > The overhead was measured and found significant [1].  Production
> > workloads with large working sets flush TLB buffers naturally, so
> > accuracy impact is negligible.
> >
> > On systems with large TLB buffers and small test workloads, stale TLB
> > entries persist across sampling intervals and produce false negatives.
> > This comes up repeatedly on the mailing list and in private inquiries
> > [2][3].
> >
> > Add a document on the design decision, trade-offs, test environment
> > problems, and recommendations.
> >
> > Link: https://lore.kernel.org/20200403103059.12762-1-sjpark@amazon.com =
[1]
> > Link: https://lore.kernel.org/20260117020731.226785-3-sj@kernel.org [2]
> > Link: https://lore.kernel.org/all/20260526145034.91594-1-sj@kernel.org =
[3]
>
> Thank you for this great patch!
>
> >
> > Co-developed-by: Wang Lian <lianux.mm@gmail.com>
> > Signed-off-by: Wang Lian <lianux.mm@gmail.com>
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > ---
> >  Documentation/mm/damon/index.rst     |   1 +
> >  Documentation/mm/damon/tlb_flush.rst | 131 +++++++++++++++++++++++++++
> >  2 files changed, 132 insertions(+)
> >  create mode 100644 Documentation/mm/damon/tlb_flush.rst
> >
> > diff --git a/Documentation/mm/damon/index.rst b/Documentation/mm/damon/=
index.rst
> > index 318f6a7bfea4..5e239437dab3 100644
> > --- a/Documentation/mm/damon/index.rst
> > +++ b/Documentation/mm/damon/index.rst
> > @@ -19,6 +19,7 @@ DAMON is a Linux kernel subsystem for efficient :ref:=
`data access monitoring
> >
> >     faq
> >     design
> > +   tlb_flush
> >     api
> >     maintainer-profile
> >
> > diff --git a/Documentation/mm/damon/tlb_flush.rst b/Documentation/mm/da=
mon/tlb_flush.rst
> > new file mode 100644
> [...]
>
> Great document!  That said, it feels like a good complete article or a pa=
per,
> rather than DAMON documentation that pursue to be short and essential.  I=
 feel
> like this fit more to be published in a blog like DAMON project blog [1],=
 or
> news site like LWN.  If you'd like to, please feel free to upload a PR or=
 send
> patch for DAMON project blog source [2].
>
> Mainly due to the verbosity, as I above mentionedd, I'm not sure if the c=
urrent
> shape of this patch is the best to be merged as is.  I also find the back=
ground
> part of the document is a kind of duplicate of some information in design=
.rst.
> What about putting only essential information in a condensed way on the
> design.rst?
>
Thanks, SJ. I agree =E2=80=94 this document reads more like an article than=
 short docs.

I'll follow your suggestion and submit it as a blog post to the DAMON
project blog instead.

Will send a PR to [2] soon. Thanks for the clear guidance.

> [1] https://damonitor.github.io/site_about
> [2] https://github.com/damonitor/damonitor.github.io/tree/master/blog_src
>
>
> Thanks,
> SJ
>
> [...]
