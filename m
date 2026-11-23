Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455473;
	b=B9mqaesyFJz9UszzcJyAHyF8q8Z1DQ40jFOeIFw7ZoYFEulsd9rPxnUfYW+w3LUyVH1Y
	 f6Yf7/dhuzoobp9z+XzwlG2f6aY11AVOZEWBPqhZvtlwlHjaEfUQIOwKofzBjaiT2jOm+
	 undV2W4NLstyN1JepO1/h1SJrgaWot1YisL+7qI+Cmbc9h7Y1xj2j492sqnIHmixxod0P
	 kUNSmud0+3tb4p5Ao7qBafkgbic9SXfulr158CR1j0g6xLNvFqlPrRWLCILBXu6LZtCrf
	 yTX4OY8De4yspYCbwBlSEcHzc8SadZtIC97kKgsdjE8h41EdXrldEXb40h6DWaziacA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455473;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=NgtEXJffBQpLVIiTDFBBAZOSsnPW9SZ70tTul+WiIJQ=;
	b=L0iju726VV1Thly3L8PXt2o+BOGGlpvXlQh/FvrBSXqp7z9SwP5ZQuaFJ5vgL6uqYKaP
	 p+5cmZSQKKBrILH07iKhW38RqSxHEnLgOx0s2vc1ADbbFYKBrjpR10naRdMeFRwXeHFUC
	 o2upUnkkqxnH8W0hIY9H/Q7Xn8Wj9/ktIVtNUdDOAmTII2Q7sr3/39G6wXbUe1SpFF7lE
	 Q2fxx0qWzdJT9VGfIK5I9e0LX/iOjEMuSH33VgdFjLolXWgX58iUvqrqT9LfFAhO0AKJs
	 LVK3yVpobaQA3eEhat4BcPpb+FuQkcC1NrJdGWhIpcZZZWqQy/pVAHavJhRpDCDnobg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K4jreHBI;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDFC606A31A
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 17:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBDFC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K4jreHBI
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-3678f64d078so4260246eec.1
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 09:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795455472; x=1796060272; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NgtEXJffBQpLVIiTDFBBAZOSsnPW9SZ70tTul+WiIJQ=;
        b=K4jreHBION3hjtukW5ljG2NkIBlTK87SQDAKB11sOBE75m7kbDYGSugzpZFXuBu/m/
         jshw9HgigSsjWMWH3OSaMjlSiz+bcBVYYozczP/4ngnQsfOSxlJr6UjGSBkXfj1P28D6
         C0NAmaNZStnL1zaDEBDKvGvqssRnZijjVknR1cT1X9xzU7/O85s8AAdxmkSF/u4uqI9z
         yjM0ITr5cV0K3EsVvg5tQpy67zQsKBm/s+U2YztE/UtBRXf+u9ki8n0yCUzUTz1BXfGt
         1M2buBUQl91emCJgbmN7AtvdSnh9kDoJrbjnEAByizSSmwEU2vkMrsG01YyCpNpRP+rW
         bcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455472; x=1796060272;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NgtEXJffBQpLVIiTDFBBAZOSsnPW9SZ70tTul+WiIJQ=;
        b=IXSidmhctQw0z9A6AuMlZa+BYLHRjV9r0uiBntlv9qFAffMmydXlfpGsXfq3JWRgQS
         Ak2e0yAJO3UPJjHQ2FFUmbWlo1D9/UWtkGNQmb5E3EdL15ziKsITHY21ClClma36BKpn
         wefCthpGVSOsFQLjARW2x8VCNzvMqVTf8AFTwAJWijOAs+9n6I1gzCklJ61nxT9TOy8b
         XUbAXxTv1WMp9ZXiw3uyqFd4fUFBFxfL0CM1eCu2uTiIEsACiyjqCeK7ilVSGum6leSD
         +2CIuglTwc20SvdmF3EibHMKDYM1cNrJEhDlFHbsq66WgEOqMS8GdJArKBy+5Ft2xhBS
         7uuA==
X-Forwarded-Encrypted: i=1; AL+hErErRsIAcPVmD3jR8SlOXl2bc2wUc6NLvT5sTtyNQtuvVHVUGm75nWRBanxM2AuuXgtywGWcog==@lists.linux.dev
X-Gm-Message-State: APuU4Z9XI3pW0H93gGcxlKYZ46P3jC6LPe7aaEA8YRKDYDDCbWgQx+wk
	wbkEAlDkemphGPK5n4UV5Y1MvqCTY/W/UijFScdaMsL3L1BZuudEbvTR
X-Gm-Gg: AZFdTZf6mhkiMqQRN7tyx9d0VMAlLm+s+pjobMdhVDU4OuW2pMFrFAhiJsDxFYTpXRb
	d4O5YkAy1WG9BjcY/JbKFQwPG1nEJgKxA2ynPDlBLquw36yvuEfg0xYeOH9ZBy/z8XkjA2FKR8l
	6Oij+sgpXbULdO563BdYDS3S06lKAkUQlJhm7oAvXj/H2j2TIzbRC5sDJs5ZH2mzO8KnZ/BN8mo
	OWBpK0/1uYQlmFjVH5pXarqdUwr5/1wEQNjNfXAbhh/ARi+zNsxdI6+Pnt9xmaRCkvRHbp7RGbG
	2i2/8s/nGCZa4BtjMwL7pGIHyGaSsTedNSQoZE/T7I8YUaXMexN9uuTBLQj3entHRtTmEF82VAe
	+nqX9Ud/qH6dZO8pEAxm7sIpDzsdbo+wbyUL2VJe784kA2EALvXoKYf9Z10k9zrFODmdCpwuvxk
	a4OVWxIRtZVsOOL0/9ufAk19SwmmQFHK8oI9tEkLqxXl104LO3ZT4+vxbVOVxS3SLnv+Rsn5or/
	GLosPNGiOvSW36fxbZvOdigw7zc+WmpuiKCQRx1a7czUw4bQg7exy5lSuPQRM+QHd8LAFOSGhZC
	hujbIuX5Hv5Hfo6/bTyfKWezVRgCKR8sgvb4/fGWy1DTdhXwTIh1rjmIgTI1faqk/zL7vp9Bz0J
	A/d9ipmyfGBsnXIL7BrbOgjvV37PJFE5W6q6pCjalnkQQ7jumNln+UOFs/iUhmw==
X-Received: by 2002:a05:7301:e0cd:b0:375:dbeb:b363 with SMTP id 5a478bee46e88-38570f221dcmr13195033eec.28.1795455471745;
        Mon, 23 Nov 2026 09:37:51 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm31532302eec.25.2026.11.23.09.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:37:51 -0800 (PST)
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
Subject: Re: [PATCH 18/27] Docs/admin-guide/mm/damon/usage: update for
 REPORT_MADE probe filter
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 24 Nov 2026 03:49:24 +1100
Message-Id: <179545256491.4.1283840104529125616.b4-reply@b4>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, damon@lists.linux.dev, 
 Lian Wang <lianux.mm@gmail.com>, linux-doc@vger.kernel.org, 
 linux-mm@kvack.org, Randy Dunlap <rdunlap@infradead.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261121210013.130397-19-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
 <20261121210013.130397-19-sj@kernel.org>
X-Mailer: b4 0.16.0

Hi SJ,

On Sat, 21 Nov 2026 13:00:02 -0800 SJ Park wrote:

> Update DAMON usage document for the newly added REPORT_MADE type probe
> filter support.

LGTM, thanks.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
