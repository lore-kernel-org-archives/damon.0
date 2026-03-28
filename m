Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C597B1F5858
	for <damon@lists.linux.dev>; Sat, 28 Mar 2026 04:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774670624; cv=none; b=UUsaqSX+NqfzMOO3Q6Q9rUkqwxujqzqfdSWQnAWrMhHa7dazwD6cK8kO6cYOrkQSNOy04INBGAB34gq9+B115T1Js60qfuA5OsXEoBmdMbVC3kPeL4X/EVsSD+NkkIl0kBiETgTb2sk66cMi6NteNYOWIzfDsbVdER9PJquHwiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774670624; c=relaxed/simple;
	bh=DBRSlAY/HawsMqi0mOD4MXCCGjAHhHaZXpBEMCG6DfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J20CJ4dbGbF3M42dcLECzBNW2k3H582/rHzo5LvNs7eiLHg34035fcBqNmOgWrsYLzTEw0kHe3ULqKn5VqPpFZBicXBlLkSML8yzH6aDGnFqGZfMe8ydVbl2fmzcZyzdkPM1j2NNeDu4uIsTNDjJ18DWnhHqAt5cWX31UUptM9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFXfIeKc; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFXfIeKc"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35a1cc6e478so1649936a91.0
        for <damon@lists.linux.dev>; Fri, 27 Mar 2026 21:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774670623; x=1775275423; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3Zdm9QRebXAcvnQwXWCkI4HeWD2IUP+mu0t1G2C/Dw=;
        b=ZFXfIeKcfI0Sq8/UA2ZFQuPHO1xAsUL7o+qTRRSOYxUG49cDfROh/qmxKjiscchAqm
         wul7/U+sdXWC1mDbP8HdM7S659K+255+pV+IJU+W6pae3K4R027JZym/kkLdWu6x0B52
         RfHH+VY0t4cnroPSZMIVVdEG9J9AmsFD8fio9R/TcrHSAa3SVQywOREfbLDJAQtuFc9C
         abylaFGxOGXpAMmqki9Kwc0u0kVsbigjZaEZfOgmGtyA/pZvtBOsF4KcL92OEQr09uCj
         MyxBJVIRBYxKnH0A/yg38ALlzMuO7aVM63CEwZrkCr87GzEfmsmJSfHIsG3bz4yeB6Yv
         70BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774670623; x=1775275423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B3Zdm9QRebXAcvnQwXWCkI4HeWD2IUP+mu0t1G2C/Dw=;
        b=JH2NbSSHkUv6o12M4HGdBkSCyqxeNu32Kd/7eL3Qu1i9rQT5A/EHLi48bfTxiKHA/U
         b8xYi0l0hJZdbD96wPXYoyr4CwJAWr8G5qm0ZHFgu4S6E17kFrBAz2P/iVYjdtPPSKRF
         MKjJqK803uog6O0lYsHARllvHcYLtiIIwl0heZ1eFszzjwv3Nrpj+QpT5joXk01fQr/B
         m5xCHD53Ekx5VwwGgGdyru5Ki0TYJlXL/1fRvrkRcK5a56mtRp68BXKtTJ50ZHdJClsI
         vpd37Ew3yLlLW7qSk0lQVfvbWgyI98APPqSFTzSxkCI++yPyHXICf6woo9FJbxGuHDWP
         AKgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrNOr8Dl4O9OA0Q8N5m8OCtoGberBraNIa+I+qE1fL5p+NnjXoR8AB9Cp24Io0OXTNnKulLQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzptZebCTnpRgj97aq+esiDW/vxD8U7nN7FU0AP8TcwrZVcYCiy
	Qj8ASC82tGdMm7Qj+SxTjHUDoNMn52lhsQiz03wepUfnOBHDQZHw/vDR
X-Gm-Gg: ATEYQzzYJlUKKOBw7AowBGkh4t/6Eb1iSfLkb6Q+0yHRrt/MQ3R1R1ebXFlU6WalLkl
	+jvNIiLAQhsEvrCWDrlA5vH8hj3Q3ld0KeR0G6moz05x7Q+3d4TvIyFSlD+3vhMLDplCVBCC2/I
	nE6p6i2yDeObinZ2yfltNzk7z0bGWa1jnvqjgMdg2uqy+oSwhVo9+xXpqks520q1lZO+1kZRn0a
	mKo8uzWyr3NUYqvvzJx/1vg2wvTLQZNy0PRAIzRDffkrMHlKq9XZY0VsetErlRzg8MmVTperDZF
	oH18wDtHZikBS/Cfotu36KkjBt3w3T1tftFB2J/WJprMT+qxZElUUbj6UZEtN7bD6Op3Wb54XSk
	xFKV1hdghsKtt4PVXbGVQAPtbs2WBZxejjMrnHCrDqTkiOGTnefqJMSzUGVy7HQxXg2bEtLDvdM
	oBrd1UoXJQBrqhKr4xaz91NQJnwssUeJq5deiQjp6F0KYu1aLWIfc=
X-Received: by 2002:a17:90b:2e83:b0:35b:93d8:6aaf with SMTP id 98e67ed59e1d1-35c3005589fmr4818265a91.19.1774670622949;
        Fri, 27 Mar 2026 21:03:42 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d9509cf33sm621254a91.13.2026.03.27.21.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 21:03:42 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v6] mm/damon: add synchronous commit for commit_inputs
Date: Sat, 28 Mar 2026 12:03:39 +0800
Message-ID: <20260328040339.51871-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327135939.4085-1-sj@kernel.org>
References: <20260327135939.4085-1-sj@kernel.org>
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
