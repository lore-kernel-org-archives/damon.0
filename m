Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D0217C220
	for <damon@lists.linux.dev>; Mon, 11 Aug 2025 15:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927566; cv=none; b=ru7SMlVQgh5qHFMKjtYEvdGS3VOrr+0eii9seiT2N8HpmnHB97ZES34dZyXf9OWNvGhSw6K0Rab2EcONkUApCUW36y4+gYogpS1n6no6mwgDHTjQduKEAyhuOaT46uU7Tbe3D1u2+p88NlJA2w+BWPMkGJ+V2AoIYBaWxnZCHt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927566; c=relaxed/simple;
	bh=NgsJI7quKz1qBg+uCHKQ2Isns73WiTG7Xk09KkjF2dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BbRECEpC/sAEyI856vWOLJpNuWDtwszXANU9rw+5D+MuGbq7EKg0iwe5kymMKWb0yQ7oRQMX2G4dy4t3mT7lX9G6zt8Xe6xboWsz70PoFih1QB/PAiw7ZP+12hcA2p39HZpdoC9v69MvDbBPDPPnonznUqN/xT7EQmAAJbJPLEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLQALW0I; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLQALW0I"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-741a62723c0so3073628a34.3
        for <damon@lists.linux.dev>; Mon, 11 Aug 2025 08:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754927563; x=1755532363; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tq1F8Mm+0ieT7b6k1Of8na1YR26QQ6eGYkl7nIaZj4k=;
        b=ZLQALW0InST5JLDeiz2IJNOgXQ/ecFZi1blmucBPuNPiF0vcQyLNPfx2E85+7s/ri+
         z2BDZfHmXG7A2fLN32EiVlSLs9SxOnBba+VFncfc8kdsepSs2FXQ8jVEqQE+0mZUf4kc
         578M13zinCbDbv89MjSwhaYZ7fxr5iDkGOBLYeI9w0TkhuVPJ2e++Se+D2RtEuoJeMZ9
         9y4i9+IwavDyQzLN7t0d9f2OGtptk793Dc1Y417K7sLJtn/ztCDsuJ4doctWaQ0imUcS
         48HIozKQBvZ9HEtLc4mx85ASPk/5Kja22YRCPBL+AMIBL+9mn1vq+qLYVHEwQ2OPJvuS
         qP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754927563; x=1755532363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tq1F8Mm+0ieT7b6k1Of8na1YR26QQ6eGYkl7nIaZj4k=;
        b=wic1L02GJ8D3KIinA9BJMEIKkAFSM1rOCi7195dNfn5GGwNvAK1gUQ8DMIZi0e1ufB
         tO+9V1UmeClDaJuB+nlDAx7JioOYGMWf62eOBHWArI3zz1W3WlrvqjtwhPzQcJXtDybo
         vRgvxX+zXcevxrY1K+OouajLM8HVXbPLz0+zkj4QUoGC6E9Yaw41KHSuWZgds2oaRHnS
         l5fFTXlSPb7sOlVRSksjU0WPentXHamAV+mjJRqsvRp30SBYH4tiSUrKps3f1n6L+zEt
         oz/bF16aG3PfRHYS6I0S9iz+9X250fx6JFbiNquywssYVvCIImnZLBODmoU71SIrRRMb
         5Szg==
X-Gm-Message-State: AOJu0Yxcek9O8deHpBkbjaMknfCkZHBPouMl9Gr1UAmcdGAzzmv+O+87
	nG7nuEs9mjGzs/PvbAJ3A6wKGV2kG4nQ3CP4kryGJTEbYkG8RzGcXczboALgq4Ll7B3iOzXZYfv
	MF7GZXPWd1NRGfhHYgjl/YJTxTHGp0u8=
X-Gm-Gg: ASbGncs/jQjA1Qh929xqhYyRXmpaC5Vhqqoj3VRK+qS36sm2AqS0W21QQnsqjiTwlmZ
	YOi7Lizmpt7BWFHLrjzdXq5Hm95BKomOTMM3auDwk0WeI+lmJL/DoS3K5mJqxVm7GsG51tcyz3K
	o1IyYMdSFdwojxzU2jJiAcqScbIEmpoOSMdxEwZIKBnILzUqReU45VVXgMRZxIKY7/1pojlnP36
	D+K
X-Google-Smtp-Source: AGHT+IHXCbMHEmKY8gITv35wc8CJGx8Dz/HDZgUw8/kaetWMyncWM0I189VmCiWrWcux/dORSGP0dLUKpOSY+sHhdpI=
X-Received: by 2002:a05:6870:9709:b0:30b:c4e1:794b with SMTP id
 586e51a60fabf-30c210ca448mr7933378fac.22.1754927563315; Mon, 11 Aug 2025
 08:52:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250811074612.89804-1-akinobu.mita@gmail.com>
In-Reply-To: <20250811074612.89804-1-akinobu.mita@gmail.com>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Tue, 12 Aug 2025 00:52:32 +0900
X-Gm-Features: Ac12FXyUIzE1FmsqO9ZQeLtj5QroYEYkxvugdKron3bDHZBfB4CboVxHhw3VGQA
Message-ID: <CABFDxMH0FfzTfnGgaLK_uKA_8tB6kMcoKiOmi-m5fbJ0L5C9Vw@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/core: do not merge regions when the number of
 regions is small
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Akinobu

On Mon, Aug 11, 2025 at 4:46=E2=80=AFPM Akinobu Mita <akinobu.mita@gmail.co=
m> wrote:
>
> This change prevents adaptive region merging when the total number of
> regions is less than the minimum number of regions setting.
>
> Even in such cases, the kdamond_merge_regions() function must proceed by
> setting the upper limit of the region size to zero to prevent any actual
> region merging, since it is responsible for updating the region ages rath=
er
> than just merging regions.
>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---
>  mm/damon/core.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 52a48c9316bc..34f1844094cf 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2247,9 +2247,15 @@ static void kdamond_merge_regions(struct damon_ctx=
 *c, unsigned int threshold,
>                                   unsigned long sz_limit)
>  {
>         struct damon_target *t;
> -       unsigned int nr_regions;
> +       unsigned int nr_regions =3D 0;
>         unsigned int max_thres;
>
> +       damon_for_each_target(t, c)
> +               nr_regions +=3D damon_nr_regions(t);
> +
> +       if (nr_regions < c->attrs.min_nr_regions)
> +               sz_limit =3D 0;
> +

I just have a question. Please don't feel bad.

1. Doesn't `sz_limit` which is already calculated with
`min_nr_regions` guarantee a lower bound generally? If you meet some
counterparts, could you share the situation?
2. Even in that case, doesn't the split/merge loop generally guarantee
a lower bound? Are there any special cases where you can't wait for
that loop?

I might be wrong. Even if my question is silly, could you please
answer kindly? I want to learn more.

>         max_thres =3D c->attrs.aggr_interval /
>                 (c->attrs.sample_interval ?  c->attrs.sample_interval : 1=
);
>         do {
> --
> 2.43.0
>
>

Have a nice day.

Best Regards.
Sang-Heon Jeon
