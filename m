Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455341;
	b=pptWwzXV3h0kNZWICNAF5YV/3ezYVjyHtc0D8wXWhcx3YpzKalWpa5SyGmgr334fWAY6
	 NyJHADVIJKDFGmmuJfgzUNr+g+eyIH+TomZOyGpdnZVnlGm6rFY07KVRQfBiHe25KuqP8
	 mCAo8Fd6xJm5jqHziw2k/kVejyaoOjE9NI0lnFA/SksR/bXAWstwwOYfD38B+11vxGYlv
	 oukVM/ncb776ytqSNVNye9bIyEWgvnH3lcZXWjLPqN7NQThyf7ewmnTrZUH87BQoAkz3i
	 RNxKX90IqRWnE6IItkzoF/IVnXyPaOM50kVZkUvHwfYLrGlWmBlA2FAQ5dkCB1vDRAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=7F+8ITRX02mLDnos/7a9o9PFJ5+L5LzcuUjZXYMI0/0=;
	b=Ua7sNER8HI8sYG/BT97t127QeIWSLZKA72H5XvELY0OqBWXv8QVY1sq3Xy8vjQJN+lie
	 Z4m5gpvnfGoymWXbTLvHU3PbXBW2qn7kJFg2vx0l5DghKEvz4D+RkbHhNebGKZ1WbBeRa
	 /uevrlaDx0+8RT7Spk2otAiYHLCS3YLp+qRKczF4kV+TvKJaNMyM8q1InxRdudHD5OqRY
	 qKQxeNpy/GeJjb4AwjmvqRVVdk9myno39wK+F6HCEwF0qq5B2sdhm+WxsuOswZ2thFFH8
	 cPDeO+kVKBbxEh8pgomyJeNXtmcDegnW7DvVjkdftAbyDNrT5iuXPfsSwksdSw+rVWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Se1ai1Zn;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CCA606A31F
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 17:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82CCA606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Se1ai1Zn
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-3869c1275bdso959596eec.1
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 09:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795455340; x=1796060140; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7F+8ITRX02mLDnos/7a9o9PFJ5+L5LzcuUjZXYMI0/0=;
        b=Se1ai1ZnsMQlTwDpnrgjmbf6V6Jxu1MRg4MPijyQKhvUZbqBU8rOj9dHah41LB5Sub
         4F18e9E9kF5nKajZgSiU+uBbSqRYY1Ey8+W96kdywTcpcDxs2itpHByaTnE/CoXdtN2H
         TPu6PQ4010HVgNckk23ALA/YEV7GsbefxlwjEQQR4e1sEekJFY49mzz03FRAKnMocjNc
         2lkf5uq9fltsgm4hUjWJSfv6XI3Gbzq7qRFvu+aTZ7UdxqhCfxUljcOReRnseIwezTdl
         pEBma7erTPy87+uuvIQAXLlAMQzQmq32w21yJJTUarmaIdvqQfzpH8J+zpeiXGdoOb2R
         /RxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455340; x=1796060140;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7F+8ITRX02mLDnos/7a9o9PFJ5+L5LzcuUjZXYMI0/0=;
        b=Q4vPy+mT02MWgeuBwF7x5dWPM6MWUo+sTRK9yMmg167RnOulW+z8nwh2PBC5RPfqWk
         WBb80n2GpsCs9+UDh1ZXUHe+DGesgMs89lHWG9knGbArb6zHQrRW+K5t0icWxcx3Ni8s
         jj3pUNmZjukSJEMLCWEwSTHpaZiJlzN+BCu5j5pcxusnOGNvnvPExmCCa6FjpSQBLuN2
         yRkW1nEeGCsNlvHw4FcXWNj38a8R0KFvBpAcKteyxWFg7fqWnCHRLJ5/uAfH8MC7SRho
         w/bcKlNB5Uivp1d2bucpLrcQQ4Nv1I7FAmaUS/Op9OWg49uzyQf0wW/+o44OrlFFq24K
         DVOQ==
X-Forwarded-Encrypted: i=1; AL+hErGE2hZRuh+EzzEnrJ2Dw3FAcipW/k6Q6wYllJQ9D1cun6va0uUQqWbZesBvH6i9YTeJdXj8gA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/MJZGjSVzPfSJbsvYO83PXno8XoB6EFDy6/3qgAiXqzxfPHcZ2
	4RTbP4/Gr+cMW3APrfI58jJQ1dm5KEdSu92w4Qqwgd3822vb1FCgkgb6Lrqwo+xNySkv8g==
X-Gm-Gg: AZFdTZfymiUBOXmPePGNcf4iMp5s+iMs1XOoETFvNPrTR/OVHUb8K3wSQf+gTwnDSTU
	A0+vnvc4HH2u56ogpGxn36dibKH8zyWtqpvr6qtBsGAFRhMv78BGBGsPQAVVun/JEvjIRHDFjpM
	Q/1ymwgGQgb2Ga5mWd6GzfFM3+9zU5y6XmoIvLMVka4ywJQalu4HWKZ9KyPyMc0p4h1u5dv06S+
	zmKrndXL8JG81oVWKlmG3sxMr57e6X8Jxa4esTjv3OhxWVVD3+IHGDuXbynokVcVY7pKvXz4VoO
	N1yhBvtggihf4Hepc34rZTHx/DHIXyTL12fffnyDiXFVzF+fqj2XSwhr5eA9wI7FVdXt98RZI+E
	/tR3+wkRm0wceRwBfHOsD8kDjnfXo17BaLR4CDZM2OkJ9jIj2PaSZ7aFPRmAj9D5PMatJ2Ms1Uo
	v4GoJMsDiAm3h/zvyymZceqNSB38dnfuzuruN1R8hoAHtkxsrhX0PuiNMQ7TOOCtL7zUtyOIIs2
	WPmwtR1P5wXE6c/1l087K1D9+1BhaUTUWlaEsaQBDY8jF7jPuxCzVz2P1P0cWdLcQC0nzCbiwJm
	WMJMrb4AVFJXnAZRE2JH+Ti7p19mGA9XkRHW4ZMTuDNbsf9/SCtptQKheOrrZyU9p0lzTM9Ft5w
	UaEUiBE+kCIyGUVVgBZ1AdNrHMnCd5ZZbZ2/i/32d3f26IPH5+dmI+tTYBzY07w==
X-Received: by 2002:a05:7301:4704:b0:383:729:cabe with SMTP id 5a478bee46e88-3856f8519ecmr13298813eec.19.1795455340146;
        Mon, 23 Nov 2026 09:35:40 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm31532302eec.25.2026.11.23.09.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:35:39 -0800 (PST)
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
Subject: Re: [PATCH 04/27] mm/damon/sysfs: add admin/reports/ directory
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 24 Nov 2026 03:49:25 +1100
Message-Id: <179545256506.4.16243298231071152571.b4-reply@b4>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
 Lian Wang <lianux.mm@gmail.com>, linux-mm@kvack.org
In-Reply-To: <20261121210013.130397-5-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
 <20261121210013.130397-5-sj@kernel.org>
X-Mailer: b4 0.16.0

Hi SJ,

On Sat, 21 Nov 2026 12:59:48 -0800 SJ Park wrote:

> Add a new sysfs directory, reports/, as a place holder for sysfs files
> that will be used for controlling the data attribute report system.  Put
> the directory under the admin/ directory, next to kdamonds/ directory.

LGTM, thanks.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
