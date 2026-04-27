Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E2923EAB8
	for <damon@lists.linux.dev>; Mon, 27 Apr 2026 01:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.196
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777251615; cv=pass; b=kIPm73XIgG7WjX3BNtUeIEnqEaNHhat4JVRy2QIHjugHHS9KH7ddLhdfJeyZWh1mCI9BE22kZuqJVNNeAqIvtVpqFyvSh2sTM3U5Pa1A2oJ8llk2bVa+zKVjMGF4BHg7PSmG9kYrpfweec+xjSsSJN3l9gO+BX75gPBXZ6kEf+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777251615; c=relaxed/simple;
	bh=+rvuH7OYXV1HsVqgeQnLsJzCNwEWaX2a9ffgwvQ+wgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMrBFdFrrOOULPEsYwLP0tiZNqSnlT0HimDstATUFUl3yE++X7J6WUBXvOqdAUuJoEtLoecU8qwZWqB8PCnQQVDJPa4gRcTAN2oqgFdVASEEAiZb4jWtu6zxibN4ZSprERVi0s3Kl6qYqGfF13GaMIDbb9bXumXlzYAGVatrHqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3gWWryG; arc=pass smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3gWWryG"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2d832f2f44cso8089687eec.0
        for <damon@lists.linux.dev>; Sun, 26 Apr 2026 18:00:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777251613; cv=none;
        d=google.com; s=arc-20240605;
        b=DXZLtXq4PWqhRFFeS7RqLvZJefzsPDqvjz3nglC5xxb9ZXyd9ukv5lZCVTkEXXad17
         REsBrfKtVlDDyxnvhFmg2mOoO+G6zLU0O9t0N6wzVbCkqe39DA0jltsDjUXLljuyAj4L
         eu3cQx6p6FB3qv4svMPKEbAygoZTEderGnQCTjICrUpkDqFD9pmesTXQc7Aer989ai7b
         5/pIlGqxavzCSUcUdRv59YvRkvlpbiPzalPiL+emAc6VYhMui085Nk6CmWqbIr7ZzVeU
         6+EPvV+cqymWkrA3YGK6kDZV1p2FEwXzoV+mhKK2JzwC3YOgh+1jrfdqO95Jyh2MdLR0
         SAGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EQvew2h5y7t1/a2E3iAG88nYAgpOqyYgpLhdQGfHFKc=;
        fh=g3VMvJQux/HSLIVicncr24svuVPzuNK+KAx5AQfJAks=;
        b=BeD9/drXv9Rl2OOZQriFJHvylehFll8BqB6HjMJykxHMaqwVcyvb6iH4RBbi+x2140
         XLzTH8fqtVIFuvk3bS1Zk1cDusM0ligXJ4cJc+koAumcfckTKCxC3iY+NUp9Ye1njTyX
         ZTPrnJ4U7h+4J17sH4jK0PqPshDA2dZIj4/UTm4HD+YxjZMuD2JwcM2cGZF9qoumGGGw
         ZlmBb1vOt49tL+GQbjaYft122kHX3r30CWekwFPb5rYLOXXM7ZuDOGLNUsGG4P+2V4Xr
         h5xVelu6rc+HCnd8iNgnCeU1OgxgTfDAtQNLN91TxTmeXeJhAAf3iXX5hPvynh4GKbgP
         8JZw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777251613; x=1777856413; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQvew2h5y7t1/a2E3iAG88nYAgpOqyYgpLhdQGfHFKc=;
        b=Q3gWWryGA1gkcTcTzhf5qqjMLNInd44gdUgikCzCXkAGelsGtX6ChLL/JIqxdp72sd
         drFfu+vnmVUSdIL3oyTghTs/L03OJCsSX8CWGuxXJnU72o85G9jfe5LbO8IxO5JzKRFX
         pWVkyMFkUeQra5pttDOCTiT/J2hbp5IuHlSF9ploxOj1qGmivKcXiY0Mnzhe8D+GZzf2
         0Q7+ZdIHZEU1nLO2a2FgPX4k0Ix1ZpH8VCWQY09NMu+OvXLeaFe/KPIkgyPe01o4x3TR
         E9BfvlT2+Xf8mFFFC42POljRmcuGCy6sz+f/VUV4zXW6w0MhAIAqKRsFSr+StJV0Oir1
         Lt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777251613; x=1777856413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EQvew2h5y7t1/a2E3iAG88nYAgpOqyYgpLhdQGfHFKc=;
        b=EueWdSX8RKif6eGa7vCbIv9BILgKG8uFVWMFMxFsTPE3v7ZkGysB9oJhB5c+XsEFYw
         40V9vgGOArIVVroolole7MyT6dxYKFRft8E5+JIzA2sP4+9bXA73zjOpSJlxD5nynuZS
         kJi3qA4zorjBBrPtJ75Qn2/9ERJAF5H1/omALiTL4dhBP21oz5ngFWZ2UhGpYztF9oI7
         DBs3cA0fvzBoaG5jHP7KZ3RiD0Ne25+u3nRXM3XIF87MNE0BS5ohkkveS2wooJEkuP63
         kARvcIXM9DxPJJOsh8oPj32OzwuccbUSNWBX5Jb56Ao9RAfiKAc2EmF6lv5n2D+w1Qag
         kCKQ==
X-Gm-Message-State: AOJu0YwOp9iBmhCLAjp7KT/ale7uugwZFra7/UGp1xaMs9xIeiAZZsX0
	IlyswVB+qIMfSSxWw/urhro5IckJ8rG/AzRPeqQcvhLOrIvOVgZcvEByWkNtvJEugFaN2AXDdOE
	ad+hXMHOEwo1blKyduCNOepVAkgQSZQ==
X-Gm-Gg: AeBDiesm/iHDLVTJdiFAWpa861NPNEVePnjlD7IJiKvyYXpl3G70pe2fYnj/1kA2MwZ
	3k6U3ulGTkElpTOAiGbPu+1FX5H433aDzHMYVtiQs77oElOEDoBJ6zwWoLYmRBtKqS5ef+yfIb8
	s9buyWV/ap1uiWgOu+lfXgYC1NGz1YI5mQlhwDseYVl8SJxNplkda5MvIjYJSkH2zM/X3ygatGI
	NNvkagUtFHptgCtut1k2P52o14DqECyxx9OnMsl4+A3vVPuJMm1B+ke9QdvZlWz+TnrmHXytflT
	rg0NLb4tGncXsYj0MAVwFfMCZppiH5cYVb3AowTX6YVkuIV6XA0=
X-Received: by 2002:a05:7300:214e:b0:2c4:dd55:ffc1 with SMTP id
 5a478bee46e88-2e464ea4fffmr21053974eec.2.1777251610424; Sun, 26 Apr 2026
 18:00:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260426213859.1835-1-ravis.opensrc@gmail.com> <20260426230322.106206-1-sj@kernel.org>
In-Reply-To: <20260426230322.106206-1-sj@kernel.org>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Sun, 26 Apr 2026 17:59:59 -0700
X-Gm-Features: AQROBzBShFgxvF3itryuUFMs9fmnj3RfnDehxrQhBcHZWpM_2mY0hlkDGF3if1Y
Message-ID: <CALa+Y16Y1rY7Pde1b-qbkn0H2_KmTCqAEkemwuW4xe1K01c2XQ@mail.gmail.com>
Subject: Re: [PATCH v9] mm/damon: add node_eligible_mem_bp goal metric
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, akpm@linux-foundation.org, corbet@lwn.net, 
	bijan311@gmail.com, ajayjoshi@micron.com, honggyu.kim@sk.com, 
	yunjeong.mun@sk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2026 at 4:03=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> [...]
> > Changes since v8:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > https://lore.kernel.org/linux-mm/20260426003245.2687-1-ravis.opensrc@gm=
ail.com/
> >
> > - Removed unnecessary casts in mult_frac() call to fix potential
> >   divide-by-zero on 32-bit PAE systems (Sashiko/SJ review)
> > - Kept original parameter name 'ctx' in damos_set_effective_quota()
> >   to avoid unnecessary diff (SJ review)
> [...]
> > +static unsigned long damos_get_node_eligible_mem_bp(struct damon_ctx *=
c,
> > +             struct damos *s, int nid)
> > +{
> > +     phys_addr_t total_eligible =3D 0;
> > +     phys_addr_t node_eligible;
> > +
> > +     if (c->ops.id !=3D DAMON_OPS_PADDR)
> > +             return 0;
> > +
> > +     if (nid < 0 || nid >=3D MAX_NUMNODES || !node_online(nid))
> > +             return 0;
> > +
> > +     node_eligible =3D damos_calc_eligible_bytes(c, s, nid, &total_eli=
gible);
> > +
> > +     if (!total_eligible)
> > +             return 0;
> > +
> > +     return mult_frac(node_eligible, 10000, total_eligible);
> > +}
>
> Sashiko found [1] this can cause __udivdi3 linking issue on 32bit machine=
 with
> CONFIG_PHYS_ADDR_T_64BIT.  Seems that is correct to me.  I believe below
> attaching fixup can fix it?
>
> Ravi, if my fixup looks good to you, could you please post another versio=
n
> (say, v9.1) for another Sashiko review round?
>

Makes sense SJ. will send v9.1 shortly with the fixup.

> [1] https://lore.kernel.org/20260426220409.95B26C2BCAF@smtp.kernel.org
>
>
> Thanks,
> SJ
>
> [...]
>
> =3D=3D=3D >8 =3D=3D=3D
> From 828ddfdfa3a996efc4620919a3cc77d55088c466 Mon Sep 17 00:00:00 2001
> From: SeongJae Park <sj@kernel.org>
> Date: Sun, 26 Apr 2026 15:54:48 -0700
> Subject: [PATCH] mm/damon/core: avoid __udivdi3 linking issue
>
> On 32bit machines having PHYS_ADDR_T_64BIT, mult_frac() with phys_addr_t
> will cause __udivdi3 linking issue.  Cast values to 'unsigned long'
> before calling mult_frac().  This could cause divide-by-zero if the
> denominator becomes zero by casting.  Avoid it by checking the zero case
> with the casted value.
>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 0ea747d487465..aec43314fc4a9 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2921,10 +2921,11 @@ static unsigned long damos_get_node_eligible_mem_=
bp(struct damon_ctx *c,
>
>         node_eligible =3D damos_calc_eligible_bytes(c, s, nid, &total_eli=
gible);
>
> -       if (!total_eligible)
> +       if (!(unsigned long)total_eligible)
>                 return 0;
>
> -       return mult_frac(node_eligible, 10000, total_eligible);
> +       return mult_frac((unsigned long)node_eligible, 10000,
> +                       (unsigned long)total_eligible);
>  }
>  #else /* CONFIG_DAMON_PADDR */
>  static unsigned long damos_get_node_eligible_mem_bp(struct damon_ctx *c,
> --
> 2.47.3
>
