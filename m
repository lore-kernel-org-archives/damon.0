Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455535;
	b=0f0+hwXvOKYvUNb0ns3K0Z2Ucc9j0FNoKRMBRhIiajZdSlSwgt4bgQDNjdRWSPsDAnzA
	 OjhZSABzqEemnfFCpFenyvpkof7aB0dyzku0A0TChTrCNoRquIVkiPADX4eWNS59WHIY+
	 GsmyIFCjQ0HlT4dWps1eJkwEXzf2IFB4+qdD3POjxcL5KBI7UoCa1oR3EFxa/Zj26BLP4
	 /YyvCD5CgcsOEMiYaCL81I4FWYo1tWT8MuUE8GctTcAdTCWzdnbX0G83vzSBfvjPuexxD
	 9EcIeRwCPtSZ+KhnZ197r7f1jaxtIddK0W2TDSPK7ZBy/89pzDNMDrqhtLaZl/bQGFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455535;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=80pkZVTQUzpocvFf4Q4AZ1jQYJsntKDso7wWkNMkYVU=;
	b=C2ynKjyxUaRUsFln4t87gZj1TU2kIAiT1OLbGI5nJ+v5TRVBktkFzQjpMsWsyc9oOnNH
	 mSmBomk5nMHa86q4zI5UXUaTaS/dddI8vsTtyVzZ0hIKdSiuO2PbEL4Lnr/J7QwmE5OgI
	 3eazXN83h4zNIinr4OmcLgcj98Q5Er6VpgsKmsdo/a7tRzwaydsUg0J08yJ7SdvP6lGtd
	 kVQ+c911scpTU5kKewv3SmHFiowgdcx76h4rQ3o2vL+ZXTmayGz/5GZCoYdZsA999aw2s
	 YqQH/+HwsVUK7MVWRJKO/vfmIYaG/1tzOjsL8xObpSzTsb/QD5shHznNyS5uqxwfg8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GIUSAfXr;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576B4606A332
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 17:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 576B4606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GIUSAfXr
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-36a6ce64b95so1376632eec.1
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 09:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795455534; x=1796060334; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=80pkZVTQUzpocvFf4Q4AZ1jQYJsntKDso7wWkNMkYVU=;
        b=GIUSAfXrZieFQi9xtG+HnyfryvgKgfejhnuaX7HI357skbABv7QyEdac8xz+A8tmsO
         bh/B4HyILKguxjt6qzbGbRFLhpiWv4bE5g0AEY5KfxhYYDEWO2BfgMwTMxHE62edL4pH
         D8mHoy5eCsDs++XnX+sWoBsn1t/nTHWbVccwOb2HU4a4084hiD9FOq+YUSQYyvBf8GEi
         CU0I29QdX+mhBnh3JQLjA4vZHpr+tn9mM4R8PjZdqplbaoMZfV1HITvJfrZn3oWKCXus
         UrTvkusHLvHQc+QYinelKO1qd67gozEDvySLbmRxjdQWFUqYiJoSP5TnL1BVCc+Pr+yM
         s1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455534; x=1796060334;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=80pkZVTQUzpocvFf4Q4AZ1jQYJsntKDso7wWkNMkYVU=;
        b=X+Nfee2iVZN6y1yAm86RBPbFEKFmGALINifnh3i5M3MfcOLdnolmcnTlQARWWh7zWh
         Dunwco0xHkBOz9Sru5LGJIx/wynG/MU6Kkl35bfmuN2jxnu6DKd6jIh1bCAuD98pfj4Z
         Nk7tXFoP6R4kX1Ge6hCYkFl7FJVYd46eFE+mpSJm7cUQKHKkK57THdXLFj5q8epWclO6
         88kf4F9u00vhlJYXRIu5Z2nmqKm7uMRwpNGHDL2GzCmLUauOSkmEjF16pfCSbKqL9Txa
         bjjgsL7Noy/f4P5B9mzROy0Nhmr3yR4eeFPUUQdv09vHHAQXKtLNNsnWYvoE2TZQ2KW3
         c/wA==
X-Forwarded-Encrypted: i=1; AL+hErGuuqlh8wuCOuvfiS0BIc68rfIwYgb3igvHb+8gAKzbRdeBpcdnW8U6pKxZdBns43iWttxpTQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9o4uuM0T3TpLVE6lmKi8ZfpD+i+OnsCI31Oc4yI8+ZYIrl020v
	5B2q7B4H9+zEIiC6p+I55mjdR2WTJLWNJXeBARz3JBLHTd4arCRDturl
X-Gm-Gg: AZFdTZciQdJRfR38ZCbUW9wif09UUL4baXaLW2kHbnupY7E1K1ro9At82DfRTt/Pohe
	/caKkopcxPNpnMCcEWmyaponC/GNYAfyVT/bMIRs0sKTCV9e3gHNnnAzgKmhYFSUVohVo8JQpeo
	Lhn3lFnPWjU0PYlv6f0soWjazkueRR2c+RA7bmkClhb6CgAx7TsNlIz/0FOsAVBWIZsaoVohryT
	F00H3Cxd420X5Si1R6GXPSimKSS6I77/ueVk5bb3qJjtKjlToqE5814cLxEjZ4sE9RIOXeMCaZZ
	tPZlXtwgxZl8PvXTvF+Olmt+j4DHhq9SMl/vavCQSUy7T2nhMsMCt+dqpb7L6wAxMPMhfur4xSQ
	44xl+kvwPJn0meQWXGTSmLVEeSDYYEL1OWV0Tri5dpvdCUkSsg3DPN8dzv3TLjglZwhzvSvvkpF
	bzhzUByjGUKMLQ8Rzp6UZCL8GnXy41f2F0BRK7oeDIGlJikIDUr3Sy71YkcygIymcSkXmxYR3Py
	UBpVki1PpS2ZuglImYb5bdsKJonioIsiTsTA/RIJCTkfnkJY5XeHOyDd7ZRXmogRR5UuffS71Ua
	MjWdWaLTKBO0mpD4KK29+zxdi7HweEIXfHsxzBMyi2vE+ZUsn6IFJS+sAxjIou0zbjCFC8vozqT
	DdJ2BUcG2RBvpCOwapQfw8T0BjJkbBqbMBGfgor7qVopQNw44vPXvO1ObS/uELA==
X-Received: by 2002:a05:7301:3d19:b0:376:ce6a:a499 with SMTP id 5a478bee46e88-3857122312dmr17033613eec.36.1795455534319;
        Mon, 23 Nov 2026 09:38:54 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm31532302eec.25.2026.11.23.09.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:38:54 -0800 (PST)
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
Subject: Re: [PATCH 25/27] Docs/mm/damon/design: update for user report
 support
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 24 Nov 2026 03:49:24 +1100
Message-Id: <179545256496.4.12112355431870219445.b4-reply@b4>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, damon@lists.linux.dev, 
 Lian Wang <lianux.mm@gmail.com>, linux-doc@vger.kernel.org, 
 linux-mm@kvack.org, Randy Dunlap <rdunlap@infradead.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261121210013.130397-26-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
 <20261121210013.130397-26-sj@kernel.org>
X-Mailer: b4 0.16.0

Hi SJ,

On Sat, 21 Nov 2026 13:00:09 -0800 SJ Park wrote:

> Update DAMON design document for the newly aded user_report type data
> attribute reports.

LGTM, thanks.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
