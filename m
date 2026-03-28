Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C30DC2FD
	for <damon@lists.linux.dev>; Sat, 28 Mar 2026 04:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774670582; cv=none; b=WxhdAgifkvlPVgiszDpquiDVdmh2fmTDxE4WP0BjiaAcgwY98fDO0U4tdCIRTUHu42njOJBkSVXt1puFVKV/0amKPh8wYGIBaHLCro6hmbx9mwJbfe6qO55ukOJMKaIYnh028YTSAYHRdLfn7zPMEx54/eyAtmu7jbf6RmzThsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774670582; c=relaxed/simple;
	bh=DBRSlAY/HawsMqi0mOD4MXCCGjAHhHaZXpBEMCG6DfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKqMpRh1jFL1DlYhdngHxkXvD9Oojxvg97ppZROC1zfkpQRWoEeETDeRmJ49zIpZOpCnKOQ726h6ePJD76HndAVXp/cIjn7RKlrIDcy5RiQQiarRxIarfs6huCnsYw6UZmxRYpntHwNy5jDoEXn4zZJrQ0VfU8pj7AU4giuhpFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfG2rueP; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfG2rueP"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c742882d2a4so1211555a12.0
        for <damon@lists.linux.dev>; Fri, 27 Mar 2026 21:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774670581; x=1775275381; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3Zdm9QRebXAcvnQwXWCkI4HeWD2IUP+mu0t1G2C/Dw=;
        b=lfG2ruePaBpsYv/GXfUqKlaPLliZCGJXjFEmyNlmytGD6mj38l6dIfrQoWt9LpuXG6
         iTB+94mZ8DgcjlY2RRT0yR/rHKlDX/peFM8dlnIkaYBrRvc6wKS3OM64C+1nPeG6or6P
         +j8CD4x91DP/GCQ8LJhJ8LnTrrlMfpYwySQSB+TC/yXmDRa1j7QIq7cAMYJe0Ikh4xif
         /aFx3y2hau2/aB86aNj3SHr0lg7WYTABYofw6+zPUJkGALAYOZI6dV9OkzJNhg1uCsCs
         T8c5XjjkCvoEVQGbL9AJ6kAVxIQFAgOWrr5t+VmMkQLtkYD8H+iH3U9R/YDVLlYITDoB
         xUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774670581; x=1775275381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B3Zdm9QRebXAcvnQwXWCkI4HeWD2IUP+mu0t1G2C/Dw=;
        b=oJI8Vh+N13K0Glvj+wJuSr0siS8PBe9PnbCenE2wWbguirakSN0/+POvz0vxEQ9BqN
         uB/xV79o6sK8JfdoJ7nqdD4e67I65YsEPEFXg6+q7KM8P96Ql/aEL1yM10sgf2+zU9su
         SLqLpZ3Dhsot0qnE+3jLj0PKxNJk3J0p3yRGhgPc1ZEFcIJsHBzEPiYHUw6VlIOQOPZQ
         IRN1kUCq3MxKpiFijSomZD1fz/IEMp55xqZUF3YBoRKPvY/Xb8TA/VU8lYkXcTJqqazz
         km7nWxQnPC9hYF7laVshL9dIUTq71lBOF9aWAtSl3cX54W6phvaLoJ5PndYDCEWpHcL3
         354Q==
X-Gm-Message-State: AOJu0Yz3ivV2IhBoe4en8zfDnJOjXH3/ynLsi8mBzdesNDP8WqZqRPhl
	wWVDPOhFlLgMFjP1Dva8cZ1eb867S7m0PE1K8zvZXvVaFfh8bNwSDhRtGNHwSw==
X-Gm-Gg: ATEYQzzJ8ECEZyMsAAxXbreWGjuet4AoBHfJ7ljR4WV1APghRSx787PdLBEs3qLTfb4
	1cbm7c8ODj2ag06ezUaPRVDXbrnIBKQX/E8zU1cBWwkr660ptNdyBqbze7VfY4G4Y/gqlcwJCan
	E6eH7wj9eSF56QcuOprf6fusbAiseXGYW0sTNubKjjhghYTmIhycdxXC4CiHidFgPgkxKjUkxRe
	XnMkwTjYNb+PkYcpKhvWnXPPlmwsmbhK8ZiNsbmRfMTo1FGM/cv/Bm1qanFbkWJ3j5LW3nC+lhF
	lnwClmqN93NnutgbUXmwH7zVxUSPqNCEczoSaVfx8xvotnTY0l9PhNXp16mKCG50/nd9kAzCVPk
	2LjEGSqEqUTq+PsqECfRPWAbHbJFA1/tY/gMm+H1CLeP75SGblidHh177DD9IjKeiEWZspL/4GS
	5NUuh/Z2PHR+7K9tYIJPcRHML/76Dyif97k+D8/qiPrf/OEE4+i8Q=
X-Received: by 2002:a17:902:fc48:b0:2b2:4029:d773 with SMTP id d9443c01a7336-2b24029dc6fmr23134875ad.22.1774670580723;
        Fri, 27 Mar 2026 21:03:00 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24264287csm9018315ad.3.2026.03.27.21.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 21:03:00 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: aethernet65535@gmail.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	sj@kernel.org
Subject: Re: (sashiko review) [RFC PATCH v6] mm/damon: add synchronous commit for commit_inputs
Date: Sat, 28 Mar 2026 12:02:56 +0800
Message-ID: <20260328040256.51726-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327071410.73642-1-aethernet65535@gmail.com>
References: <20260327071410.73642-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > +static int damon_lru_sort_commit_inputs_store(const char *val,
> > +		const struct kernel_param *kp)
> > +{
> > +	bool commit_inputs_request;
> >  	int err;
> > +	struct damon_call_control control = {
> > +		.fn = damon_lru_sort_commit_inputs_fn,
> > +		.repeat = false,
> 
> Undeclared fields are initialized to zero.  I don't think we need to explicitly
> set repeat here.

Agreed. This change can makes the code more clean.

> > +	return control.return_code;
> 
> Shouldn't we return err if it is not zero?

Correct, I've noticed that as well [1]. But thank you for reminding me
anyway.

> > --- a/mm/damon/reclaim.c
> > +++ b/mm/damon/reclaim.c
> 
> Same comments can be applied to changes for this file.

I will apply these changes in the next version. I will remove the RFC
tag because I believe the high-level design in now solid, and the
low-level details have been mostly addressed. :>

[1] https://lore.kernel.org/20260327071410.73642-1-aethernet65535@gmail.com

Best regards,
Rui Yan
