Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4A822068F
	for <damon@lists.linux.dev>; Wed,  3 Dec 2025 07:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764748488; cv=none; b=doZ58uoHGd1vzyoX7LPNQZlLMLhRdyBDNuNHteHvtXsubgRIxT0yupSCAKrG80nThzgDeIRwMJRnRHlN60yu7JMD+jw8y6BtmB27M5ujnVA9uuyPTDcYgxEtVqJSmldomvyboUmNPjtaSkYSczF577s0VQ76LyHNh/xXl1s7m6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764748488; c=relaxed/simple;
	bh=RZOQW2L1yL+55c4hFB7TxRsdKnca/Jc6Bt/0APuWMSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rH6N9p4ifHrVsOO2B4FraKaw9gZVGG2K9BIzRAjyUAYH9ssa/lFqZw5w+7bTFZ/tSyf4YoeROWeESvsWLXdBskrW8rnXUwKAf3ibyRPncd/Y6lyKLFsFGPGByHm97Z5v0/o3+hECckhfOBBhI+Licm16dLd7f9EdCuWM3/ly1ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObO7dvsa; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObO7dvsa"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-641e4744e59so6737755d50.2
        for <damon@lists.linux.dev>; Tue, 02 Dec 2025 23:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764748485; x=1765353285; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=opxEjkEEzWDYDI6mbsJgfie/jI2vqrmyMYr8FKJBA40=;
        b=ObO7dvsazv3x7/LeSB0fS0X7kIsuqDpFEq3XZrp9M/aiOz35SiaU4FbIG4cPDtGRE/
         T9uXLHa8fH19uTar1/QWSRq2Nq52cwSNUqj70Mw72WhmCtEnqElofbNNRiVrS40Re0r1
         8pxbSqJ1E796HfujM0u6aRGouiyoZqQ4UhV2L73l2ORSdQzvqHdq4ogSQJ+VxtRhm2BL
         Bstaw2CsN5XyPySxNgr6jZ3SnC4fij3t7kOvIg+cEcUkZVvU+KUUpjfTKv39XQAlEwju
         zGVFD4Fk+q0ZahmBfeCfO0+zQc2R1LngcIu3g/QCaf0F/SjCrKw4Nl7Tbcu8oHFj6d6/
         FXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764748485; x=1765353285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opxEjkEEzWDYDI6mbsJgfie/jI2vqrmyMYr8FKJBA40=;
        b=dI7MebihGVM/lYIGNN+TaLYvDajTQ3Zh5FTNk3NukJcS/3C/GEQtLx8f1+Ys3VqycX
         rqz9GD59S/+9+XBQBw9La3FbYTxLrQ1U45PlhXU2zhR1+6g2BRv7Exktn9wHojCTcZ4i
         VGOfq/hpAU8LQ70N5Y0sDlFDVivCqB/7Ju+WR+aZyBhH47EtJDBmcTDSQNAf1gjYLrPf
         OVGXAaEHd/IBLWH9lWTI25EsJUeysqAqTZeY8i69vxtaESEm5YzLSaurZPawbzOgBH0v
         qhD+oO614WRV3S76Wk3ITI+/RkdO/yac6Ei7iyslJPW+e5JtmLKHE0x0cfeb2vYA6Gib
         8iIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyKfjLDMvRa2Wf32orVBlahDS2f7JMBO3sdMhfDYij/S+HZHyoYBwEp7sdFfzn9ADqcFKNmw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyvf89vJGagsTX/i2f5S2pQOAV2/1l4QS3JuFL5MkutovY4L5dA
	yGha4+yv7W/bnxKEek+xBbjUCGqXxTkH/YkamypGEJzMze80DpTggGUG+LUBWcPKZai4WpyrC2d
	Juxdjftn9FK5MDfp+c+gICiDMKN1GU34rTTJ/H9w=
X-Gm-Gg: ASbGnctLiLjqgLT9Y9v7fqeOOhTmG4Az4OJDp6+aNN3i5q4E8stpm/vrgnVWBCDkDWE
	kQ9qaH4AzqCGAsgiQuQFc/thPHhqnOFDcyHUQRkvd/8zG2WgAguC2EN48jtVXOMRJCM3zkaHn0G
	gI+Gg+glBfeWPfKentQCVdnlIRgvcw/64MS9bmFOEjPryW3bG9/kWpgAV7Ob+04TlNo9w9Jb6mo
	75TtS9gpRtJzzbCgeNsLG+ZoqpEnnQbdZIEocnSKc7nsdL8+qJl9xMvS4OWKW8UzSqbaF04
X-Google-Smtp-Source: AGHT+IENKl0Dkx8rYrQUsvLPO5L3t8HEgzDrP/ixPiYlg+yAleWlsgnRJvxrxEcDhTyTitTH4p4QzqYQ+U5uxHnFMTo=
X-Received: by 2002:a05:690c:6e03:b0:788:17c5:4459 with SMTP id
 00721157ae682-78c0c1b3612mr11124357b3.58.1764748485496; Tue, 02 Dec 2025
 23:54:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251203033350.14629-1-rgbi3307@gmail.com> <20251203042738.47206-1-sj@kernel.org>
In-Reply-To: <20251203042738.47206-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Wed, 3 Dec 2025 16:54:34 +0900
X-Gm-Features: AWmQ_bkgfLdzi-xw68LxqlBAAb_jyseLFUz9QtWZnNb2t9w7BsoVbbS3bXQXxbk
Message-ID: <CAHOvCC71f5ZXRq_HK_NiCT-o6kVfOY3cm4wWzFy+N6Ds2RMPQw@mail.gmail.com>
Subject: Re: [PATCH] mm/damon: Remove duplicate attrs.intervals_goal at the damon_stat_build_ctx()
To: SeongJae Park <sj@kernel.org>
Cc: linux-mm@kvack.org, rgbi3307@naver.com, damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi, SeongJae Park,
Thank you for your kind reply.
I will send you the v2 patch incorporating the advice you provided above.
Thanks.

On Wed, 3 Dec 2025 at 13:27, SeongJae Park <sj@kernel.org> wrote:
>
> + damon@lists.linux.dev
>
> Please Cc damon@lists.linux.dev for DAMON patches from next time.
>
> On Wed,  3 Dec 2025 12:33:48 +0900 Jung-JaeJoon <rgbi3307@gmail.com> wrote:
>
> > The damon_stat_build_ctx() function sets the values
> > of attrs.intervals_goal structure members.
> > These values are applied to damon_ctx in damon_set_attrs().
> > However, It is resetting the values that were already applied previously
> > to the same values.
> > I suggest removing this code as it constitutes duplicate execution.
>
> Thank you for finding and fixing this!
>
> > Please check the modified code below:
>
> The above sentence is not needed for normal patch descriptions.  Please drop
> it.
>
> Also, I think the subject could be better describe this change, e.g.,
>
> mm/damon/stat: deduplicate intervals_goal setup in damon_stat_build_ctx()
>
> Could you please make the above suggested changes to this patch and resend the
> modified version as v2?
>
> >
> > Signed-off-by: Jung-JaeJoon <rgbi3307@gmail.com>
>
> If you agree to my above trivial suggestions and make the requested changes,
> please feel free to add below on the v2 patch.
>
> Reviewed-by: SeongJae Park <sj@kernel.org>
>
> > ---
> >  mm/damon/stat.c | 8 --------
> >  1 file changed, 8 deletions(-)
> >
> > diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> > index bf8626859902..51dd29685915 100644
> > --- a/mm/damon/stat.c
> > +++ b/mm/damon/stat.c
> > @@ -173,14 +173,6 @@ static struct damon_ctx *damon_stat_build_ctx(void)
> >       if (damon_set_attrs(ctx, &attrs))
> >               goto free_out;
> >
> > -     /*
> > -      * auto-tune sampling and aggregation interval aiming 4% DAMON-observed
> > -      * accesses ratio, keeping sampling interval in [5ms, 10s] range.
> > -      */
> > -     ctx->attrs.intervals_goal = (struct damon_intervals_goal) {
> > -             .access_bp = 400, .aggrs = 3,
> > -             .min_sample_us = 5000, .max_sample_us = 10000000,
> > -     };
> >       if (damon_select_ops(ctx, DAMON_OPS_PADDR))
> >               goto free_out;
> >
> > --
> > 2.43.0
>
>
> Thanks,
> SJ
>
> [...]
