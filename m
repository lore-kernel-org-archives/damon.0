Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06F6310774
	for <damon@lists.linux.dev>; Tue, 27 Jan 2026 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769518617; cv=pass; b=Q2RIKI1P+dh2AwD4hv+No9CtXjfcsmPuZ/ucVoRBTGldU+dFKTeD++5Q7YREi5a1s3X+HDWMzWqEg3FwbAChU3+SUwIwyyP+B6/8WERS0Ms9XiBPSAIwlKEVyTUtIU7VkgDjZwqpm1peaBAHKUoent2ZyUnJSrOnpIdRPK1x3Eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769518617; c=relaxed/simple;
	bh=ubrkqs4rvwbrLUkrZ5FPplHf8omJhRh/vJEV1N1VGTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOiEjHyGuz01Nl8qa5SCutfgVVR/N7RzNv+PdBVQA0QtHkw70LDVbY49dvHn3osY5/C8IThEbm5P657m7wqR8dvxuA098DMIJtfc7irOSm8uFIDPBw/ELBiZA7u/waUspIBCX3+B/sZ+PXXag4CvVSqxIVldt1VDGpv+OhLgvDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBRMcg1N; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBRMcg1N"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-502a4e3e611so50549141cf.0
        for <damon@lists.linux.dev>; Tue, 27 Jan 2026 04:56:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769518615; cv=none;
        d=google.com; s=arc-20240605;
        b=M2Djwtu07d52iIc6peBax95owZt/7B5SO0BoVHs4502TlxhSSBiAN3rifugirRTcdO
         bSZyI6QNa7dBIqMR5lQ8lildBrU/6XUEKzJrdnmAEGRmVDOU4y4U6ycK0GHqoNyeYs5D
         qLaxOZ0nCV6Y5ml0v2vs8QSFpBJbXZD3gAscNhhzbkeohIRxudVHLJ7ImMroVCu1FITA
         AtgmedgonEFOiGebEUpy+Gib5hEzsTZ6our0SRwbVCcGR3Q24tfTvqVuWBDSfJSbn9KH
         L38SBd9Z1m6ET3P2AVNUHmJNG+3tR4OX46Tx9xqZ31tiMT0gDi0YwIgv1/z4cowvemRM
         hVNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AC7UFWp9PeHQpeKmmheGmxDeCajyTPmISibkaDG915o=;
        fh=LuNIxDwrU8tBU0lHgCDdCWufQL5TCnYVCcwzLcZSFis=;
        b=KiDmejNZtd7nHFTwI5lgohnuAilwqDXXWN5GIESz5wWC4AMzhVoRXopJdlnzNpnVMi
         y+Rk5zojvwtB2wM1sW7OtVxNsMwGwjUPe1VpStgpfJQKPxkC8Vh/WEeBP1ZJie8Fnn67
         WTgDPerJ4tm2nPVDQcLBoBal/PIKaZpZVIYNe2fVe00HibN7Ib1cTdg4YJ8d+Q+SRk+K
         JiMkzk0hDwFvvPcDu4r9LCfsHT8vAMvU9qKkZ/uFGv/e7CY29C2bubL4A3eT8ATnbcpK
         oWiaAl5Ef+Y9Y4u/8TJSii7orfm4C1Quam5CN5CFRcRmu37W0kVhvM+IhKl+ytofnY+Z
         8u8g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769518615; x=1770123415; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AC7UFWp9PeHQpeKmmheGmxDeCajyTPmISibkaDG915o=;
        b=JBRMcg1NHtRNNAcO/BQqpnjjd4OtG1Y8gEvGYkBvVIAw1EgzlxL5HssWMJhJu+bs5e
         8/6bS7lqPylmDgGkLRhaly/eR29UC/xAX+YmMH9TIvJN85W9XcdyC5IYSxta6pSPFHPp
         K7DxIgxRgVujh7vOWGZT1U1vsyI43YgT/O1PLVWuQx8dZ0F1gWYJVZw/WEUF3g6Cq3GW
         3pS1wxVdPwvS/Jix96uYMM5Ngqrqpi0mhY3sg5gE9FXY+ndhXNZpBWw6ZmnKIwzam4Tn
         eGEhVw9v9WfXs+HAFDRF8wCQFzcDcH51Hzxa1UTKcPitW9DqDAeollujoi/X7OVZ6sb2
         DzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769518615; x=1770123415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AC7UFWp9PeHQpeKmmheGmxDeCajyTPmISibkaDG915o=;
        b=MVD4fgoGOSH8F8Os1FzZ8UsY7768C+LdKuMZqzGzLhAGc+bOF+GkHMUF8J8u5QXxVM
         q5p+HDIzDa+V6wpwcmFUHfnMKKCW/x+RhG6GSW+srCTj0y+AFLGLjwszxbiTm84+eShG
         6ocqF9iLwKAX+PI2agiSM5Nn5JgnD8ILKFHKxuiMNqgMi1d5OhVlPX70pULTXDZ3lvV2
         egReCTOQPmzcKtaRhCWJyujg06ne6x4b0cw1fR7iZ07fyujzhnGNPi1OvNg571EHCwE5
         NFZ9ZIJd1XYmwma/yuuzc6s8Hpb+JzJgagxb+EhcAKPSAgyna3HvGXLOtU4pJEXm43SG
         canA==
X-Gm-Message-State: AOJu0YzH4f9qz4TY4jdYHGVwa2gmFAfM2tH63SUkMQw2fNUJVFNlAIpZ
	M33YCoZxkfQynvS0J3OYVkHLa3ZnW4X107qrgjbPhAKXRWiyjSIFleU/empK3dXlRYe/wXIojCM
	R9mVilU9HEAZ3jqbq3T49wV67Ct3rbKc=
X-Gm-Gg: AZuq6aIruPW9fvGRAPM68YutpO1t6h51Gi6RObjDZHgBYHsr6Gag/FQJIPuYG/a5xiO
	EFVknsfHJK8ckvNOcRw+VcMEEYMdsyux0mBMZJYZYu4Wz/QmfS1kkRm4iwtHiNvR2uV0GlSyAes
	S/dAgnLvBVvL39MO/npjps1llJS3TsK45ajZljiBKuvoR3WRyixdapLMngI702yhyMSGfHMmWJE
	GRTm5XDSAhNdh1Fwj+xJuD7/uJ5H/AhgWaSsX9bIz4UOnfWvyp55A3Ac6XfEBbOvXUlYlYei0EC
	Ij+IV/4JeX4KK7JqjEYzn28=
X-Received: by 2002:ac8:7d89:0:b0:4f1:c1fe:ba3d with SMTP id
 d75a77b69052e-50330075b80mr15248161cf.7.1769518614658; Tue, 27 Jan 2026
 04:56:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAC5umyjmJE9SBqjbetZZecpY54bHpn2AvCGNv3aF6J=1cfoPXQ@mail.gmail.com>
 <20260127064338.67909-1-sj@kernel.org>
In-Reply-To: <20260127064338.67909-1-sj@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Tue, 27 Jan 2026 21:56:43 +0900
X-Gm-Features: AZwV_QijuXZtUjrJwIyW8mlQ1SWqZ0tqKrn7OvytREEWREa7_KN4p6GjFC4spxQ
Message-ID: <CAC5umyhVW+Rh2YfUCZCPu_7NuBh8FSGrsK23_EopDv2ixAe36w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] mm/damon: introduce perf event based access check
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B41=E6=9C=8827=E6=97=A5(=E7=81=AB) 15:43 SeongJae Park <sj@kerne=
l.org>:
> Actually DAMON is internally setting such maximum region size based on th=
e
> min_nr_regions parameter, via damon_region_sz_limit().  Nonetheless, the =
limit
> is applied only in regions merge time.  That's why it requires the region=
s
> split to happen sufficiently until the real fixed granularity monitoring =
is
> started.
>
> And I think this behavior is just a bug, or suboptimum implementation at =
least.
> That is, users set the minimum number of regions but it may not really be=
 kept.
> That's definitely confusing behavior.  Actually there was a similar case =
that
> number of regions can be larger than the max_nr_regions.  We fixed it, wi=
th
> commit 310d6c15e910 ("mm/damon/core: merge regions aggressively when
> max_nr_regions is unmet").  I think we discussed about similar case for
> min_nr_regions, but I cannot find the discussion for now.
>
> So, I think it is better to fix this rather than introducing a new parame=
ter.

I agree with that.

> Maybe we can split regions based on the min_nr_regions based size limit, =
before
> starting the main loop of kdamond_fn().  Similar to the max_nr_regions
> violation, there could be yet another corner case on online parameters co=
mmit
> situation, so it would better to check the case, too.  You could implemen=
t such
> fix on your own, or let me do that.  In the latter case, if you don't min=
d, I
> will add your Reported-by: tag to the fix.  Please let me know your
> preferrence.

You'll be better able to fix it, so please fix it at your convenience.
Adding Reported-by: tag is fine.
