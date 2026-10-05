Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238D444AB83
	for <damon@lists.linux.dev>; Mon,  5 Oct 2026 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791191360; cv=pass; b=GKaU5SoxyoA1xVqbwSWDrUYq4jDhT5dAYa2v4UMNCk3NHqdlJvHMLqJab/SwM0mfdRKGaEuX+UxH/ZKXPoyODpI+kFMVc9lx8KlK7eCqVQ4msQvweupQfPHkN0+1AGnjdza2cK9lyQW5kbfE9JGYQEOjX8WVK/LItFMvI+XF+DY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791191360; c=relaxed/simple;
	bh=Pg3fz4PNkRiCGc9O+mF7at92p5TplzPaQRJoEH/LflM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ra5qa5ETBCNd+jWR2Jhg3OxWG9uDLqj9vz2CB67pSIPUc25D2IHW7PUgc+2aacLDlJ1HaY9KPsCVewUECEPyi0gJ0iSySTsSSrrysAqSwlA0f3iHlujIAS0kWxKqDbbw+JXlOHf1D5qzeuWKP5uLmY4lN8ZiGqV2ZhmS85fSz3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBcPjiAD; arc=pass smtp.client-ip=74.125.229.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBcPjiAD"
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-35133d53028so477791eec.1
        for <damon@lists.linux.dev>; Mon, 05 Oct 2026 02:09:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791191358; cv=none;
        d=google.com; s=arc-20260327;
        b=gADiYgpR9UFzwdAQi1FUkVE1jMMdiKSTXMxFOdS3o4wop8RazuY20rX+1U1YBkNZuh
         qr0qUvaLGnvFVVoBvjhgomZLKbf+GyJb5TOTD1ISAryR6OxNZA0lxTCB6trNvDF7bhyF
         0RtvEn/pAoY7Vfa76bKoIpXIga7jgmqmW5s+fGOV4vn6UGy5zR73nUHt5l+imaBqXBds
         RgTYQMnmvQYuSVUFcXYMukfYF02lvVmUf4fMub3UZpX0WqjDLIn9tSCnSOK7JdpKfZZT
         keIQ2U0ywf+kVvUkr/ZOs8tK+Z/DDNoxCvrIW5qDcz8vvhVhs4ji6rcBHSYkbr0AXQ5U
         ErAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Duw2nxZN8kxbqWipjB3kgCvhqho4PD5wPOWTNu1vMgg=;
        fh=O99RUq0qjO2HlEss+3pAoeCLvvHJIFsewwjPGa+9rzw=;
        b=cZPIl+2tLvM/phsDS7RcqtS/+75A3Fuksz+duRTez+FqEXWxqY5voYuFq6isIKY8uM
         smQIs37oYyzivbwyNrSLKiLZ/fR+87xwKddXzo9YqbwPda5R1pf+jtNDJDG4k4DAcdOL
         rSCUFHSSKPiCe5hToh+qGMgXa7sgv+VV5IkodBCXIGoy1SURZIL2w8K6/4CIrnE5zEuT
         4b9GnhVAN5YVKYK8X85gs3xYTggoankd3oqQ+sJkeH65B+cWVp5jAC5beHGmyVr9gulE
         L3RhMf0AMa2KhuHOput0woKmqlehZEA19JDq01sK6DdcTNEFqMnQhw6EXLVklTn0W13V
         eNGg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791191358; x=1791796158; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Duw2nxZN8kxbqWipjB3kgCvhqho4PD5wPOWTNu1vMgg=;
        b=WBcPjiADYqAGyvxGZUwfUFNFpD/VWERg9GTMO+VrY1e4xVVoG8Jp8CwGE166Hk5EN1
         eefRa4tchBCHbU1s0V25ZRtk+jTk8gmH7caa4XnR6YjXfRPZ2FcTDNSSCGbCpLf91e4+
         ocSzykUazgRFFjRWE/mCbz0Jn867/vMFf46C0rFXMrJqrXIWFIcJwq8iDAmsluktt+Tt
         WAhXQEhxcRuuMOPtfCqtMj6HuJSW5AYATtKrgS+g5dW9Uk60q9VIeC+9PryIU9o3NHP6
         8K8pnzr4EaGeWEaGZZMJpxUaNmBMWMXorXTh6wMdi3cHlxP986HP900YcvLBrqvSM4Tb
         3FKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791191358; x=1791796158;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Duw2nxZN8kxbqWipjB3kgCvhqho4PD5wPOWTNu1vMgg=;
        b=dASgaP5+A7mzTfsVpDHW81VrwqKMe4fXwO0ZVSf+/2lORRIRONdsuTKJX47gfRLIn5
         PiouAyLNHJ6o5DHAUSJ5vTaxe/xLPlcTwt7verhFMT3+HShJI7muNS6LhhTVFEBh5cx1
         tnQoJRee5V3tv6yhw3iXsA6ljXrOoVD3wd9Up1Qw+HUSdfaDeHxo+3wPUJ6P6uzU2eYh
         biHMlO0mbHwzAj6iWhXOTwvobmIEdYmrjymMZX3QzCfaVgtg8fklFZdsDCqdY5u8BigX
         qTC92RrUwIZEbyWH6rfRoKhZPWcwOhP5vpcQ78zFWQzLRCJC5pO/0v6YUWww+hVG61fE
         cAJg==
X-Forwarded-Encrypted: i=1; AKwUvBwktuAms5ajDKWJB30ADp40Irwrom4nAkTgSJhH3pi308fpPaQ8E58ggjL0XFq4mSyor+bOGw==@lists.linux.dev
X-Gm-Message-State: AFuF++kG3skADB39k9MpDfDHpczIagOfSHhrZfpyPSqYuijhmerDB8SE
	/FRFqNOiwbXBytUvDw84nK1Fo4OjtDFJCqg3bIYn/Zj5zdQi/EfXlCtHVDTnInm1MX9tnWOy2Fc
	z219ASoEpiq+r0tHg/9f0uPzPFCQ97g==
X-Gm-Gg: AYBFou0pJm4iiR/1JjKsfvX0Owo8r2oTh9rFEuF2gL0auZCPfHnhLVECmSjHQxXFHWs
	ds9aZeyui6LDP9ovPA6j0N+gnd388tjt7/9cSyojTvpeO3a3Go6erlzGY20gQAuWLDAIGJCSvUx
	uFtV2dr5BCcYqVvdG2XiC/l8b7/Y9Iu6Z7XA6i6WY6TWbARnqGYqRW7m46ZoRf+2bZpkvqmHf76
	yBcGXUp1dtscYSrAZwaAbHSeYtWmSLu5uN+XIXe7qaztATgKJUWwstY9JMLRC1KB51JuxwEQdkL
	acVtmnCMW3CIyA1GcLbG4U0qOAjcEflQ0JJEcmY68fzmDzaQ/1QFGyIzYNI94jL8SY4=
X-Received: by 2002:a05:701b:4583:20b0:151:ceb3:e105 with SMTP id
 a92af1059eb24-151cec32443mr9674795c88.11.1791191358038; Mon, 05 Oct 2026
 02:09:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-2-0f00417b41bc@gmail.com>
 <20261004083036.613169-1-kunwu.chan@gmail.com>
In-Reply-To: <20261004083036.613169-1-kunwu.chan@gmail.com>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Mon, 5 Oct 2026 02:09:05 -0700
X-Gm-Features: AclHuK93ndMC4ovSjSP_cU8HjtSfyaChQiTBQ98ae5wltCXWwtXcA60S-czM1oQ
Message-ID: <CALa+Y17BOR0DBLS9-vns2SQfRhCueT0f82XCVojHhg9uacOX+w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/9] mm/damon/core: replace the access report
 buffer with per-context rings
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Gregory Price <gourry@gourry.net>, David Rientjes <rientjes@google.com>, Wei Xu <weixugc@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Bijan Tabatabai <bijan311@gmail.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	Honggyu Kim <honggyu.kim@sk.com>, Yunjeong Mun <yunjeong.mun@sk.com>, 
	Akinobu Mita <akinobu.mita@gmail.com>, Lian Wang <lianux.mm@gmail.com>, 
	Kunwu Chan <kunwu.chan@linux.dev>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Kunwu,

Thanks for looking into this.  Yes, in v3 I made the drain raise
nr_accesses once per drained sample.  My intent was that a region
receiving several samples in one interval should show a stronger signal
than a region receiving one, and it let the existing access-pattern
schemes act on the samples unchanged.

> Unlike page-table or page-fault based access checks, where an access
> report is generated from a deterministic access observation, a
> hardware-sampled report represents a statistical hardware event whose
> frequency depends on the PMU configuration.
>
> For the same workload, nr_accesses may therefore have different
> scales when monitored with different PMU sampling configurations
> (for example, PEBS at a given frequency versus IBS with a different
> sample period).

Agreed, and that made me look at where this information belongs.
DAMON's data attributes monitoring already keeps a per-probe hit count
for each region, probe_hits[], which the probe weights apply to, and a
PMU sample is exactly such a data attribute sample.

So in v4 [1] the drain no longer touches nr_accesses at all; its scale
stays with the access check primitives, independent of the PMU and its
sampling settings.  A sample instead raises the region's probe_hits[]
count, at most once per sampling interval, the same per-interval bound
a probe hit has for the samples DAMON takes itself, which keeps the
count within the samples per aggregation.  The meaning differs a little:
DAMON's own sampling tests one address per region, while a perf hit
means that at least one PMU sample landed in the region during the
interval.  To act on the samples, a context sets a probe weight, which
puts it in DAMON's data attributes-only mode, and its DAMOS schemes
select regions with probe_hits_wsum filters.

> Should we document this distinction, so that users configuring DAMOS
> schemes with nr_accesses thresholds understand that the value depends
> on the hardware sampling source?

With v4, nr_accesses thresholds no longer depend on the sampling
source.  What still does is how likely a region is to get a probe hit
in an interval, so yes, that should be documented.  I left the
documentation out of the RFC until the design settles, and will cover
it there.  Since I was already respinning for the v3 review, I folded
this into v4 so that there is a testable series before Plumbers.

[1] https://lore.kernel.org/all/20261005-damon-perf-rfc-v3-send-2026-10-03-v4-0-b03452e137f3@gmail.com/

Thanks,
Ravi
