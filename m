Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8747824468B
	for <damon@lists.linux.dev>; Mon, 30 Mar 2026 06:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774850935; cv=none; b=mRTlB6Gj19tF4/+PvOJd+OgRcUXQFm2xb8psW17d+7vIY41FxFaRg0Fvwyyr945oLluUQI7HtbtvD+5rU1MfFDO2MJjOJ1lcN1WUqkc/3gWFtj159m5T9dzZt8X2oWQZRclYVWkBD3ITrd/UkevwrT77q8sCiHxqBsx51h/GBvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774850935; c=relaxed/simple;
	bh=BatnoV3M3K5XyLDYoIbOmPBB95cXdpk9g5TT82uzbpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opJ6iI8hTOYglU1Wff4Ha8Y72qtWy/FjOxb33YsFjrdInRZsIY40owOn+RL4zJm3FRLC5IexYOxvKfjRuoEmmsPr6Xo8tx7ry4Na93PPWEHTcS1F0Dc87RdJLO+6fPw5YsSPEnvGSQ0oNNl3m5wxTjWln1s3oIwc0PUVfKY3OzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTb+lO1m; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTb+lO1m"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35da9692ec3so387574a91.1
        for <damon@lists.linux.dev>; Sun, 29 Mar 2026 23:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774850934; x=1775455734; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYECvkLYIdqO7PMq8pUGmPwH0CV33XwnM84wxRtZNC0=;
        b=NTb+lO1mbYeCApfquesucc3mGpNuOrbQpvpoBirfNIZ6dCU6ZBnQklKlCQYpmtjto8
         2KyjUNKbEsSVixq2tR1GzbHdHGtbBxagmTrUpjiz7kfwHBHmHgjr3CYpjhKZScIrPMj1
         3yfpUD72n1O4xWwNl/Q4WU2T6av8VH0Df8Rq7ykhwGWk2jxhWNSugRFEaANsW5R2ANvy
         +S2PCsUPwvyfeERWnHF9FRQ4tgW6uBrwi9lBoh1Nt8L20JH4GDH9FI+YwPu93Q20Ipww
         ElVc8SEb+asb7akcjDbjn/vq3GITcHV49f8fkapG81HWEqKLMvkA5ciUYH1iVwRGNucR
         KiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774850934; x=1775455734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AYECvkLYIdqO7PMq8pUGmPwH0CV33XwnM84wxRtZNC0=;
        b=h4OqxVQNgg3oMo5v/lYSkV6JYKMH8WuMVfTh3edJGt2RLJt8I8x2grC2KsFineavPW
         b0fnk+ZV543kE4IZxLGAp8JdBhf7aSKNvvUEmCKe/DoeEGXfE+/QxaTj9Zf88jnpxqKA
         2T2bPkezn/nA/kCKiRsZmj9eZqGRLs1tjtP4siuFW89PJQTlx/YzPrqkY3v5/ou3pWmP
         8tUEjXibCC75Eoy0kH9N89TwijgjwUP7hMDpRCgrJido7CUAc9TAmtIcNGdgGSKZBkzQ
         dIBC7ur2o5vvrsB/r33RVFsvJezViaYP4/DisMyoFWwOUAZbNrn3V42Uup5fAkY4oD/Q
         tddA==
X-Forwarded-Encrypted: i=1; AJvYcCVmFUgixCHz9njIKho2ujcTbfAIr5vcr9xpMTWGFsgfekaC5B5ndeKvarOZalBUvIpE7/3KQA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwG+7RZdubfsr58YqQjbFKzVUAP0F65hFp63cSgHpI544ratk5Y
	zxi3awjNQMy7+TrouEVS3MyyYcJy02tno70oKw0Ug2ulO8AutZO/1jLw
X-Gm-Gg: ATEYQzwHuIXYpmE7I8DGK5CQE9NGr3F1H4+fnHcm8PkpIeoGSnRnyl1TBHGvK8gwgPA
	Wi/yJ7eIKKaxmUhkoMQMGzYL8BnJILACwZiTAGM7+nbjSRXTShqJ6SbQ1o9PpCTKcW1VSdnlCT0
	O2tu6YLZdeub8JUQH15Urng2IJk5um9pSSdC3d2h//mNPDckuLqo4IsAJpbyudp3+m8jZby0aGU
	lMv7Bi8vVgYZ90gd3acL6Qn5+70nxjYyVKZoHjotwI9oYdLa8BRV/xn12xqKQ9iZko2BaDSN2JB
	WGnJpd71RPoOWPV2nycRbMNe5tMb8TUTaBVDRrDpxhE0sfKCJq3nQi9l3T4L7KQQcYTFKat/B1x
	U5OGccQCmCsw7nLQQqvedPx+aUIJtLrJmNc3eem1BWFnrq5u2pb1IhFwnsYcKA4P1E0bEwdx+lW
	5N/+jiY7Nl5wD8PpAxiYd+oUbHejNtr+zVfo/uqaC3iFhDTrSaG2o=
X-Received: by 2002:a17:90b:2d86:b0:35d:a3b4:2f00 with SMTP id 98e67ed59e1d1-35da3b4314bmr3334498a91.8.1774850933713;
        Sun, 29 Mar 2026 23:08:53 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d950b5583sm5840224a91.14.2026.03.29.23.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 23:08:53 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: validate addr_unit to be power of 2
Date: Mon, 30 Mar 2026 14:08:51 +0800
Message-ID: <20260330060851.4659-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329151507.44171-1-sj@kernel.org>
References: <20260329151507.44171-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SeongJae,

On Sun, 29 Mar 2026 08:15:07 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Sun, 29 Mar 2026 15:51:07 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> [...]
> > To confirm, are you suggesting something like the first approach [1]?
> > 
> >     if (input_addr_unit < PAGE_SIZE && !is_power_of_2(input_addr_unit))
> >         return -EINVAL;
> 
> Yes.  But the real constraint is min_region_sz, so testing it would be more
> simple and effective.  E.g.,
> 
> 	if (!is_power_of_2(param_ctx->min_region_sz))
> 		return -EINVAL;
> > 
> > [1] https://lore.kernel.org/20260325071709.9699-1-aethernet65535@gmail.com

Thank you for the example.

The 'param_ctx' you mentioned confused me for a moment, as it doesn't
exist in the current addr_unit_store(). But I assume you are suggesting
that we should validate the result of 'min_region_sz' rather than the
'addr_unit' itself, and this check should happen within the
addr_unit_store() callback.

So, would something like this in addr_uint_store() be what you expect?

    if (!input_addr_unit)
        return -EINVAL;

    min_region_sz = max(PAGE_SIZE / input_addr_unit, 1);
    if (!is_power_of_2(min_region_sz))
        return -EINVAL;

This keeps the fix local to the modules, and directly enforces the
power-of-2 constraint on the actual monitoring granularity.

Best regards,
Rui Yan
