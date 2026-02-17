Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3D7338584
	for <damon@lists.linux.dev>; Tue, 17 Feb 2026 13:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771335176; cv=pass; b=IzV9SwRetjHMPdrm7o1rdIZo5rp08fwoDdOTJqcTetXArrDXUDpzJY253D4+xvqjINaOn3fcyfs0ppqkxt+QqjyAiU2MSnWHhigigIhSjru/mAYj+3eozgnx8uuYoLkIov8O5EgLltNgg4UzvIlEnPJ//1+3TbhMiOQzI1ZslgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771335176; c=relaxed/simple;
	bh=V1JKzj0LdjjFLF/ybZNwjENnDCUz9VVKs3ZPu5GaTDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UspHxEiJq5NjD26QfEixL/k364WzOEsvtOAHKpqlP2ivWpcV6GeyrbxbnFC1SHkVF1B3RkExBQPbP0yrwf1nTLs3hTczywM03z/FsctTTRQi4KjdtK5ydB4jdY6j8vV84sbHQ45uAtIe2eb+03bM/XTt5Ndn9ZN+sFkbaRCTbtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBSPF7ad; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBSPF7ad"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5033387c80aso75013971cf.0
        for <damon@lists.linux.dev>; Tue, 17 Feb 2026 05:32:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771335174; cv=none;
        d=google.com; s=arc-20240605;
        b=dDK14Kb99/EdKLEMwguvi7VJ6Vzy/fdEOQnQ8rccFdYCRL0aOqWhrsHoCHke+WpKi+
         D7Gx/gVy5U4lYF+AykPl657Xh3i75CDx6QdTYJ4KCOYMlDo/gzfZQiDcjPSAtWIVQTMg
         aEv/EMwP4UH7bJKc44upq1gcuTxIt2UAD6YLrwA5/OgCzmSQXFldI2QZrROmu2oO7Ivn
         6QEObDzjsrcxCij1XTqrLzixe+Z/TMBE9980FTUewcB1Kuahn34jXtZ1X4WvHMWIAYag
         gsxzyRm/VCRUx0ZLwgxbPfMioUkVcmxUrGIhcl8y6S31mP86UvW87HhBwfatFZDDeACn
         c+Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vKB1Zp/zEIpuQ07zWR3DyfpL4rrg8eTMyNKLHhmJndI=;
        fh=LuNIxDwrU8tBU0lHgCDdCWufQL5TCnYVCcwzLcZSFis=;
        b=Sx0AplcR7nfzqdej+rorfOIw+b4mUnMqNY/OWQTDRuxNiOqQCJN6ep4h0/eMbOocbC
         dCgmLbSQ0AR38bJx3pfJjk4J588jYP0hQUt7BuhWb86hfgwqwOfzIIEvO/WFxrlx8pZ1
         CAC7+R4/YNLyKvL9pojb9tfs60Ign/JZcEhKQwXUsT/qWQwPF7YaCwto6t6BClh7240H
         qAqSF/+L1y/KNN0k9RoQntnXepHKkt0QqomVglXAxXZEwVsS/FuBSSghvJENkntA1V9x
         +aWPDYBzdFnorzA9Ls4PyusoW5YZYS+NSaF72QeXoN8je6HWDXSjmcEvWRbqRQJtuzhn
         4n6Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771335174; x=1771939974; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKB1Zp/zEIpuQ07zWR3DyfpL4rrg8eTMyNKLHhmJndI=;
        b=LBSPF7ad6SzDPPMAphVN5S42LxzFn1pTiQmedLpXX6C3TlufohIcUI0g9Nw6eWLcbU
         Jmghd2nbZLMUmqhmS0NNZVwCT2y0HGeUWX3CsJKM1IpjCLlhppXv3mT7/NjjCKiETf0E
         AyHr4JHcjAWXCc+n7FXqlFVOUmyr0bC4z+RGmEl/m+yxy5zhIKCfbWwSMHD9UXGBKKEW
         M6Eci/bnA2W4o5m8TkYxR2g4jbHaOfJsK53B6BkzYR1lW7TKNy5JToHP/hRDjLHxMgH0
         EMgEyeP3bHy9Qucn5W2XT7AMC69Sd+/d5EYUGPI7zMKimkcSNapg8399S0u27TV8zIzk
         EwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771335174; x=1771939974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vKB1Zp/zEIpuQ07zWR3DyfpL4rrg8eTMyNKLHhmJndI=;
        b=ACpiefwR1G0nonyTU8mGPOGjGQv25eLjvYhQSbwyMm2Fnwmr4z6fg7tyCyyBS+XQ94
         QpJgSGJfQujxh1/+eF+j+oMzlaobLzhjGZjLM2prGyFz5y7VtQ8/Nf+7VvQMmbqXDEMD
         pDFYT1ktiZYBVKgxNcZ1gd9BZLI5vnCJp2BasByQaBAly7rmc98KUpCQ/jjWz5V9848f
         lPFopa2UXrWm20LkruowrlbG0s9i83pF7TgRpB6VcMkFHS9Dl2Mj0UQqp1rBXYfhJsRK
         hItncqAaPQsBrd2jW2w7kgcAYaNLTtHhHzd/5aNUPUyqCR1c/kg28WLpSbEWqPWY4z3z
         1eMw==
X-Gm-Message-State: AOJu0Yz8AIXl14njMLEuz2YNCdN9IASqpdq+nVPZ2ILXQr1iTjnp7+VS
	WcHod64zOgIVFTD1qZ9OMhX6oRh4CP/kPI7gmMRyOJ4G7zu0L/2el9vP/ScUMoqPl9ZpwtoxX3N
	Nj1d9Ak9n6Y2fVl6P6e2w9BmvCrB/NxE=
X-Gm-Gg: AZuq6aLwP72pIPHV1Pvpipb1b9+CkoZ30WhzdqQLOhA+dWXOAxFc4aBuYt6QDQzxkza
	kyzsDaWXZoGXVXWrkxe6C7uC3FBT7NG1h2a9nI6tPxzpaDhI0HCAWw9DwwKZ4vpSMc1rDsQumaU
	xuVqJlOz2ifpj8+lP5TPQUcTQXbYVorywcOnK8WyKyRkzpFFKH/0apY4hQGVeEbSnB/8hpg2w75
	lK6Ty+NnhchYwGkayMnq/3inI/hl0djxHPCUrXwIVfzlSJbTAXTdSk7QEMdwu2uhbmOX5F4B915
	pap+0uMNTL2ZQ38BT9N7yKhPP7hpNb0Tadg=
X-Received: by 2002:ac8:584f:0:b0:4f1:c601:3ca4 with SMTP id
 d75a77b69052e-506b2731b93mr156521101cf.32.1771335174179; Tue, 17 Feb 2026
 05:32:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260128011225.71964-1-sj@kernel.org> <20260217001325.69633-1-sj@kernel.org>
In-Reply-To: <20260217001325.69633-1-sj@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Tue, 17 Feb 2026 22:32:43 +0900
X-Gm-Features: AaiRm51rNmbw6Yt4x6ryMJNFAmIzjRurVq3Cpi3Fa7x6Mddcs6yUElHRRtDwidc
Message-ID: <CAC5umygPq8+FQWTG73-QPOKHT1P5=N2+qFkrRfZAkL_7G=gQXQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] mm/damon: introduce perf event based access check
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B42=E6=9C=8817=E6=97=A5(=E7=81=AB) 9:13 SeongJae Park <sj@kernel=
.org>:
>
> On Tue, 27 Jan 2026 17:12:23 -0800 SeongJae Park <sj@kernel.org> wrote:
>
> > On Tue, 27 Jan 2026 21:56:43 +0900 Akinobu Mita <akinobu.mita@gmail.com=
> wrote:
> >
> > > 2026=E5=B9=B41=E6=9C=8827=E6=97=A5(=E7=81=AB) 15:43 SeongJae Park <sj=
@kernel.org>:
> > > > Actually DAMON is internally setting such maximum region size based=
 on the
> > > > min_nr_regions parameter, via damon_region_sz_limit().  Nonetheless=
, the limit
> > > > is applied only in regions merge time.  That's why it requires the =
regions
> > > > split to happen sufficiently until the real fixed granularity monit=
oring is
> > > > started.
> > > >
> > > > And I think this behavior is just a bug, or suboptimum implementati=
on at least.
> > > > That is, users set the minimum number of regions but it may not rea=
lly be kept.
> > > > That's definitely confusing behavior.  Actually there was a similar=
 case that
> > > > number of regions can be larger than the max_nr_regions.  We fixed =
it, with
> > > > commit 310d6c15e910 ("mm/damon/core: merge regions aggressively whe=
n
> > > > max_nr_regions is unmet").  I think we discussed about similar case=
 for
> > > > min_nr_regions, but I cannot find the discussion for now.
> > > >
> > > > So, I think it is better to fix this rather than introducing a new =
parameter.
> > >
> > > I agree with that.
> > >
> > > > Maybe we can split regions based on the min_nr_regions based size l=
imit, before
> > > > starting the main loop of kdamond_fn().  Similar to the max_nr_regi=
ons
> > > > violation, there could be yet another corner case on online paramet=
ers commit
> > > > situation, so it would better to check the case, too.  You could im=
plement such
> > > > fix on your own, or let me do that.  In the latter case, if you don=
't mind, I
> > > > will add your Reported-by: tag to the fix.  Please let me know your
> > > > preferrence.
> > >
> > > You'll be better able to fix it, so please fix it at your convenience=
.
> > > Adding Reported-by: tag is fine.
> >
> > Sounds good, I will do so!
>
> I just posted an RFC patch series [1] for this.  I will drop RFC tag afte=
r the
> current merge window is finished.  Please let me know if you find somethi=
ng
> wrong there!
>
> [1] https://lore.kernel.org/20260217000400.69056-1-sj@kernel.org

Thank you for posting the patch series.

I tried it and found that patch 2/3 made things worse than before in terms =
of
monitoring at page size granularity.  This is because, in my evaluation, ne=
w
target processes are added without stopping kdamond, so processes added lat=
er
are not initially monitored at page size granularity.

Would performing a split operation like damon_apply_min_nr_regions() within
damon_set_regions() solve the problem?
