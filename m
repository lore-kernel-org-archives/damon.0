Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794679838;
	b=jT6WXjWzpPPJWML3g1fasXMFQJSPsuK4Yk4TjUZ6Y4yCXmLPAgN6fIvH84sCjr1WTrzA
	 0zjju9299N+00bPY21pttI2VqABJshzAQ0MjFO5G8Ij0IFV/lFkB/l+dsyi6ezPVdfqpP
	 O8RKM42QRxe8WrpS2I+yK8hL0FNdqWRGowpJpGNAagpRg7UzEBQfcCG3YXunoJNV2phUW
	 1RJ4VO+g4VfzlRQTUFKmXjIM0fbssVdRniBEJCxt4J4Iq2OnVtIH6AHAstdp2lFeCqzpe
	 mxhAp1uhczrYcfV0kXU6OTVsj5PcDWhkiaPAQsmloPIZXlsADl1zYlOShGSljSXtZHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794679838;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2tV4PJFJAVwFY0+x5FVmRJ66Mz8ksU1cklE+L0oAwR0=;
	b=nIzMqPSVJ702G3o1QccAu+AUqgBA+invdESCiN++c42egruKVOF0ialZVd4fNZLO1Hg9
	 /uGpL/myoOk2rVSqUO1kIKioBkBmzgio7aeA2Zd+SEeWpFX9pvJX1GHzYeX2ZAKex2oTN
	 GCog7KBHFgqYcso53Wea+RhaQQsQJO0BH6pjg9/dWt4kLk8+yn/FVWpXzeTyGhjQa2Svh
	 ztkRzWMWgkiumRVWaTP8WbG4uO/b8v1xJqCohafog2xRKni2li7oDBH8RE2DyvSvZ5FQI
	 6qPbnKg7LHfq7htiGHDZo6tHAVALN/CkWVL7QuHu591BNOFxlEHxKURyx5Y7d3Q9EMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wGsDC7YE;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A31606A32D
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 18:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36A31606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wGsDC7YE
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso12238975e9.2
        for <damon@lists.linux.dev>; Sat, 14 Nov 2026 10:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794679836; x=1795284636; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2tV4PJFJAVwFY0+x5FVmRJ66Mz8ksU1cklE+L0oAwR0=;
        b=wGsDC7YEiarre1DZuaw6B7KRtFEBZIcSLptdv6z5vOqVgFRiB4Y1+sQcGXrwqmbbis
         GKi4kFW85gfLSJhie7VRJi2tMRw4sTxtdNsQ0eWPdrrqEa8CpHfEWkQ4b+iKv0tP0wjP
         8QU5G2PaMeE6roK8QcjhuF3a1VM8NTS9zGifDavZ/EdNFejSz65DGlzf7jj+tMkYdfsd
         lgoHjLijRRZ0W+oAJpK2EKW35uQaIpkkLF61sHAyHXxV8IoZyEMXGHmv2F//MWMPE36p
         Y2+VE3Cvne/CkJ7DjAlv3au1g0FfQ8ifubtiDh/Kdon8lXLj8gCiAvnStIptDA+Th6+9
         B7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794679836; x=1795284636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2tV4PJFJAVwFY0+x5FVmRJ66Mz8ksU1cklE+L0oAwR0=;
        b=jSQ7v19D363QLqpWGqRAOj+2SgOecuvuRiaNIou6ghFhQISy6fUFiubbx15AtkXc31
         bZX0SrgAnwleDgiaZrVA9IOb3nM4ZD2IeRUpWykZbQG8MpdwK3HK7tX+Qwui3V1xMpYh
         osr5m6Rh8iZ/5VKqNPXPuC3A9kw30CyULA/4wxpA2Tk5OyNqpVRoh4tWNV1g/OeO3006
         SrmxGfTL/HuBRNg/aRuIZ6idBRgARln/MeAHnuUWyHNJlposUEDHHgPI+Wx4LQMkZgJ/
         phlLndrJDp1o1/KVXF6tYX9bp+sw+t9rvjhg4r7YsEMLa7xuzWb6blVH0iFpGYhlrtWe
         og7w==
X-Forwarded-Encrypted: i=1; AL+hErHMzOxJmvdMah20o9puWK2AhLmz5EJf91042Ve/GwVEaPfvYy3sYxsrpqc2ArDUKzZdDWKpbw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8n2pWZpjs5ckHtoyrhh/XxrGKNKEF6NhJRkLutDzkgCFBn6cDk
	l7fK5wYbw0dzw/8ZaiqQV4GGnE0yDmSe6DhDQ1iB44u8q62OGlq6c3kk
X-Gm-Gg: AYBFou0Iz/cgYRyDAHaow46gm80sNuTBsSw5+rNsDwOGAN641A4KghpcnHFGw51dNhM
	BXI3k/3HobKhA05Yxltvzavvg1cn1ldVCnVU41qp4XvQZklc2vRBHLOOU9mWLbZAgz358OlGTaC
	5hb3WCkpcow5YoWH6OCPnL4OC7OjbzlzgDGjy0m1v5mBDXt3mbqPv957oBECZaJiWNkXsTO7G1f
	OqTNyy/LZ6jLdWq95XVlJ3b71vxm1rdgiQz6r/b4EysXEA2i0v9K7VBRf8g9M++JbS7daWpYgef
	XfFCiIaKGAKmdAiP5i/mhxvi2nAUhXB3tT9LtlEpO3JxBtilMcR59VbCs7AVC5C5xTo2vH8JXju
	28kESoSBt4OhmnrRKbFinq7RoCfmKruCUUVIysogkMFppc4T25FNb1f419ZvE8lPgjq0Ii3JYly
	bHTRALkeKehfCJ6cu+SfF+BuReVnsO3JmB5beY6gg7HrV2L0FZeRoufRABhmjWUX7Fi6jr7ck4e
	xP2IZRmcWJubPrGHC1JWqGtPeYP+dFWQ46dCPC2cHQtqTfZupE/4SHQpEA5xPOsoJNg1U0y0ecr
	jGn39POCcT3CgjCkRKp3WvrKqqW/1hvWwJlLRxOzJhN5TZWrxH6u7WYtSj6Uv3oKsRaw+ByR7Wu
	OHQ5ixU95bpNVPDkPCJsTZL7vpJ1QDQnQ7/Y=
X-Received: by 2002:a05:600c:4715:b0:4b7:6b0a:a2f6 with SMTP id 5b1f17b1804b1-4bb55a963ecmr125366935e9.21.1794679836134;
        Sat, 14 Nov 2026 10:10:36 -0800 (PST)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c605e5b2fsm12637227f8f.40.2026.11.14.10.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 10:10:35 -0800 (PST)
From: David Carlier <devnexen@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Aveline Noir <jm5905938@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] mm/damon/stat: avoid 32-bit overflow in idle percentiles
Date: Sat, 14 Nov 2026 18:10:34 +0000
Message-ID: <20261114181034.2665113-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102150757.93058-5-sj@kernel.org>
References: <20261102150757.93058-5-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SJ, Aveline,

The value stored a few lines below has the same problem on 32-bit:

	damon_stat_idletime(region) *
	(long)c->attrs.aggr_interval / USEC_PER_MSEC;

The product is the region's idle time in microseconds, held in a 32-bit
long, so it wraps once a region has been idle for more than about 36
minutes, whatever the intervals are. The cold-end percentiles then come
out negative or wrong. Doing the multiply in s64 with div_s64() would
keep the sign and avoid it.

Hope it helps !
