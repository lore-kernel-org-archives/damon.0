Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455435;
	b=iqDun8U8edfOfIcChSyecckHvRtz0wb/LCcjCTp2AjYjByPlDkNn9akxcAPCytnUg3DE
	 8CvxSYIDTnkZQuUXhpNtsQXI++I8EfLc19IJ2V5pnTLtAQV2cEg5ogpz+1uL7GI7ysPL8
	 9qBURS2a3PwMh1ST9M7mpH6hPGC2ch8UwO5ncmJIHSUuRmhcqwniX5pNmSaYIcGtjmTLA
	 9kla+iDvuW0UIZBpa+fgsWh35QiO7OpwQXubviPw0xECn3nn1pBQk7JPlnnxw+mY6JFXQ
	 itpJ1UxyjNc8SElNyBmEoUH/iIm7OF+/cEgD0WPTKcdciV//WiQu36JsZ+sd0jKEUbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=om/YY5kZeKIylMMbicCgla2f6oKdp4uIwLCHt/pWIM0=;
	b=RpA5tHXI7J7MUKrkbszKtwTPTRaUVOfi4xBOrv7fTgEc7wpjnbgFKtj9RGqelKzAJyOw
	 777hJRNb+8tso4KFuHV7AWsj7uK7z3VVNhhh9z2hhNpsx5cBC+nM05NFTvY191adCJRYx
	 DTTx9+eZItQlEAiiwMwQpvNwJ6zYOk/FwFtdxSo3Udz2f6gfcC2ROYZEYVFdaHVQBRhP3
	 uCaq9dYLMiuXgDeldC6QIVA9GL8ZlWcF0IA2GkecKWFniMYi5THTGEsfLmU36UpNaoMYb
	 Nl04d2AVZPAyEXccSi8gSSaebRGf3OKogFEjtUZx0O8X5bnpKfuQ/T2GwjVpo/XMxCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E3Z+4bFZ;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE911606A31E
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 17:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE911606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E3Z+4bFZ
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-36a6ce64b95so1376012eec.1
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 09:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795455434; x=1796060234; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=om/YY5kZeKIylMMbicCgla2f6oKdp4uIwLCHt/pWIM0=;
        b=E3Z+4bFZPsgdlH8l6FX8SmpaaIUtA8IIbiwJdY+f1uq19mT8HSG82w4/0zKtKBYbh7
         hdcj16sim9uwcFO44U36vKS8tAOQqrpuBl5tqyDNULWtasSNq84n+/+Km5JGWPnOeQm8
         ApzxF1QI3fCgigPaW0vvEQXlc0BL9K8wf2tiI0UH+ErmUA1fRr10gFZ/IdCylgQuHB0L
         ctDYAqdoi9MICSxPHQJH+IaFxQKt/dgXWUo1DIZarNJ8nr7An8hlnLnAWOmwruPF1u/6
         t2n4rAxtrgdmndbJMUSMUj3/kLPMmONgeATs9mkQx12gy6p5RHJuMVCQEGF6kd2WZz4P
         rePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455434; x=1796060234;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=om/YY5kZeKIylMMbicCgla2f6oKdp4uIwLCHt/pWIM0=;
        b=sd15jBpwhHpkqxhgpktMMnREH2X/ysDC3QaFgRbmn70V0s911PK/6ZVLAKwyuREDN0
         FaMscLClwIpQRMxsQhlZDIIfIFMhXkD2ikE3Hveg8n8gX0TyVGMQtWNV0tWh08Z+WFG7
         TI7qFUE4JwT7cKrFKR13vIOuSmjf+aJYqVe0W/C0B9UMYtRPId2aPrYAhL/RF9vOcEdt
         G4o1ESEcwrJY12+6jkOCCGjKjdfwBE6OZ4ARA+3dYTuR4ZcmyqsNghwyTfyll7xuSVZa
         0fJB06l6QH0635TeKXaa5BMls+ssfx6USQbikVwPGaNkvo9ggmehf957JDUm6k5i1sr9
         hNyA==
X-Forwarded-Encrypted: i=1; AL+hErGnca25qWAEAT/WtP56JHztvf7QzsBo3+bQlg98b9dkgpXwipjQOoD6RvhbGoNvzNpL/B9iVQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+nmzjvPAvHE9uQh8Jzv9+1D9y1PZuCZqXM5VqlkcPt49PNNIi0
	MYopbgWmkzMlYr0pJUeeRvS8y6yasU2AfFS1K9vxjotbfcH+AHVqhLrd
X-Gm-Gg: AZFdTZcklzFzr02gczOMHX9oc+Exus/rsbF4qPrViaBQAncdB/u40+hE28FzB37j2c0
	F+QBIpzssCfAYCusq/CpKVD0WwzcCcqHeMtAB6Lkc1YzSKVirtUvRAqI78QYN4kncWqUdcYLn7r
	EovYdWNoULn7vlsXwCO7R92PLCxYRyFE8dYIUKKaHQAJRGeePLMOCxWMkZUcfu0kLUl+cql1erb
	rX4aafGXrTR08OeZydL5pOevW7PURPGy4kD2zoRDUfzC1cxajZP3GtNQIuKwj4EcE4l7ucp4Lup
	J+4TcDkBFLeqK8vO/Mw324CmXKmg+MIB3xhjD7X8P5TWwzMUoU7/sklTf+l4AGT/BLnbEwaVtxQ
	clVGPjf4ShHo5epEEOEZKI0TIsU9HZ6J/A2760KlvVn5Wzv6AnBuLu4FazcGDrt2AxSiWMf47KO
	OfGUqmoNG5g66KQFm789c+1wWelNxi7q58qIQlsyE2xahusFILSC7Kdx7wkHnQblfRDGH/1/3XN
	8p1PvjEKeS5XFZc2gev1K2o92n/kKQAtj7vBA8+RZ/mH8jyeLfpbz6zC7PEQ45x0R/i54PoAJHW
	JKiaZd/L2IygZAahDCAZccPfFD271JOFtFeU2jGixMXsbBXqvdnze21y9u1MlZ3XNzn2dWsRqxO
	PXvgMW9ecWHoXD2A/zeu6esrvTPwyu+idT6qW27XkJj6dd7Hj3L1BJMHRKqliXg==
X-Received: by 2002:a05:7300:2202:b0:36a:1e9e:ae61 with SMTP id 5a478bee46e88-3857170afa1mr18197276eec.38.1795455433928;
        Mon, 23 Nov 2026 09:37:13 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm31532302eec.25.2026.11.23.09.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:37:13 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 14/27] mm/damon/paddr: support REPORT_MADE type probe
 filter
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 24 Nov 2026 04:00:26 +1100
Message-Id: <179545322647.4.683470932650691650.b4-reply@b4>
To: Lian Wang <lianux.mm@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
 linux-mm@kvack.org, sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev, 
 SJ Park <sj@kernel.org>
In-Reply-To: <20261123120009.9120-1-lianux.mm@gmail.com>
References: <sashiko-outbox-227387@kernel.org>
 <20261121211922.131352-1-sj@kernel.org>
 <20261123120009.9120-1-lianux.mm@gmail.com>
X-Mailer: b4 0.16.0

Hi Lian and SJ,

On Mon, 23 Nov 2026 20:00:02 +0800 Lian Wang wrote:

>  		addr_range.start = damon_pa_core_addr(pa, ctx->addr_unit);
> -		addr_range.end = damon_pa_core_addr(pa + 1, ctx->addr_unit);
> +		addr_range.end = addr_range.start + 1;

With this conversion, each paddr context looks up reports in its own
addr_unit. Producers submit to one global queue, so two contexts with
different addr_unit values can interpret the same report as referring
to different physical ranges.

Could we define a common address unit for reports and document it for
addr_start and addr_end?

Thanks,
Aveline Noir
