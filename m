Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455419;
	b=fPNaV4Gfi2ttcHNvmDTGIl2iF7TNZ6W/wXDmH+iM+6/KNArBMux9L0XEZuQzpzZrjMo3
	 /gRe5JkgaqHSf3FhjgM2bBgI3TBqYxPM3Pr6K01hq9Fmgsq74AquxBEzLRHps6tFA7vrH
	 P21LwXbOLYkNEtYUfiSvsgtRzg+vxPe/GaArKQEqQYmig9SLLxJi2ZZQK3OV+LwNlpss+
	 X1NNnH5QGXIZ4GaYbHw9gUhl373ogoadTodTJdcKSg6B/sK/YXzkzCGEmUAPygHtSLsUC
	 D487UK8OLdGnmYKtwVs3/X1Gie0bm7QYIS12xl8y4PGfk05DaqKIRBqOKIU07bpPR5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455419;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=bgTsp/DxzVnpN2p0duzzJ5EXBBoNw1MgnrXgm0rl4OM=;
	b=DCqqvoTWy8oPbfZfLr0+ZKX37p3JYiQLMKRXgUrWHszhoei+RQTVsFVc1/T0a3hDCvAZ
	 OkBtQGlyYb11V3frc1kmWmeWGGgXwb0HQy14tL1t9GFDqsJkfXR9wOOU8qQIomDGAsLOt
	 40iQLGUKTHTBXm59E0zIbp1HsIwjxg1e+tUqoBIiyRdTJpoMqrFxpqD1z6aixL+I10bo4
	 Bv7Cews+OhzhNOZ7g74U3jjQMmmfUTFaqCezwWb73+Fus8MIqCZcQFxPMRSsSgfAhor+B
	 6dVx5EKKqDE6Vt2YNiv4t+NZImoDY6HhrGmoEHbvEl4ZtR8+UPahxr1giT33ZaMnTNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z4lfKq5H;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DDA606A33F
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 17:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16DDA606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z4lfKq5H
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-3831d564bcfso1418876eec.1
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 09:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795455416; x=1796060216; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bgTsp/DxzVnpN2p0duzzJ5EXBBoNw1MgnrXgm0rl4OM=;
        b=z4lfKq5HshpsAYaIOsm+FTfr8XZHCj+En2sOL245RAb1CelXX9/opiw04bMse9I2Pm
         O+taY+Mfxk6jNRt7VkCWy/HmnGqFQe3jNGxzrLQCGLSE/iURnvWuWEaGrzFo1P1vwv7Z
         6gsX2mw4myv6dZx7UFVcpDxdMfh8SnMtLGT80UHRCldESHpro/d6rDNqIrOP9sfFnBXx
         2uzUNKCd9E9gvecgOsJYbpcdWTuOJ735PzKqQE2qiYhWp9PXh6oKNSW4ilkDUD/mMaGv
         l3nfMjrd5+fe98s2wIKEgjeUR2imgDcBt/4u/eaoEWy+tYK5DdNW67Rzv2FM7XVcgKmp
         J8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455416; x=1796060216;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bgTsp/DxzVnpN2p0duzzJ5EXBBoNw1MgnrXgm0rl4OM=;
        b=w6a8KG62eKCp21vnjsrFc9AtoEIikTXDQBIQXXg+YkLpAGX0lgTX0djbHSlEZ5jgLu
         qfbQMC1OjVJXhIPt0VDoDDrW5yPlmnCO8Ez9IDWX7BmjOGeGH4ZjvYsduRKidR5/X0qG
         /VFCHjHbAqYXcDyWRtyJKptIW+nduUJo9nD2mye8tlxq7nqQ81YHI8G91IL5VbVKn0IO
         Ei4hNtmTC8VKjzpfmNVNqaiU9VvtiFXlso6xhQFhwzk00qqtrrW0UXcEAgJ/Rm5Ixlds
         jwZBwfRUg0Zz0rfMSE0B4S0e1RKfbGQJADT6j+eWQfI6cykHHyuzDaA/OPw/uSFzmHVo
         RDaA==
X-Forwarded-Encrypted: i=1; AL+hErGwPxcDsHOtXuy7Zu8WoJBlZY9MJTIXtTDJDKaZB4heDtMzQCPf1SV6uQE1rbDdJfc4ymWHiA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9j22jJab5wnyT1fMY7c0JEAcSF6gM4abqnWxtXi9AdnwDw4dHD
	aFtjDf34OvFo0ItWMGBOiQC4KMx+CLUf6r/cFd/GBu9auwZby9QkXpm+
X-Gm-Gg: AZFdTZfdSnRwp1Uy+hF9AdVmQrkcDTAzma1e7zKeBFgG1SadGmneJU4U1ZXwVNxRpGp
	11WizmgR7T0itdXredp9OqeUH32MOviV4zUzkyxh0vWULPzytggYaBqom9WdSSwQsCquCmoYd10
	LC0h3aelDnSh8SfeaJTl6kAv4rT2wxUT5kP1B2IybQFFG8nrZ26brji1esTGv+6/GZa6icnhnq+
	j9Hu/QK7xEzZjXnnpe4LvQI8rZdl5OO1v57KfJCtGtvjHvK79Slprf5s3HU8vDeXthGK084gg+G
	gozo6eSA/Co+VUhoPLTdN2xuzNrTl3XcMQKvBsxiVzS6EWVfB60X8lySLpV7GOkCM6SUcMx88WR
	kVBZKiZ0JSCS3pMi/g+Rq8O3pBo/+xUbzeEaUAaO+3i44ZikCJTN2Ua3D9fpsQQrTWaVoR4cf3G
	53cpeoYKh61iiKBETixfEB/50qEqjIFb7XWTENlFwfQOiWMJ1uQyckuhXaJxPs4ZQoJpvLDlBFI
	0ZUsYfEClR93lj9h7Y33hKStnvg3+atjv+iOHnzsDBGtcHQ0ctGF6pvPf6DtPyfljb8JrpfZPeC
	6/PIBD6VcGHwMMm+S6Ru/KAuIz9ngRFbFMAlT2uly1RCT3Sac2j0M7g/tVsvCt75DoNdB5I2V3o
	qbW7M/ZKn0xk090cu/U2+SwhCQXGvAmM+fZcpigus9iM0u9Dq3bPXw1nQ3W1FRQ==
X-Received: by 2002:a05:693c:42d9:b0:386:bc40:1508 with SMTP id 5a478bee46e88-386bc40185bmr746802eec.14.1795455416017;
        Mon, 23 Nov 2026 09:36:56 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm31532302eec.25.2026.11.23.09.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:36:55 -0800 (PST)
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
Subject: Re: [PATCH 12/27] mm/damon/core: introduce
 DAMON_FILTER_TYPE_REPORT_MADE
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 24 Nov 2026 03:49:25 +1100
Message-Id: <179545256509.4.9812891949286022161.b4-reply@b4>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
 Lian Wang <lianux.mm@gmail.com>, linux-mm@kvack.org
In-Reply-To: <20261121210013.130397-13-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
 <20261121210013.130397-13-sj@kernel.org>
X-Mailer: b4 0.16.0

Hi SJ,

On Sat, 21 Nov 2026 12:59:56 -0800 SJ Park wrote:

> Extend DAMON probe filter for the existence of data attribute reports
> for the probing memory.  Define a new filter type, REPORT_MADE, for the
> purpose.  Add a union argument for specifying the type of the reports
> for the filter.  Update the new argument for the new type when new
> filter parameters of the type are committed.

LGTM, thanks.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
