Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794887676;
	b=sh7FElHGsTy/G5A+z/HtLodMu+iSAUAx5GcgK+bvijAQprNm+lXVB2PYOnkj8J+i1mV0
	 bSfOoSFY27z55AXx3uRDKqHvmuFX3Bs2uaLSELrIz4dgfYdmGSeXl+fVu9FYyA5ML8o4g
	 FCpb16cN4oAaMw7mSAY3M5bPxN7yfbehfJs+sL0c6aJia8pQmhREXTkOJJWoT8NGnvxTz
	 wez92cEjVJRKGpTOAqgYTpjICN4fALH7Lk/jfrfIyA5Hm9r9XJT6aNbWaUao0uXvrGq/c
	 aUlaqJ9mHVdw2yYf3RstWxQ2H3l8yrO2JuqmaptwB4hiY3mqYnR6xGs7caqzD1RefoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794887676;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=5yYPPMuupwmdDkr+0YrNM2gwTmLnnxHM0lDOoH4/yWY=;
	b=GNOBdgNbRh9IFa0+c3ZGALQAl9wFufwpz4pzH/uO32hpcfLDp9YVd7lFwbRFOFBLWW4C
	 08K8f5DKe5X6jQNpqE86zet/LqV0ZBE7HyqkpQxdLbiq/HtNt/Qj1xv7dmW8moBYdHsqa
	 /Tl3U6p1zVOzt87ZD8Tdi8ITmOEhgs6O3xJaoIpU1o2b4ubtuP0NYCudwvfv9krPWlUDU
	 uVLVttOvhiiJzsHZr4xlsZ4Q2GCEyiy3ciAAX6gA5qQNduxI2WM9Qyx1kSSWLtI/r1ZQj
	 zVU7mfuiW1SDM9/mFiTfI8UAKG0SG+D6IgQj81Gzjf2tojBoY1xKRyKAMqEErtdnweA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WRBC4RqD;
	arc=none smtp.remote-ip=74.125.227.199
Received: from mail-pi2-f7.google.com (mail-pi2-f7.google.com [74.125.227.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C19606A31C
	for <damon@lists.linux.dev>; Tue, 17 Nov 2026 03:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7C19606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WRBC4RqD
Received: by mail-pi2-f7.google.com with SMTP id 41be03b00d2f7-cd66d7e32baso1026425a12.0
        for <damon@lists.linux.dev>; Mon, 16 Nov 2026 19:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794887675; x=1795492475; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5yYPPMuupwmdDkr+0YrNM2gwTmLnnxHM0lDOoH4/yWY=;
        b=WRBC4RqDfnYD5tK2FiQPOrzGPCLewdTfXiYnHLssCiVC/SADZakFd00H+hkeVL8bD1
         H9bWdHteryXdJESZ7b7di2rM/A1chkIaG0XB8fGU8Fx9tkPrtBJqJok5ChhT5Wwxegfd
         xfHoysS20DzP/B1ASLl3o4X08zVUU2EBcNprfBH58ARog8Ud2uvf7wBgdJdsmS8nL936
         6urDBBsawTTSclwP6YISodpkayX07cixDYMxHOsCM5GTD+Mj2+1/6iKhAJNO68mwGGuH
         I51VYMsfD6FwUaD/B9CQk8Aezyn8cksXGcnveOYWyIcn66pfVSIDVfO/Yl9QMWAB7S8a
         KeoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794887675; x=1795492475;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5yYPPMuupwmdDkr+0YrNM2gwTmLnnxHM0lDOoH4/yWY=;
        b=i5UUg2xjZO48NmhREWWCSnVgdNMftlBfE13lqcCzb/FWxq1xNKu6SIcegORqfhpM90
         +eR+eCCKdT9VIyyfA4SybP1kOsVRYUwQibO71K0obga7CeMGVNg5RswILuXztFN6I/kW
         Dvyqm2qjkMBxqOH7mjVy1ZwpNsOz40kCIsKTDyJ8LJQTcP8P19UaebN8Ja3T6nA+DSlF
         l6I2lzeWhEqmZkGucOJKJhPQveadbs8DO4ov1f4w0BHm+Ku6FxfEMWRk9RUsf06XrBVP
         xwYKQ2KYNRstntb8po/DjsQvASuG5OfJnL2d17FCc2VXy32UTTG8GlmUtLtkrQBg+em6
         j0kw==
X-Forwarded-Encrypted: i=1; AL+hErF6E2u8mi6WxipyBlNeKcPjanBQzxWtQDzT6Pka21WkaRAd7f2X9vURjQ8UTUQPgAyFuCHVcw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+t5NQffjblfG8N0cDHez/CRW6Yvrim22i6K9LUEyYbTksCu453
	+ep03ZjeQW8h5u89/+/0L3aV6RxO2n5e4INDCt5gVpVjl8ONI/NirBlf
X-Gm-Gg: AYBFou0dI/C/rGBt4QOzOjrr+LE91nSx6EvdN+qpYsp7w4isRU2AHTEzkpa9ElfE3DP
	cYVYaP5zr0+9nzAJn/HE4hx8icoqgokj5jeKVg+5M5m7VcEg7znQXQGY+8M9yQOVJpu7ZbxM5OS
	qpc7OfcTgNNwhYPZwWSmWQfvrB9J3HIqtTcZNVqXnORxuE7OTm27kXwRhM231La235JofPygqmC
	QBkeRXp6w6f6KWbbq6WZD4Zc8bnWpkp2Yd2B/eHZCFwYT3gjBB3ltigVI88k1Nv/Xkp2t76rPg2
	oe8bnQaY7wAgfPpyzMMCnu/uI9guvuayOF9gzOVZmnBD1E8NARQ0T2MXqY2pOikg0xppi1GjS3G
	DK2/8spgD8/rMZPmI2Mw2LirQgd1tWA3lpgTI+iSMwyXPEwxukcDfMM8cSxVSGoVg2ulYCSUzhA
	zVyUoJ9CEJg0V2ZN93V4Ie6XiuOsVdisD1Q2e7zH5c3qZVzMAJ+xWdoXP+5WAQumUcTZa7/ueVl
	lNaubRQuRsMkloJoRN3hSZyLPMMx6IuboePlNNYHyPaEbXY9F4cJklmHYPjX2FfoajCGtzr2Ax9
	/OBRDd8vOB5fHRg70xZnbzBR90G6SmSxRk6o2ABd0kqvRTtD7NLHMRM4Jw9OMMAcWCZzznQaIwl
	ME8EqkAM5E4WbGeMMy/QbrbhESqzJigI/SkV+R6eBnzxMCykH2mSW4vQ8WmaVXg==
X-Received: by 2002:a05:6a00:bb8c:b0:883:904e:da56 with SMTP id d2e1a72fcca58-8beb677fb7cmr12261080b3a.36.1794887675077;
        Mon, 16 Nov 2026 19:54:35 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed263649esm4319559b3a.45.2026.11.16.19.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 19:54:33 -0800 (PST)
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
Subject: Re: [PATCH 3/6] mm/damon/tests/core-kunit: test
 sz_ops_filter_passed_last
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 17 Nov 2026 14:49:05 +1100
Message-Id: <179488734513.2.6285120857568566018.b4-reply@b4>
To: mattathias.pinchover@uber.com
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, damon@lists.linux.dev, 
 Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Randy Dunlap <rdunlap@infradead.org>, sashiko-bot@kernel.org, 
 sashiko-reviews@lists.linux.dev, SJ Park <sj@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261116-damon-sz-ops-b4-v1-3-1cffe7227e6d@uber.com>
References: <20261116-damon-sz-ops-b4-v1-0-1cffe7227e6d@uber.com>
 <20261116-damon-sz-ops-b4-v1-3-1cffe7227e6d@uber.com>
X-Mailer: b4 0.16.0

Hi Mattathias,

On Mon, 16 Nov 2026 19:10:06 +0000 Mattathias Pinchover via B4 Relay wrote:

> Add a kunit test for the sz_ops_filter_passed_last DAMOS stat.

Since the motivation mentions contexts with multiple targets, maybe we
could also cover two targets in the same context, with the stub returning
different sizes for each? Checking their sum, then changing the sizes for
the next interval, would verify both aggregation across targets and that
the value only includes the latest interval.

Thanks,
Aveline Noir
